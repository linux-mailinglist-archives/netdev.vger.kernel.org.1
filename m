Return-Path: <netdev+bounces-305959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cp31MCyaTmqTQQIAu9opvQ
	(envelope-from <netdev+bounces-305959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:42:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A68729A31
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:42:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="X32/tJqW";
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="Jk4Nmd/e";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305959-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305959-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF1F30C324F
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA23A4CA297;
	Wed,  8 Jul 2026 18:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A147F2E1;
	Wed,  8 Jul 2026 18:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536019; cv=none; b=p8NCQ4gjH/3Kav43Zupk0BqqStIgTDLvB3yMZlTMs0JgUwjo6gQ3D4vyxwB5z2j7nxRWKgohAY4e8P1vNwB6avo0dfMcLsc8loAorDbZqFHb2GZsUHy1nByAO8ps7QqREAw/LWaylP8zPmjH0aUzcJEh5nwFLUPWTA7Ouvskb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536019; c=relaxed/simple;
	bh=oST6Bqq05oJMcmhim8NTeGKe5DQPoPd4A5HlUKcuC9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTI5nPOFAV9bg1n2DdH5wkHJUTJcb8TZlKsoXT44erQf6bLg5jDO8/ulgPPJOg5JBebi6yTAhCAzqQ1Xk4hxjQAN4wMShdWSt3Hxd2yNog483r/0EUP+nM72kjpP8RIPKEuea3350LjyTKIb00jnRqEN+w7k5takKxIy4Qp245c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=X32/tJqW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Jk4Nmd/e; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536011;
	bh=oST6Bqq05oJMcmhim8NTeGKe5DQPoPd4A5HlUKcuC9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X32/tJqWMTygJbYEda9jgtYaPzjM8y+muHD6MJ67UcoHONwcf3CFiYUR9I3CQV4le
	 dzuHK38+2PVNA0uj1Ohs4OLD/cZdllDNbsIMfsJfV1CLKzbc/OBDgyLcIMWDoyM/IW
	 zBmkiAwm3xj90mcZ2pXvK8+wns41d1orqzMjcM9QGWAaWRjmniiMDsWeRR9YwmqrQZ
	 unk9UwOBPImeE/k318VemwHAq1z31n2quF+DaMBsfjtdv+/ceD72XF9ixoFUSp6vng
	 dpLt5hylhYC1Lwt27SScYWOhoVqLfIKRLu0d+WJw1HiCRWZ5t1EKz5euXLe+3VSvyF
	 Ibj4/3+plvQiw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id BC1394944C; Wed,  8 Jul 2026 18:40:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536006;
	bh=oST6Bqq05oJMcmhim8NTeGKe5DQPoPd4A5HlUKcuC9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jk4Nmd/eOl9Hg+iLQ7tP7HEA2BKnWHgcgP6upgNo4G/9NbBlPA6L3f335BUW0zln+
	 cbcSow/osLY4ukSIoq2mKrtOjxY49VLOr+fXcJWXiVT3P6F0dDcnmRMkCzKL/tFW1t
	 IsdXWhUJGZyudFWKzF4WG7dl/fy3CIKE6xdaTc5f2X7JRQEBRcEvBPe7e/jLPLbFPu
	 zxzRo0vRmqycpmkE3hF5s4Gy9aM5Ex2qBLZuk2qhGUWzsBJqYfk0n8XQaVddgE1Oad
	 4UhiAcKlK2qUAh+Ce7caLVqU22IEGixbP0PIHejMH9pE5ThHMt3nsa8b+plVkKDOsU
	 9hHlDfuckM9gQ==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id EDDCD4943E;
	Wed,  8 Jul 2026 18:40:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:12 +0200
Subject: [PATCH net-next v2 06/12] ax88179_178a: EEE setup for
 AX88179A-based chips
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-6-0800fedb2e16@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-305959-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28A68729A31

Add EEE setup for AX88179A-based chips. For these
chips we enable EEE by default. Adapt the ax88179_chk_eee()
EEE status verification function to also support AX88179A-based
chips in order to make sure the initial setup leads to
a correctly identified EEE status.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 7d1d75d570a3de013b5eda11e0ce0eac988eab49..94820dd1e7e4cbbcd2028783288615eef79b16e2 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -972,6 +972,7 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
+	struct ax88179_data *priv = dev->driver_priv;
 	int val;
 
 	/* Get Supported EEE */
@@ -992,6 +993,13 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
 
+	if (priv->chip_version >= AX_VERSION_AX88279) {
+		val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE2);
+		if (val < 0)
+			return val;
+		mii_eee_cap2_mod_linkmode_adv_t(data->lp_advertised, val);
+	}
+
 	return 0;
 }
 
@@ -1010,7 +1018,9 @@ static int ax88179_chk_eee(struct usbnet *dev)
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
-	if (ecmd.duplex & DUPLEX_FULL) {
+	priv->eee_active = 0;
+	if ((priv->chip_version < AX_VERSION_AX88279 && (ecmd.duplex & DUPLEX_FULL)) ||
+	    (ecmd.speed == SPEED_1000 && (ecmd.duplex & DUPLEX_FULL))) {
 		int eee_lp, eee_cap, eee_adv;
 		u32 lp, cap, adv, supported = 0;
 
@@ -1027,10 +1037,8 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			return true;
 
 		eee_adv = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
-		if (eee_adv < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (eee_adv < 0)
+			return true;
 
 		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
 		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
@@ -1038,16 +1046,13 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			     SUPPORTED_1000baseT_Full :
 			     SUPPORTED_100baseT_Full;
 
-		if (!(lp & adv & supported)) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (!(lp & adv & supported))
+			return true;
 
 		priv->eee_active = 1;
 		return true;
 	}
 
-	priv->eee_active = 0;
 	return false;
 }
 
@@ -2535,11 +2540,20 @@ static int ax88179_reset(struct usbnet *dev)
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
 
-	ax88179_eee_config(dev, false);
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		ax88179_eee_config(dev, false);
 
-	ax88179_ethtool_get_eee(dev, &eee_data);
-	linkmode_zero(eee_data.advertised);
-	ax88179_ethtool_set_eee(dev, &eee_data);
+		ax88179_ethtool_get_eee(dev, &eee_data);
+		linkmode_zero(eee_data.advertised);
+		ax88179_ethtool_set_eee(dev, &eee_data);
+	} else {
+		ax88179_eee_config(dev, true);
+		ax88179_ethtool_get_eee(dev, &eee_data);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, eee_data.advertised);
+		if (ax179_data->chip_version >= AX_VERSION_AX88279)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, eee_data.advertised);
+		ax88179_ethtool_set_eee(dev, &eee_data);
+	}
 
 	/* Restart autoneg */
 	mii_nway_restart(&dev->mii);

-- 
2.47.3


