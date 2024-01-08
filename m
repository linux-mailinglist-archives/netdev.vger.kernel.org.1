Return-Path: <netdev+bounces-62356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB8826C4D
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 12:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EBF283168
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EB14AA3;
	Mon,  8 Jan 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q5S5akSd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB92E650
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso18324541fa.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704712225; x=1705317025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGlwmcHcweDhckO9yQHyIGRRFJGh66YUQEcDbSAmCvI=;
        b=Q5S5akSd4IlFSPkc+/g4+I2qqLI2QDjVTlHSeIitSCF+WOAMKXBRLJGc328Iwx5K9I
         zJwH75mvTGOrHPHS+US73c9gMGVVcgxXooT06eSmybdxOxzMpDeic2NHHTg0qJvuXiBs
         dUwx4OpQH1gRleRoCYdVj+cXNW5QtnQ6YHT+Q9qgg9PSmDZhUI8MpTu5CWUQi2eUCdc8
         iYBfzWxrkjjA9L2Wy2a5j+Lbz5MqqfwdUEzw1tUKJhrjxCnj/G88lJHB24qDlJSd8LNV
         hXVakrB6S9fZbW5Yolv0yQjvrnDtDr4CYwO9plEZMy1GOkOcp+A4snzFoAyqEyTivy0+
         4WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712225; x=1705317025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGlwmcHcweDhckO9yQHyIGRRFJGh66YUQEcDbSAmCvI=;
        b=kEaOfIzYxynq1D9T3r5o6JoMUijvmLzd04uAPr+7OxBM7x4HEG4bA9hsJ1ETcbz3xv
         7SX95VrxE6w94x1apgUNHYDsx+biV1hB2JvmFlVaG5AmjdOCKr5Na0y3kyTq/iGc3dr5
         pnMY9RPtEDeXGAwwrdTl4OduTWvbBm1i2MbiEvyRqnv0+b1kCslYrjnPjhzWMyOnfZVO
         lk6v41PlfNVrzXe4gi0GxXYGH9ss90qs8NzPVKd09cZsC4KnQVKD5lZ1yLcuLmYEpg1p
         ILAyjX1AKDE7qmsaJz6Ei+iQ4DSezTkL4ccyNFoMBn0gnOouEmsLeRCiaBZdKHfJLK+a
         mDYA==
X-Gm-Message-State: AOJu0Yx/HHQb4xadYgcIj69oCcqu/iYLvkqZZPNhCe+JlzV0xeV4fnDc
	kc8OGFBu1PNQO8m1+EQWxEyf/OQaCSA=
X-Google-Smtp-Source: AGHT+IGIbjjTagiBvZ429Dctn1fhN+nEprE52pZ19fCEGtZbsNqM/+M+UQ2ObOD79ab073LkYkLy8g==
X-Received: by 2002:a2e:301a:0:b0:2cd:2606:70e2 with SMTP id w26-20020a2e301a000000b002cd260670e2mr1354679ljw.20.1704712224861;
        Mon, 08 Jan 2024 03:10:24 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-006-145-115.77.6.pool.telefonica.de. [77.6.145.115])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b00557aa373d71sm1119179eda.45.2024.01.08.03.10.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:10:24 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] ss: add option to suppress queue columns
Date: Mon,  8 Jan 2024 12:10:20 +0100
Message-ID: <20240108111020.12205-1-cgzones@googlemail.com>
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
v2: rebase to iproute2-next
---
 man/man8/ss.8 |  3 +++
 misc/ss.c     | 24 +++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 4ece41fa..b014cde1 100644
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
index c220a075..188a8ff9 100644
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
@@ -1425,10 +1426,13 @@ static void sock_state_print(struct sockstat *s)
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
 
@@ -5378,6 +5382,7 @@ static void _usage(FILE *dest)
 "\n"
 "   -K, --kill          forcibly close sockets, display what was closed\n"
 "   -H, --no-header     Suppress header line\n"
+"   -Q, --no-queues     Suppress sending and receiving queue columns\n"
 "   -O, --oneline       socket's data printed on a single line\n"
 "       --inet-sockopt  show various inet socket options\n"
 "\n"
@@ -5521,6 +5526,7 @@ static const struct option long_opts[] = {
 	{ "cgroup", 0, 0, OPT_CGROUP },
 	{ "kill", 0, 0, 'K' },
 	{ "no-header", 0, 0, 'H' },
+	{ "no-queues", 0, 0, 'Q' },
 	{ "xdp", 0, 0, OPT_XDPSOCK},
 	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
@@ -5540,7 +5546,7 @@ int main(int argc, char *argv[])
 	int state_filter = 0;
 
 	while ((ch = getopt_long(argc, argv,
-				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
+				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHQSO",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
 		case 'n':
@@ -5724,6 +5730,9 @@ int main(int argc, char *argv[])
 		case 'H':
 			show_header = 0;
 			break;
+		case 'Q':
+			show_queues = 0;
+			break;
 		case 'O':
 			oneline = 1;
 			break;
@@ -5819,6 +5828,11 @@ int main(int argc, char *argv[])
 	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
 		usage();
 
+	if (!show_queues) {
+		columns[COL_SENDQ].disabled = 1;
+		columns[COL_RECVQ].disabled = 1;
+	}
+
 	if (!(current_filter.dbs & (current_filter.dbs - 1)))
 		columns[COL_NETID].disabled = 1;
 
-- 
2.43.0


