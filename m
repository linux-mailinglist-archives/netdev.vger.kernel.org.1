Return-Path: <netdev+bounces-296629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+npMO/jJmrpmQIAu9opvQ
	(envelope-from <netdev+bounces-296629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:46:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292B658485
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:46:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=AxYIg51N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296629-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02C9349FE77
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637A332621;
	Mon,  8 Jun 2026 15:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCC32FA2E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931278; cv=none; b=pqOnl1n6MgvGlAzBiHduo0zDHs/iHAo3Ltf9eqfQ8ueQTtOQzhFadBGD1FhdnY8ve/sRGYOqY28wu3jckY5XrJGA+vNL4afhcMYDzGwHUMEUS8Fjr5Juhv0sT7oRy0jMuWwWeNNIUh0w2KwPHhthQBTdACgMoK1B3AmyrpQZLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931278; c=relaxed/simple;
	bh=PHVRarPaYIDKIhFH9KTFLa6c0rej1lneINvJtVVTlhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZPVAfg4MR1SklNVVY9+N4mfshKxGv1WqvqW6dmtMr5saEuA9GvP340S3hBvFsh1Zx85XguldqITLE8P8aZ+8NoyoHJuYL6ICfRIbzJ6LrYPjkwhwI9J/kb6DFUi4wInXGbXNKs4SKHa3aUUYGDOgIcJfXGS+rAlBx3ZiDJUa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AxYIg51N; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so49152175e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931275; x=1781536075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Muu7mxdkljEgo2Os9cZ2QlibJnZNmx0/kaGfGcrf98=;
        b=AxYIg51NoBMbAMxQROC+E51Vjfr69MEWRYxKaa2YXvXyMvLcMVXVuUCEqU70qvq6pz
         3QSBxqUySsg5LfReMPdeXbTSnlghYDc56mgIjizm293Qv18Ou5/3Mkal4WM1cc1dAgLT
         vXYQS14xW9BYND9UbiBTi91qgKPb+j4iWE2lUkyEB1HTIsblxgyNLBVn5Rs+l2Dr6iz+
         AgwCxegoWdxelw43tdzFwbw/Qgd7K4AD6lE3KonSG0nm5ZPIkh1pezBWHvml7fnAe61P
         ez3DuujktTXkUq++c5+pSabihlzx3H2bMag+vrlQIwKrJhTX1hnC2Svg+XLi4BxMg7FV
         D7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931275; x=1781536075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Muu7mxdkljEgo2Os9cZ2QlibJnZNmx0/kaGfGcrf98=;
        b=N/0t4hUbC7QysDZM8qd74HXtk020KCD3nAjNWYBHrEwN1yhMYd8cRNpxaql4erpCqK
         To2p/6TFEEbIjlWIuMDujzc6V6vaWiR+Lygaq6bjio6fe0Js1WwMUNeYMXMLvU+wbC+y
         zf0dzhgbNUhmv6++3wv9lcADrexcwaaWv3gdRAHk7bUilPMd1fH0AQ1K+tU31k43ui1y
         oBRaFru7pT6NCaQ3SeLX3A/3JnhRtfm2kM2jmgxDvZB1Ha/b9Zu1pzXieQDVLGz2njpX
         pJJzWp1J4m6y+X7EWasdwt/qzcyKVQLlvMjAV0Af1c+fLUWYAlnZVJopbOZESGsPTu5i
         OFDw==
X-Gm-Message-State: AOJu0YyGdEPFu+/VHRJqQu9b0miRQXvhdXNA7NFv0RyIk64LqPhe8gEZ
	Qs9+WUFEbla9AvSwO2LSvwDeCVYUDY7yIu7NA6DKe0fe1yReFMS0w0KGn1VR4MrqT8Aw0ubU97o
	v/8igaSdhtUqkNALtBz2aaB9PM65wuahnVYEudYz/IT8Ho5zuKrY2mq8wSHApp+k7Dzs=
X-Gm-Gg: Acq92OErZNbisIvpebScpCdoBCJKh+rqgSnWz6pgwqtvAzKeoBYtblytd4aCDW913Az
	GXUW8hii+NAdw8ntRKR6X0cCODjkrNjocA/1MWPBH+MIuUWZur/W8pahs6qnTk4W0Tz6mniv1QO
	uOiu3dND4X+cS3JG4UPbpeRDAMmhoj3WekX8V9cHcTVxh6+aozM+zgaEj7NTE0QfqsZLmCPdtTm
	dcI80J+Vx7wwQO9NadZHk7Eyva7g0UfmZ0VCVA2Doh09FV3Ix7TscK4SCfDLzhnppKPdsN1BpPO
	GKbYE9ehJd2TU7tfssB6Fl82V9g4uSQi8tL9sCtWxcojycSr7kdMaQIk+nAY4+a8WZuVUfFX4Lp
	/OAR4wsXJadaPIHAUeibT68mry7vBhZSOwQH+4Kc2i+WLKYUnLoja1iTJan3uY1SqhTQHRxWHUg
	AT4Q81mVcKbw9YHmspCG+ofqKw8FnLwKVyOYsgf2Vy1kONwt2Q3luDQ6U48dn4z7G2gmk0
X-Received: by 2002:a05:600c:4444:b0:490:b9c3:6c59 with SMTP id 5b1f17b1804b1-490c260579fmr262207545e9.29.1780931274727;
        Mon, 08 Jun 2026 08:07:54 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Qing Ming <a0yami@mailbox.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/6] ovpn: avoid putting unrelated P2P peer on socket release
Date: Mon,  8 Jun 2026 17:07:32 +0200
Message-ID: <20260608150741.3320919-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:a0yami@mailbox.org,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:antonio@openvpn.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:email,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,openvpn.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4292B658485

From: Qing Ming <a0yami@mailbox.org>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
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


