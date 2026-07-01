Return-Path: <netdev+bounces-303471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YmkjNvGoRGpkygoAu9opvQ
	(envelope-from <netdev+bounces-303471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0396E9E6A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=vFOeTmrJ;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=mjCWgB7T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303471-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 133E93014131
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E88392820;
	Wed,  1 Jul 2026 05:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8E3845D9;
	Wed,  1 Jul 2026 05:43:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884582; cv=none; b=JrY16+l0nuycg5zhiTUYYI8RMe+QLo9vtfDvb5EQvTdwEwyVnPjb37Vuazf1q0WOYhyOKA1K/qzuL+dP9bBB0j6FAv8vseRiVdBZhVPjImiLvrNan04Hhk9452y+LM9ajMc0RuyvXq6kelwQ375EuF50XbX2PPE7TavT9Ace+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884582; c=relaxed/simple;
	bh=AAgcfQ0lgEdUkXafIXMFQ5Nzg8LI0Qj6iIp2AkF95ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRv/9zLI6xX/gCs9a3QkQW1zxDDNgTk/Bk2rJkAI30DZDlcVPodtShjXMZAEMThNfiHTAfdWZi9dMWiZ5nkkvE1BTPlfzdlb4yUkMpWFjaWuiArRkNMz4tkg8y9uurwHmwMj6igvGrowvBx983uWaV2uwu+4n/8WCgrJlT8h/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vFOeTmrJ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=mjCWgB7T; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884577;
	bh=AAgcfQ0lgEdUkXafIXMFQ5Nzg8LI0Qj6iIp2AkF95ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vFOeTmrJhgZY/UY+rqs8+oBLY8xRzLpOjrDfc6je1yru+eNn8Sl83ODZRuWp6HM/I
	 xnkb4A0pCjEoQ8jOGRgeOD/s+5m7mJ44Dzu0Ic28MZ3liItOrUWgp1DNMBW2WKUa98
	 KNGfdipSs9OG+DGj3Y8R8ghttPlBmL/wafNmsUold8Nh2cpmK7Srx9HqZIizwVDCjQ
	 see1bSrV6Gcx+01N6frYtFhxm7le9VT1rUhIN2HkbLeNgSm8zsRgU2LDzBWGOhvBYy
	 WM30pwBcdUKHUhYxYFxewtO9H6CH4UTmZc0TY+Ap3wY/P6T+12foWBBwp0Of1vtiak
	 ideFQFOoe0Qzw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B173849364; Wed,  1 Jul 2026 05:42:57 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884572;
	bh=AAgcfQ0lgEdUkXafIXMFQ5Nzg8LI0Qj6iIp2AkF95ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mjCWgB7TCGkXHQqtpCUkpDw3RgaLujk1VVCAHONY3bArJFmmrJfjhxyrj+a8yiwux
	 nbOO3DcqPgT4Udt5tH+Qsu8q5r8D4H0EDMTV/VqcZoIQthIPXJDNp7HUKMt/DJAgpq
	 cHI7CPyET474DqBE+C1rFOoJvU4oy7Ln84luZHQHELkC6sS4HFptfHnMZ3mF0TJXHM
	 XAjpQeDBwcguunyOJxrbqL07ji5zesq/GMISSoOa1mdm+ih8zqJHMUtRkDcClS3zOF
	 0jaHNABIZ4ab7klKsGtBAowQPESMZjQCFGjmlrqqn/IlTINXCGjpov76Y6YzckVT+K
	 iilCYOvY8cftw==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 329FF49337;
	Wed,  1 Jul 2026 05:42:52 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:54 +0200
Subject: [PATCH 8/9] ax88179_178a: Add support for AX88179A/772D/279 EEPROM
 access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-8-13685df67515@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303471-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 6C0396E9E6A

The AX88179A/772D devices have 32 efuses with 20 bytes each,
which can be randomly programmed. The AX88279 has 16K FLASH.

Provide ethtool read capability for these devices. However,
no write access is provided.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 75 +++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index d990e28540bdf9336cebfd820b90468d01554450..001faa66efb29df1e09fa3fdc7aa582ab254baca 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -17,6 +17,8 @@
 
 #define AX88179_PHY_ID				0x03
 #define AX_EEPROM_LEN				0x100
+#define AX88279_EEPROM_LEN			0x4000
+#define AX88179A_EEPROM_LEN			(32 * 20)
 #define AX88179_EEPROM_MAGIC			0x17900b95
 #define AX_MCAST_FLTSIZE			8
 #define AX_MAX_MCAST				64
@@ -37,8 +39,11 @@
 #define AX_FW_MODE				0x08
 #define AX_GPHY_CTL				0x0F
 #define AX88179A_FLASH_READ			0x21
+#define AX88179A_FLASH_WEN			0x22
+#define AX88179A_FLASH_WDIS			0x23
 #define AX88179A_FLASH_WRITE			0x24
 #define AX88179A_PHY_CLAUSE45			0x27
+#define AX88179A_FLASH_ERASE_SECTION		0x28
 #define AX88179A_ACCESS_BL			0x2A
 #define AX88179A_PHY_POWER			0x31
 #define AX88179A_AUTODETACH			0xC0
@@ -799,41 +804,74 @@ ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 
 static int ax88179_get_eeprom_len(struct net_device *net)
 {
-	return AX_EEPROM_LEN;
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data;
+
+	ax179_data = dev->driver_priv;
+
+	if (ax179_data->chip_version < AX_VERSION_AX88179A)
+		return AX_EEPROM_LEN;
+	else if (ax179_data->chip_version >= AX_VERSION_AX88279)
+		return AX88279_EEPROM_LEN;
+	else
+		return AX88179A_EEPROM_LEN;
 }
 
-static int
-ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
-		   u8 *data)
+static void
+ax88179_eeprom_access_params(struct ax88179_data *ax179_data, int i, u16 *value, u16 *idx)
+{
+	/* AX88179 has a word-addressable EEPROM
+	 * AX88179A uses EFUSES with 20 bytes length
+	 * AX88279 has an EEPROM addressable in 256 byte blocks
+	 */
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		*value = i;
+		*idx = 1;
+	} else if (ax179_data->chip_version >= AX_VERSION_AX88279) {
+		*value = (i * ax179_data->eeprom_block) >> 16;
+		*idx = (i * ax179_data->eeprom_block) & 0xffff;
+	} else {
+		*value = i << 4;
+		*idx = 0;
+	}
+}
+
+static int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
 {
 	struct usbnet *dev = netdev_priv(net);
-	u16 *eeprom_buff;
-	int first_word, last_word;
-	int i, ret;
+	struct ax88179_data *ax179_data;
+	int first, last, i, ret;
+	u8 *eeprom_buff;
+
+	ax179_data = dev->driver_priv;
 
 	if (eeprom->len == 0)
 		return -EINVAL;
 
 	eeprom->magic = AX88179_EEPROM_MAGIC;
 
-	first_word = eeprom->offset >> 1;
-	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
-	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
-				    GFP_KERNEL);
+	first = eeprom->offset / ax179_data->eeprom_block;
+	last = (eeprom->offset + eeprom->len - 1) / ax179_data->eeprom_block;
+
+	eeprom_buff = kzalloc((last - first + 1) * ax179_data->eeprom_block, GFP_KERNEL);
 	if (!eeprom_buff)
 		return -ENOMEM;
 
-	/* ax88179/178A returns 2 bytes from eeprom on read */
-	for (i = first_word; i <= last_word; i++) {
-		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
-					 &eeprom_buff[i - first_word]);
+	for (i = first; i <= last; i++) {
+		u16 value, idx;
+
+		ax88179_eeprom_access_params(ax179_data, i, &value, &idx);
+		ret = __ax88179_read_cmd(dev, ax179_data->eeprom_read_cmd,
+					 value, idx, ax179_data->eeprom_block,
+					 eeprom_buff + (i - first) * ax179_data->eeprom_block);
+
 		if (ret < 0) {
 			kfree(eeprom_buff);
 			return -EIO;
 		}
 	}
 
-	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
+	memcpy(data, eeprom_buff + eeprom->offset % ax179_data->eeprom_block, eeprom->len);
 	kfree(eeprom_buff);
 	return 0;
 }
@@ -843,12 +881,17 @@ ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 		   u8 *data)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data;
 	u16 *eeprom_buff;
 	int first_word;
 	int last_word;
 	int ret;
 	int i;
 
+	ax179_data = dev->driver_priv;
+	if (ax179_data->chip_version >= AX_VERSION_AX88179A)
+		return -EOPNOTSUPP;
+
 	netdev_dbg(net, "write EEPROM len %d, offset %d, magic 0x%x\n",
 		   eeprom->len, eeprom->offset, eeprom->magic);
 

-- 
2.47.3


