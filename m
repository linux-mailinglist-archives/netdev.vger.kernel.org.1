Return-Path: <netdev+bounces-291053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPf4MlViEWpclQYAu9opvQ
	(envelope-from <netdev+bounces-291053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:16:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04D5BDD42
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 065BA3006B74
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C52DE6FF;
	Sat, 23 May 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yfx2bChS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r0SMmnlv"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D61A0728;
	Sat, 23 May 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524175; cv=none; b=XEHcCYvAlBbQxTnd/+orkaAsoPI8t+xiukyd8e4i9NPdcxO2v2iFn912ekBRGLlVEsZYXUUvVtbeEKcIUCj7ZShVmEh8zMGFoU53Wu4bUIaFui9bYuY9jLE3AkNvJ14Jp+1uiHr7rWheDeqWXjDb4okXaLFGaWqgOLcTOTxtbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524175; c=relaxed/simple;
	bh=ASHPTjOnvm5f6LP7g0blhOe5w7Qd29Z8iScIUHb+ZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEtgTz++An0UYHZPVrSHzm0EpL9nQ4PwV5fv5gLIr8NmbHpRJwQphIvn8tqqqjp3scK/TsqAljdxnSDxX0lTxheABkfctIxMrry83IYXO5vTJWZr0hgNkm599UO1xSbo8jd3dxhuelC79KfqN/bkS6jBzlc7Tz7gDqzj5HnKiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yfx2bChS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r0SMmnlv; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4gMw2f6lptzB0yg;
	Sat, 23 May 2026 10:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779524171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3+TB+1iXKC+oEhr9lDwhe4/BMpmiFavf8+dndQZOTfs=;
	b=yfx2bChS3HtcJ4ZsgB8HvGGnKDZBycZqWAp0xeqtSpv4myxuPseCUUjb4xNhbin1O4XMul
	qqanMQD60w0tXNyroeeXkE6aqgPyqpiOkibGaBULuxvojjREE7LBDg7P4TK+wVryA3f4tB
	q2/csx0lJiDcuSJTd4R8CiOZxwet2uQTGt0Vz/KBoX0GtdtZmGDOtiVodOK4GD5q1NCB+R
	qkSC7h7ZyKV++2KfIfPxOdAgqWUsbCtDbipWcvBHuFpmNNsUrwt9MENajDvl2N9rvDl7D8
	v+G9AN84n1eJruUBDHJcIERfE5kQYgQEyi9/qWGi4ivDoqdF5ec8OQ2TQehJgQ==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779524169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3+TB+1iXKC+oEhr9lDwhe4/BMpmiFavf8+dndQZOTfs=;
	b=r0SMmnlvkHHMbAMpfs25i7d5aapH+7xi8g+udsGKlCji2ma3tyllEfl4b8HqaLKLBER7+s
	GUajbhRjdq+EDlEJZzS0fjxH/aJcA6MQex3pzgOScueRIN7jR1Jy0EJJ2hMLe+wZP8HYWK
	D0Y1PbOYPzoyeHFuZlb6a/RzY2R+dYWSH1LEf68vufeujvU2vGOG4l5zJkRPjD4R2zNAWT
	HPkR3ZaJETwfK2XNu0WbHexbhMlqGPiYEL0N/U6YdLWjaGL22dgSEr9pBPJvzMrRxylyBN
	J25DPEHwpKX+qIofdpQgfsYoFt1UR8Wh31iWOVK/ZQXYQg8/Keoc/5QVOuf0fQ==
To: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH] ovpn: avoid putting unrelated P2P peer on socket release
Date: Sat, 23 May 2026 16:15:43 +0800
Message-ID: <20260523081543.94507-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: s1ii7quzkwapaeiyukwpkaqydhe4tdr3
X-MBO-RS-ID: b7e33da714da48b7d5d
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291053-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0yami@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 6A04D5BDD42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ovpn_peer_release_p2p() is called when an OVPN UDP socket is being
destroyed. It checks the currently published P2P peer and releases it only
if that peer still uses the socket being destroyed.

A peer replacement can publish a new peer before the old UDP socket is
destroyed. When the old socket destruction path runs afterwards,
ovpn_peer_release_p2p() observes the new peer through ovpn->peer. Since the
new peer uses a different socket, the function takes the socket mismatch
branch.

That branch still calls ovpn_peer_put(peer). At this point, however, peer
is the currently published replacement peer, not the peer associated with
the socket being destroyed. Dropping its reference can free it while
ovpn->peer still points to it, leading to later use-after-free accesses
from the peer and socket cleanup paths.

KASAN reports this as a slab-use-after-free on the kmalloc-1k ovpn_peer
object. In the reproducer, the object is allocated from ovpn_peer_new() via
ovpn_nl_peer_new_doit(), and freed through ovpn_peer_release_rcu() from RCU
callback processing. Observed access sites include ovpn_peer_remove(),
ovpn_socket_release(), ovpn_nl_peer_del_notify(), and unlock_ovpn().

Fix this by returning from the socket mismatch branch without putting the
peer.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
 drivers/net/ovpn/peer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..1844d97154ce 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1167,7 +1167,6 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 		ovpn_sock = rcu_access_pointer(peer->sock);
 		if (!ovpn_sock || ovpn_sock->sk != sk) {
 			spin_unlock_bh(&ovpn->lock);
-			ovpn_peer_put(peer);
 			return;
 		}
 	}
-- 
2.53.0


