package com.base.common.util;

import java.util.UUID;

public class IDUtil {

	public static String uuid(){
		return UUID.randomUUID().toString().replace("-", "");
	}

}
