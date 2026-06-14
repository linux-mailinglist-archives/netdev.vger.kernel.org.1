Return-Path: <netdev+bounces-299248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rp5BmTeLmqQ5QQAu9opvQ
	(envelope-from <netdev+bounces-299248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:01:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A8681A69
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=IM5rmqTE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299248-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75236300250A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2763CBE7D;
	Sun, 14 Jun 2026 17:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB43C8C7F;
	Sun, 14 Jun 2026 17:01:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456465; cv=none; b=OsOhVv0gKxo5LZnz4+Ne+NsAfG2cs8b3ZkheC5ZFMGvKDzCjNsVgTCaA8WdybfRUwZuXVTK6wR7iAQF6FHQHbZ8vUdvfmzzK8G4XvIhJ3WPKxwOj6Fsbr4dwS+7fOR+G4n4aNi/EuZKDGi/gQ2CKrnuY61kbplWdkVZPwr2CI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456465; c=relaxed/simple;
	bh=RcfvknUgQTugoKwFzDXqvnX/EDb9wFloC2KEPk+WO6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cesvpeLbIVGIpmv9QhdgC6TcIx86woeWIkLgswTtukH4m4QKnzulRA3dMCI9nWoTJhTOsshfnzhfZq+18mrzWdbjY/UMhMR5c50Mc6nD+yMBArhIe7l4bVYYtgXJSUsw7m8oD8vMLer3c8mHlEPLKuUBgpzkkGhSWz0DR/zrQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM5rmqTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24FEAC4AF0E;
	Sun, 14 Jun 2026 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781456465;
	bh=RcfvknUgQTugoKwFzDXqvnX/EDb9wFloC2KEPk+WO6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IM5rmqTEPJBMTYe8xVEonIpXF83YeuP6h4sW5d6enhhQStD9mEfLjEfX9kMyaEPvk
	 kyKbKt1c1O56Oc9GhiIYFLjb1d8nQuPDtuLuhgRUmTCzdaVEFYHI0UtxuPBdVOStop
	 rOrUW4aDpsCc56XBwrl5RjPOiejpmHK3RUJHRoGrJuJP8/JdQsQzQ7gBjGzgLJS9LL
	 pmAoklKDnw0VoR2A789maI2oD2d2Xi+g6SxpF151MTcvZLcyEyXXQTzLwkEttd7dew
	 UeM4yMLsYISPdRwHnoxwxRvrqZ6KVqNXxQtAb1Qj0bAo53JTm9XVOOpbtFT0CYP94P
	 68VcucPpFBu6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E46CD98D8;
	Sun, 14 Jun 2026 17:01:05 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 14 Jun 2026 10:00:18 -0700
Subject: [PATCH net-next v5 02/15] net: phy: Helper to modify PHY loopback
 mode only
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-s2500-mac-phy-support-v5-2-89874b72f725@onsemi.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
In-Reply-To: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781456462; l=3349;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=LR4dCtu8dt8SKzEEzyzZCEhrOtW1KnkVuUBypOQtpbs=;
 b=b/Et1WTO8rrTHj7465Vlp+xXWP/x5nNv4glL3X8wkzabvcx3YcK/y83lMpkNrvhUQpnojh3nl
 w1E3fgR/vxHBhM+O8EzjbS3DcmXSGv2HRdaA4JxGBhiaoBzzXhkT8bV
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
	TAGGED_FROM(0.00)[bounces-299248-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 254A8681A69

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Generic helper function to modify loopback bit of the PHY without
modifying any other bit. This will help the PHYs that may have fixed
speed, like 10Base-T1S or PHYs that don't need any other settings
to set them in loopback mode.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5
  - No change
changes in v4
  - Created a new genphy API to set the loopback. No other PHY
    registers touched.
---
 drivers/net/phy/dp83867.c    | 11 +----------
 drivers/net/phy/phy_device.c | 20 ++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cd..01ea2e8dd253 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -991,15 +991,6 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int dp83867_loopback(struct phy_device *phydev, bool enable, int speed)
-{
-	if (enable && speed)
-		return -EOPNOTSUPP;
-
-	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
-			  enable ? BMCR_LOOPBACK : 0);
-}
-
 static int
 dp83867_led_brightness_set(struct phy_device *phydev,
 			   u8 index, enum led_brightness brightness)
@@ -1204,7 +1195,7 @@ static struct phy_driver dp83867_driver[] = {
 		.resume		= dp83867_resume,
 
 		.link_change_notify = dp83867_link_change_notify,
-		.set_loopback	= dp83867_loopback,
+		.set_loopback	= genphy_loopback_fixed_speed,
 
 		.led_brightness_set = dp83867_led_brightness_set,
 		.led_hw_is_supported = dp83867_led_hw_is_supported,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b82b99d08132..11fd204eea16 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2842,6 +2842,26 @@ int genphy_phy_write_mmd(struct phy_device *phydev, int devnum,
 }
 EXPORT_SYMBOL(genphy_phy_write_mmd);
 
+/**
+ * genphy_loopback_fixed_speed - Helper to modify the PHY loopback mode
+ * without affecting any other settings.
+ * @phydev: The phy_device struct
+ * @enable: Flag to enable or disable the PHY level loopback.
+ * @speed: Speed setting. Not expected to be set. Error if it is set.
+ *
+ * Returns: 0 if successful, negative error code on failure.
+ */
+int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
+				int speed)
+{
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
+			  enable ? BMCR_LOOPBACK : 0);
+}
+EXPORT_SYMBOL(genphy_loopback_fixed_speed);
+
 int genphy_suspend(struct phy_device *phydev)
 {
 	return phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8266dd4a8dbe..61bcd71a3143 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2301,6 +2301,8 @@ int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 				 u16 regnum, u16 val);
+int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
+				int speed);
 int genphy_phy_write_mmd(struct phy_device *phydev, int devnum,
 			 u16 regnum, u16 val);
 int genphy_phy_read_mmd(struct phy_device *phydev, int devnum,

-- 
2.43.0



