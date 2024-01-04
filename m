Return-Path: <netdev+bounces-61417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B845823A1A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDAB1C24232
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4D632;
	Thu,  4 Jan 2024 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="deUDvD74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5C7F6
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bd623c631so8998394a91.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 17:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704330875; x=1704935675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHkrjOkOte7bqKcE1yFAWukI27bsGeUXJY3eIZvDCE4=;
        b=deUDvD74A89dIaAniTzj2+CCqJzm/xNXTFsvBa+xpKW5jf4rq+I1Z5aTEL12DOdGx8
         JXECY1x+9eBIE737GssU25+tBXE1bOS3BSp8iSrRVChUkTvHt96f2DP6qE2kv95FdJxU
         glyY50EhHU1RD/uG5rTIaPZaeaLnK5ZVFcGBi0+blC886raKfGnB2/Y+3YyUXWOM6QVu
         38ni6sWQKQsF0OBzFYaZQ+8gMawBbfhCNgonOi/rcxQibFFC62pfSj94zs/DYQdNbgUD
         MDzzt3IYcb7yb4wU3E2yMufz9qQLqNurSU8QAERMG3jK0anCDqY7+MyncTtMqNvkFowm
         ZK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704330875; x=1704935675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHkrjOkOte7bqKcE1yFAWukI27bsGeUXJY3eIZvDCE4=;
        b=IVAIKlwsmi7atz7slfvAnGkxqR/Lgb/s4YyosEzyWh6yLLv4+4L3lc+4+11dRZfvUj
         DUTAKT4OB8vZ68AkPBhKKJ2JcvedGAb1altrFnOeH1OjWPjZO6YYb2GUEwwuLwRWqFXj
         gtbMXInJl0rvpkwxFrxo/dYBXWu+Y4fpxop4A60CmVMVFPYPoh9TM2vGs+AWkLzExCkf
         5SkLXaljRJVs23ISxkH2bd68sqcvgEHzFRWilufDrP4BL4IIzElz7QI+WR7BD0O8QduR
         FjrnzGpKoTGwzh2EONyGptTCSRveNSYqnQxs3JS3vgBRD+ajtkg0e4tuO+M0x0oyoLG7
         yPUA==
X-Gm-Message-State: AOJu0YwpUKjHbYaenVVKarwkXUky1fxHHZsPjUNlQs5AD+9QvB8bXa1y
	HVQi90xjRf5v7Qy1tdsqauSJl+DCumGtyfEuoLK8JOzWh8U=
X-Google-Smtp-Source: AGHT+IH4GiCMTpF/onVcJruQY2nLuEucRl7zujINHn6RbffWtJEueiIgn+bBbiKzd9zJcRGPskBjVw==
X-Received: by 2002:a17:90a:aa0f:b0:28b:dd93:a2ee with SMTP id k15-20020a17090aaa0f00b0028bdd93a2eemr11261077pjq.95.1704330875244;
        Wed, 03 Jan 2024 17:14:35 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b0028adcc0f2c4sm2510124pjl.18.2024.01.03.17.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 17:14:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 3/6] rdma: make pretty behave like other commands
Date: Wed,  3 Jan 2024 17:13:41 -0800
Message-ID: <20240104011422.26736-4-stephen@networkplumber.org>
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

For tc, ip, etc the -pretty flag only has meaning if json
is used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.c  | 3 +--
 rdma/rdma.h  | 1 -
 rdma/stat.c  | 6 ++----
 rdma/utils.c | 6 ++----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/rdma/rdma.c b/rdma/rdma.c
index 60ba8c0e5594..bee1985f96d8 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -115,7 +115,7 @@ int main(int argc, char **argv)
 			       filename, version);
 			return EXIT_SUCCESS;
 		case 'p':
-			pretty = 1;
+			++pretty;
 			break;
 		case 'd':
 			if (show_details)
@@ -153,7 +153,6 @@ int main(int argc, char **argv)
 
 	rd.show_details = show_details;
 	rd.show_driver_details = show_driver_details;
-	rd.pretty_output = pretty;
 	rd.show_raw = show_raw;
 
 	err = rd_init(&rd, filename);
diff --git a/rdma/rdma.h b/rdma/rdma.h
index f6830c851fb1..f9308dbcfafd 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -68,7 +68,6 @@ struct rd {
 	struct nlmsghdr *nlh;
 	char *buff;
 	json_writer_t *jw;
-	int pretty_output;
 	bool suppress_errors;
 	struct list_head filter_list;
 	char *link_name;
diff --git a/rdma/stat.c b/rdma/stat.c
index 6a3f8ca44892..b428a62ac707 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -208,8 +208,7 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
 
 		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
-		if (rd->pretty_output)
-			newline_indent(rd);
+		newline_indent(rd);
 		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 	}
 
@@ -802,8 +801,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 			} else {
 				print_string(PRINT_FP, NULL, ",", NULL);
 			}
-			if (rd->pretty_output)
-				newline_indent(rd);
+			newline_indent(rd);
 
 			print_string(PRINT_ANY, NULL, "%s", name);
 		}
diff --git a/rdma/utils.c b/rdma/utils.c
index 32e12a64193a..f332b2602e6f 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -920,8 +920,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 	if (!rd->show_driver_details || !tb)
 		return;
 
-	if (rd->pretty_output)
-		newline_indent(rd);
+	newline_indent(rd);
 
 	/*
 	 * Driver attrs are tuples of {key, [print-type], value}.
@@ -933,8 +932,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 	mnl_attr_for_each_nested(tb_entry, tb) {
 
 		if (cc > MAX_LINE_LENGTH) {
-			if (rd->pretty_output)
-				newline_indent(rd);
+			newline_indent(rd);
 			cc = 0;
 		}
 		if (rd_attr_check(tb_entry, &type) != MNL_CB_OK)
-- 
2.43.0


