import {
	type HttpStatus,
	Injectable,
	type NestMiddleware,
} from "@nestjs/common";
import { HttpException } from "@nestjs/common/exceptions/http.exception";
// import { ExtractJwt, Strategy } from "passport-jwt";
import type { NextFunction, Request, Response } from "express";
// import * as jwt from "jsonwebtoken";
import { jwtVerify } from "jose";
import { SECRET } from "../config";
import type { UserService } from "./user.service";

@Injectable()
export class AuthMiddleware implements NestMiddleware {
	constructor(private readonly userService: UserService) {}

	async use(req: Request, res: Response, next: NextFunction) {
		const authHeaders = req.headers.authorization;
		if (authHeaders && (authHeaders as string).split(" ")[1]) {
			const token = (authHeaders as string).split(" ")[1];
			const decoded = jwt.verify(token, SECRET);
			const user = await this.userService.findById(decoded.id);

			if (!user) {
				throw new HttpException("User not found.", HttpStatus.UNAUTHORIZED);
			}

			req.user = user.user;
			next();
		} else {
			throw new HttpException("Not authorized.", HttpStatus.UNAUTHORIZED);
		}
	}
}
