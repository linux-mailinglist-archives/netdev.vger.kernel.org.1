Return-Path: <netdev+bounces-299876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tAP/Br5fMWr2iAUAu9opvQ
	(envelope-from <netdev+bounces-299876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:37:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711F1690923
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=KdKWavUt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299876-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299876-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFF031A4A09
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B33B47C4;
	Tue, 16 Jun 2026 14:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF010385D83
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:29:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620182; cv=none; b=WZv+H4zHUWSBYLBXn/aOPk+r3WT7nvbkf1sGSsYN3uYP/JePvDF2nwWXelORj57Rei9t/GyuMK/hyJghI6dxZqua9yPdEAyD+HDNt9lqIaBCJjW5ydygDMc+3UBwgQ2ZCqqnNr1kNQk50k1N9xs3xcavcvs/2F1Nf/G2COISAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620182; c=relaxed/simple;
	bh=Qqh2kYR5AnndYSSSbCw524nQrS4BOLBstcnsQoCxirk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUiiicYyBypnW65EVsD2OG2bWIRbQEkPbywm2gm5u5qsLAkJ8VOwttJ3LlSOa3xytFI7SMKtuMLUQa3lE0POR3sBQEu0NbLfRKx7am/DkDh6aZUfBRBAbWFiGqFntbtBwNciG0dhJK9EKvT5vMKHwSk4zyHnBE8S9ay379Y4qR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KdKWavUt; arc=none smtp.client-ip=195.121.94.185
X-KPN-MessageId: cb46390c-698f-11f1-8ff8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cb46390c-698f-11f1-8ff8-005056999439;
	Tue, 16 Jun 2026 16:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oUFyyFB8ReNjnGZAg5IYXFWboSBSWEg1wqQRR6CgHAw=;
	b=KdKWavUt0IY8WAwNt8yjhsfVR+RUMQadpdQQNP5CnGQs180xWepbqP0rKLzRFcZ0lH2XSj+Vtperm
	 +/bfCjK2QZEM2X+Ei9U6lXrdt0Epfl8ZuCK/EAqvGEnApDzE/VHMAXJelUAWn+df3SPNlvdh0AvZMi
	 uJHvuqCcC++HOgzTNu040vJepZI+Y/drQKfng1HM3hSaPJhdgLpGAdlZR/2O87An8yBAgiJVHClVCs
	 rhXvk+60z5W2G7W3b+ZRYSksMDRqTDUYuDvMT7TvoXp8QM44dnXn8tYROVAw9aDasU9vT6heoOU1R8
	 sqwJ5uiY6J21ZggaudxxXxRm6aw6fZg==
X-KPN-MID: 33|Zn1HwyGZC67ZdL3UJijwOHmQ6zqjaCPSsuW1Kb+RTKtjB/p3eZUI1MRh/mDHlBf
 T+6+5CDxyI37ddRpwArk5KN4HVVyJKl8RQoeD1cMIHBI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wXGn/3ZPgfboUacRCHaajdPhZN5xsyoB/yLW9fIbQCChZCruUcanpqndrrafo4p
 jOT+m4ixXbpv1905sc/Gu5w==
Received: from daedalus.home (unknown [178.230.193.174])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cb00c67f-698f-11f1-a77e-00505699772e;
	Tue, 16 Jun 2026 16:29:33 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] net: af_unix: replace copy_from_sockptr() with copy_safe_from_sockptr()
Date: Tue, 16 Jun 2026 16:30:03 +0200
Message-ID: <20260616143020.3458085-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-299876-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-fsdevel@vger.kernel.org,m:jkoolstra@xs4all.nl,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 711F1690923

Replace deprecated call to copy_from_sockptr() with
copy_safe_from_sockptr().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/unix/af_unix.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4e1463ee2815..eb4051f3aae7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -933,6 +933,7 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct unix_sock *u = unix_sk(sock->sk);
 	struct sock *sk = sock->sk;
+	int error;
 	int val;
 
 	if (level != SOL_SOCKET)
@@ -941,11 +942,9 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 	if (!unix_custom_sockopt(optname))
 		return sock_setsockopt(sock, level, optname, optval, optlen);
 
-	if (optlen != sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	error = copy_safe_from_sockptr(&val, sizeof(val), optval, optlen);
+	if (error)
+		return error;
 
 	switch (optname) {
 	case SO_INQ:
-- 
2.54.0


