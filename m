Return-Path: <netdev+bounces-299874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8PfDO9dMWqgiAUAu9opvQ
	(envelope-from <netdev+bounces-299874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4069080A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:30:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=DbHG0a3F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299874-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299874-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E61F93010614
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464AB37C912;
	Tue, 16 Jun 2026 14:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA536C0C8
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:29:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620174; cv=none; b=KecKUSYsPduQdenjioG/KrYFwSFsGOMtC1F/omrSiQBAabeVi+1IXvFJSWqtY7fxWBYn223vcXYDSjYHIk3fZMYoDiSdf2yFbedFzrGHRYDuBhCbpNcVSnVg3WedixGVJ0bSQ4Uc9BMN6e0FLb0nYHmHdTmPpGKYkS7EBRfnca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620174; c=relaxed/simple;
	bh=wQlAUK8yb5O7tkDU7pSJ2qwqf7JbAv3RsZU7RkjUXhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3tYdLGB1z9PUD8pFmwUfubxcVAfheHRot8tyyc0zBl0Cs102SjkWaXxsEa/DPMZeeErqe4Xy6sE1+putHwavxko+FNzjVcqCg5YFuwi6VjNjcwVm7eSghSY+Abe+lR00r29fLkzbxA6sDCBTpIYN7O3NlPZAIOfJOuo8LHnoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DbHG0a3F; arc=none smtp.client-ip=195.121.94.183
X-KPN-MessageId: c8a905e0-698f-11f1-beab-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c8a905e0-698f-11f1-beab-005056992ed3;
	Tue, 16 Jun 2026 16:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=etSJLXtuXbFYY4p2xurfRhpzKgCv0tmCROn4H+X+ivg=;
	b=DbHG0a3F49OvcCFtDOyPSp1znqTmwUromr60kcbg1/fkEX3TOWLLLfd70jwhY6Iq8U3jcfqojHVmN
	 pVhK8NgcwISUt/2dbbapDv4EKjnFsLGP8qys0Ir+E9VXmec7mYuslgl1e+OyhrUG7iCGlyZJQN/l9Y
	 N4nLtiuFK5uPz3Hc7GExXcXYYMItffqCbj6uEUSOa03ENGBFNtfXwEjw6CK1mBItVYwwDX3c8w7Ztk
	 do3tBqiUL5fLRiUwi8sMCUWarKhkTfD7Ss13FnRTX/nJQJczcN3hc/Nh83z/jhtznMROrhBXcrtzb+
	 plTefDJdbtlyKWdJgF5E26quW4E37/g==
X-KPN-MID: 33|6pLfU2O9ZhGCLSx/eFP5XgK6eVOaeImzyet/9xFopyU6VfsA0AA+hI5BzGZAOX6
 ft1l2Uw3HJEbmIYFpe1CDZvFYyqeIUOI3dut0hfX85gQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|MB0ANrUBVF6lYEmrKZXbxai3w/4EWrB3fcAn10rsH2D+ryueRhsleeMiPnSivqF
 PN43KEZTw6vZyd1FlTbvoRg==
Received: from daedalus.home (unknown [178.230.193.174])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c5f136e7-698f-11f1-a77e-00505699772e;
	Tue, 16 Jun 2026 16:29:29 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
Date: Tue, 16 Jun 2026 16:30:01 +0200
Message-ID: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-299874-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-fsdevel@vger.kernel.org,m:jkoolstra@xs4all.nl,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8D4069080A

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
 

base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
-- 
2.54.0


