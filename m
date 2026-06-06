Return-Path: <netdev+bounces-296043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X36SLnCzI2r9xAEAu9opvQ
	(envelope-from <netdev+bounces-296043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:43:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28664C995
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:43:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=b3lOqoZH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296043-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA9B302D534
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2D3093B2;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED12F7F00;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724569; cv=none; b=QyHmjTKb7vpBTI6FTVeLbUTc+Vci2zcdp27cfw7TmKkm3lFqogMIkrZ79AWxhLioWxb/G+0iAQS053XD3OHg9BoPztePjOivQr2GnDUGh4CZ8Qaq2fpDM6UbxtGBS/dc980aUetfpV/8NtLIgvMerw7XKFyOijWp23JmevnvpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724569; c=relaxed/simple;
	bh=LjX0iNDA1QuH0fa/aAzAd20F0ug7JO+NaJvzlquleo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSnLRwrdah8mKV0wi2jQRfntDDp3J9rRN7q/peoiBIC33+DNRKyngtmhlA98va1f04DD6r3fF+9JIeZl/a7Jn/epGr6y6uDAZnW3qBOhI1PoLbv/peMf2i79xDjghwZ+kHaXVGCOlJjnWLIm7Ee66KvvXFzsbqGHBTwFVkaNjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3lOqoZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 273CCC2BCC7;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=LjX0iNDA1QuH0fa/aAzAd20F0ug7JO+NaJvzlquleo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b3lOqoZHf/c6KTKbDNiZLpO1GWlrjRkUEm4I4L1Q+fcoLzrn1Ea7H4gxee1ob3JF7
	 vJJ56vNwDacXzB9iAFmCfJZ1qQxQNfl7IYaF7dkxNdTMFBgqdwZIdFAUy5PHMzIBjX
	 h831BuTHPSfXxa/ZVs0MH0ZSo9CuoKDc2e6TAQAREdFqhYSt/+oAVlWuC9jSBbbsYw
	 u7LSGqEq77hLnTKxfuG8P8eDDtyZr7xoWrbZBC47IC2Y3gqjViQWEfTgmK5aSvySqi
	 zVbzwxmCp2okzWVpCMhr7OlgjIVyecGu8kGayvu9x4bceFy6PsmzLgCwByffOSdvYg
	 NeX4obGw7WBNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1242BCD8C85;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:32 -0700
Subject: [PATCH net-next v4 01/16] net: phy: Helper to read and write
 through C45 without lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-s2500-mac-phy-support-v4-1-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=3459;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=JvvJXQtiELpn1FGIsjj4sr5oo2VlfTINRAZf1k5i42I=;
 b=y6DMdh9smhvvWef/6NBQQFDz0anPehbu1rQUl6u/PaXM+u/UUKbuu9HObang8430hF8xDin9w
 yS0GcRb19+qAIVJLzQr2yRfdG0nTHd44a0VfZijWHNbf1iCZ1+7mkuy
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296043-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B28664C995

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Generic helper function to initiate read and write through C45 bus
protocol without mdio bus lock. This will help PHYs to avoid indirect C22
API calls for C45 bus protocol which may not be supported by the PHY.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/phy/phy_device.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  4 ++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..20c92fde4fbb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2781,6 +2781,61 @@ int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 }
 EXPORT_SYMBOL(genphy_write_mmd_unsupported);
 
+/**
+ * genphy_phy_read_mmd - Helper for reading a register without lock
+ * from the given MMD and PHY.
+ * @phydev: The phy_device struct
+ * @devnum: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Description: PHYs can have both C22 and C45 registers space. Once PHY
+ * is discovered via C22 bus protocol, it uses C22 indirect access to
+ * access C45 registers. Some PHYs, like 10Base-T1S PHYs defined by OPEN
+ * Alliance 10BASE‑T1x, support only direct access.
+ *
+ * If PHY indicates C45 support through DTS entry, it avoid C22 APIs
+ * entirely and therefore generic MDIO registers are inaccessible.
+ *
+ * MDIO bus isn't locked here because when called through read_mmd
+ * callback of phy_driver, caller is expected to lock the bus as
+ * implemented in phy_read_mmd.
+ *
+ * Returns: Register value if successful, negative error code on failure.
+ */
+int genphy_phy_read_mmd(struct phy_device *phydev, int devnum,
+			u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	lockdep_assert_held(&bus->mdio_lock);
+	return __mdiobus_c45_read(bus, addr, devnum, regnum);
+}
+EXPORT_SYMBOL(genphy_phy_read_mmd);
+
+/**
+ * genphy_phy_write_mmd - Helper for writing a register without lock
+ * to the given MMD and PHY.
+ * @phydev: The phy_device struct
+ * @devnum: The MMD to write to
+ * @regnum: The register on the MMD to write
+ * @val:    Value to write
+ *
+ * Description: Similar to genphy_phy_read_mmd
+ *
+ * Returns: 0 if successful, negative error code on failure.
+ */
+int genphy_phy_write_mmd(struct phy_device *phydev, int devnum,
+			 u16 regnum, u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	lockdep_assert_held(&bus->mdio_lock);
+	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
+}
+EXPORT_SYMBOL(genphy_phy_write_mmd);
+
 int genphy_suspend(struct phy_device *phydev)
 {
 	return phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..8266dd4a8dbe 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2301,6 +2301,10 @@ int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 				 u16 regnum, u16 val);
+int genphy_phy_write_mmd(struct phy_device *phydev, int devnum,
+			 u16 regnum, u16 val);
+int genphy_phy_read_mmd(struct phy_device *phydev, int devnum,
+			u16 regnum);
 
 /* Clause 37 */
 int genphy_c37_config_aneg(struct phy_device *phydev);

-- 
2.43.0



