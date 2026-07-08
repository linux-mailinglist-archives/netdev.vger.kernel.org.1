Return-Path: <netdev+bounces-305964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DPhWG+OaTmrrQQIAu9opvQ
	(envelope-from <netdev+bounces-305964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:45:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CD729AAF
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:45:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=U6g+sPXx;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=RvPrx3M6;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305964-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305964-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E2C3129248
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0534D90DF;
	Wed,  8 Jul 2026 18:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A74D8D91;
	Wed,  8 Jul 2026 18:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536022; cv=none; b=CVnY5Tk2r7dHadwFrYyAYBhaZxcanjcR+JyvMgBzOtj58vFu1zNHvV6yNdcxxNQGzlKhb07aYXVrqQQTPnIVMUkDcD3t5RtUQY8vK2paJEWZ79sZcaD+f+NVtxhAarYav2tvJyrHRC9SEARkJLpvPfUT6wOccLCzJHlOoOzplFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536022; c=relaxed/simple;
	bh=VFZFa+sqUfWBHYurcLEvhRD//b3NDb9yrlEBlFIELNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7vkZUOfWiH5MxzztBbeaBPMs+vyNuUpO/hOBE4x5+M2btKGIglVNklGUsybNSsIUhZF3V4lMSdf5lDymBHhF11zQYRNNx0RgqTmOjjGBcIBH2SSr/MreEdQVOqZn5ZunKAW/sFmc70Iwq4YIqul5uS8r9T5WrIIw5O0NSjujvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=U6g+sPXx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RvPrx3M6; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536015;
	bh=VFZFa+sqUfWBHYurcLEvhRD//b3NDb9yrlEBlFIELNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U6g+sPXxvU/ARC+eAbMqMlVuOsXKzJW/IZj0Ngjh/oXlHwcG4zCmA/07eN+pz9Vdu
	 TG02zvXt4i83Gh/RKavjNFr96TqbYS7OSw+shAf8n6OIOPYY0Th1l4z/EAfmU5Sv6x
	 c2yh/RN+bYgx5MEavXIxGbUj5krYQ9nqgEPeRhqnSGnsOzUottVi+0cRarGxuQzPis
	 lLCgBmpNQ4wK+8KU1in8BWNXLcNYD+Xz8DbOYYxigYTEfS3dq+HT0DtXyQboO03lFE
	 4eDvzECP6tHHl/+x+8KnMfH6ybpI5E8T3kJyErvNrASuUoVAsfhP0LKt6J0p4lu487
	 PuNZFrSVWj3yQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 02F5049444; Wed,  8 Jul 2026 18:40:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536007;
	bh=VFZFa+sqUfWBHYurcLEvhRD//b3NDb9yrlEBlFIELNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RvPrx3M6GgcsUPQRH9X25Mp2FaHEXnBvDjtMXb/fQ9H6CJiVYY3+RLNPIMJUz5GIF
	 JdAjnBqL/iz6ALVs1mCYy38h+kqhy+GdamJVKv0FH4Ucv4+GskRssQKNuDdWkOhaRK
	 C68cnnIzjjZ0wN8M/caAokRrWfSIu7UO52mxgPzRC7hx+nEsmLIcT9R/XH+HPP+4RW
	 2SEkfTc/JUnlkW7Anj/eTw9SD34R8qII4y2eQnL+R96qsYSbzvhzgsaHglf7qJ9Iqi
	 cyt4XnZISY8WKDQNNsEVU5R/mWiddbxcj2Rx9SU/64bl72v5acNGnyrm0thhdllA8j
	 Tuyc+kH2IRswA==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 44C9B493F1;
	Wed,  8 Jul 2026 18:40:07 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:18 +0200
Subject: [PATCH net-next v2 12/12] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-12-0800fedb2e16@birger-koblitz.de>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
In-Reply-To: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 149CD729AAF

Add support for conditionally setting the ip_alignement flag
AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
is also set to be consistent with the initial configuration in
ax88179_reset()

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 3972eff910ca766cd6e2cca0431ca50a2b02dd2b..d7c021388979595b9c0773eea2126080ca7d2d86 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1313,10 +1313,14 @@ static int ax179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
 	u8 *m_filter = ((u8 *)dev->data);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
 
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
+	if (data->ip_align)
+		data->rxctl |= AX_RX_CTL_IPE;
 
 	if (net->flags & IFF_PROMISC) {
 		data->rxctl |= AX_RX_CTL_PRO;

-- 
2.47.3


