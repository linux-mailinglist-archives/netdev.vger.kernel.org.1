Return-Path: <netdev+bounces-61416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68144823A19
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1AF1C24B8F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C11849;
	Thu,  4 Jan 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lcV10Oxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B8184F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28c2b8d6f2aso4297610a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 17:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704330874; x=1704935674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joh+KKCav0TyiAWmMDEkWm48inIYUD1e06QlNTY3D3Y=;
        b=lcV10OxsKydroYEAoNgxKUPdwcOFlZe9ahcMaWoS1oX6hNg/jbU5b7Im4kKZQhhV4y
         TM8CdW/86D+bCWz/NcOgOQd30b+QjqzqrjeS5+gKyZif4kF5mXkSW78R1WHTsEcwMFva
         mG2sdk12Odka0Wajhtz+Wo8CZ5FrBKH+8ofO5XOniU2jD2RB/8lfy/Tr7hGRt815EV3j
         bEy4Vbkakfxhr7jHULcaC57k/X7jGHpu0zv4GLkRgbazuOsGeYBM/dzrdWEj6GsJruzL
         xv3xcz/HzrZ4FSpPw0E8WPkRwhuDOrFncHtS5xDc4wIwnfN3dMHACdEQ7d2635UwqoUU
         4QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704330874; x=1704935674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joh+KKCav0TyiAWmMDEkWm48inIYUD1e06QlNTY3D3Y=;
        b=k78Dk9+OlAxmXd0nwwZSWYnPq7FNx5DU8PqJ6JemchqFnd13oYvPH2/CyDhmLv62Em
         QA6S2Rq25xOuvduAtErre3u/IFNpj0tFGA715U7aDJyS0YIrN9i/+2F9DoqBUOClu06m
         vKKgREO5TS+CpZPTSNCTMvPyNYbFr5rHRp8VUHUq+pyQTfCtuGfQUPBFmSkYwKbAB2G7
         IQqyDFCgo2rC1sCEwCB0TRMW9rIPsp+8DgEPPZt+VtpbcDyfzZ31LKzk9q9c6pnnwOSn
         jkhKOPxHbaGN1sXflItZIhbvgbs2Dviow1ll8pK2QPrPGQ/zhbaY/0zDpEHuSqOTq1/p
         KpUg==
X-Gm-Message-State: AOJu0YwH7gLUFWKyvib4ieILaFJV5/HdfIksRg0vvMZ/xQBd/QyEIPMw
	vMVq1gzpG58248Gmnj7oEcAvdefNEHkCq6K9sdhdmXZbjB4=
X-Google-Smtp-Source: AGHT+IFOfLsoRLLndiB4CkPS4cG2BRmN5sYFHxl7pXKlqgyDX7KVslLmMEXRY4kVwsAcGKP/G51+oA==
X-Received: by 2002:a17:90a:fb8b:b0:28c:1c30:aaac with SMTP id cp11-20020a17090afb8b00b0028c1c30aaacmr5822690pjb.70.1704330874548;
        Wed, 03 Jan 2024 17:14:34 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b0028adcc0f2c4sm2510124pjl.18.2024.01.03.17.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 17:14:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 2/6] rdma: use standard flag for json
Date: Wed,  3 Jan 2024 17:13:40 -0800
Message-ID: <20240104011422.26736-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104011422.26736-1-stephen@networkplumber.org>
References: <20240104011422.26736-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The other iproute2 utils use variable json as flag.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.c  |  7 ++++---
 rdma/rdma.h  |  1 -
 rdma/res.c   |  5 ++---
 rdma/stat.c  |  4 ++--
 rdma/utils.c | 12 ++++++------
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/rdma/rdma.c b/rdma/rdma.c
index 8dc2d3e344be..60ba8c0e5594 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -8,6 +8,9 @@
 #include "version.h"
 #include "color.h"
 
+/* Global utils flags */
+int json;
+
 static void help(char *name)
 {
 	pr_out("Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
@@ -96,7 +99,6 @@ int main(int argc, char **argv)
 	bool show_driver_details = false;
 	const char *batch_file = NULL;
 	bool show_details = false;
-	bool json_output = false;
 	bool show_raw = false;
 	bool force = false;
 	struct rd rd = {};
@@ -125,7 +127,7 @@ int main(int argc, char **argv)
 			show_raw = true;
 			break;
 		case 'j':
-			json_output = 1;
+			++json;
 			break;
 		case 'f':
 			force = true;
@@ -151,7 +153,6 @@ int main(int argc, char **argv)
 
 	rd.show_details = show_details;
 	rd.show_driver_details = show_driver_details;
-	rd.json_output = json_output;
 	rd.pretty_output = pretty;
 	rd.show_raw = show_raw;
 
diff --git a/rdma/rdma.h b/rdma/rdma.h
index 0bf77f4dcf9e..f6830c851fb1 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -68,7 +68,6 @@ struct rd {
 	struct nlmsghdr *nlh;
 	char *buff;
 	json_writer_t *jw;
-	int json_output;
 	int pretty_output;
 	bool suppress_errors;
 	struct list_head filter_list;
diff --git a/rdma/res.c b/rdma/res.c
index 715cf93c4fab..f64224e1f3eb 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -160,7 +160,7 @@ void print_comm(struct rd *rd, const char *str, struct nlattr **nla_line)
 	if (!str)
 		return;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_PID] || rd->json_output)
+	if (nla_line[RDMA_NLDEV_ATTR_RES_PID] || is_json_context())
 		snprintf(tmp, sizeof(tmp), "%s", str);
 	else
 		snprintf(tmp, sizeof(tmp), "[%s]", str);
@@ -187,8 +187,7 @@ void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
 		snprintf(tmp, sizeof(tmp), "%s/-", name);
 	}
 
-	if (!rd->json_output)
-		print_string(PRINT_ANY, NULL, "link %s ", tmp);
+	print_string(PRINT_FP, NULL, "link %s ", tmp);
 }
 
 void print_qp_type(struct rd *rd, uint32_t val)
diff --git a/rdma/stat.c b/rdma/stat.c
index 28b1ad857219..6a3f8ca44892 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -208,7 +208,7 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
 
 		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
-		if (rd->pretty_output && !rd->json_output)
+		if (rd->pretty_output)
 			newline_indent(rd);
 		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 	}
@@ -802,7 +802,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 			} else {
 				print_string(PRINT_FP, NULL, ",", NULL);
 			}
-			if (rd->pretty_output && !rd->json_output)
+			if (rd->pretty_output)
 				newline_indent(rd);
 
 			print_string(PRINT_ANY, NULL, "%s", name);
diff --git a/rdma/utils.c b/rdma/utils.c
index f73a9f19b617..32e12a64193a 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -572,7 +572,7 @@ int rd_exec_link(struct rd *rd, int (*cb)(struct rd *rd), bool strict_port)
 	uint32_t port;
 	int ret = 0;
 
-	new_json_obj(rd->json_output);
+	new_json_obj(json);
 	if (rd_no_arg(rd)) {
 		list_for_each_entry(dev_map, &rd->dev_map_list, list) {
 			rd->dev_idx = dev_map->idx;
@@ -621,7 +621,7 @@ int rd_exec_dev(struct rd *rd, int (*cb)(struct rd *rd))
 	struct dev_map *dev_map;
 	int ret = 0;
 
-	new_json_obj(rd->json_output);
+	new_json_obj(json);
 	if (rd_no_arg(rd)) {
 		list_for_each_entry(dev_map, &rd->dev_map_list, list) {
 			rd->dev_idx = dev_map->idx;
@@ -794,7 +794,7 @@ static int print_driver_string(struct rd *rd, const char *key_str,
 static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %d ", key_str, val);
@@ -811,7 +811,7 @@ static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
 static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %u ", key_str, val);
@@ -828,7 +828,7 @@ static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
 static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %" PRId64 " ", key_str, val);
@@ -845,7 +845,7 @@ static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
 static int print_driver_u64(struct rd *rd, const char *key_str, uint64_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %" PRIu64 " ", key_str, val);
-- 
2.43.0


