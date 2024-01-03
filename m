Return-Path: <netdev+bounces-61071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FA822601
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B501F22453
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885A62D;
	Wed,  3 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="yLgnA4eT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127D257E
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so4207377b3a.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242169; x=1704846969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgVIYHhcRrcBmcar/jXnvQJ+Eb4s64gp589ASDDzuQ4=;
        b=yLgnA4eTo6K52wgvPdw/B6HHH0A12AN/ettWceA3gJKQC/VhxHoIStoLl8dw8jFYoZ
         b6BFjwUUwR06MyjxjT0B2xIeVKIy+qoPn+Sp0St5PZzCv7jglcev6+6EYE973AvEoe4g
         pA0I1rhAiHwFnF0SEXDn6ESIf1WX38svNdlA2pp0OlfE6p6OlVxC4pGSg8nhJU6umE5N
         AdyWuTaApTDKPfKfxMSbF5EG1GjLFL0LaWvi5sy/a0I0OO1TMubBxRm91z2YnTsQg+OJ
         abJxCFGUAAJwETde3mpTxJC/glKEFz72S7KuAx5Y8jOdNCi4v4P+6pN8klbxawVT4Lv7
         IoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242169; x=1704846969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgVIYHhcRrcBmcar/jXnvQJ+Eb4s64gp589ASDDzuQ4=;
        b=OrANulU0IwvBHu7nKXq3Atordv+vhDGlaD+OviW35g0TZas0Ed/cRFoYYWYTyNT1wA
         PNu8u7odHc8j4eOXUPu9tkDr0igUw5KLweIAH6G1iFgj6g84B1rU8YK/YuVCu0r3W4eY
         vvzv3OfJqSN4DRYqxsgP06kgwddWVEo4qOOlJ6xVPsqH7bq03fgiGn1TGiSGF0yFM7WL
         lGYlbWPYtddyUyGQhXTl0wstdZYqFT6otbq3idXxMUP5ZOmM8skNQ5MEIVl/VLEFBrAA
         eBf29gungBtq7upfymBPhLYVI6KrOg4NjsnqslOBFdKY/Z7jiiyfRR1rxTn/94KoUN3e
         Xbpw==
X-Gm-Message-State: AOJu0YzlMGTReqXHdHlZ5K1s1MOmuX9pu65b7xT4yyTi4+OiYsQqaJdF
	xjog/PcBYQ/0x2b1eRSWp7wNOAC7Ptulcw==
X-Google-Smtp-Source: AGHT+IGyWjZYDL2ueMyie/4skyDTevHUh5mG7WaH+deZsZj9CgzhwBTd0zlBUMHrZUVyZRL+lqWIFw==
X-Received: by 2002:a05:6a00:130f:b0:6d9:b5cb:d773 with SMTP id j15-20020a056a00130f00b006d9b5cbd773mr341915pfu.22.1704242169202;
        Tue, 02 Jan 2024 16:36:09 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 1/8] rdma: shorten print_ lines
Date: Tue,  2 Jan 2024 16:34:26 -0800
Message-ID: <20240103003558.20615-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the shorter form of print_ function some of the lines can
now be shortened. Max line length in iproute2 should be 100 characters
or less.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/dev.c     |  6 ++----
 rdma/link.c    | 16 ++++++----------
 rdma/res-cq.c  |  3 +--
 rdma/res-qp.c  |  9 +++------
 rdma/res-srq.c |  3 +--
 rdma/res.c     | 11 ++++-------
 rdma/stat.c    | 20 +++++++-------------
 rdma/sys.c     | 10 +++-------
 rdma/utils.c   | 15 +++++----------
 9 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/rdma/dev.c b/rdma/dev.c
index e3483482c823..7496162df9e2 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -144,8 +144,7 @@ static void dev_print_sys_image_guid(struct rd *rd, struct nlattr **tb)
 	sys_image_guid = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_SYS_IMAGE_GUID]);
 	memcpy(vp, &sys_image_guid, sizeof(uint64_t));
 	snprintf(str, 32, "%04x:%04x:%04x:%04x", vp[3], vp[2], vp[1], vp[0]);
-	print_string(PRINT_ANY, "sys_image_guid",
-			   "sys_image_guid %s ", str);
+	print_string(PRINT_ANY, "sys_image_guid", "sys_image_guid %s ", str);
 }
 
 static void dev_print_dim_setting(struct rd *rd, struct nlattr **tb)
@@ -185,8 +184,7 @@ static void dev_print_node_type(struct rd *rd, struct nlattr **tb)
 
 	node_type = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_DEV_NODE_TYPE]);
 	node_str = node_type_to_str(node_type);
-	print_string(PRINT_ANY, "node_type", "node_type %s ",
-			   node_str);
+	print_string(PRINT_ANY, "node_type", "node_type %s ", node_str);
 }
 
 static void dev_print_dev_proto(struct rd *rd, struct nlattr **tb)
diff --git a/rdma/link.c b/rdma/link.c
index 913186cbfd73..48f7b0877468 100644
--- a/rdma/link.c
+++ b/rdma/link.c
@@ -120,8 +120,7 @@ static void link_print_subnet_prefix(struct rd *rd, struct nlattr **tb)
 	subnet_prefix = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_SUBNET_PREFIX]);
 	memcpy(vp, &subnet_prefix, sizeof(uint64_t));
 	snprintf(str, 32, "%04x:%04x:%04x:%04x", vp[3], vp[2], vp[1], vp[0]);
-	print_string(PRINT_ANY, "subnet_prefix",
-			   "subnet_prefix %s ", str);
+	print_string(PRINT_ANY, "subnet_prefix", "subnet_prefix %s ", str);
 }
 
 static void link_print_lid(struct rd *rd, struct nlattr **tb)
@@ -176,8 +175,7 @@ static void link_print_state(struct rd *rd, struct nlattr **tb)
 		return;
 
 	state = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_PORT_STATE]);
-	print_string(PRINT_ANY, "state", "state %s ",
-			   link_state_to_str(state));
+	print_string(PRINT_ANY, "state", "state %s ", link_state_to_str(state));
 }
 
 static const char *phys_state_to_str(uint8_t phys_state)
@@ -202,8 +200,8 @@ static void link_print_phys_state(struct rd *rd, struct nlattr **tb)
 		return;
 
 	phys_state = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_PORT_PHYS_STATE]);
-	print_string(PRINT_ANY, "physical_state",
-			   "physical_state %s ", phys_state_to_str(phys_state));
+	print_string(PRINT_ANY, "physical_state", "physical_state %s ",
+		     phys_state_to_str(phys_state));
 }
 
 static void link_print_netdev(struct rd *rd, struct nlattr **tb)
@@ -216,10 +214,8 @@ static void link_print_netdev(struct rd *rd, struct nlattr **tb)
 
 	netdev_name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_NDEV_NAME]);
 	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_NDEV_INDEX]);
-	print_string(PRINT_ANY, "netdev", "netdev %s ",
-			   netdev_name);
-	print_uint(PRINT_ANY, "netdev_index",
-			 rd->show_details ? "netdev_index %u " : "", idx);
+	print_string(PRINT_ANY, "netdev", "netdev %s ", netdev_name);
+	print_uint(PRINT_ANY, "netdev_index", rd->show_details ? "netdev_index %u " : "", idx);
 }
 
 static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
diff --git a/rdma/res-cq.c b/rdma/res-cq.c
index 9656773ffe6e..b4dcc026ed4b 100644
--- a/rdma/res-cq.c
+++ b/rdma/res-cq.c
@@ -21,8 +21,7 @@ static void print_poll_ctx(struct rd *rd, uint8_t poll_ctx, struct nlattr *attr)
 {
 	if (!attr)
 		return;
-	print_string(PRINT_ANY, "poll-ctx", "poll-ctx %s ",
-			   poll_ctx_to_str(poll_ctx));
+	print_string(PRINT_ANY, "poll-ctx", "poll-ctx %s ", poll_ctx_to_str(poll_ctx));
 }
 
 static void print_cq_dim_setting(struct rd *rd, struct nlattr *attr)
diff --git a/rdma/res-qp.c b/rdma/res-qp.c
index ef062c764c06..2390c0b5732b 100644
--- a/rdma/res-qp.c
+++ b/rdma/res-qp.c
@@ -37,14 +37,12 @@ static void print_rqpn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
 
 static void print_type(struct rd *rd, uint32_t val)
 {
-	print_string(PRINT_ANY, "type", "type %s ",
-			   qp_types_to_str(val));
+	print_string(PRINT_ANY, "type", "type %s ", qp_types_to_str(val));
 }
 
 static void print_state(struct rd *rd, uint32_t val)
 {
-	print_string(PRINT_ANY, "state", "state %s ",
-			   qp_states_to_str(val));
+	print_string(PRINT_ANY, "state", "state %s ", qp_states_to_str(val));
 }
 
 static void print_rqpsn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
@@ -60,8 +58,7 @@ static void print_pathmig(struct rd *rd, uint32_t val, struct nlattr **nla_line)
 	if (!nla_line[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE])
 		return;
 
-	print_string(PRINT_ANY, "path-mig-state",
-			   "path-mig-state %s ", path_mig_to_str(val));
+	print_string(PRINT_ANY, "path-mig-state", "path-mig-state %s ", path_mig_to_str(val));
 }
 
 static int res_qp_line_raw(struct rd *rd, const char *name, int idx,
diff --git a/rdma/res-srq.c b/rdma/res-srq.c
index 714abb96711a..e702fecd1f34 100644
--- a/rdma/res-srq.c
+++ b/rdma/res-srq.c
@@ -22,8 +22,7 @@ static const char *srq_types_to_str(uint8_t idx)
 
 static void print_type(struct rd *rd, uint32_t val)
 {
-	print_string(PRINT_ANY, "type", "type %s ",
-			   srq_types_to_str(val));
+	print_string(PRINT_ANY, "type", "type %s ", srq_types_to_str(val));
 }
 
 static void print_qps(char *qp_str)
diff --git a/rdma/res.c b/rdma/res.c
index b0efcd95f4fe..715cf93c4fab 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -51,9 +51,8 @@ static int res_print_summary(struct rd *rd, struct nlattr **tb)
 
 		name = mnl_attr_get_str(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME]);
 		curr = mnl_attr_get_u64(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
-		res_print_u64(
-			rd, name, curr,
-			nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
+		res_print_u64(rd, name, curr,
+			      nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
 	}
 	return 0;
 }
@@ -189,14 +188,12 @@ void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
 	}
 
 	if (!rd->json_output)
-		print_string(PRINT_ANY, NULL, "link %s ",
-				   tmp);
+		print_string(PRINT_ANY, NULL, "link %s ", tmp);
 }
 
 void print_qp_type(struct rd *rd, uint32_t val)
 {
-	print_string(PRINT_ANY, "qp-type", "qp-type %s ",
-			   qp_types_to_str(val));
+	print_string(PRINT_ANY, "qp-type", "qp-type %s ", qp_types_to_str(val));
 }
 
 void print_key(struct rd *rd, const char *name, uint64_t val,
diff --git a/rdma/stat.c b/rdma/stat.c
index 53d829e9ccf8..28b1ad857219 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -304,8 +304,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 
 		qpn = mnl_attr_get_u32(qp_line[RDMA_NLDEV_ATTR_RES_LQPN]);
 		if (!isfirst)
-			print_string(PRINT_FP, NULL, ",",
-					   NULL);
+			print_string(PRINT_FP, NULL, ",", NULL);
 		print_uint(PRINT_ANY, NULL, "%d", qpn);
 		isfirst = false;
 	}
@@ -790,28 +789,23 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 		if (supported || enabled) {
 			if (isfirst) {
 				open_json_object(NULL);
-				print_string(PRINT_ANY,
-						   "ifname", "link %s/", dev);
-				print_uint(PRINT_ANY, "port",
-						 "%u ", port);
+				print_string(PRINT_ANY, "ifname", "link %s/", dev);
+				print_uint(PRINT_ANY, "port", "%u ", port);
 				if (supported)
 					open_json_array(PRINT_ANY,
-						"supported optional-counters");
+							"supported optional-counters");
 				else
 					open_json_array(PRINT_ANY,
 							"optional-counters");
-				print_string(PRINT_FP, NULL,
-						   " ", NULL);
+				print_string(PRINT_FP, NULL, " ", NULL);
 				isfirst = false;
 			} else {
-				print_string(PRINT_FP, NULL,
-						   ",", NULL);
+				print_string(PRINT_FP, NULL, ",", NULL);
 			}
 			if (rd->pretty_output && !rd->json_output)
 				newline_indent(rd);
 
-			print_string(PRINT_ANY, NULL, "%s",
-					   name);
+			print_string(PRINT_ANY, NULL, "%s", name);
 		}
 	}
 
diff --git a/rdma/sys.c b/rdma/sys.c
index d7403a24027d..7bb0edbfec2b 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -36,8 +36,7 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 		else
 			mode_str = "unknown";
 
-		print_string(PRINT_ANY, "netns", "netns %s ",
-				   mode_str);
+		print_string(PRINT_ANY, "netns", "netns %s ", mode_str);
 	}
 
 	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
@@ -45,17 +44,14 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 
 		mode = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
 
-		print_on_off(PRINT_ANY, "privileged-qkey",
-				   "privileged-qkey %s ", mode);
+		print_on_off(PRINT_ANY, "privileged-qkey", "privileged-qkey %s ", mode);
 
 	}
 
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
-	print_on_off(PRINT_ANY, "copy-on-fork",
-			   "copy-on-fork %s\n",
-			   cof);
+	print_on_off(PRINT_ANY, "copy-on-fork", "copy-on-fork %s\n", cof);
 
 	return MNL_CB_OK;
 }
diff --git a/rdma/utils.c b/rdma/utils.c
index d647813c37fa..f73a9f19b617 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -872,24 +872,19 @@ static int print_driver_entry(struct rd *rd, struct nlattr *key_attr,
 
 	switch (attr_type) {
 	case RDMA_NLDEV_ATTR_DRIVER_STRING:
-		ret = print_driver_string(rd, key_str,
-					  mnl_attr_get_str(val_attr));
+		ret = print_driver_string(rd, key_str, mnl_attr_get_str(val_attr));
 		break;
 	case RDMA_NLDEV_ATTR_DRIVER_S32:
-		ret = print_driver_s32(rd, key_str, mnl_attr_get_u32(val_attr),
-				       print_type);
+		ret = print_driver_s32(rd, key_str, mnl_attr_get_u32(val_attr), print_type);
 		break;
 	case RDMA_NLDEV_ATTR_DRIVER_U32:
-		ret = print_driver_u32(rd, key_str, mnl_attr_get_u32(val_attr),
-				       print_type);
+		ret = print_driver_u32(rd, key_str, mnl_attr_get_u32(val_attr), print_type);
 		break;
 	case RDMA_NLDEV_ATTR_DRIVER_S64:
-		ret = print_driver_s64(rd, key_str, mnl_attr_get_u64(val_attr),
-				       print_type);
+		ret = print_driver_s64(rd, key_str, mnl_attr_get_u64(val_attr), print_type);
 		break;
 	case RDMA_NLDEV_ATTR_DRIVER_U64:
-		ret = print_driver_u64(rd, key_str, mnl_attr_get_u64(val_attr),
-				       print_type);
+		ret = print_driver_u64(rd, key_str, mnl_attr_get_u64(val_attr), print_type);
 		break;
 	}
 	free(key_str);
-- 
2.43.0


