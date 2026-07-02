Return-Path: <netdev+bounces-304268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1VGEHSfIRmqqdQsAu9opvQ
	(envelope-from <netdev+bounces-304268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC56FCB4A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:20:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=ofNXMzsE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304268-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6991B3026725
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632A3749FE;
	Thu,  2 Jul 2026 20:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17642312834;
	Thu,  2 Jul 2026 20:20:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023651; cv=none; b=dQy5hj+G2BsR1kzgEATZlS9ziymyKlgoBr+A4IszAw18mlIhiT1pN/HUFzRBUz6f9OPjRNZiiqQXGJoyAXMZTfWFM4TNmyavs5BCjkfypHOKcJDg5Y7GE99/AmlWIvDW/a/Mzyzc0qDEfoaeXceyY9PoZ++uPnIGz57JNpx51E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023651; c=relaxed/simple;
	bh=4XoIEW6ya3kMkpGTNYbhCabw9j27ZsUeWbtwd4s0WVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boUkN+HavAUdKyc5VYZfRpWh1zkEyOc/OKCLJmGlkpadQKNV+/XPZYEjxlyi51Ntmv/9Dns1ltr+tjXGGC0R7bLZo5WwoO7WMxYHh2oAdpcLbLPNWzZzdFPQAswXJfwFndsoJ7HvXSbxCVNe7YBVJwpnWxUpUWT5p62NZaPSkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofNXMzsE; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id A7F5C13800CE;
	Thu,  2 Jul 2026 16:20:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 16:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783023648; x=1783030848; bh=orpjg5ywUFc5x2uxg26eHWW5X93sx0l37Y2
	klzb3rBw=; b=ofNXMzsEjeYJDSRRwRhfIndAf6D2MiY5HhrQAcHORSwX7a1T757
	INlvzscILeTpjV0TbbtUX+oLxf3jn93X3sw4q0xGhmw3nt+mNJELoz428O7++lsh
	aspfRtL+xfhkdqtZu1C8uCbD840JWGYqKO6Y2AwahW1oQiE91V0RvDgiBQLnrht8
	kMypnlGrrk1/b85YmMvg71xtECcDlgfwGKhAueTaGU4gBO1Xylfd4qQ0UzMPgErC
	zBk8SMumRQL4jqmmty1SyK5VcHfJ/wU9Hs+7hAE4m9+E+ePaXk1wj8+gYYs+MHp0
	jlOeGvB5QAelxwp8i+VrI1XxzsoY0h1ZOPw==
X-ME-Sender: <xms:H8hGapBR5pljPX7qj_kcM0aGmBxD7Oafng6ZQVX3yRhlXUnmenMO8Q>
    <xme:H8hGasthmLU7VuzZjx4a4qqOcHVcIVWFTyI-l5hkhgOKYzXJvE5UDS72971Ifs2Vr
    UgKivYUuruki5nPYh7IDgCPw5aUC28aT0wBwh10BaGQqwgJYz5BaCE>
X-ME-Received: <xmr:H8hGan-NTIq9K0IbjR4wXslgYG4TYVc9AOG62S5Xi9A14JYpTr2XJ5dJO_AzIq5qrK1OHLkC8szj69vluuN_wkOSS42RHEGX2qTdPQ>
X-ME-Proxy-Cause: dmFkZTGPGxdb89j8lqq9p8S//Xd0iQNnKU4dkmz2cQVowI+UPfjhQH4FKgsi6dQPBr9lkk
    VcccJi4eVnq60Tf7dHBaE4mD4XSuHg0+UdJ+o52vfUM+4gZGHAEJlFasPRmvqjcyvlxVMh
    Tssq75TWuRZJMZ71Q3XcrbQMTeZny63Dr8YskB8wgwIqBX++jCId+sUoPU0Z4Qm4VW0rhq
    bXf1b6ftaDkJma0hDrHXm0Mx6HXiCRtBbu+9rnc/Mv60HT4LY4a3CKijAofLlWXk3ApNcI
    IOZDXo/6Zkhug0nniFP9RIHDivEecR7MOM5krSbizVOcjJLgE/NCUGQlqy3slk6UM3Gmrk
    u2a5Y2Dit4M5L8J9wIB9mZOGGpvDBmSOJEjzChJNdpP1JtKg8qfAp3w1iN4jePkYE0iRJw
    kjLnPurgmaER3FB2/1a0e0gNlKBxE4+Ek7kUMVaxzRgF3ZuXuTayHQ3ZV7IrjUeNXSO9Uv
    dql/6oJivT6whLv9EKVDQ2poISHS1VwPNie3VTqCedWxMh8p2tEjBv7KUrHdhuqvKwBeWD
    ZK/amuBp2aAttP9lfcpEpI4R6qC5nNQCXc20nn0Aceno/cGv0avSjwEbnVqI5d/pFlSqiu
    K9Z19GF1sEzX+noD1DDLfi64MjtF2B3CptFTffZkPLdzF9CJPghed4a2iUpg
X-ME-Proxy: <xmx:H8hGajSY6toR1hD0_CQwh6k7Vj4VoeuM3duqdzgbEQdo4JSX9a0ChQ>
    <xmx:H8hGapUZDUXw_lbe94Dtm1nrAGGpV4I3M6yBP7e7JaeYqLNX4kpODQ>
    <xmx:H8hGal9CzDcbkFKh_xopt6TSS7HbHFH8bvCkxL_zm_xpNDzRSsVMSw>
    <xmx:H8hGap0t6Rn1Sg7m29Bz9ltxr4RhybXuc0wd8IxhFCXWxl6QGr1G3w>
    <xmx:IMhGart3C7TgdoR5pxN2Cb8DoWSyShz3AWb8PbSl-dGKIDl_jWWQZmaR>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 16:20:47 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Ericson <mail@johnericson.me>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Cong Wang <cwang@multikernel.io>,
	John Ericson <john.ericson@obsidian.systems>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] af_unix: fix listen() succeeding on sockets in the wrong state
Date: Thu,  2 Jul 2026 16:20:15 -0400
Message-ID: <20260702202018.2280336-1-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304268-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:john.ericson@obsidian.systems,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBBC56FCB4A

From: John Ericson <mail@johnericson.me>

Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
reaped sk->sk_peer_pid") inserted a `prepare_peercred()` call between
`err = -EINVAL` and the socket-state check in `unix_listen()`. Since
`prepare_peercred()` leaves `err` at 0 on success, `listen()` on an
AF_UNIX socket that is not in `TCP_CLOSE` or `TCP_LISTEN` state (e.g.
one that is already connected) now silently returns success without
doing anything, instead of failing with `EINVAL` as it did before.

To fix this bug, and avoid such bugs in the future, switch to a style
where `err = -E...;` instead happens right before the `goto`. (`err =
other_function(...);` is not changed.) Then there is no spooky-action-
at-a-distance between the `err` initialization and the `goto`, something
which is easier to slip by code review.

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Assisted-by: Claude:claude-fable-5
Signed-off-by: John Ericson <mail@johnericson.me>
---
 net/unix/af_unix.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..7878b27bbaf8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -813,18 +813,22 @@ static int unix_listen(struct socket *sock, int backlog)
 	struct unix_sock *u = unix_sk(sk);
 	struct unix_peercred peercred = {};
 
-	err = -EOPNOTSUPP;
-	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
+	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET) {
+		err = -EOPNOTSUPP;
 		goto out;	/* Only stream/seqpacket sockets accept */
-	err = -EINVAL;
-	if (!READ_ONCE(u->addr))
+	}
+	if (!READ_ONCE(u->addr)) {
+		err = -EINVAL;
 		goto out;	/* No listens on an unbound socket */
+	}
 	err = prepare_peercred(&peercred);
 	if (err)
 		goto out;
 	unix_state_lock(sk);
-	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
+	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN) {
+		err = -EINVAL;
 		goto out_unlock;
+	}
 	if (backlog > sk->sk_max_ack_backlog)
 		wake_up_interruptible_all(&u->peer_wait);
 	sk->sk_max_ack_backlog	= backlog;
-- 
2.54.0


