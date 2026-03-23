Return-Path: <netdev+bounces-270441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FM4OsYIwWmtPwQAu9opvQ
	(envelope-from <netdev+bounces-270441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D742EF1FF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 246303022955
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9584386C19;
	Mon, 23 Mar 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="spp/GR26"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8288386545
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258307; cv=none; b=kh/ufau9MjLB4DS297lE21TwdliBhttgjdnhZNEVb0qbIGrZQYwM6/F9wnFH32IqoyAuqFcl2tOamd7HVX7ypS1m9nEraSRu3ypV30CMqIjPboShp3rlIFx6cq47gANAhf9gbc91tD/XYBUQtHyZMmLdqil3OdPA3uwRbR7Dqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258307; c=relaxed/simple;
	bh=FKdqYbJRCbHV8ED0taAnDFFEIfeq7RVIDgOTv57eXkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaKUzwVzN7aWtdq3F0EhyyBbC6hHNr8KBeMZVU1SmJxQdWw70zsoJ0pM7i0c2J6uEpU0uWF08IIYqLqkxPe892It7A3nNWXVa6obNUFPw6PUiQ/840aYeQ9SMydUSDrQJvs+vIxZtlm7ClPkXZ9OidTDUGIeSmsRb63F95benX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=spp/GR26; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3292C3F7FE
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774258298;
	bh=yYJfPNbB792lL6QrmI4JXU+RjVxNWhivL7IyPS98fSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=spp/GR26vk+ZpBVJwa+AIQMFWYj+s5JVi8+Wbhleg9u9RCsh6FiBy/6zGy3E0ZTW8
	 E70hO47NNoZLEn4PqBhrnSBY3KYTcaimh7kMk9exTLeyj0QB1K8OcLIxIMx8TJQKtv
	 AjuJZDKyqjIhJCeFQhIeQw0dkmFKtXBDnkjVNBD3xJSIX0EmvK6zcsNMqZKJ2Y9nKr
	 Q6S/9/Kewog3AeBHki62hngvEYz5/M8npP5COdIw9tPtaVGfpW6dMwMRWjlLY2eTh+
	 J8UkQseDarc8ogIQMyj++TB/SdUAPS6G/ES5kYl42mqG4iQYpf77pjw3qCcuGBAX4t
	 f5LWwj5vuz7wK0v7ky7p6h29dhsdGlbq9EP4j2jYAjbaC0LDVkc899XRinxeP+lO8+
	 c/wmHdyHjost+cioYZ/UPrk2O1Ud57ogG3YhmC4CL6OZGiReRqpvXA3ZB3+Kn7lMTw
	 3SKzxmmy20aKUrNmIq3zb11nup8Y+Yii+32eJUUkE6C71ueiSCmnXfn0uMsFWPgCSL
	 iBELyBKtF3rWuBr9SRMZuxzmL6nYaD4Bycxi6usHqf9tGB67pSo7sudzghY6nWZreZ
	 yS5g5mv50E7gPhbiTOm19Rg7UOW+cXR7GPH0tL2R3CjUD8vMXlnt7gTO44QcpAXhYK
	 P1rpME+LOPt8s1Bg/7Sg4zAk=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439cbc5fb4fso3560970f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 02:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258297; x=1774863097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYJfPNbB792lL6QrmI4JXU+RjVxNWhivL7IyPS98fSg=;
        b=aHMjMeOzFumzu962ar+n8vx/bUBLFa8vunE70JmQ/EhetRiD9qOzQnSK27Wkgw4LeN
         ge2iOkfuXwkbgjJIeurJnBPHunxgLIDGYwAidblEw2OHCyX0LoEH2oEzCzZCN6zfGfQG
         CGI8h87CUadM9UCSFxrnOhUT9xVDzjm2aGLeiRLZTgqWQulFAFRzFdl3r8mrMU7FWDjd
         Ke36Wb9DnaAEiCjbH/wfne2YDe0XlgXhOxiUCIBsWYg7xc+xh05FcMZwmEEMIL5m09po
         Y0Fv29yNCp/3aev54LLb4x5wOlKvV8IqPKPd/qaE+pyuNaZMwcWXqaTKv2mRcFhB89hA
         nuzA==
X-Gm-Message-State: AOJu0YyOOKnVTlutDoyILeJ6NW8Q2RRuGC0/Yv3ESzkQoyp7iFVd5Ihn
	wlDubpO80GzkjumHLtyMQWDvC8dC8IwTUMxcikT5Iw6F+eDMg0CXp10y+uv1P9cCM56pLTY7Aw8
	RS520fDABF4Jgq0OmQll2O5LnnFemPJwBB5gWxdN3ndDvc8Oy4NBD9l6rRrmt8fi+MbFbBnmZGc
	mGu73AHA==
X-Gm-Gg: ATEYQzxCsgts64HyNtrdqS1+dSIAeh/BtgBOuoxY65KzjfCR8Gllp3GHLk1Hq6pBObv
	BUk7nRK/2B+VBAgUa6gPx0Uv8Rr27tVMtM8Zeq8GV3BF/jcpfR/QuI1EY/k/kTD0LghZ5NaXq0y
	sRjyEP1OyP5qtQHkrDGelklbguV+D26Vp5jvHAC2WhTIqWTdAweSoTKn7WRIy9dah4MRcYDJBFK
	vLnVNtvKfTLZyryBT6JXdqXzGyr+UT112PRLd189N0WTSaR04xlqUSanNUmllFpfRrfZzca5TXz
	0blkxWd8Ebb0lCrdzNP55sVLHJDYBTyFLdXHovpTY4oqhQlOvgYF0ecWyfza3rVzGNsXlfatRLi
	pgwV/rAwI++ts7/dbKU0G61Joig4lMSyJ
X-Received: by 2002:a5d:5f94:0:b0:43b:5744:13fb with SMTP id ffacd0b85a97d-43b6423489dmr18149868f8f.4.1774258297067;
        Mon, 23 Mar 2026 02:31:37 -0700 (PDT)
X-Received: by 2002:a5d:5f94:0:b0:43b:5744:13fb with SMTP id ffacd0b85a97d-43b6423489dmr18149810f8f.4.1774258296574;
        Mon, 23 Mar 2026 02:31:36 -0700 (PDT)
Received: from devstation.. ([194.120.133.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6cdfdfa9sm18901032f8f.9.2026.03.23.02.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:31:36 -0700 (PDT)
From: Ioana Lazea <ioana.lazea@canonical.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	jay.vosburgh@canonical.com
Subject: [PATCH iproute2-next 2/2] tc/htb: enable use of 64 bit burst 
Date: Mon, 23 Mar 2026 09:29:13 +0000
Message-ID: <20260323092918.11010-3-ioana.lazea@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323092918.11010-1-ioana.lazea@canonical.com>
References: <20260323092918.11010-1-ioana.lazea@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,networkplumber.org,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-270441-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.lazea@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: 69D742EF1FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Modify the HTB queueing discipline to allow burst sizes up to the
limits supported by the kernel API, which may exceed 4 GB at higher rates.

In the current implementation, the burst option is effectively limited
to 4 GB due to the use of a 32-bit field while parsing the burst size.
However, the kernel internally represents the burst in terms of time
derived from the configured rate. As a result, at sufficiently high
rates this time-based representation can correspond to burst sizes
larger than 4 GB, making such bursts feasible without requiring changes
to the kernel.

This change removes the artificial 4 GB limit and allows larger burst
sizes where supported by the kernel API.

Signed-off-by: Ioana Lazea <ioana.lazea@canonical.com>
---
 tc/q_htb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tc/q_htb.c b/tc/q_htb.c
index 545152ff..a3ad4215 100644
--- a/tc/q_htb.c
+++ b/tc/q_htb.c
@@ -112,14 +112,14 @@ static int htb_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 {
 	struct tc_htb_opt opt = {};
 	__u32 rtab[256], ctab[256];
-	unsigned buffer = 0, cbuffer = 0;
+	unsigned cbuffer = 0;
 	int cell_log =  -1, ccell_log = -1;
 	unsigned int mtu = 1600; /* eth packet len */
 	unsigned short mpu = 0;
 	unsigned short overhead = 0;
 	unsigned int linklayer  = LINKLAYER_ETHERNET; /* Assume ethernet */
 	struct rtattr *tail;
-	__u64 ceil64 = 0, rate64 = 0;
+	__u64 ceil64 = 0, rate64 = 0, buffer64 = 0;
 	char *param;
 
 	while (argc > 0) {
@@ -158,7 +158,7 @@ static int htb_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 			   strcmp(*argv, "maxburst") == 0) {
 			param = *argv;
 			NEXT_ARG();
-			if (get_size_and_cell(&buffer, &cell_log, *argv) < 0) {
+			if (get_size64_and_cell(&buffer64, &cell_log, *argv) < 0) {
 				explain1(param);
 				return -1;
 			}
@@ -225,8 +225,8 @@ static int htb_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 
 	/* compute minimal allowed burst from rate; mtu is added here to make
 	   sure that buffer is larger than mtu and to have some safeguard space */
-	if (!buffer)
-		buffer = rate64 / get_hz() + mtu;
+	if (!buffer64)
+		buffer64 = rate64 / get_hz() + mtu;
 	if (!cbuffer)
 		cbuffer = ceil64 / get_hz() + mtu;
 
@@ -240,7 +240,11 @@ static int htb_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 		fprintf(stderr, "htb: failed to calculate rate table.\n");
 		return -1;
 	}
-	opt.buffer = tc_calc_xmittime(rate64, buffer);
+	opt.buffer = tc_calc_xmittime(rate64, buffer64);
+	if (opt.buffer == UINT_MAX) {
+		fprintf(stderr, "htb: burst out of range\n");
+		return -1;
+	}
 
 	if (tc_calc_rtable(&opt.ceil, ctab, ccell_log, mtu, linklayer) < 0) {
 		fprintf(stderr, "htb: failed to calculate ceil rate table.\n");
-- 
2.43.0


