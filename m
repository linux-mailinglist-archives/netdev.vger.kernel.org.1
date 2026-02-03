Return-Path: <netdev+bounces-256261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAVwOgbfgWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:41:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD49D887F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66B7B3009E03
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C9339875;
	Tue,  3 Feb 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="qQ1o68rm";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="knM74zwa"
X-Original-To: netdev@vger.kernel.org
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA9E274B3A;
	Tue,  3 Feb 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118895; cv=none; b=BwD60A2adoXasf3pnRlmpHHlUxgebyOdMQFKTaSqw+9jSqrukN4lLwUfYZlh3h/KdVU5AKdTVW2Zqmqwioy2M0PVCiyj/jhYrbeRIkRrTMmU289y4eCDLAjxtIb7BimC8YO8jt3WWgc8tf7DikNdyYDUQJKSpfVlJT09X/qkSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118895; c=relaxed/simple;
	bh=BUiikn3ciRWKGL6zJXbhUy/3/71llULE1nnDlIezANc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlWZrieJ912r1GZmxquRMOzfnBapDm/nH8k1S4iYqw71kgJQr4Hz7lfkioqJe1hYNs6lu8RW4DT9KMpzEMEj/Q9nyxFfWG8wgsChEbf+FAhID4RPGq+TyovWqV79gDcL8rQYocrpIVSWlfiDqv/Em+bplTRiJcmcFIxvX0njlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=qQ1o68rm; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=knM74zwa; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1770118334;
	bh=QgwXDA7y8ElPew3Bm76Ii7abYAwPdkjzXVimtuAJjTA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=qQ1o68rmr5sWm0vlgi7vHdaB3kTi8ZQh2d1m1VNn9Kqd0RWWVfLV+Wr34Bo/YyG1v
	 R9A7x1nCZAdbAUtoDdcUmgI0FvkBy3U6mWj8SdnbaM2R3N6C16GaoiTHDrIQuV10mA
	 40yRunjaHdPMVfzERFUEOwHHI+iB/s1XV6Q5IVgtg6AGeinD7daF9v+1ERN1E57h02
	 t2UJJeo+sFkKL7nqfSt+uqlFATKDVllRG3GOiLhHO04lTPxEj0SKnA1SIaPio0ry0c
	 vOhF6mCph6dbZAs0snbxHa4Gm8e2t4zA6RGQwRu5UpCBcmrScSR5LOTBwlYA7NXwKV
	 EfNVwEq5KaDBw==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id B82AEE8394D;
	Tue,  3 Feb 2026 14:32:14 +0300 (MSK)
Received: from mx9.kaspersky-labs.com (mx9.kaspersky-labs.com [195.122.169.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx9.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id 9459AE80D14;
	Tue,  3 Feb 2026 14:32:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1770118327;
	bh=QgwXDA7y8ElPew3Bm76Ii7abYAwPdkjzXVimtuAJjTA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=knM74zwazdq53HyT/LWGOqx9pnfGp4ZXQeVe4XD617xzkJ9vKlDZYN4Qxa5bht9QW
	 8Z9R0WxWpc/k2BOOQX8kFXlFrF22bruzTLZMANvAGO0pgGLSIYQLX4iL0551Cler7G
	 pmQQZxJWiyJSrdOKw5SU/uRTRB9XL/IRm+Ep94PfnyxAazaGvQMD3YlIyw5OyXzJHf
	 YbXvQa+erDH0KlFMzI7GqWPOnxg5roGpRNsMB/3S3vfJ59R6/+zfYoHW+eunXGE1rT
	 m4FQCpNcPTLNrc6242FYNI41Ab9Bh/Yx+cuP0TL69Z2eclbPNPgNhybeEskvtdiZOx
	 zRrOojsQXyWig==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
	by relay9.kaspersky-labs.com (Postfix) with ESMTP id EAAC38A00CB;
	Tue,  3 Feb 2026 14:32:06 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id A85898A000F;
	Tue,  3 Feb 2026 14:32:06 +0300 (MSK)
Received: from Votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 14:32:05 +0300
From: Votokina Victoria <Victoria.Votokina@kaspersky.com>
To: "David S . Miller" <davem@davemloft.net>
CC: Votokina Victoria <Victoria.Votokina@kaspersky.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, Eric Lapuyade
	<eric.lapuyade@linux.intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] nfc: hci: shdlc: Stop timers and work before freeing context
Date: Tue, 3 Feb 2026 14:31:57 +0300
Message-ID: <20260203113158.2008723-1-Victoria.Votokina@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 02/03/2026 11:16:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 200084 [Feb 03 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: Victoria.Votokina@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 86 0.3.86
 47cb2a3d3f5c7e795bff2d0998e8c196722872ab
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:5.0.1,7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/03/2026 11:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/3/2026 9:04:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/02/03 10:20:00 #28174714
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256261-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Victoria.Votokina@kaspersky.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kaspersky.com:email,kaspersky.com:dkim,kaspersky.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0CD49D887F
X-Rspamd-Action: no action

llc_shdlc_deinit() purges SHDLC skb queues and frees the llc_shdlc
structure while its timers and state machine work may still be active.

Timer callbacks can schedule sm_work, and sm_work accesses SHDLC state
and the skb queues. If teardown happens in parallel with a queued/running
work item, it can lead to UAF and other shutdown races.

Stop all SHDLC timers and cancel sm_work synchronously before purging the
queues and freeing the context.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4a61cd6687fc ("NFC: Add an shdlc llc module to llc core")
Signed-off-by: Votokina Victoria <Victoria.Votokina@kaspersky.com>
---
 net/nfc/hci/llc_shdlc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/nfc/hci/llc_shdlc.c b/net/nfc/hci/llc_shdlc.c
index 4fc37894860c..08c8aa1530d8 100644
--- a/net/nfc/hci/llc_shdlc.c
+++ b/net/nfc/hci/llc_shdlc.c
@@ -762,6 +762,14 @@ static void llc_shdlc_deinit(struct nfc_llc *llc)
 {
 	struct llc_shdlc *shdlc = nfc_llc_get_data(llc);
 
+	timer_shutdown_sync(&shdlc->connect_timer);
+	timer_shutdown_sync(&shdlc->t1_timer);
+	timer_shutdown_sync(&shdlc->t2_timer);
+	shdlc->t1_active = false;
+	shdlc->t2_active = false;
+
+	cancel_work_sync(&shdlc->sm_work);
+
 	skb_queue_purge(&shdlc->rcv_q);
 	skb_queue_purge(&shdlc->send_q);
 	skb_queue_purge(&shdlc->ack_pending_q);
-- 
2.43.0


