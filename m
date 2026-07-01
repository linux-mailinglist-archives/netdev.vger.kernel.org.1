Return-Path: <netdev+bounces-303470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iry8BO6oRGpjygoAu9opvQ
	(envelope-from <netdev+bounces-303470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAC6E9E65
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:43:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=uAeSeRuv;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=1K3aAuuj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303470-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303470-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 074DE301D31A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71528391E4C;
	Wed,  1 Jul 2026 05:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FD37FF7B;
	Wed,  1 Jul 2026 05:43:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884582; cv=none; b=oMAYTXhRzvrOoImV8HIi6Xiy+dfjIxhFjoavNTipqYOu0x372hgp4oBH4HrYtNTE1dcQnHDrtGdVbM7UDpktE2Xey/+lxh6nr+E4Y9VjwskBRmcfgYb/IIfukOd5nDfnR/pOFQ8Kad9tJeDNryAH/Ug/tIDS0308KgMU15AfjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884582; c=relaxed/simple;
	bh=B6MPSip2IWD0NYA1NhMmuvFBh5mHLUXCYhN6hAx2c80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O28bU4ylxjOwLEOCMO1i+Dh1pPKMO3KDr8uY0UKRhMZOi0uwJ+XKGU9VGtdVV+axnpZ1E5asBarOxQ/km0pJ2zRq8nrTos/7XeYE4hwhPi8Hk8xXxaD5kE8ndJ07xtIJGPs05exArJ7vmDvYCgIw3OqZDDsuUwjFqwRrdMeA12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=uAeSeRuv; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1K3aAuuj; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884577;
	bh=B6MPSip2IWD0NYA1NhMmuvFBh5mHLUXCYhN6hAx2c80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uAeSeRuvpGU/RIBVxlX4C20AasId9qWIJVnF6xgjTQLQ5ltYPxoXsRxz+5howSCcT
	 Fq9o807nI4BxMEtJS2ve8lXr+hdKMoU9DAs7LN+8Csa0cjzwMLGim3WmxL4KDsv3rv
	 OfcBpyf6+c/jbwlFsh9sljPoTqasB8Z2/3swJf4YuCXhTXAC/6gygaDaLvjAECnyU3
	 +vRM3muzxjWC1RwSBYbTF3jnNv9ZHxOMVKfcjHxrzwOgtuas8l1wY/11wI9moFCWIA
	 udfslLPjFSoAxeHbg95poIcgZ4+832nAhzx1QF2VWOOaaASjVDqe2OqKo7izwrkKEM
	 X9XD6+qP2QxCw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 31B5A4937A; Wed,  1 Jul 2026 05:42:57 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884572;
	bh=B6MPSip2IWD0NYA1NhMmuvFBh5mHLUXCYhN6hAx2c80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1K3aAuuj2Icu4g9uPExiRAAUTQsI977NerUhrVK7RJlABxPCq6wB+fUKzX0x3+ewH
	 sVvdz4d2MFNR38cewoEzzZ6jObQqPYhBwcC0ISWunN8ltxa38c8ECdLu3Jc1uuc4II
	 5TT/qKXcYa4+WzmwhtGsL04K0uXcikDCeP+L834JA5Ll5oXPIxdutLmVkyRWF9nxDc
	 Ub3t9hUJbmEoUmBo0lXwLnsBZqhlgxcbMA0mTO3SEBhb+R6p/bxHnP/j2WqVRPJEV/
	 nce7XALGzK0bA+j2kWVwI5KknewrwJRmVP0cNNZmr7xSOejlreLwSuvtT4p020DQ8H
	 ABlZ1mcqTk8lA==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F19F249343;
	Wed,  1 Jul 2026 05:42:51 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:53 +0200
Subject: [PATCH 7/9] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-7-13685df67515@birger-koblitz.de>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
In-Reply-To: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303470-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70BAC6E9E65

Add ax88179_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index f70f79ebc7f7c4d2321e033f7b8d09e6291c842f..d990e28540bdf9336cebfd820b90468d01554450 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -758,6 +758,21 @@ static void ax88179_disconnect(struct usb_interface *intf)
 	usbnet_disconnect(intf);
 }
 
+static void ax88179_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *priv = dev->driver_priv;
+
+	/* Inherit standard device info */
+	usbnet_get_drvinfo(net, info);
+	if (priv->chip_version < AX_VERSION_AX88179A)
+		return;
+
+	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
+		 priv->fw_version[0], priv->fw_version[1],
+		 priv->fw_version[2], priv->fw_version[3]);
+}
+
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
@@ -1193,6 +1208,7 @@ static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179_ethtool_ops = {
+	.get_drvinfo		= ax88179_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3


