Return-Path: <netdev+bounces-300225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2i/IDOzhMmr56QUAu9opvQ
	(envelope-from <netdev+bounces-300225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E95369BDA3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:05:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b=o277kNkP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300225-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300225-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5933051D28
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0903367B61;
	Wed, 17 Jun 2026 18:05:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBB374E71;
	Wed, 17 Jun 2026 18:05:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719527; cv=none; b=oF4m+p+QEaqKaZCdWyqCRVSwMckT18lC1t9a0fT/0BcpFioMX6O7oHDTnO9+0hqHegK49khrDoKqYHveRkkpFf/QkmMb/dk4DSjLIbemUbWfqIKcnc5eAaYJQz0EMGsN/VZwvNxdSXqx/vW+wAMETugkopoxLAXHDZNEBx49l7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719527; c=relaxed/simple;
	bh=9xp0Kk5bUmkF0PPUbgqTGcLbD87miuDQAR9pgS/9kXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ1Wnd+8Or0ZQgx5QzEVFeq7goGB5KfTffvMHqszMdy6UT2Ihd0fZiASW3V6XCzfeIb9sCvtJZOlDkG9awZUsADLAT/hM8AQ7ZIlNVo+cSypo2gGfrKXM73JcF+HyPcM4Qpo0Hv+fnIV2DVxy1pvv4OW/APBKlLHcrsaBUhUSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=o277kNkP; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781719517; bh=9xp0Kk5bUmkF0PPUbgqTGcLbD87miuDQAR9pgS/9kXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o277kNkP2Uq/D87XMTSu6aPrtO5+3cSQii5IjWlg4W7Aa55jN7h2MsmEEwgB+ZlQy
	 92RnoDGQ8xqTCzKDx2K+8Xl6cFzW6bKOvTIl5IlLoNEa3Q1JQYqr7WDOKyjgAA0Y/x
	 FFQU2NLPaPEO3FwVvQcKJ6v7uWhYLZzNKTAazV36nx8B0AnqMCvAGUkiVLgdFGw+3r
	 Uxn0PJPnoDwpuOEfCxzwZSFYnYWtsx/dVA9+YxXBY/kPUZTgbMtobYalqecD5FtFQ8
	 fp19SGM8wQwfcJMBfkFM+3k0TEPozrfRxKVX/q4mxUWgvjmm1AwWTJgxPqd1mYjl50
	 1l068AIh494HA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 428841263DD;
	Wed, 17 Jun 2026 20:05:17 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Date: Wed, 17 Jun 2026 20:05:23 +0200
Message-ID: <20260617180526.15627-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617180526.15627-1-matthieu@buffet.re>
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300225-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[buffet.re:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,buffet.re:dkim,buffet.re:email,buffet.re:mid,buffet.re:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E95369BDA3

The documentation of the socket_connect() LSM hook states that it
controls connecting a socket to a remote address. It has not been the
case since the addition of TCP Fast Open (RFC 7413) support, which allows
opening a TCP connection (thus, setting a socket's destination address)
via the MSG_FASTOPEN flag passed to sendto()/sendmsg()/sendmmsg(). The
problem then got duplicated into MPTCP.

Landlock did not take it into account when its TCP support was added,
leaving a bypass of TCP connect policy.

Ideally a call to the LSM hook would be added in the fastopen code path,
in order to fix this generically. But connect() hooks are designed to run
with the socket locked, unlike sendmsg() hooks.

Closes: https://github.com/landlock-lsm/linux/issues/41
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/landlock/net.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 4ee4002a8f56..a2375762c18b 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -246,9 +246,26 @@ static int hook_socket_connect(struct socket *const sock,
 					   access_request);
 }
 
+static int hook_socket_sendmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size)
+{
+	struct sockaddr *const address = msg->msg_name;
+	const int addrlen = msg->msg_namelen;
+
+	if (sk_is_tcp(sock->sk) && address != NULL &&
+	    (msg->msg_flags & MSG_FASTOPEN) != 0) {
+		return current_check_access_socket(
+			sock, address, addrlen,
+			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+	}
+
+	return 0;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
 	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
+	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
 };
 
 __init void landlock_add_net_hooks(void)
-- 
2.47.3


