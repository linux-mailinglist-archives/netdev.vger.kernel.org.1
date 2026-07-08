Return-Path: <netdev+bounces-305965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x0pAIOmaTmruQQIAu9opvQ
	(envelope-from <netdev+bounces-305965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A9729AB4
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:46:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=oOj3ob1H;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=ltQf5sRG;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305965-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305965-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE98312B94C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1C4D9906;
	Wed,  8 Jul 2026 18:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00884D8D86;
	Wed,  8 Jul 2026 18:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536022; cv=none; b=GF53qLtfhVs6H47qIfMiJThq/D7eLv+saiHTwJHn5Phrsvt4vYHN86WRJz4NJwq4r9tuVn4lR25WIq7DtpMt7XJikX+WFaCCjFvWUKkwFf944KCHCAMJjjiAPFav1DxeUYKez/OYapfU0rWZRwl9mDLNdpEqZ2orDwQ9+yAjqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536022; c=relaxed/simple;
	bh=CAHOASJFkvHTG3BGUywT9taqG/e3JFGDRjy/E+wj0B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1zTnFqX7Hi+rLCzAL3O0Jd0N2VlH/Z/BhET4g8bxu9lZUIqOOZOQBkEMglFtfqCI7B7MVRg2R7yB16A5yCfwRFPdx7gkkQD8VYjUOBmIAKzY0KWD0bGI1Id09LmQvx+QyzWDzT4rQW76EkfdPudwm9aAbdUlZDQA9I7kTHK43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=oOj3ob1H; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ltQf5sRG; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536015;
	bh=CAHOASJFkvHTG3BGUywT9taqG/e3JFGDRjy/E+wj0B4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oOj3ob1HHLrVKH80uX1Iaa3IfQpvQ9Tk0Qck2B5kDQMff/fz6RkTFto0/v8uDKG1T
	 5h34kmv7mKp4BBu/UTne842LG469xkX0aTi5Ov1rnA3cGDRaGXwNUk4/6ish+V2sjG
	 9Fwcq4+P3NdSTE4wVv2yxzdlw5xFQGCwQAd9vmqjUJmbGKPLdSiNtMNTtiej9F4D+O
	 YdExBHl//TsMRokepVKkOsJGyCAzpQFgwU9z69L8yDNQMCiO/ot9Pj5GwwIVEKNs2k
	 85/LhxURQ11SMS6Z1+YiUQphyIvByu3VyBVnrtz/G4W6N2GLie9GrL7cywmzXzyEz6
	 l6mJE+fkpxewA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 197EC493DD; Wed,  8 Jul 2026 18:40:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536007;
	bh=CAHOASJFkvHTG3BGUywT9taqG/e3JFGDRjy/E+wj0B4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ltQf5sRG6Q6VjjCFYkQsWrwMb8KmdaOkExkL4zBx6e6n0zTd4hhvjoCzgOFgJCfhH
	 976J2Si+ixMRoIK4eLVG1i3y7zvrPd+rwhSs+WTIQVuGmTtpk/qxbSgl8bNwIdtcN6
	 R6vbKu2lWblJIN8VEj19TYIcXd3sLZWJoT0raIFoG+E0NZDH9jQ2lo8oFkVqWx8/s/
	 LWqFFUy0b/Fggci56sbErDBCQvI0F/yZt3dQVgDt+fCvi1p9ZNf83FAB6nbI6BjIoV
	 ZaiX0WVcRaUDGebmSWfm86tmm4I/4hizEvJF8T6nSJJ91J2hPS+CX5MxCXgGdgu5TI
	 xxRs9tE6CRIOw==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0FD9F493ED;
	Wed,  8 Jul 2026 18:40:07 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:17 +0200
Subject: [PATCH net-next v2 11/12] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-11-0800fedb2e16@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305965-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 186A9729AB4

The AX88179A/772D devices have 32 efuses with 20 bytes each,
which can be randomly programmed. The AX88279 has 16K FLASH.

Provide ethtool read capability for these devices. However,
no write access is provided.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 75 +++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 31e0ec1c15b455b8810f73d4d8ae9a5b5b05f9a2..3972eff910ca766cd6e2cca0431ca50a2b02dd2b 100644
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
@@ -805,41 +810,74 @@ ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 
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
@@ -849,12 +887,17 @@ ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
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


