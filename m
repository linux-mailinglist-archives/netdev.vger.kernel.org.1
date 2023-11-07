Return-Path: <netdev+bounces-46375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F217E3651
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC31280FE7
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354812E74;
	Tue,  7 Nov 2023 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hMJTJ/6n"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E612E69
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:19 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33E122
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so9152777a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344377; x=1699949177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/tu5XWHHR8usb5Jk8v5P3g4yLTlyEOFPX8/M/aZHvs=;
        b=hMJTJ/6nTjEXHnAaTvrM2El+5T01ixu0j8vOOgLsnnQeKzEkAFCa9RULgpnPmshC1H
         BXgT8M9NQTISMYstieRNPScGTaAf9zI9YqsCeeU5/q3StyuIujcJp4+AbDbfn+Qe1RDF
         eWH6s4dpiCS21uEgc/fBOTC50uJESJhsz9yHhFzXFQGqHmMj6GMeVJ7iJ3rTavs8QfJb
         6jC7w+/kOgm5d/Hwc7JbezCJ2MxQUNvkvUr2l6Iv0TP5YyLEy6Db8pl60ni/IZGWucnw
         OaW3RnHn76Bg9UeZ5UuVelxi+w0dao1BQX3DoGMm+cyscTrai0FZV7PHqKOjXxgjPKUi
         o2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344377; x=1699949177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/tu5XWHHR8usb5Jk8v5P3g4yLTlyEOFPX8/M/aZHvs=;
        b=Q45Zp18clO8/vwHs+UJ6J4MJ/JVrVsU/sV5Hp0mm7NJ7QaXXsQUerzGXHXehWeCvN0
         iJQHGhvCZ5mRqrY2cy5QAR1lbCjCGgQyHWP3zU9DSVRed3U1GxKw0JT3bfNrNjFYceH3
         4LPU+uiPq5DN6TCZhnA0Dyp1qBxgWhAoOM16vvFErnzBKl7hcut+e9PyCcD7adChdkoY
         +v4mkBWkl3GHauVQlzh0stLpH1kXejfB0/cPRGCdwkEGVHYXby8/vQJUJJXeU8AEcNvy
         S0koNbzi4oRo8Y0+XWEnNFM70/EulJ793QoyKJjVYhL9emXKhKcwtYR7HESt0BLWx7r3
         BIDw==
X-Gm-Message-State: AOJu0YzbE77VbosyMUDwV2wTKwnhTMen32L0zy7e45+Syily0y8rJ3Cw
	ll4d1FhwKxskjzgdr/lK/wAt8PBBzFEZFBNxjaY=
X-Google-Smtp-Source: AGHT+IEpR3Al3MGh5toAtTlWDnHTG44FlOJ9ICNsYSr7lCLoRPHfLy6mLhTwWKWXKEkJiYmwdDdy8w==
X-Received: by 2002:a50:d7d6:0:b0:543:5cfa:ba41 with SMTP id m22-20020a50d7d6000000b005435cfaba41mr17477705edj.25.1699344377060;
        Tue, 07 Nov 2023 00:06:17 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id i8-20020a0564020f0800b00533e915923asm5129618eda.49.2023.11.07.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:16 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 6/7] devlink: print nested handle for port function
Date: Tue,  7 Nov 2023 09:06:06 +0100
Message-ID: <20231107080607.190414-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107080607.190414-1-jiri@resnulli.us>
References: <20231107080607.190414-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If port function contains nested handle attribute, print it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of new patch "devlink: extend pr_out_nested_handle() to
  print object"
---
 devlink/devlink.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f276026b9ba7..ae31e7cf34e3 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -772,6 +772,7 @@ static const enum mnl_attr_data_type
 devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
+	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
 };
 
 static int function_attr_cb(const struct nlattr *attr, void *data)
@@ -2896,6 +2897,22 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 	__pr_out_nested_handle(NULL, nla_nested_dl, false);
 }
 
+static void pr_out_nested_handle_obj(struct dl *dl,
+				     struct nlattr *nla_nested_dl,
+				     bool obj_start, bool obj_end)
+{
+	if (obj_start) {
+		pr_out_object_start(dl, "nested_devlink");
+		check_indent_newline(dl);
+	}
+	__pr_out_nested_handle(dl, nla_nested_dl, true);
+	if (obj_end) {
+		if (!dl->json_output)
+			__pr_out_indent_dec();
+		pr_out_object_end(dl);
+	}
+}
+
 static bool cmp_arr_last_port_handle(struct dl *dl, const char *bus_name,
 				     const char *dev_name, uint32_t port_index)
 {
@@ -4839,6 +4856,9 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_PACKET ?
 				     "enable" : "disable");
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
+		pr_out_nested_handle_obj(dl, tb[DEVLINK_PORT_FN_ATTR_DEVLINK],
+					 true, true);
 
 	if (!dl->json_output)
 		__pr_out_indent_dec();
-- 
2.41.0


