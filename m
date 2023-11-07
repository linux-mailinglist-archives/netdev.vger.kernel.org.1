Return-Path: <netdev+bounces-46376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FA7E3652
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24670B20F23
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FADDD7;
	Tue,  7 Nov 2023 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BES/P7q4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAE13AE9
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:22 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE606129
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so9181550a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344378; x=1699949178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVEm7APPSSSk+YJQkBaPKu7CTimG895Qex6fY+sz04k=;
        b=BES/P7q4r3D6JI66C4Rnx2yUj0hakfQ+8ffgu6A7zpEaky91TmXN/9n3JqQNnFd3/a
         iY+PEF68Fa9WMkYzYte2/ZEIAz/446DspOFEg8el04HvXE4McVf8j/j7OATVXLANnzfS
         NMRoX0P1Xdul8IOB+gcNqB+o55cIgyyqWejDHgFacbywnzRz7mSQUwgfCQN4/QtGCOG0
         E9eFY/dJTypwf386lncqkTdNmiY6sTQG626SguM7JYClm1QSm72+2I5DNQNi1tcLUvhf
         CZVKAop4+ezy1/c9G50oDbsdiJJnDwzfzP/6j8uD7z39web2fdXPBxTX04Bx/dCOUBPX
         j5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344378; x=1699949178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVEm7APPSSSk+YJQkBaPKu7CTimG895Qex6fY+sz04k=;
        b=d4Y+uO2QDVnwbopwJxKanq+gSrYxpT5YrCu1T3vVM/fQEAqbnrf8cyp6UMhcio7XHG
         w7DbTD3QcEXyRmpWPAtOhMU8Dt+q7jtbs5WqVvI7NtGEdCv6FzCNkGUkHsA6LTBeYxZs
         2nLmXj21HTNHgNidtJny3gLcOEB5wleJ1dO8vw3j4nJdyEEJG1IqiWQ5xPgOO/X+ITjz
         HyyLbi8cxs5/oYG4PvSA4hIaQLQnb5bcslREP97QD2AeD1GMsicNN5dHXj7V+ndWe6Eo
         OqveCdWmCIIPocGFvJfhsIQ+Db7DQb8N7EpuP2ehrNqI2LGsjJgrCvco3SR58mGX69t9
         5D9g==
X-Gm-Message-State: AOJu0YwgwqCndUf3Ix5t6WfLXhrln4bw8vu9FVO87NGlhUn7umQnNn2S
	a1hXeY5TrEoFseO/M4IOezQIZPrY8ezO+eXbWZQ=
X-Google-Smtp-Source: AGHT+IGt+2lUSniG9n1WfTC+6eWFO1Jr7yjUgnEmgfGsp46sdzNP5/ZxAId7fCY8cRHUv0lkCdqkig==
X-Received: by 2002:a17:906:fe41:b0:9b6:aac1:6fa5 with SMTP id wz1-20020a170906fe4100b009b6aac16fa5mr16218048ejb.55.1699344378446;
        Tue, 07 Nov 2023 00:06:18 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906bc5200b009c503bf61c9sm734050ejv.165.2023.11.07.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:17 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 7/7] devlink: print nested devlink handle for devlink dev
Date: Tue,  7 Nov 2023 09:06:07 +0100
Message-ID: <20231107080607.190414-8-jiri@resnulli.us>
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


