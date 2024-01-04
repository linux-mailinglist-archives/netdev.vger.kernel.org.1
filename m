Return-Path: <netdev+bounces-61419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D9823A1C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8D01F2617D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DA184F;
	Thu,  4 Jan 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Kp3/LI1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EABD1C33
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28c0536806fso3998a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 17:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704330876; x=1704935676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYyU+71JNEa9ChMbxk4Ddokt/Dh5PGrhJl1Fn3uUx/8=;
        b=Kp3/LI1yucUMcfYZlp8oexYpLfZ0s6o7nPP2QhTZC7lXCCeO2LpY6aDqtGjK9Q9/Ya
         y8dR2Lig57lh4YnFMmXu7OdnincuUBtL1xW8Q77CLJ02HzEcmkBHIXAGgfujJXmETUlk
         mjoB1LgSOouzle7+tsopbA45LWiu7+urhsNWdmRx7jyvLlx7cLizEw/82TiuzWrMyxci
         7Tc9wEMVkBmXEL6K+bHxZ+3SM32iswVsOU9gPVJT7hcZYdVzwdEJwgSLFQslc3v0KpPJ
         jinr/+8GTuN8rluFxmwM+vxN18TDJDfmsVP+Gbr97bHF5yEa3MeIrDtNfcu2r5Kc3ZvQ
         jRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704330876; x=1704935676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYyU+71JNEa9ChMbxk4Ddokt/Dh5PGrhJl1Fn3uUx/8=;
        b=qiSpH/cxCNYQXSCIhdyAbHjSbmIn0GlgUvRFdMzzyGX6vLX5mVsCT/cK8ft13w79E9
         ER8Tb2aZgz3UViA4DZvUGT/VJBvAXfnjtL+Hwxb3xBY7XaAuHUBdcWXtDVqWjJMV4/Ee
         Fr9JO7PEdK4noKo7gGyio3N1rYtDRDDJmycUHetRxiBknOtSE/h0ovzgnzS4VdITuwv7
         XzFT8sDyL+8/6JD7OspskRhhsT2squfmLGuq4xRchiRv94HvmjUb4kH5PRHb/BeUeAVf
         qiV5XsozRXlKXKvjYCMdBGX8JpJwizip3M+tFMwzKk3W1jnTR2ZXGK5dSvccljv/bzPX
         kZBA==
X-Gm-Message-State: AOJu0YyCPNjZ+2TuqglM72dN7mmRucPsE5dhX0971x61VaKN2zzzCCin
	+caRdnGVlLqFTBGxCZQevOg/B8gOLWuSCQ==
X-Google-Smtp-Source: AGHT+IE+dEcL5wpIqudn2TZDjI/IMebe1WewTHCzir5SIspWtD6Y8ElTo+PMdCdv4HuIN9+oJRv1lg==
X-Received: by 2002:a17:90a:fc83:b0:28c:5a10:f31d with SMTP id ci3-20020a17090afc8300b0028c5a10f31dmr8874943pjb.45.1704330876597;
        Wed, 03 Jan 2024 17:14:36 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b0028adcc0f2c4sm2510124pjl.18.2024.01.03.17.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 17:14:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 5/6] rdma: add oneline flag
Date: Wed,  3 Jan 2024 17:13:43 -0800
Message-ID: <20240104011422.26736-6-stephen@networkplumber.org>
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

Add oneline output format like other commands.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/rdma.8 | 12 ++++++++++--
 rdma/dev.c      |  2 +-
 rdma/link.c     |  2 +-
 rdma/rdma.c     | 11 +++++++++--
 rdma/stat.c     |  2 +-
 rdma/sys.c      |  3 ++-
 rdma/utils.c    |  2 +-
 7 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/man/man8/rdma.8 b/man/man8/rdma.8
index c9e5d50d5ad7..5088b9ec3cf2 100644
--- a/man/man8/rdma.8
+++ b/man/man8/rdma.8
@@ -25,8 +25,9 @@ rdma \- RDMA tool
 .ti -8
 .IR OPTIONS " := { "
 \fB\-V\fR[\fIersion\fR] |
-\fB\-d\fR[\fIetails\fR] }
-\fB\-j\fR[\fIson\fR] }
+\fB\-d\fR[\fIetails\fR] |
+\fB\-j\fR[\fIson\fR] |
+\fB\-o\fR[\fIneline\fR] |
 \fB\-p\fR[\fIretty\fR] }
 
 .SH OPTIONS
@@ -63,6 +64,13 @@ When combined with -j generate a pretty JSON output.
 .BR "\-j" , " --json"
 Generate JSON output.
 
+.TP
+.BR "\-o" , " \-oneline"
+output each record on a single line, replacing line feeds
+with the
+.B '\e'
+character.
+
 .SS
 .I OBJECT
 
diff --git a/rdma/dev.c b/rdma/dev.c
index 7496162df9e2..31868c6fe43e 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -94,7 +94,7 @@ static void dev_print_caps(struct rd *rd, struct nlattr **tb)
 
 	caps = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_CAP_FLAGS]);
 
-	print_string(PRINT_FP, NULL, "\n    caps: <", NULL);
+	print_string(PRINT_FP, NULL, "%s    caps: <", _SL_);
 	open_json_array(PRINT_JSON, "caps");
 	for (idx = 0; caps; idx++) {
 		if (caps & 0x1)
diff --git a/rdma/link.c b/rdma/link.c
index 48f7b0877468..d7d9558b49f2 100644
--- a/rdma/link.c
+++ b/rdma/link.c
@@ -96,7 +96,7 @@ static void link_print_caps(struct rd *rd, struct nlattr **tb)
 
 	caps = mnl_attr_get_u64(tb[RDMA_NLDEV_ATTR_CAP_FLAGS]);
 
-	print_string(PRINT_FP, NULL, "\n    caps: <", NULL);
+	print_string(PRINT_FP, NULL, "%s    caps: <", _SL_);
 	open_json_array(PRINT_JSON, "caps");
 	for (idx = 0; caps; idx++) {
 		if (caps & 0x1)
diff --git a/rdma/rdma.c b/rdma/rdma.c
index bee1985f96d8..131c6b2abd34 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -16,7 +16,7 @@ static void help(char *name)
 	pr_out("Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
 	       "       %s [ -f[orce] ] -b[atch] filename\n"
 	       "where  OBJECT := { dev | link | resource | system | statistic | help }\n"
-	       "       OPTIONS := { -V[ersion] | -d[etails] | -j[son] | -p[retty] -r[aw]}\n", name, name);
+	       "       OPTIONS := { -V[ersion] | -d[etails] | -j[son] | -p[retty] | -r[aw]}\n", name, name);
 }
 
 static int cmd_help(struct rd *rd)
@@ -89,6 +89,7 @@ int main(int argc, char **argv)
 		{ "version",		no_argument,		NULL, 'V' },
 		{ "help",		no_argument,		NULL, 'h' },
 		{ "json",		no_argument,		NULL, 'j' },
+		{ "oneline",		no_argument,            NULL, 'o' },
 		{ "pretty",		no_argument,		NULL, 'p' },
 		{ "details",		no_argument,		NULL, 'd' },
 		{ "raw",		no_argument,		NULL, 'r' },
@@ -101,13 +102,14 @@ int main(int argc, char **argv)
 	bool show_details = false;
 	bool show_raw = false;
 	bool force = false;
+	bool oneline = false;
 	struct rd rd = {};
 	char *filename;
 	int opt;
 	int err;
 	filename = basename(argv[0]);
 
-	while ((opt = getopt_long(argc, argv, ":Vhdrpjfb:",
+	while ((opt = getopt_long(argc, argv, ":Vhdropjfb:",
 				  long_options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -126,6 +128,9 @@ int main(int argc, char **argv)
 		case 'r':
 			show_raw = true;
 			break;
+		case 'o':
+			oneline = true;
+			break;
 		case 'j':
 			++json;
 			break;
@@ -151,6 +156,8 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
+	_SL_ = oneline ? "\\" : "\n";
+
 	rd.show_details = show_details;
 	rd.show_driver_details = show_driver_details;
 	rd.show_raw = show_raw;
diff --git a/rdma/stat.c b/rdma/stat.c
index b428a62ac707..e90b6197ceb7 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -291,7 +291,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 	res_get_hwcounters(rd, hwc_table, true);
 	isfirst = true;
 	open_json_array(PRINT_JSON, "lqpn");
-	print_string(PRINT_FP, NULL, "\n    LQPN: <", NULL);
+	print_string(PRINT_FP, NULL, "%s    LQPN: <", _SL_);
 	mnl_attr_for_each_nested(nla_entry, qp_table) {
 		struct nlattr *qp_line[RDMA_NLDEV_ATTR_MAX] = {};
 		err = mnl_attr_parse_nested(nla_entry, rd_attr_cb, qp_line);
diff --git a/rdma/sys.c b/rdma/sys.c
index 7bb0edbfec2b..7dbe44094820 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -51,7 +51,8 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
-	print_on_off(PRINT_ANY, "copy-on-fork", "copy-on-fork %s\n", cof);
+	print_on_off(PRINT_ANY, "copy-on-fork", "copy-on-fork %s", cof);
+	print_nl();
 
 	return MNL_CB_OK;
 }
diff --git a/rdma/utils.c b/rdma/utils.c
index f332b2602e6f..aeb627be7715 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -774,7 +774,7 @@ struct dev_map *dev_map_lookup(struct rd *rd, bool allow_port_index)
 void newline(struct rd *rd)
 {
 	close_json_object();
-	print_string(PRINT_FP, NULL, "\n", NULL);
+	print_nl();
 }
 
 void newline_indent(struct rd *rd)
-- 
2.43.0


