Return-Path: <netdev+bounces-60729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61382150F
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82081F2144B
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D38D518;
	Mon,  1 Jan 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FVjZccCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396CDF51
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bd623c631so7252140a91.3
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704135040; x=1704739840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7y2S2KbHNw1PSwUgQJykkhAQ4Lozec7GoB1tQGnJa0=;
        b=FVjZccCa0NhcfeuuM5eaonmEfZ12GGx64Nco+MFR4gjzRlmyuuHvkbi4c4iiZy85jz
         a7kN0ZaWgYSLHjXDN4QEOHprThV0WiH3sGhiLIRpxRjkGcN0YWBt/3WAy4AWjjpcK5qM
         KTbhuoW8nX9oyWB1dxN4NQ5f3WhLWOnorNCRmyH+Kv4zcUaMQWD/0oRhNevYP6mRAQqT
         sDgM+Q7ltFbJ0eO28xe/jjzqbytPPIYZx/wGqi1Io8ixqVE5To5lV7wQsyzU4MZ4zYLn
         M4ajcZgKxQaVcWEXmEYPxTRmuXyQ+YilmKgIZgPOaAQudXtlSyMr7Cpm8ci4vYFTo3j8
         y3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704135040; x=1704739840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7y2S2KbHNw1PSwUgQJykkhAQ4Lozec7GoB1tQGnJa0=;
        b=GUt/d+yDxUlE5JCFv9MiIpSvvD7VQpvMoI9IVeGKOTl8Bgg7ZjVutVgas7AwOZc/9+
         h2FwD5teysQFELAk7JMx3k/aVhKivAZKSSgIXVgv3bPr6rmXxtOU1Gnyw2MJ01N0NSNE
         oMjqGnQu77cVOI+Ko8irs//6M3hkWhY7alQUReB0z0DKL7YaE59EJJxSNAbYfgTDQc8l
         2ICT6tK1vqwImEMHOf6Y/DEsU3zCRyLIf+OzFpPzFWaNpe88mG8tkhmLgTNK1BZrG9Q0
         PrgFPj+0PdJPo7Il+pdtJHGQmWmbvtwdw1dNZCjZnjW5sQwIY8SN9eX4WScSsdgsRPqJ
         F84w==
X-Gm-Message-State: AOJu0YwvdOzcvBLg6Qd22YSfVI2CedaL2osxDDR6l0DuRx4eoPTBFoDx
	JQT0dmxNLL4PVFAMquMR4LqeDdh7W9zxGCg423lfeq6RDqM=
X-Google-Smtp-Source: AGHT+IHu3fsDIfAYVUVadOyoP6DAOLz9ZXRkGs+vz4kco6ERGJhGWl+kY2kaul+jdHwF2rsZ+cRjpg==
X-Received: by 2002:a17:903:1251:b0:1d4:e0e:fa1b with SMTP id u17-20020a170903125100b001d40e0efa1bmr16991950plh.57.1704135040178;
        Mon, 01 Jan 2024 10:50:40 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ji4-20020a170903324400b001c9db5e2929sm20575877plb.93.2024.01.01.10.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:50:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: idok@mellanox.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] rdma: use print_XXX instead of COLOR_NONE
Date: Mon,  1 Jan 2024 10:50:00 -0800
Message-ID: <20240101185028.30229-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rdma utility should be using same code pattern as rest of
iproute2. When printing, color should only be requested when
desired; if no color wanted, use the simpler print_XXX instead.

Fixes: b0a688a542cd ("rdma: Rewrite custom JSON and prints logic to use common API")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/dev.c      | 18 +++++++++---------
 rdma/link.c     | 26 +++++++++++++-------------
 rdma/res-cmid.c | 10 +++++-----
 rdma/res-cq.c   |  2 +-
 rdma/res-qp.c   | 10 +++++-----
 rdma/res-srq.c  | 10 +++++-----
 rdma/res.c      | 32 ++++++++++++++++----------------
 rdma/stat.c     | 24 ++++++++++++------------
 rdma/sys.c      |  6 +++---
 rdma/utils.c    | 18 +++++++++---------
 10 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/rdma/dev.c b/rdma/dev.c
index 585bec54fa0e..e3483482c823 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -94,11 +94,11 @@ static void dev_print_caps(struct rd *rd, struct nlattr **tb)
 
 	caps = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_CAP_FLAGS]);
 
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, "\n    caps: <", NULL);
+	print_string(PRINT_FP, NULL, "\n    caps: <", NULL);
 	open_json_array(PRINT_JSON, "caps");
 	for (idx = 0; caps; idx++) {
 		if (caps & 0x1)
-			print_color_string(PRINT_ANY, COLOR_NONE, NULL,
+			print_string(PRINT_ANY, NULL,
 					   caps >> 0x1 ? "%s, " : "%s",
 					   dev_caps_to_str(idx));
 		caps >>= 0x1;
@@ -113,7 +113,7 @@ static void dev_print_fw(struct rd *rd, struct nlattr **tb)
 		return;
 
 	str = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_FW_VERSION]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "fw", "fw %s ", str);
+	print_string(PRINT_ANY, "fw", "fw %s ", str);
 }
 
 static void dev_print_node_guid(struct rd *rd, struct nlattr **tb)
@@ -128,7 +128,7 @@ static void dev_print_node_guid(struct rd *rd, struct nlattr **tb)
 	node_guid = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_NODE_GUID]);
 	memcpy(vp, &node_guid, sizeof(uint64_t));
 	snprintf(str, 32, "%04x:%04x:%04x:%04x", vp[3], vp[2], vp[1], vp[0]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "node_guid", "node_guid %s ",
+	print_string(PRINT_ANY, "node_guid", "node_guid %s ",
 			   str);
 }
 
@@ -144,7 +144,7 @@ static void dev_print_sys_image_guid(struct rd *rd, struct nlattr **tb)
 	sys_image_guid = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_SYS_IMAGE_GUID]);
 	memcpy(vp, &sys_image_guid, sizeof(uint64_t));
 	snprintf(str, 32, "%04x:%04x:%04x:%04x", vp[3], vp[2], vp[1], vp[0]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "sys_image_guid",
+	print_string(PRINT_ANY, "sys_image_guid",
 			   "sys_image_guid %s ", str);
 }
 
@@ -185,7 +185,7 @@ static void dev_print_node_type(struct rd *rd, struct nlattr **tb)
 
 	node_type = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_DEV_NODE_TYPE]);
 	node_str = node_type_to_str(node_type);
-	print_color_string(PRINT_ANY, COLOR_NONE, "node_type", "node_type %s ",
+	print_string(PRINT_ANY, "node_type", "node_type %s ",
 			   node_str);
 }
 
@@ -197,7 +197,7 @@ static void dev_print_dev_proto(struct rd *rd, struct nlattr **tb)
 		return;
 
 	str = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_PROTOCOL]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "protocol", "protocol %s ", str);
+	print_string(PRINT_ANY, "protocol", "protocol %s ", str);
 }
 
 static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
@@ -213,8 +213,8 @@ static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
 	open_json_object(NULL);
 	idx =  mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "ifindex", "%u: ", idx);
-	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "%s: ", name);
+	print_uint(PRINT_ANY, "ifindex", "%u: ", idx);
+	print_string(PRINT_ANY, "ifname", "%s: ", name);
 
 	dev_print_node_type(rd, tb);
 	dev_print_dev_proto(rd, tb);
diff --git a/rdma/link.c b/rdma/link.c
index bf24b849a1e0..913186cbfd73 100644
--- a/rdma/link.c
+++ b/rdma/link.c
@@ -96,11 +96,11 @@ static void link_print_caps(struct rd *rd, struct nlattr **tb)
 
 	caps = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_CAP_FLAGS]);
 
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, "\n    caps: <", NULL);
+	print_string(PRINT_FP, NULL, "\n    caps: <", NULL);
 	open_json_array(PRINT_JSON, "caps");
 	for (idx = 0; caps; idx++) {
 		if (caps & 0x1)
-			print_color_string(PRINT_ANY, COLOR_NONE, NULL,
+			print_string(PRINT_ANY, NULL,
 					   caps >> 0x1 ? "%s, " : "%s",
 					   caps_to_str(idx));
 		caps >>= 0x1;
@@ -120,7 +120,7 @@ static void link_print_subnet_prefix(struct rd *rd, struct nlattr **tb)
 	subnet_prefix = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_SUBNET_PREFIX]);
 	memcpy(vp, &subnet_prefix, sizeof(uint64_t));
 	snprintf(str, 32, "%04x:%04x:%04x:%04x", vp[3], vp[2], vp[1], vp[0]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "subnet_prefix",
+	print_string(PRINT_ANY, "subnet_prefix",
 			   "subnet_prefix %s ", str);
 }
 
@@ -132,7 +132,7 @@ static void link_print_lid(struct rd *rd, struct nlattr **tb)
 		return;
 
 	lid = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_LID]);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "lid", "lid %u ", lid);
+	print_uint(PRINT_ANY, "lid", "lid %u ", lid);
 }
 
 static void link_print_sm_lid(struct rd *rd, struct nlattr **tb)
@@ -143,7 +143,7 @@ static void link_print_sm_lid(struct rd *rd, struct nlattr **tb)
 		return;
 
 	sm_lid = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_SM_LID]);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "sm_lid", "sm_lid %u ", sm_lid);
+	print_uint(PRINT_ANY, "sm_lid", "sm_lid %u ", sm_lid);
 }
 
 static void link_print_lmc(struct rd *rd, struct nlattr **tb)
@@ -154,7 +154,7 @@ static void link_print_lmc(struct rd *rd, struct nlattr **tb)
 		return;
 
 	lmc = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_LMC]);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "lmc", "lmc %u ", lmc);
+	print_uint(PRINT_ANY, "lmc", "lmc %u ", lmc);
 }
 
 static const char *link_state_to_str(uint8_t link_state)
@@ -176,7 +176,7 @@ static void link_print_state(struct rd *rd, struct nlattr **tb)
 		return;
 
 	state = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_PORT_STATE]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "state", "state %s ",
+	print_string(PRINT_ANY, "state", "state %s ",
 			   link_state_to_str(state));
 }
 
@@ -202,7 +202,7 @@ static void link_print_phys_state(struct rd *rd, struct nlattr **tb)
 		return;
 
 	phys_state = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_PORT_PHYS_STATE]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "physical_state",
+	print_string(PRINT_ANY, "physical_state",
 			   "physical_state %s ", phys_state_to_str(phys_state));
 }
 
@@ -216,9 +216,9 @@ static void link_print_netdev(struct rd *rd, struct nlattr **tb)
 
 	netdev_name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_NDEV_NAME]);
 	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_NDEV_INDEX]);
-	print_color_string(PRINT_ANY, COLOR_NONE, "netdev", "netdev %s ",
+	print_string(PRINT_ANY, "netdev", "netdev %s ",
 			   netdev_name);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "netdev_index",
+	print_uint(PRINT_ANY, "netdev_index",
 			 rd->show_details ? "netdev_index %u " : "", idx);
 }
 
@@ -243,9 +243,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
 
 	open_json_object(NULL);
-	print_color_uint(PRINT_JSON, COLOR_NONE, "ifindex", NULL, idx);
-	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "link %s/", name);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "port", "%u ", port);
+	print_uint(PRINT_JSON, "ifindex", NULL, idx);
+	print_string(PRINT_ANY, "ifname", "link %s/", name);
+	print_uint(PRINT_ANY, "port", "%u ", port);
 	link_print_subnet_prefix(rd, tb);
 	link_print_lid(rd, tb);
 	link_print_sm_lid(rd, tb);
diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
index 7371c3a68184..fb32c58a695a 100644
--- a/rdma/res-cmid.c
+++ b/rdma/res-cmid.c
@@ -39,13 +39,13 @@ static const char *cm_id_ps_to_str(uint32_t ps)
 
 static void print_cm_id_state(struct rd *rd, uint8_t state)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, "state", "state %s ",
+	print_string(PRINT_ANY, "state", "state %s ",
 			   cm_id_state_to_str(state));
 }
 
 static void print_ps(struct rd *rd, uint32_t ps)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, "ps", "ps %s ",
+	print_string(PRINT_ANY, "ps", "ps %s ",
 			   cm_id_ps_to_str(ps));
 }
 
@@ -56,9 +56,9 @@ static void print_ipaddr(struct rd *rd, const char *key, char *addrstr,
 	char json_name[name_size];
 
 	snprintf(json_name, name_size, "%s:%u", addrstr, port);
-	print_color_string(PRINT_ANY, COLOR_NONE, key, key, json_name);
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, " %s:", addrstr);
-	print_color_uint(PRINT_FP, COLOR_NONE, NULL, "%u ", port);
+	print_string(PRINT_ANY, key, key, json_name);
+	print_string(PRINT_FP, NULL, " %s:", addrstr);
+	print_uint(PRINT_FP, NULL, "%u ", port);
 }
 
 static int ss_ntop(struct nlattr *nla_line, char *addr_str, uint16_t *port)
diff --git a/rdma/res-cq.c b/rdma/res-cq.c
index 2cfa4994e77a..9656773ffe6e 100644
--- a/rdma/res-cq.c
+++ b/rdma/res-cq.c
@@ -21,7 +21,7 @@ static void print_poll_ctx(struct rd *rd, uint8_t poll_ctx, struct nlattr *attr)
 {
 	if (!attr)
 		return;
-	print_color_string(PRINT_ANY, COLOR_NONE, "poll-ctx", "poll-ctx %s ",
+	print_string(PRINT_ANY, "poll-ctx", "poll-ctx %s ",
 			   poll_ctx_to_str(poll_ctx));
 }
 
diff --git a/rdma/res-qp.c b/rdma/res-qp.c
index c180a97e31ed..ef062c764c06 100644
--- a/rdma/res-qp.c
+++ b/rdma/res-qp.c
@@ -32,18 +32,18 @@ static void print_rqpn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
 {
 	if (!nla_line[RDMA_NLDEV_ATTR_RES_RQPN])
 		return;
-	print_color_uint(PRINT_ANY, COLOR_NONE, "rqpn", "rqpn %d ", val);
+	print_uint(PRINT_ANY, "rqpn", "rqpn %d ", val);
 }
 
 static void print_type(struct rd *rd, uint32_t val)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, "type", "type %s ",
+	print_string(PRINT_ANY, "type", "type %s ",
 			   qp_types_to_str(val));
 }
 
 static void print_state(struct rd *rd, uint32_t val)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, "state", "state %s ",
+	print_string(PRINT_ANY, "state", "state %s ",
 			   qp_states_to_str(val));
 }
 
@@ -52,7 +52,7 @@ static void print_rqpsn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
 	if (!nla_line[RDMA_NLDEV_ATTR_RES_RQ_PSN])
 		return;
 
-	print_color_uint(PRINT_ANY, COLOR_NONE, "rq-psn", "rq-psn %d ", val);
+	print_uint(PRINT_ANY, "rq-psn", "rq-psn %d ", val);
 }
 
 static void print_pathmig(struct rd *rd, uint32_t val, struct nlattr **nla_line)
@@ -60,7 +60,7 @@ static void print_pathmig(struct rd *rd, uint32_t val, struct nlattr **nla_line)
 	if (!nla_line[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE])
 		return;
 
-	print_color_string(PRINT_ANY, COLOR_NONE, "path-mig-state",
+	print_string(PRINT_ANY, "path-mig-state",
 			   "path-mig-state %s ", path_mig_to_str(val));
 }
 
diff --git a/rdma/res-srq.c b/rdma/res-srq.c
index cf9209d775e1..714abb96711a 100644
--- a/rdma/res-srq.c
+++ b/rdma/res-srq.c
@@ -22,7 +22,7 @@ static const char *srq_types_to_str(uint8_t idx)
 
 static void print_type(struct rd *rd, uint32_t val)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, "type", "type %s ",
+	print_string(PRINT_ANY, "type", "type %s ",
 			   srq_types_to_str(val));
 }
 
@@ -34,15 +34,15 @@ static void print_qps(char *qp_str)
 		return;
 
 	open_json_array(PRINT_ANY, "lqpn");
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, " ", NULL);
+	print_string(PRINT_FP, NULL, " ", NULL);
 	qpn = strtok(qp_str, ",");
 	while (qpn) {
-		print_color_string(PRINT_ANY, COLOR_NONE, NULL, "%s", qpn);
+		print_string(PRINT_ANY, NULL, "%s", qpn);
 		qpn = strtok(NULL, ",");
 		if (qpn)
-			print_color_string(PRINT_FP, COLOR_NONE, NULL, ",", NULL);
+			print_string(PRINT_FP, NULL, ",", NULL);
 	}
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, " ", NULL);
+	print_string(PRINT_FP, NULL, " ", NULL);
 	close_json_array(PRINT_JSON, NULL);
 }
 
diff --git a/rdma/res.c b/rdma/res.c
index 854f21c7c20e..b0efcd95f4fe 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -79,8 +79,8 @@ static int res_no_args_parse_cb(const struct nlmsghdr *nlh, void *data)
 	idx =  mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
 	open_json_object(NULL);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "ifindex", "%u: ", idx);
-	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "%s: ", name);
+	print_uint(PRINT_ANY, "ifindex", "%u: ", idx);
+	print_string(PRINT_ANY, "ifname", "%s: ", name);
 	res_print_summary(rd, tb);
 	newline(rd);
 	return MNL_CB_OK;
@@ -165,13 +165,13 @@ void print_comm(struct rd *rd, const char *str, struct nlattr **nla_line)
 		snprintf(tmp, sizeof(tmp), "%s", str);
 	else
 		snprintf(tmp, sizeof(tmp), "[%s]", str);
-	print_color_string(PRINT_ANY, COLOR_NONE, "comm", "comm %s ", tmp);
+	print_string(PRINT_ANY, "comm", "comm %s ", tmp);
 }
 
 void print_dev(struct rd *rd, uint32_t idx, const char *name)
 {
-	print_color_int(PRINT_ANY, COLOR_NONE, "ifindex", NULL, idx);
-	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "dev %s ", name);
+	print_int(PRINT_ANY, "ifindex", NULL, idx);
+	print_string(PRINT_ANY, "ifname", "dev %s ", name);
 }
 
 void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
@@ -179,23 +179,23 @@ void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
 {
 	char tmp[64] = {};
 
-	print_color_uint(PRINT_JSON, COLOR_NONE, "ifindex", NULL, idx);
-	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", NULL, name);
+	print_uint(PRINT_JSON, "ifindex", NULL, idx);
+	print_string(PRINT_ANY, "ifname", NULL, name);
 	if (nla_line[RDMA_NLDEV_ATTR_PORT_INDEX]) {
-		print_color_uint(PRINT_ANY, COLOR_NONE, "port", NULL, port);
+		print_uint(PRINT_ANY, "port", NULL, port);
 		snprintf(tmp, sizeof(tmp), "%s/%d", name, port);
 	} else {
 		snprintf(tmp, sizeof(tmp), "%s/-", name);
 	}
 
 	if (!rd->json_output)
-		print_color_string(PRINT_ANY, COLOR_NONE, NULL, "link %s ",
+		print_string(PRINT_ANY, NULL, "link %s ",
 				   tmp);
 }
 
 void print_qp_type(struct rd *rd, uint32_t val)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, "qp-type", "qp-type %s ",
+	print_string(PRINT_ANY, "qp-type", "qp-type %s ",
 			   qp_types_to_str(val));
 }
 
@@ -204,8 +204,8 @@ void print_key(struct rd *rd, const char *name, uint64_t val,
 {
 	if (!nlattr)
 		return;
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, name, NULL);
-	print_color_hex(PRINT_ANY, COLOR_NONE, name, " 0x%" PRIx64 " ", val);
+	print_string(PRINT_FP, NULL, name, NULL);
+	print_hex(PRINT_ANY, name, " 0x%" PRIx64 " ", val);
 }
 
 void res_print_u32(struct rd *rd, const char *name, uint32_t val,
@@ -213,8 +213,8 @@ void res_print_u32(struct rd *rd, const char *name, uint32_t val,
 {
 	if (!nlattr)
 		return;
-	print_color_uint(PRINT_ANY, COLOR_NONE, name, name, val);
-	print_color_uint(PRINT_FP, COLOR_NONE, NULL, " %" PRIu32 " ", val);
+	print_uint(PRINT_ANY, name, name, val);
+	print_uint(PRINT_FP, NULL, " %" PRIu32 " ", val);
 }
 
 void res_print_u64(struct rd *rd, const char *name, uint64_t val,
@@ -222,8 +222,8 @@ void res_print_u64(struct rd *rd, const char *name, uint64_t val,
 {
 	if (!nlattr)
 		return;
-	print_color_u64(PRINT_ANY, COLOR_NONE, name, name, val);
-	print_color_u64(PRINT_FP, COLOR_NONE, NULL, " %" PRIu64 " ", val);
+	print_u64(PRINT_ANY, name, name, val);
+	print_u64(PRINT_FP, NULL, " %" PRIu64 " ", val);
 }
 
 RES_FUNC(res_no_args,	RDMA_NLDEV_CMD_RES_GET,	NULL, true, 0);
diff --git a/rdma/stat.c b/rdma/stat.c
index 3df2c98f4d9a..53d829e9ccf8 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -135,7 +135,7 @@ static int qp_link_get_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
 
 	open_json_object(NULL);
 	print_link(rd, idx, name, port, tb);
-	print_color_string(PRINT_ANY, COLOR_NONE, "mode", "mode %s ", output);
+	print_string(PRINT_ANY, "mode", "mode %s ", output);
 	newline(rd);
 	return MNL_CB_OK;
 }
@@ -284,7 +284,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 		return err;
 	open_json_object(NULL);
 	print_link(rd, index, name, port, nla_line);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "cntn", "cntn %u ", cntn);
+	print_uint(PRINT_ANY, "cntn", "cntn %u ", cntn);
 	if (nla_line[RDMA_NLDEV_ATTR_RES_TYPE])
 		print_qp_type(rd, qp_type);
 	res_print_u64(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
@@ -292,7 +292,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 	res_get_hwcounters(rd, hwc_table, true);
 	isfirst = true;
 	open_json_array(PRINT_JSON, "lqpn");
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, "\n    LQPN: <", NULL);
+	print_string(PRINT_FP, NULL, "\n    LQPN: <", NULL);
 	mnl_attr_for_each_nested(nla_entry, qp_table) {
 		struct nlattr *qp_line[RDMA_NLDEV_ATTR_MAX] = {};
 		err = mnl_attr_parse_nested(nla_entry, rd_attr_cb, qp_line);
@@ -304,9 +304,9 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 
 		qpn = mnl_attr_get_u32(qp_line[RDMA_NLDEV_ATTR_RES_LQPN]);
 		if (!isfirst)
-			print_color_string(PRINT_FP, COLOR_NONE, NULL, ",",
+			print_string(PRINT_FP, NULL, ",",
 					   NULL);
-		print_color_uint(PRINT_ANY, COLOR_NONE, NULL, "%d", qpn);
+		print_uint(PRINT_ANY, NULL, "%d", qpn);
 		isfirst = false;
 	}
 	close_json_array(PRINT_ANY, ">");
@@ -790,9 +790,9 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 		if (supported || enabled) {
 			if (isfirst) {
 				open_json_object(NULL);
-				print_color_string(PRINT_ANY, COLOR_NONE,
+				print_string(PRINT_ANY,
 						   "ifname", "link %s/", dev);
-				print_color_uint(PRINT_ANY, COLOR_NONE, "port",
+				print_uint(PRINT_ANY, "port",
 						 "%u ", port);
 				if (supported)
 					open_json_array(PRINT_ANY,
@@ -800,17 +800,17 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 				else
 					open_json_array(PRINT_ANY,
 							"optional-counters");
-				print_color_string(PRINT_FP, COLOR_NONE, NULL,
+				print_string(PRINT_FP, NULL,
 						   " ", NULL);
 				isfirst = false;
 			} else {
-				print_color_string(PRINT_FP, COLOR_NONE, NULL,
+				print_string(PRINT_FP, NULL,
 						   ",", NULL);
 			}
 			if (rd->pretty_output && !rd->json_output)
 				newline_indent(rd);
 
-			print_color_string(PRINT_ANY, COLOR_NONE, NULL, "%s",
+			print_string(PRINT_ANY, NULL, "%s",
 					   name);
 		}
 	}
@@ -1074,8 +1074,8 @@ static int stat_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
 	port = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
 	open_json_object(NULL);
-	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "link %s/", name);
-	print_color_uint(PRINT_ANY, COLOR_NONE, "port", "%u ", port);
+	print_string(PRINT_ANY, "ifname", "link %s/", name);
+	print_uint(PRINT_ANY, "port", "%u ", port);
 	ret = res_get_hwcounters(rd, tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS], true);
 
 	newline(rd);
diff --git a/rdma/sys.c b/rdma/sys.c
index 3e369553fdc7..d7403a24027d 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -36,7 +36,7 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 		else
 			mode_str = "unknown";
 
-		print_color_string(PRINT_ANY, COLOR_NONE, "netns", "netns %s ",
+		print_string(PRINT_ANY, "netns", "netns %s ",
 				   mode_str);
 	}
 
@@ -45,7 +45,7 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 
 		mode = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
 
-		print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
+		print_on_off(PRINT_ANY, "privileged-qkey",
 				   "privileged-qkey %s ", mode);
 
 	}
@@ -53,7 +53,7 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
-	print_color_on_off(PRINT_ANY, COLOR_NONE, "copy-on-fork",
+	print_on_off(PRINT_ANY, "copy-on-fork",
 			   "copy-on-fork %s\n",
 			   cof);
 
diff --git a/rdma/utils.c b/rdma/utils.c
index 099850693d6c..d647813c37fa 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -774,20 +774,20 @@ struct dev_map *dev_map_lookup(struct rd *rd, bool allow_port_index)
 void newline(struct rd *rd)
 {
 	close_json_object();
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, "\n", NULL);
+	print_string(PRINT_FP, NULL, "\n", NULL);
 }
 
 void newline_indent(struct rd *rd)
 {
 	newline(rd);
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, "    ", NULL);
+	print_string(PRINT_FP, NULL, "    ", NULL);
 }
 
 static int print_driver_string(struct rd *rd, const char *key_str,
 				 const char *val_str)
 {
-	print_color_string(PRINT_ANY, COLOR_NONE, key_str, key_str, val_str);
-	print_color_string(PRINT_FP, COLOR_NONE, NULL, " %s ", val_str);
+	print_string(PRINT_ANY, key_str, key_str, val_str);
+	print_string(PRINT_FP, NULL, " %s ", val_str);
 	return 0;
 }
 
@@ -804,7 +804,7 @@ static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
 			return -EINVAL;
 		}
 	}
-	print_color_int(PRINT_JSON, COLOR_NONE, key_str, NULL, val);
+	print_int(PRINT_JSON, key_str, NULL, val);
 	return 0;
 }
 
@@ -821,7 +821,7 @@ static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
 			return -EINVAL;
 		}
 	}
-	print_color_int(PRINT_JSON, COLOR_NONE, key_str, NULL, val);
+	print_int(PRINT_JSON, key_str, NULL, val);
 	return 0;
 }
 
@@ -838,7 +838,7 @@ static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
 			return -EINVAL;
 		}
 	}
-	print_color_int(PRINT_JSON, COLOR_NONE, key_str, NULL, val);
+	print_int(PRINT_JSON, key_str, NULL, val);
 	return 0;
 }
 
@@ -855,7 +855,7 @@ static int print_driver_u64(struct rd *rd, const char *key_str, uint64_t val,
 			return -EINVAL;
 		}
 	}
-	print_color_int(PRINT_JSON, COLOR_NONE, key_str, NULL, val);
+	print_int(PRINT_JSON, key_str, NULL, val);
 	return 0;
 }
 
@@ -909,7 +909,7 @@ void print_raw_data(struct rd *rd, struct nlattr **nla_line)
 	data = mnl_attr_get_payload(nla_line[RDMA_NLDEV_ATTR_RES_RAW]);
 	open_json_array(PRINT_JSON, "data");
 	while (i < len) {
-		print_color_uint(PRINT_ANY, COLOR_NONE, NULL, "%d", data[i]);
+		print_uint(PRINT_ANY, NULL, "%d", data[i]);
 		i++;
 	}
 	close_json_array(PRINT_ANY, ">");
-- 
2.43.0


