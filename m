Return-Path: <netdev+bounces-43801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE5B7D4D3D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5260C1F22719
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369C250FA;
	Tue, 24 Oct 2023 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VSN4lK3Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9D26290
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:18 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0CDA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ba081173a3so675809366b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141856; x=1698746656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMD+/2AEbaBoagYEL4uOL6ECD86C589TD6FuI5XI2ZU=;
        b=VSN4lK3Zh/lGUwg+Laihtv2UNavXNPjmyGX8cBBGSs83uuxNvTrGMnPDZZ4Nnjsk7V
         k7FG+4nHbQu3bcm/o1kFDemld+Q00cfx1pfuvk4SusAKkVTOPGuJU6kVhq3fjChmGhA0
         G3aci20EnDdUHuwwU1lRVPMfg+FQPq4jCLRPsXBcjPTuCUizQLyOH+1ZHFmRKWYaAeCs
         5LZdXYvCcBukCPC6XP1wwHMm+GhCd9sRydeJ+0O+6Fqwo6yxBS7f2LCHViVtX1Fvvxqp
         3RsQeC0lmBpQT7mlYCnTh24BEY4cYxiDi/eZ2yXy4W7aXUe7a1rolautADEIKUpjf6cp
         BYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141856; x=1698746656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMD+/2AEbaBoagYEL4uOL6ECD86C589TD6FuI5XI2ZU=;
        b=VfptDev8l7djh7+yged4TCtwkXkGTJInh1V1BdXtI+VQrjhLbJBe7e0VZz6WitVex2
         cW5dRIaYduw6Bb0r4XmkV1KYGe+NPEZ64CyHkAt3X2ajbvlOAB7Lqyk89lbE+0ouyzCb
         umrUy2avkElRvZtUwB9l6i7oL9Lfs3gcFzhBH9tFWhzmWZS4snykuv4yYNSb5MKJyHQv
         M342iJY5OFhJY3jJVHwT/HSrNlBzoyeSfeiObG530vCPaVxP/AwVzwPUsnBZLqw0fVht
         izkDL8+kONP7hNY97/08UxUtm/1Sn8krGFdCu4N3F8e7QRyYTucOJ0IT5wE3oV6H5avz
         SJmw==
X-Gm-Message-State: AOJu0YyKk4DYDtpbLVI5olqm6i+XCwkvjHDQfjAQ/veZU4A583CaEhyz
	t97X90mgaMP5C7+kTjfrV5POTegyCzhNdEj+qt2Jow==
X-Google-Smtp-Source: AGHT+IHhDamTEZ7+DnZOw1o/Unb9eed63LjrWeIaCu1s6zyufwCnw5QZ94MJ067QZtCpUcbgmXBeVw==
X-Received: by 2002:a17:907:3d9f:b0:9b2:b152:b0f2 with SMTP id he31-20020a1709073d9f00b009b2b152b0f2mr8672380ejc.10.1698141855777;
        Tue, 24 Oct 2023 03:04:15 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lt13-20020a170906fa8d00b009c4cb1553edsm8033791ejb.95.2023.10.24.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 6/6] devlink: print nested devlink handle for devlink dev
Date: Tue, 24 Oct 2023 12:04:03 +0200
Message-ID: <20231024100403.762862-7-jiri@resnulli.us>
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
index 90e8872b07ef..09ac347051f4 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3858,13 +3858,35 @@ static void pr_out_reload_data(struct dl *dl, struct nlattr **tb)
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
@@ -3881,7 +3903,7 @@ static int cmd_dev_show_cb(const struct nlmsghdr *nlh, void *data)
 	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME])
 		return MNL_CB_ERROR;
 
-	pr_out_dev(dl, tb);
+	pr_out_dev(dl, nlh, tb);
 	return MNL_CB_OK;
 }
 
@@ -6808,7 +6830,7 @@ static int cmd_mon_show_cb(const struct nlmsghdr *nlh, void *data)
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


