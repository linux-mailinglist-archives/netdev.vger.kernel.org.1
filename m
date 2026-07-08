Return-Path: <netdev+bounces-305915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGBSNHyGTmpcOgIAu9opvQ
	(envelope-from <netdev+bounces-305915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A8F7291C9
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=nsvKswU+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305915-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305915-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617D4301476D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F194A3411;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEC3033CB;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530756; cv=none; b=bxtoBawfur1X2dujMkJcnXyyyzakO2mFwxHGfiajIrCuUjFzFN+VLA5Xwzl0ZbnHqucYzIBk2na7RDxy6hiiaGmUuNsO6mz1oW4aYR+BouOu5YMoCuwlffSkXv/We9HyWUFP0/mmcpArthlfI1ITDWI6KSJCKRk1xQX3j/WhoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530756; c=relaxed/simple;
	bh=0HmNNiW0GG7UgLWfJSFluoRYlfuLGzkN9mAzRLqBpwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FibpjctsiFW1Xgbu1fjHuPrpwoa4r3/gLHDVHG38TJNSYCwFCiprzSls2yuVvRsuKZGvLiEw7QMUADGXB9B+xYMA7xTAvENfDY+OhacXjnNvhRR/BPU61YEXOTHKRTVYlQWuqxE1EH7A/QcWHzFyKnErh/PkGqeE135xBstbYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsvKswU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B862C2BCF6;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530756;
	bh=0HmNNiW0GG7UgLWfJSFluoRYlfuLGzkN9mAzRLqBpwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nsvKswU+ky19OVVnHLpwGqIkGihBrnZGxK6Fpte8paC0MQNVWsYfX5NW8bIfA3VP9
	 uLXOk6+epdufAWJextm6V2Ki/x8ZesdDWZy8AUeYEqpmUG1CUI9YTYFINgUhRbC3qO
	 LszBnjJy3SBPyzWFkfcHsivqLN//KfLvrOFhubNmjB/5a1AH0Fw+RRAuzvpAOazjTj
	 YAS/0TwXsRMynPyDajt8QmSV6zeHGesj7yCs2qxNMoDVsLlEBEP9ojNMY3saETMPv1
	 JDd4yUpNdvcaJxtr3H9Sv2EtK45Dkhle6huES9RTCLY1HkZUwIN3RGi1ob0nTgnoeF
	 UU5JicgGZdanQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0CEC44507;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:33 -0700
Subject: [PATCH net-next v7 03/15] net: phy: Helper to read and write
 through C45 without lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-s2500-mac-phy-support-v7-3-478c877aa1a9@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=3783;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=LI5pKSoF0QdeqOjosWOREP4o7fCPJjwFfpoSB0CTU+A=;
 b=iZSU8W854GORsDfChsC+CYZ+11t9A1hL2VvMu7mHRji9n7cSS8IcJtl4mydfzJhNwyi+xBoPz
 MeY2wkjjAT/BVPxms94qK93J1mp9bDOwIUDcncYlcM35BH6bj/z7/76
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305915-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89A8F7291C9

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Generic helper function to initiate read and write through C45 bus
protocol without mdio bus lock. This will help PHYs to avoid indirect C22
API calls for C45 bus protocol which may not be supported by the PHY.

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
  - lockdep_assert_held added to ensure correct calling convention
changes in v3
  - Added the genphy APIs to initiate Clause 45 register read/write
  - first patch
---
 drivers/net/phy/phy_device.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  4 ++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..b82b99d08132 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2787,6 +2787,61 @@ int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
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



