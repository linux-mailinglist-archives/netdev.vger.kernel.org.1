Return-Path: <netdev+bounces-43798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC67D4D3A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D191B21025
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA125113;
	Tue, 24 Oct 2023 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UzdXe7pw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF5250F6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:13 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDAF9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso637537866b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141851; x=1698746651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mitkHMxFPrlJNS1H9PyNiOCeZEz/WwBpqGxo02llvo8=;
        b=UzdXe7pw9hMsqOFUwDl6jtjZ7/tsjB22UfytbffEgFtFa0Vn1NL237IoQO9HX4VdYS
         3dRp9FVW1ktrc7pSOKgrgemk9ORAsy9eKKKSdIu+Ar+CIjD51l/hisXqe+257U0FpSgD
         OBDI3qZkjADBjPqUMmz0GK+8ArRo1K5msuwq/7GAFAln+x3bUHCTLzShzzMfY1zgUIYw
         vHqUwnFtc3TEPxwBa7Dt8TSxXPKhyMSFaXwsnKCDtInzzGjBAcy2QTUzK0d72m5GElp1
         AxGjbsx0EA+GzN6LNIqpYwnLSthRwXF81Woxf9XxB8JTOxMHBv2UdQTxtUxtCkYs7nVH
         55WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141851; x=1698746651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mitkHMxFPrlJNS1H9PyNiOCeZEz/WwBpqGxo02llvo8=;
        b=ieR/JaJBIVRHrpiGEgNZ48SXqJPxT5hGmuRa/D6H93fhv6nE0HdtBk9fJwJcguqlRc
         48JrtQU/RcNMG+L1NNodRUGZmctlNElBGcS0RT5JY08dpziXfV53WhzKnVcXinZNF5X3
         5Uk6zgSzSKGRZyW0A9d7G+quD9W1dPM06alN5YbpZfstJIpcDAmmQ2u8gY+VxWBrfw9U
         e8Dv+p8qUajO1pWU7MZMPR1+1w0D6IHzjz5FAU5n599WDOVVxjcC9cfefNr1Z2cUyMGF
         rgIR6/wiLa0cemD/bsN9kRSZT0GDGtpi7HVNMKyWXH0x680dSNwMglgilJN9U6ndc31Y
         eNhg==
X-Gm-Message-State: AOJu0YxjLS9LtKfasReKeWDfpg1IVvVCRdbl3bY6pKqDCOwcORDS3eLl
	CagwXdrreMM1plU8lpyJzkSYeC8C9SFqQVwj1agGOw==
X-Google-Smtp-Source: AGHT+IFavFCVPs4D5iivBChGBrRwCB4QDAP9NU3jss8A+skDTLgAGkyU6fGRQaynxyEOzyD1U0N4Mw==
X-Received: by 2002:a17:907:2dab:b0:9b9:b12c:133d with SMTP id gt43-20020a1709072dab00b009b9b12c133dmr8966246ejc.53.1698141850584;
        Tue, 24 Oct 2023 03:04:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm7948706ejq.163.2023.10.24.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:10 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 3/6] devlink: extend pr_out_nested_handle() to print object
Date: Tue, 24 Oct 2023 12:04:00 +0200
Message-ID: <20231024100403.762862-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024100403.762862-1-jiri@resnulli.us>
References: <20231024100403.762862-1-jiri@resnulli.us>
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
v2->v3:
- new patch
---
 devlink/devlink.c | 51 +++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index c18a4a4fbc5a..f7325477f271 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2747,25 +2747,6 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
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
-	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
-		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
-	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
-}
-
 static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,
 				  bool content, bool array)
 {
@@ -2861,6 +2842,38 @@ static void pr_out_selftests_handle_end(struct dl *dl)
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
+		sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
+			mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
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


