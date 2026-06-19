Return-Path: <netdev+bounces-300551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 18qmH7uLNGq6awYAu9opvQ
	(envelope-from <netdev+bounces-300551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0636A32EE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:22:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b="c/2R54vZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300551-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300551-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 897563015863
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6958287E;
	Fri, 19 Jun 2026 00:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4054654;
	Fri, 19 Jun 2026 00:22:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828535; cv=none; b=jmIZDXrMUFyE8hLyWMhy4E4lInNHd+UEOyGUR7J2X8PY4PYz8f/GbzBPAdCrZcfKy0BchME5hG7jQLsKa+TIMX2BmGNocSB6guf77A9+0ySFeEBgqSpBfedMB+QErk0Igo4HgxjCnm6bAeiuwgaqh4jKWvKTy4SQEbpVXRMPV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828535; c=relaxed/simple;
	bh=nXyHwTLWPjAyiQcT8bDNyzKWJu7lPBvjuljCk6QgLPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CetTAqOYHKG9zdxL65YWiWnK/1DwHkNha6ehShjaJfXhaCTeJEKSxuRO2HTIymI7u/l0bDE7QUy6y8c9OKsXR7p1eiIn4M/lwGU4A0RLv5dQ2d3UjsH42eQ4DG1JO2nLIf3Wto+x2V0Xm7ymzv9RW7p+hqeM6gU+AyazonJDgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=c/2R54vZ; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781828523; bh=nXyHwTLWPjAyiQcT8bDNyzKWJu7lPBvjuljCk6QgLPo=;
	h=From:To:Cc:Subject:Date:From;
	b=c/2R54vZqwYD4JZUdOV6Ip7XVopz4xSxtvTyM9TXhbNZctXDZBlgCFNe/JiLfRb4e
	 w38SUqIOvP9UV7qAPWK2541Ll+XW/d16hGCsoXMOB4wAKKtjHdToSOaVT6BnDxmpg3
	 NHIxorjKmqfeJQ887b+rgn0xXHFXHteB5Rewu86ov1kl6Hp+hDJfhYx8uNvLvaU5A4
	 Ykd9K1UJrNqFVc1sKvqPTyszSSvIWLs59fZOudg3EkkwH9pEiAdgMEERBq/skuNC3O
	 58MQ3NFnl5HQ8sfZ5X2Xmw7d4i9l51yfPktjA7M55CeBXnyuL7muQHYSoJ5AejI98F
	 p6Qvsu4dqFGGA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id B2DEE1264EA;
	Fri, 19 Jun 2026 02:22:03 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Yuchung Cheng <ycheng@google.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH] tomoyo: Enforce connect policy in TCP Fast Open
Date: Fri, 19 Jun 2026 02:22:07 +0200
Message-ID: <20260619002207.61104-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
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
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300551-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:takedakn@nttdata.co.jp,m:penguin-kernel@I-love.SAKURA.ne.jp,m:hexlabsecurity@proton.me,m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:ycheng@google.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[buffet.re:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B0636A32EE

Tomoyo restricted TCP connections in 2011 in commit
059d84dbb389 ("TOMOYO: Add socket operation restriction support.")
using the socket_connect() LSM hook.

However, the MSG_FASTOPEN sendmsg() flag was added in 2012 to allow
combining connect() and the first sendmsg(). Tomoyo was not updated to
take this into account in its send hook.

This resulted in a TCP connect policy bypass similar to that reported in
Landlock in 2024 (see Link below), with the difference that Tomoyo was
fine when originally merged, and the problem got introduced when adding
fastopen support, possibly due to lack of synchronization between lsm
and netdev worlds.

Add MSG_FASTOPEN handling in Tomoyo's existing send hook.

Link: https://github.com/landlock-lsm/linux/issues/41
Link: https://lore.kernel.org/all/20260616201615.275032-1-hexlabsecurity@proton.me/
Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Cc: stable@kernel.org
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/tomoyo/network.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index cfc2a019de1e..7d9ba7268dc2 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -764,11 +764,25 @@ int tomoyo_socket_sendmsg_permission(struct socket *sock, struct msghdr *msg,
 	struct tomoyo_addr_info address;
 	const u8 family = tomoyo_sock_family(sock->sk);
 	const unsigned int type = sock->type;
+	int ret;
 
+	address.protocol = type;
+
+	if ((msg->msg_flags & MSG_FASTOPEN) != 0 && msg->msg_name != NULL &&
+	    (sk_is_tcp(sock->sk) ||
+	     (sk_is_inet(sock->sk) && type == SOCK_STREAM &&
+	      sock->sk->sk_protocol == IPPROTO_MPTCP))) {
+		address.operation = TOMOYO_NETWORK_CONNECT;
+		ret = tomoyo_check_inet_address(
+			(struct sockaddr *)msg->msg_name, msg->msg_namelen,
+			sock->sk->sk_protocol, &address);
+		if (ret != 0)
+			return ret;
+	}
 	if (!msg->msg_name || !family ||
 	    (type != SOCK_DGRAM && type != SOCK_RAW))
 		return 0;
-	address.protocol = type;
+
 	address.operation = TOMOYO_NETWORK_SEND;
 	if (family == PF_UNIX)
 		return tomoyo_check_unix_address((struct sockaddr *)
-- 
2.47.3


