Return-Path: <netdev+bounces-46371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCCB7E364C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5381C1C20A94
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB5101E6;
	Tue,  7 Nov 2023 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d7Rs8sia"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DCDDB5
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:14 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43474114
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so9181382a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344371; x=1699949171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTqhdD/yxa3vJkiQbvPLc+KLXqkT95pVduQu/oE9MT0=;
        b=d7Rs8siaLndrLEzIEyF+3XjRKP4Ygb+ff/8WNUGyFCCrCfyTlQLd10zAEQxrvXVh9S
         /REmGT6DTsmk6vwSThREaQqgsVYzre7v+YOFGZ33QRHq75pM6tCMIJ3/xf1671EeA1eC
         oUqxJIMh4qUXdhN+hLXOMxDZOvFf1OvCHkDfs7+vOg/vGStp++mc+eXc3P4JWJ/CCCHr
         BRm0oPZWt1z29WIbZKD8DXw4eq6lfEEShBCwI9aqtWMV0p057DbLbGjERFzhzKMAekV+
         4jDoUDd0nL0Cc3V7BMB+HOoQWaK1gPxpP1zTBDrhfiT5mpa8RP7fw61KP1X8BhnoChma
         cqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344371; x=1699949171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTqhdD/yxa3vJkiQbvPLc+KLXqkT95pVduQu/oE9MT0=;
        b=EOMHo2WabT9zR/9NENcx2AU8OKWBqqgp9V/gV4pF3R5TBqovvxclhQepaN19Ue1R++
         PJ8xZ1Qw4BTqzyvenMAuy3SAxt9i4M+0rzNQdKLWTOuTqxiCzEmPtr/z7hzSZddkFWXj
         gKvikqfrYkc8itICIcw6YGOrmj6Hnhn4dD2LgJsbCA4kqNTkV2KNCdoptz93l3Qs6IZ+
         Et2Al2FYwHTRPOrl1C69uQibtY9UBEaIq5kT/P49KHAgEZg6Fwt0iyP2mA8vluMRxfRD
         22xXHPzVuAlXNhY0N2o5AoZclqOl+mTdUzH1fKucfMqSdK2wrp9ER7yoCchxlzomRCgQ
         /LxQ==
X-Gm-Message-State: AOJu0Yy7yZ/W7d95/TRZG1v7QtqzOERIcqhveM3dxH9N6irPWGjTvTbY
	isr7d5jKIOpNkMgd3bBdGMheUpB3KjaFX0mdmlc=
X-Google-Smtp-Source: AGHT+IG0VEZZB4zTTQBPetYz02vGMps+8gRTuAcAlCjRt4p6QMJJji2BDzD7fggeDTOHezTtfKfcyQ==
X-Received: by 2002:aa7:c1cb:0:b0:53e:3839:fc81 with SMTP id d11-20020aa7c1cb000000b0053e3839fc81mr23369086edp.32.1699344371665;
        Tue, 07 Nov 2023 00:06:11 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id g15-20020a50d0cf000000b0053e408aec8bsm5325585edf.6.2023.11.07.00.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:11 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 2/7] devlink: use snprintf instead of sprintf
Date: Tue,  7 Nov 2023 09:06:02 +0100
Message-ID: <20231107080607.190414-3-jiri@resnulli.us>
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

Use snprintf instead of sprintf to ensure only valid memory is printed
to and the output string is properly terminated.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- new patch
---
 devlink/devlink.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 3baad355759e..b711e92caaba 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2761,8 +2761,9 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 	    !tb[DEVLINK_ATTR_DEV_NAME])
 		return;
 
-	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
-		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
+	snprintf(buf, sizeof(buf), "%s/%s",
+		 mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
+		 mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
 	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
 }
 
@@ -2773,7 +2774,7 @@ static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,
 	const char *dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
 	char buf[64];
 
-	sprintf(buf, "%s/%s", bus_name, dev_name);
+	snprintf(buf, sizeof(buf), "%s/%s", bus_name, dev_name);
 
 	if (dl->json_output) {
 		if (array) {
@@ -2832,7 +2833,7 @@ static void pr_out_selftests_handle_start(struct dl *dl, struct nlattr **tb)
 	const char *dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
 	char buf[64];
 
-	sprintf(buf, "%s/%s", bus_name, dev_name);
+	snprintf(buf, sizeof(buf), "%s/%s", bus_name, dev_name);
 
 	if (dl->json_output) {
 		if (should_arr_last_handle_end(dl, bus_name, dev_name))
@@ -2902,9 +2903,10 @@ static void __pr_out_port_handle_start(struct dl *dl, const char *bus_name,
 	if (dl->no_nice_names || !try_nice ||
 	    ifname_map_rev_lookup(dl, bus_name, dev_name,
 				  port_index, &ifname) != 0)
-		sprintf(buf, "%s/%s/%d", bus_name, dev_name, port_index);
+		snprintf(buf, sizeof(buf), "%s/%s/%d",
+			 bus_name, dev_name, port_index);
 	else
-		sprintf(buf, "%s", ifname);
+		snprintf(buf, sizeof(buf), "%s", ifname);
 
 	if (dl->json_output) {
 		if (array) {
@@ -5230,7 +5232,7 @@ pr_out_port_rate_handle_start(struct dl *dl, struct nlattr **tb, bool try_nice)
 	bus_name = mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]);
 	dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
 	node_name = mnl_attr_get_str(tb[DEVLINK_ATTR_RATE_NODE_NAME]);
-	sprintf(buf, "%s/%s/%s", bus_name, dev_name, node_name);
+	snprintf(buf, sizeof(buf), "%s/%s/%s", bus_name, dev_name, node_name);
 	if (dl->json_output)
 		open_json_object(buf);
 	else
@@ -6305,7 +6307,7 @@ static void pr_out_json_occ_show_item_list(struct dl *dl, const char *label,
 
 	open_json_object(label);
 	list_for_each_entry(occ_item, list, list) {
-		sprintf(buf, "%u", occ_item->index);
+		snprintf(buf, sizeof(buf), "%u", occ_item->index);
 		open_json_object(buf);
 		if (bound_pool)
 			print_uint(PRINT_JSON, "bound_pool", NULL,
@@ -8674,7 +8676,7 @@ static void pr_out_region_handle_start(struct dl *dl, struct nlattr **tb)
 	const char *region_name = mnl_attr_get_str(tb[DEVLINK_ATTR_REGION_NAME]);
 	char buf[256];
 
-	sprintf(buf, "%s/%s/%s", bus_name, dev_name, region_name);
+	snprintf(buf, sizeof(buf), "%s/%s/%s", bus_name, dev_name, region_name);
 	if (dl->json_output)
 		open_json_object(buf);
 	else
-- 
2.41.0


