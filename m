Return-Path: <netdev+bounces-46373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6957E364F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BB81C209E6
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1397812E4C;
	Tue,  7 Nov 2023 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ADWoy4mV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725D10A0D
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:17 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831911D
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so9026884a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344374; x=1699949174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHwNAGhvr8qblRJ7IY3DURpvARsJQGPAY0lSUzSqs+I=;
        b=ADWoy4mV67WrrN1gBufZd12NqPAIh14UrFK6wmh3+Y4qzj9E1Oifg3iAa2mkscRrty
         NKRlxCnx8QIcki/kpItnf+wmy/duFWEqANGyV5TJHP+afxov+Pqt62oo1jbbkBMEyusY
         r+zd2sUglXp+e/gBrCb1uX3SD3/2byoqnExSrYIsT4i4rJ9ycPenAsFxWD8k5o8qjPIA
         525weU+NS7Quah96FhDtetwSHgUDSZi1Dw/uqLO0M569pe+ChFvAMnU5Cdv24PF10IVD
         l7pxpBnkOmrT/3bzR6TUS2ZdL8FfwPG9YhytfsoEUJPYO9dd/DFLt8KokC6PasvdxBkn
         vLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344374; x=1699949174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHwNAGhvr8qblRJ7IY3DURpvARsJQGPAY0lSUzSqs+I=;
        b=EAMbbPlBfrAh4TZVnozGO8R8+vmL36kLNuBW2MAIx70wGj7oWfovh2fVPxvh9WAT9e
         chKrP61fUIwtfj1D8nQTaB3g/kxamOERS51vrhb/9GiwU3R1jTCTBnMj0EIA5Zeg1GUt
         Olb5OZeazhnUE32odbFNzvp+h82rij3WTOVtThlMAXd8ASUztRtaRqfjv6HNaeC9f6O5
         4529MUEnb09uXh3F3VZhtfyi68E0FnSh59KukbrZzVDRR0hSQPUeRcppodemfPLDHCZp
         VXgu2jJeMs4dPdtX1dgRtxqpaSLWg8UCc/nzuQfPA5Un7gf9blAgkxb6q2usjnICSaLk
         +8MQ==
X-Gm-Message-State: AOJu0YzUj1nlqqhTXOq2g2FYDPnK9rhtVsYzsQoS7vcgwmyH/QLgqYLU
	6vCYqZUwoTVJCjYb4EAqycV6jLJbk3F8QXXoFVc=
X-Google-Smtp-Source: AGHT+IGUaQGl098XhmbHBQNanqyXrBoL1IX9Z2tbV5vUPgZ/33outJgtfYC6LC8xU4aUsneMhPDOiQ==
X-Received: by 2002:a50:d483:0:b0:544:55c3:ccf9 with SMTP id s3-20020a50d483000000b0054455c3ccf9mr7155830edi.22.1699344374427;
        Tue, 07 Nov 2023 00:06:14 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id b15-20020a50cccf000000b00542da55a716sm5234993edj.90.2023.11.07.00.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:14 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 4/7] devlink: extend pr_out_nested_handle() to print object
Date: Tue,  7 Nov 2023 09:06:04 +0100
Message-ID: <20231107080607.190414-5-jiri@resnulli.us>
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


