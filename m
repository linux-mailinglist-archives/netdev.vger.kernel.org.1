Return-Path: <netdev+bounces-61075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B7D822605
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FD72849B3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C415BD;
	Wed,  3 Jan 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xgai9Lcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7BA54
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbce1202ebso4236197b6e.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242172; x=1704846972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYyU+71JNEa9ChMbxk4Ddokt/Dh5PGrhJl1Fn3uUx/8=;
        b=xgai9LcmcvggVdEApFqpTbru1d3nwL8sQjwkgPbYkg8E+pjH8yFYXQmAmzAiYekh3h
         eNDvvmhuuUXQNnHQanoriZXqvCbE7DrDFpSqlGaodTvMyoBUMyaMI1V44N9U1hkBO0s/
         tnt+3StxQyRohn9MBTRwUYLl9kPgyurvaRa5vOuCYcW9ssve3DdSsS8HR4ShFzjGgnLH
         kxxZIix38PhWpT/IljPjPB7HI+7iMCirva8js/AyFakK0aNPcSPZE5wnjzAg4BGJYWMt
         w5yxT0Nb1M0nCj+aG4+PvWENFTxM6bjbs8M34RPdOo2fyHWLUiSoNjTBj5xzVXGCM68/
         MDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242172; x=1704846972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYyU+71JNEa9ChMbxk4Ddokt/Dh5PGrhJl1Fn3uUx/8=;
        b=NjVOM5Av+g8/9FDqVWBVS7M8dCiUKWO8SiSksRM+j6TN8Ky1CDlurFGRCQgsl1cWI/
         McT3/X/EnMqM6owTaM/7dSPGg7wMsbhym4hj9cw22oWzGiZZ24MWFSk0QxagO0+giz1U
         kJL27bIhVr5Zm3LDOBkuZtgXbSrwR0A7JlGSkNkbI6rBrB7unlcKZoWqwviBIqKnssqs
         ee+6snx3dQjm8fKzpo0Q4RXBeeO5kAInEEEwx6uMkDzRuajTWB2IQmO+rQHYlykRuVT4
         bV5DfiXAEd619My7HBsjLeLynbUWikjgqXn8nQzc40PcI9X8g4X1TdiVQl6VoRwB4zJw
         1eCw==
X-Gm-Message-State: AOJu0YwUt/d7ueOD+N2gFZI0a+Zyk54QzMYNU0BIAvddabsp5nI53sAG
	G098WGjtFAwNQZwDDuspLPXkXAOjhAWpmpFxDYI5d+g1CBg=
X-Google-Smtp-Source: AGHT+IFSVjI+bySJZQ38hfyaPdZR8nlRCcEZ9HtfDQD1CXYW16e5WIr+xMtif/lCI1S3q+EXlfrZ/w==
X-Received: by 2002:a05:6808:2226:b0:3b9:df4a:978b with SMTP id bd38-20020a056808222600b003b9df4a978bmr23704960oib.82.1704242172466;
        Tue, 02 Jan 2024 16:36:12 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 5/8] rdma: add oneline flag
Date: Tue,  2 Jan 2024 16:34:30 -0800
Message-ID: <20240103003558.20615-6-stephen@networkplumber.org>
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


