Return-Path: <netdev+bounces-44708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D627D94EA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B249C28231B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8F182D2;
	Fri, 27 Oct 2023 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l6vh/qoA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E831802F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:16 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ACD1B6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so3217777a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401653; x=1699006453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHwNAGhvr8qblRJ7IY3DURpvARsJQGPAY0lSUzSqs+I=;
        b=l6vh/qoAuguvIyh/Wfoq8iHb6v9YYXhSmekWv1ZBtKeyGECHrZmYgFY4r/mNN6efkd
         yJ0MvVu7qWZQIT1PGJuDAumL+qgBBmZ8XbaJUKNJW48jSoLQ8WZV7HmvHPjVYBcMQ4ko
         TOM0/Rj0wgxrGluMtUlIYliqV5VSTJEFN0MKOvGEiLXLsDw0f9nPGZHTzzcMoum4C4ua
         m9Bj8x+2Usn9+NMsKKmFgY/7ynJ227wSf8bui6kP4gdNnNFFchI9R+nflAAOU/elK1Gj
         vv6abRKFOB5kqjyY3E9xyuFONZzmXvE823dEjWkt5BxFxdUhrFkNLiD9M6Oif9SyBIbJ
         Z9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401653; x=1699006453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHwNAGhvr8qblRJ7IY3DURpvARsJQGPAY0lSUzSqs+I=;
        b=NVxRfh60yYRshvtBxvbPtl7DrLLp1jwJwy0qB9OrCTjrz9ydYJAbm4ndpj9zs9VQTa
         qRgWGSz+X4C8U9SjiLRZHRIyNHPR+LGbcktUwClq9ljfcHOauAz8Bty74uEI7kRTtGaA
         k8CmSJlYl7G90atvz4J9a/U8mhWMSu/LUgF3Dtw5N3O2hfUluory52LVNmX90+9QcFKH
         07Uyp6CaniU84UpN0Ayl0P6zHbWKZV+mCOziwWWZn+pBRIZUj9YiHW/GWEVohw8/Zqq0
         4XMitPv06IaA/Ne8vdyVWHSkuU0GFqPJeY7GcZL3fOQ6G2GImKtCAn75OoPY8D85De8X
         MOXQ==
X-Gm-Message-State: AOJu0YwcpvBdf6R9vV7vsvi+lwV4sUb+Jr2mpQPNkBvBXye+zWGAUVOb
	ePz0iitFKtyvTA8lfzo3w53BbCKBbfGWxRmR06MFwg==
X-Google-Smtp-Source: AGHT+IGC1oK7t60uQgZw0mTW4OoGk2YkB8HtZBFetqLFcMwCKkM4EZ2lZLWjZvUGwnBc5jcIbHj8Ig==
X-Received: by 2002:a17:907:608c:b0:9c4:41c9:6ac6 with SMTP id ht12-20020a170907608c00b009c441c96ac6mr1569954ejc.33.1698401653104;
        Fri, 27 Oct 2023 03:14:13 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s8-20020a1709066c8800b009ad7fc17b2asm959132ejr.224.2023.10.27.03.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 4/7] devlink: extend pr_out_nested_handle() to print object
Date: Fri, 27 Oct 2023 12:14:00 +0200
Message-ID: <20231027101403.958745-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027101403.958745-1-jiri@resnulli.us>
References: <20231027101403.958745-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

For existing pr_out_nested_handle() user (line card), the output stays
the same. For the new users, introduce __pr_out_nested_handle()
to allow to print devlink instance as object allowing to carry
attributes in it (like netns).

Note that as __pr_out_handle_start() and pr_out_handle_end() are newly
used, the function is moved below the definitions.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- rebased on top of snprintf patch
v2->v3:
- new patch
---
 devlink/devlink.c | 53 +++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 90f6f8ff90e2..f06f3069e80a 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2747,26 +2747,6 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
 	       !cmp_arr_last_handle(dl, bus_name, dev_name);
 }
 
-static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
-{
-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
-	char buf[64];
-	int err;
-
-	err = mnl_attr_parse_nested(nla_nested_dl, attr_cb, tb);
-	if (err != MNL_CB_OK)
-		return;
-
-	if (!tb[DEVLINK_ATTR_BUS_NAME] ||
-	    !tb[DEVLINK_ATTR_DEV_NAME])
-		return;
-
-	snprintf(buf, sizeof(buf), "%s/%s",
-		 mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
-		 mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
-	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
-}
-
 static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,
 				  bool content, bool array)
 {
@@ -2862,6 +2842,39 @@ static void pr_out_selftests_handle_end(struct dl *dl)
 		__pr_out_newline();
 }
 
+static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
+				   bool is_object)
+{
+	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
+	int err;
+
+	err = mnl_attr_parse_nested(nla_nested_dl, attr_cb, tb);
+	if (err != MNL_CB_OK)
+		return;
+
+	if (!tb[DEVLINK_ATTR_BUS_NAME] ||
+	    !tb[DEVLINK_ATTR_DEV_NAME])
+		return;
+
+	if (!is_object) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%s/%s",
+			 mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
+			 mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
+		print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
+		return;
+	}
+
+	__pr_out_handle_start(dl, tb, false, false);
+	pr_out_handle_end(dl);
+}
+
+static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
+{
+	__pr_out_nested_handle(NULL, nla_nested_dl, false);
+}
+
 static bool cmp_arr_last_port_handle(struct dl *dl, const char *bus_name,
 				     const char *dev_name, uint32_t port_index)
 {
-- 
2.41.0


