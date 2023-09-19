Return-Path: <netdev+bounces-34949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B837A61D5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F90281732
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7A33991;
	Tue, 19 Sep 2023 11:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BBC15BE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:57:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082FF4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-403012f27e3so63296055e9.3
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124618; x=1695729418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY/dd8qXYtYbD0sLTcojKvwEIrcDT96hMholuoW3bIg=;
        b=ClHA9ALD1KgmKPFjzdPmG7gXJ2KxZSmGJBMNOIeeKR5wxl3sBfpmHN0JSFA3Qgyprj
         oxg2DZNw8hINuRQScXw8kr7kYpMpX64a2o4hHTTXjSgIwUna4nrENf0HP4SRiFvRkf64
         VdM0VML5HAnC8vMTCsfH9VH4U1pA6FsTVFRVV+DxJE2tfvVeGXF5TSoSaiTxC7vrdcMH
         19g8EvSCgCfIsCh1vr0d1gnRbP3MbpW65LLhIqD5LDo8xu8MfdbNd25zjh/Cj+/2HuAI
         jbHfz3AfvtHmirHIMV5DoPRkEq8PfJjP3IFiVJwSwr7wKnY3hXi22ET/T6ayPQW+KpoP
         OG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124618; x=1695729418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY/dd8qXYtYbD0sLTcojKvwEIrcDT96hMholuoW3bIg=;
        b=pQmLrVlJBl20kRAbiXsg5ttvP3sYQsIBQbqr5ogBfpWnoxNj8dNsuXi333eJxJuTS7
         /gqn7KOEo6vxY4YUNRmHUMC5Tdl0JJNyB786nmVVE2dxNc1zaHF2xZ5E5mkILgppLftT
         YYmuUD/OwqL9tVHCKW6pkSfGMJjW3Pv8f+u6SQJoLSpDJm1q17tujKIhX4R+9cCA9/p6
         JaYXZbJaywuQbUDmnab/N1kW6eF1VZRGhf2hfzwJY7ZIk1vOYcghYAVk75HV11EhD//v
         JIf4d7tVAvkjL1L9QBQ/6BSnFWYmQLN64N7PeHsg+gx8HUGLLJZe/Lhypp51r+hpx19L
         R1Fw==
X-Gm-Message-State: AOJu0YwK189U6ApyCDRfFDYibv2hbglqRlhk+4f9hVtworuloPXWgCeg
	9QMxTSBI4tVxv3VE+1VGexh6/kgMci7HdNzJrtM=
X-Google-Smtp-Source: AGHT+IHda+rhFfeLOHgxr3h78IktT/bw8hZ2J0jw4f8WCe0Nsv5FKVlQb0Xi//ZZN75qByTSY+Av9A==
X-Received: by 2002:a7b:c4cc:0:b0:401:aa8f:7570 with SMTP id g12-20020a7bc4cc000000b00401aa8f7570mr10875626wmk.1.1695124618222;
        Tue, 19 Sep 2023 04:56:58 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003feee8d8011sm18125856wmj.41.2023.09.19.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:57 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v2 5/5] devlink: print nested devlink handle for devlink dev
Date: Tue, 19 Sep 2023 13:56:44 +0200
Message-ID: <20230919115644.1157890-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919115644.1157890-1-jiri@resnulli.us>
References: <20230919115644.1157890-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Devlink dev may contain one or more nested devlink instances. If one is
present, print it out simple. If more are present (there is no
such case in current kernel, but may be in theory in the future),
print them in array.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b30e4fd8e282..06c1fbaa2404 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3844,13 +3844,50 @@ static void pr_out_reload_data(struct dl *dl, struct nlattr **tb)
 	pr_out_object_end(dl);
 }
 
+static void pr_out_dev_nested(struct dl *dl, const struct nlmsghdr *nlh)
+{
+	struct nlattr *attr, *attr2;
+	int count = 0;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		if (mnl_attr_get_type(attr) == DEVLINK_ATTR_NESTED_DEVLINK) {
+			count++;
+			attr2 = attr;
+		}
+	}
+	if (!count) {
+		return;
+	} else if (count == 1) {
+		pr_out_nested_handle(attr2);
+		return;
+	}
+
+	pr_out_array_start(dl, "nested_devlinks");
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		if (mnl_attr_get_type(attr) == DEVLINK_ATTR_NESTED_DEVLINK) {
+			check_indent_newline(dl);
+			if (dl->json_output)
+				open_json_object(NULL);
+			check_indent_newline(dl);
+			pr_out_nested_handle(attr);
+			if (dl->json_output)
+				close_json_object();
+			else
+				__pr_out_newline();
+		}
+	}
+	pr_out_array_end(dl);
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
@@ -3867,7 +3904,7 @@ static int cmd_dev_show_cb(const struct nlmsghdr *nlh, void *data)
 	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME])
 		return MNL_CB_ERROR;
 
-	pr_out_dev(dl, tb);
+	pr_out_dev(dl, nlh, tb);
 	return MNL_CB_OK;
 }
 
@@ -6783,7 +6820,7 @@ static int cmd_mon_show_cb(const struct nlmsghdr *nlh, void *data)
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


