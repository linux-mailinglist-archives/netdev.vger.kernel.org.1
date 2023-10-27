Return-Path: <netdev+bounces-44711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED37D94EE
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D1B282433
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF3179A1;
	Fri, 27 Oct 2023 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NDW/zTi/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F818AEF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:21 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1C111
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99de884ad25so290043866b.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401658; x=1699006458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVEm7APPSSSk+YJQkBaPKu7CTimG895Qex6fY+sz04k=;
        b=NDW/zTi/z91o5Ekwx5RicwfBPbNN7Q7R2j8LrV/pf+BRV9p9vKpkxcghCp97zRXUwe
         /eDXTJutKjqRMYbSY1CdnwHrQXEECuuW9hN84UUkfdZQ/DByD0zbs66gy0a/dOJKqF1g
         VUEPHb7VqNQHbDu06soPrrlmT/V4S5BJDwQR0PBAfify1IXRPy9VqfYRoFMgJDUJ8NLp
         b1QTzjy/6ejiBMrt1JPWkp8+NCBHQQmo+PFJVOPUjEQgPas6RpG/DShN05uB+vXcTGBE
         ALbuYnmV1LCb8iVfTIHsPD5FbBNYGFxk30yozndPZjAmgw8ObAOWHIPw1Zw1OaBtkfQf
         5sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401658; x=1699006458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVEm7APPSSSk+YJQkBaPKu7CTimG895Qex6fY+sz04k=;
        b=Az+r5DvExoKz7b2Lpx9pficbcwqL8SE4v9VqSPs4QyhCduGi+/eFy40wbH1VPdOlhz
         Nm0anJZlKmzQrTqt5got9qlO+aidoc6RXpzNkyJl1tbSaI6+Ue0mD5Uwp/GMM/tABdAb
         tGzXds0MyMvQNf72X0nMt3LaLbOnF82IoESa91sOZj0cMbxIdOzSxJQzL6xjBvGik6G5
         l1HAnh+FO/VesRJTVHFFmZU/kTXSe7p6t++Mxl/emlcHDF4gHZzbgnmpEhqT2nZyfY5l
         qLjXj3Z/9mR3l/n17Oy7vLmTMOi/e4ThzZeJq+hQ06Vm59Sa0vXJ6BUUoxaBcHbdA7eY
         eoow==
X-Gm-Message-State: AOJu0YwVIsIK++K8Zn9LFOmNCUNgKuAcSUICDOAwyGOe+87Pf8Ihpz1g
	pnhvpfSaxPuZSDhOCA+l7NEGAxEDHIY+r05CbshCWA==
X-Google-Smtp-Source: AGHT+IFfu8gSec0X8VNfECaNQ4pek2v8RK5jv+N8PPxIzx90sNZ3br0xG1wrLeVQqmMfq9SfqodsaQ==
X-Received: by 2002:a17:907:9614:b0:9af:4561:591d with SMTP id gb20-20020a170907961400b009af4561591dmr1917582ejc.18.1698401658053;
        Fri, 27 Oct 2023 03:14:18 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906208300b0099cd1c0cb21sm954886ejq.129.2023.10.27.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 7/7] devlink: print nested devlink handle for devlink dev
Date: Fri, 27 Oct 2023 12:14:03 +0200
Message-ID: <20231027101403.958745-8-jiri@resnulli.us>
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

Devlink dev may contain one or more nested devlink instances.
Print them using previously introduced pr_out_nested_handle_obj()
helper.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of new patch "devlink: extend pr_out_nested_handle() to
  print object" and previous patch to use pr_out_nested_handle_obj()
---
 devlink/devlink.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index ae31e7cf34e3..f999e5940c63 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3860,13 +3860,35 @@ static void pr_out_reload_data(struct dl *dl, struct nlattr **tb)
 	pr_out_object_end(dl);
 }
 
+static void pr_out_dev_nested(struct dl *dl, const struct nlmsghdr *nlh)
+{
+	int i = 0, count = 0;
+	struct nlattr *attr;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		if (mnl_attr_get_type(attr) == DEVLINK_ATTR_NESTED_DEVLINK)
+			count++;
+	}
+	if (!count)
+		return;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		if (mnl_attr_get_type(attr) != DEVLINK_ATTR_NESTED_DEVLINK)
+			continue;
+		pr_out_nested_handle_obj(dl, attr, i == 0, i == count - 1);
+		i++;
+	}
+}
 
-static void pr_out_dev(struct dl *dl, struct nlattr **tb)
+static void pr_out_dev(struct dl *dl, const struct nlmsghdr *nlh,
+		       struct nlattr **tb)
 {
 	if ((tb[DEVLINK_ATTR_RELOAD_FAILED] && mnl_attr_get_u8(tb[DEVLINK_ATTR_RELOAD_FAILED])) ||
-	    (tb[DEVLINK_ATTR_DEV_STATS] && dl->stats)) {
+	    (tb[DEVLINK_ATTR_DEV_STATS] && dl->stats) ||
+	     tb[DEVLINK_ATTR_NESTED_DEVLINK]) {
 		__pr_out_handle_start(dl, tb, true, false);
 		pr_out_reload_data(dl, tb);
+		pr_out_dev_nested(dl, nlh);
 		pr_out_handle_end(dl);
 	} else {
 		pr_out_handle(dl, tb);
@@ -3883,7 +3905,7 @@ static int cmd_dev_show_cb(const struct nlmsghdr *nlh, void *data)
 	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME])
 		return MNL_CB_ERROR;
 
-	pr_out_dev(dl, tb);
+	pr_out_dev(dl, nlh, tb);
 	return MNL_CB_OK;
 }
 
@@ -6810,7 +6832,7 @@ static int cmd_mon_show_cb(const struct nlmsghdr *nlh, void *data)
 			return MNL_CB_ERROR;
 		pr_out_mon_header(genl->cmd);
 		dl->stats = true;
-		pr_out_dev(dl, tb);
+		pr_out_dev(dl, nlh, tb);
 		pr_out_mon_footer();
 		break;
 	case DEVLINK_CMD_PORT_GET: /* fall through */
-- 
2.41.0


