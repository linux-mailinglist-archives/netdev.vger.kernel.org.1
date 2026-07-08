Return-Path: <netdev+bounces-305923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahPsCOGFTmoTOgIAu9opvQ
	(envelope-from <netdev+bounces-305923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:16:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE59729150
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:16:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=RxIsh2R0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305923-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305923-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7273430258AA
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14144D2EFE;
	Wed,  8 Jul 2026 17:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE54C6F0D;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530757; cv=none; b=crD1hD6oVtf6MKEY7yJr9gOCcj/noXlNqemadjM8F5Q7PcLAHfGCfPEyPGYx+bVYcYZo1ycr5BqzYqwE7r6tvykuoaJtlLK++Eb0VBsn49sce+MVSfTqeJ47XNlpnE7Y7ofSq6GprabTW1TQB3zor9Ybc7USz5sD1v69lU4A7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530757; c=relaxed/simple;
	bh=meb6FWfhYC4oYd6lRg8G4/avVFqNscJnmGXrqfTEY08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwfHhNKvlPEjQ1L96IjwAcs+iUZ/fHP7ZFk5adfkL61u4Rtiwvvn9t/9ng9fOCHa9DTajAgcvcBTAcdVfNsLe8SNtSONwDxmVqV3GHSOUeuDJVz68uYVmucYgFyMt2O35/SP9+P5+kpJqHnGQwl3oUklTkwPAk8MNccCv01kP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxIsh2R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC94EC2BCB9;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530757;
	bh=meb6FWfhYC4oYd6lRg8G4/avVFqNscJnmGXrqfTEY08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RxIsh2R0WspOx3A7HKaORNjnZKK3vmRDQU9H0fRQF7QUcUBAhno9yuBQmmO5zNcbe
	 vIJQ4ypHv/RkALOWDbMXxH6SL8qZE8wbHJWF11DlVBKoAspwa21E9eMcHR+joldS4X
	 YZ3hgq/UZG4bmM/drTA0KM0CX5U47FBKTpx2cvp/0BNuRQpLrG9dsM8pvVZpynYNLF
	 owgLN9ymL5C+p5Rrua5rCEFvJEmIicvPN/PYp/EptRHy2wILWsdlVhQoR+L8vARTT/
	 z++PKx8qPmO4ewypF27Juf8ISHbm0rA0HlycTFPlFWe5/oCvCiSm0pWztuHuqx344w
	 4LITjwSrNdxpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33CC44503;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:39 -0700
Subject: [PATCH net-next v7 09/15] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-s2500-mac-phy-support-v7-9-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=3468;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=kAvcvfZI+qrFnwbRDJm3yhKTDEjWkojRoOjPcD5Eqtc=;
 b=ADU+ViecVwl+30kaFTDyLYZbbEsyve6VmbA6bcRSBK/HM4aE9L4Gk1+PqPcJ+96ztwIihW37/
 YZv05IYOg0qD9muN8C7lYAxPJvz3HA5j6DOR7Salg8g0rVhyYFqMhr/
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305923-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EE59729150

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

OPEN Alliance 10BASE-T1x Serial Interface specification, table 6
allows vendors to use any memory map select (MMS) value between
10 and 15. This new API interface enables vendor to map one of
thes MMS values to MDIO_MMD_VEND1.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - no change
changes in v4
  - no change
changes in v3
  - no change
changes in v2
  - Moved the handling of vendor specific MMS mapping to separate patch
  - new patch
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c | 21 ++++++++++++++++++---
 include/linux/oa_tc6.h               |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 939935cb170d..422f3f10b992 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -207,6 +207,18 @@ int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_ioctl);
 
+/**
+ * oa_tc6_set_vend1_mms - Add vendor specific MDIO_MMD to OA TC6 MMS
+ * mapper value.
+ * @tc6: oa_tc6 struct.
+ * @mms: vendor defined MMS value for VEND1 mdio device.
+ */
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
+{
+	tc6->vend1_mms = mms;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_set_vend1_mms);
+
 static __be32 oa_tc6_prepare_ctrl_header(u32 addr, u8 length,
 					 enum oa_tc6_register_op reg_op)
 {
@@ -460,7 +472,7 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
 				     val);
 }
 
-static int oa_tc6_get_phy_c45_mms(int devnum)
+static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
 {
 	switch (devnum) {
 	case MDIO_MMD_PCS:
@@ -473,6 +485,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 		return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
 	case MDIO_MMD_POWER_UNIT:
 		return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+	case MDIO_MMD_VEND1:
+		return tc6->vend1_mms;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -485,7 +499,7 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	u32 regval;
 	int ret;
 
-	ret = oa_tc6_get_phy_c45_mms(devnum);
+	ret = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (ret < 0)
 		return ret;
 
@@ -502,7 +516,7 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	struct oa_tc6 *tc6 = bus->priv;
 	int ret;
 
-	ret = oa_tc6_get_phy_c45_mms(devnum);
+	ret = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (ret < 0)
 		return ret;
 
@@ -1333,6 +1347,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
+	tc6->vend1_mms = -EOPNOTSUPP;
 	tc6->tx_ts_idx = OA_TC6_TTSCA_REG_ID;
 	INIT_LIST_HEAD(&tc6->tx_ts_skb_q);
 
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index e678a12aedf1..58668f169ea2 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -47,5 +47,6 @@ void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
 			 struct ethtool_ts_stats *stats);
 int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
 			struct kernel_hwtstamp_config *cfg);
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
 void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
 #endif /* _LINUX_OA_TC6_H */

-- 
2.43.0



