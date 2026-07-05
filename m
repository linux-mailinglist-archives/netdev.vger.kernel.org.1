Return-Path: <netdev+bounces-304778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wh3LD7pQSmomBQEAu9opvQ
	(envelope-from <netdev+bounces-304778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 14:40:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F0709FAE
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 14:40:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=IzG5IH95;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304778-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304778-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C913016ED8
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6F37EFE9;
	Sun,  5 Jul 2026 12:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F4360ED0
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 12:38:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783255128; cv=none; b=WihP0vBXvAkcyvf3kMp8G5j0yvhd6+wgB+i2fHsFVdXwyj4yvpYUDttvJHYuSeoVXIACDE3ZAssV7uZUzZ8V5ADDoizT8fWOznCeDm7oeJkvNqwGqTVIAFYwCiC5/OJIuuFL2feLKXm6GxAK7JPzRaZn1s46lpKIVwiLscT+d1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783255128; c=relaxed/simple;
	bh=zqv3Np8ys3PYoKLLnoNREbJb5Mli48vuqtrDU10NNhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcusaSXuhTu3iXSePhp9NbwcczldmaIRF0x4iW2YQroCfXg1CJpPzjqOxPBmPjiZSoGsBnXJWjto+UFPdLZIyZqq87n8eqqmdXxqw4YFhi/9W11jY/e9pbnjqcE0pLIhJa4i8VEXHLwAEqReEDy8uCfrWQ2UndXvGcueRJV1XLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IzG5IH95; arc=none smtp.client-ip=195.121.94.183
X-KPN-MessageId: 4e0af6d7-786e-11f1-8f53-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4e0af6d7-786e-11f1-8f53-005056992ed3;
	Sun, 05 Jul 2026 14:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=G6fztcr09RgbS+JSICNlygpsayswdGMK5f5FkM7aTAk=;
	b=IzG5IH95P4wmLVa0KruZ5dZQGJodw729jeKsRjqqlEMm7iHXl6G+7hRZeIdc2WM5FklEL4E2oo9ke
	 N/FXDrKPKRIv4yKR8BTmE4WVDayeFQg5AdR30J3LM9F0oZ7nGyXgzhsQTQ4QOTblqK2NUu/vCeRCRe
	 HnAgqhWEDHC2d0lB7U0Obd6mHfQaRrzXFSYyWdZ4ix1Jc+aUmDct4eN4bVzZBYM6vPCTbY5l2vjHax
	 UWcOD/FvZXOXJIUUl0VB9Okdfmf0Y8r/wwNU5LBYAeyJywYIVs4nVLqFuUu+U6E+xRghwyDQ7vnlc8
	 H9x+qNWZyRYWbhnElU5lKS2LH8g+fbw==
X-KPN-MID: 33|wEc7jfyWzf9CugYpFP6w9sqKBkTxhK95MK2sb4HTvvENzBMc2vJ2x1Y963A3m8/
 jjLC6PxnRB7GaYl7jWxFzt7GvhQhzZ1EP+vleIDknt9w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cEtDrH7Kt1jankJseMmrjF2N74kqtZhtDY68l3AVei+1WGbqYfy/nbYfIaVDAFG
 iIbt00gLCqw5dqTyF9lLXPQ==
Received: from daedalus.home (unknown [178.231.11.83])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4dc6cd53-786e-11f1-807b-005056998788;
	Sun, 05 Jul 2026 14:37:37 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH net-next v4 1/3] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
Date: Sun,  5 Jul 2026 14:38:24 +0200
Message-ID: <20260705123826.3818443-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-304778-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:from_mime,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 731F0709FAE

scm->fp can only be set when using UNIX sockets, therefore we should
move it out of the common path __scm_recv_common() into
scm_recv_unix().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/core/scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index eec13f50ecaf..a73b1eb30fd2 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -523,9 +523,6 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 
 	scm_passec(sk, msg, scm);
 
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
-
 	return true;
 }
 
@@ -545,6 +542,9 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
+
 	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
 
-- 
2.55.0


