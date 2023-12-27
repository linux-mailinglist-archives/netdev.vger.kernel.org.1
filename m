Return-Path: <netdev+bounces-60383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EB81EF3A
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB631C21910
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CD44C90;
	Wed, 27 Dec 2023 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OBxdLUdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7728E34
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2335d81693so899282966b.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703684654; x=1704289454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HijIDrLvvLxGdPSHEgD3gcCXrAeRlR6lL9vQk+GIAck=;
        b=OBxdLUdSZ5bnNgLDyDnFbgHt9G6nYv7N6KuLLaFVVAzOzXXDR2vLfy7HE/vrieKVqH
         oy3YxJDE3EEoHr7T0A3kvZS1V0UIh2piKldr7/ywcaQZbTztSKxEum4pnRAbo/0MfCjr
         KXAZ10FJku5WkZCp502SRJo1mUFA3u+Tgg6KkksGmqtOxrothyGc4jLmHFiHd/3TxHf+
         Ttd3np2qjrrLhJpT/zhEA00pDN/RlaZg9MQJkUi0KeXXqOebZYpdf7Ak5S3AZPrtB1K9
         lTXGgNwq8nnMNxYKkvLjsPHcTLPnaNROslH1/EUbjN4wS0Te+M1sgXQ9FyZzm5/PaIt8
         kpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703684654; x=1704289454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HijIDrLvvLxGdPSHEgD3gcCXrAeRlR6lL9vQk+GIAck=;
        b=g3tp1fOl+VgT46V9XW27PCOcKo7sxhhl2Bti89ppmnpBB4EPUcz92bSgdOYDNCjuu+
         m+zbJsLjPeycALmUVs6vmmzQISzpiNiFubRvdVeiEKxfBeiEXR96HgWQADUSIaI+cv20
         l/CPcH7aUNNair+eyPacfPvb+3pSVS52iEajJYKqhWHcSgJQJCHRlvKt3TqLeYEJyhVn
         qlFZT8ukSF+HOwl0E3EQrLuV0MFJVMZLwg+MJdX989JHnbUI0ZV2BgdovUHtdWon7Xpf
         RyCXFUOIOQJOwRF0itPFuiwDuVnJDF8iiQvFzC4oJVt9gvSctzDB/N6k+Cm6PFd+tg9Q
         5eOA==
X-Gm-Message-State: AOJu0YxAkbpFZSgnEtZ7oI1VhhrOt4qfO7eFPjK9pN9rRmwnOxyFCGGk
	QTm/mk4v16a+tVw1ixI68e/66TF2l0g=
X-Google-Smtp-Source: AGHT+IECoF7ALkDhHmX4KVDxidI8MjpecgNjwHTF58dx2/kbI2alHxu+VO6EQI+uD/Ep72KMoba8fQ==
X-Received: by 2002:a17:907:72cb:b0:a23:577f:41ba with SMTP id du11-20020a17090772cb00b00a23577f41bamr10808110ejc.17.1703684653885;
        Wed, 27 Dec 2023 05:44:13 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-095-119-050-251.95.119.pool.telefonica.de. [95.119.50.251])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b00a235f3b8259sm6530099ejb.186.2023.12.27.05.44.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 05:44:13 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] ss: add option to suppress queue columns
Date: Wed, 27 Dec 2023 14:44:02 +0100
Message-ID: <20231227134409.12694-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new option `-Q/--no-queues` to ss(8) to suppress the two standard
columns Send-Q and Recv-Q.  This helps to keep the output steady for
monitoring purposes (like listening sockets).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 man/man8/ss.8 |  3 +++
 misc/ss.c     | 24 +++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 073e9f03..ecb3ae35 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -24,6 +24,9 @@ Output version information.
 .B \-H, \-\-no-header
 Suppress header line.
 .TP
+.B \-Q, \-\-no-queues
+Suppress sending and receiving queue columns.
+.TP
 .B \-O, \-\-oneline
 Print each socket's data on a single line.
 .TP
diff --git a/misc/ss.c b/misc/ss.c
index 09dc1f37..00b661e1 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -75,6 +75,7 @@
 int preferred_family = AF_UNSPEC;
 static int show_options;
 int show_details;
+static int show_queues = 1;
 static int show_processes;
 static int show_threads;
 static int show_mem;
@@ -1420,10 +1421,13 @@ static void sock_state_print(struct sockstat *s)
 		out("%s", sstate_name[s->state]);
 	}
 
-	field_set(COL_RECVQ);
-	out("%-6d", s->rq);
-	field_set(COL_SENDQ);
-	out("%-6d", s->wq);
+	if (show_queues) {
+		field_set(COL_RECVQ);
+		out("%-6d", s->rq);
+		field_set(COL_SENDQ);
+		out("%-6d", s->wq);
+	}
+
 	field_set(COL_ADDR);
 }
 
@@ -5367,6 +5371,7 @@ static void _usage(FILE *dest)
 "\n"
 "   -K, --kill          forcibly close sockets, display what was closed\n"
 "   -H, --no-header     Suppress header line\n"
+"   -Q, --no-queues     Suppress sending and receiving queue columns\n"
 "   -O, --oneline       socket's data printed on a single line\n"
 "       --inet-sockopt  show various inet socket options\n"
 "\n"
@@ -5500,6 +5505,7 @@ static const struct option long_opts[] = {
 	{ "cgroup", 0, 0, OPT_CGROUP },
 	{ "kill", 0, 0, 'K' },
 	{ "no-header", 0, 0, 'H' },
+	{ "no-queues", 0, 0, 'Q' },
 	{ "xdp", 0, 0, OPT_XDPSOCK},
 	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
@@ -5519,7 +5525,7 @@ int main(int argc, char *argv[])
 	int state_filter = 0;
 
 	while ((ch = getopt_long(argc, argv,
-				 "dhaletuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
+				 "dhaletuwxnro460spTbEf:mMiA:D:F:vVzZN:KHQSO",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
 		case 'n':
@@ -5700,6 +5706,9 @@ int main(int argc, char *argv[])
 		case 'H':
 			show_header = 0;
 			break;
+		case 'Q':
+			show_queues = 0;
+			break;
 		case 'O':
 			oneline = 1;
 			break;
@@ -5795,6 +5804,11 @@ int main(int argc, char *argv[])
 	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
 		usage();
 
+	if (!show_queues) {
+		columns[COL_SENDQ].disabled = 1;
+		columns[COL_RECVQ].disabled = 1;
+	}
+
 	if (!show_processes)
 		columns[COL_PROC].disabled = 1;
 
-- 
2.43.0


