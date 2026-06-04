Return-Path: <netdev+bounces-295348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jxAeBt6qIWqzKwEAu9opvQ
	(envelope-from <netdev+bounces-295348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:42:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B028641F57
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:42:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=G3Fru6kI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295348-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC5C3105CA8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BF749219B;
	Thu,  4 Jun 2026 16:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B817481AA2;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=LTa5DUElPcCCWDDcjWPlCtVL9TaxYg+zIdh6jIRTwE/4m5y+PsXrk7hncv0lhOxmm8lyztOFGc5kyJ9L1uWtrplbRXxFLsAGGaJd3Tff0XpZ67GpAX9hMZyI7sqVXFReuXtq2e8dcdvKLcwLWRWAH7tp4E/DK30OjygQrUR+IlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=rEvULvmlnDRA4sCVLDbBlYEfqv7KSe1XTjHaDmbBasI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0KUYyOzisL5HDzYkEzAZqIox3A8LEwVlpJXuf93A8uN/AbPGbTMG8DFnbAQc2SKdNl0R04ubARv4waFToY5IW2Hz56B7hnRXH63/lmclVd5yi52XLszXP+JvC0AvBbwSoDFkWoS4OQmY+0kWDLNnGsTGADl7S1Yvtb7F07LN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3Fru6kI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 324AEC2BCF4;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590780;
	bh=rEvULvmlnDRA4sCVLDbBlYEfqv7KSe1XTjHaDmbBasI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G3Fru6kIaVGr+aYfq7TtCzJwh0a5JvVFyzsBy5tLMycLCEnBryfVooT65r9hXxvnF
	 lQK0Ja8qRIi4V5QX8qJ80ohpNZ5223M2TUmtKrwiy90IohOIiMFKkIcpDSsi28NoOF
	 ck6Oc7fdmxwGZUuaYFjMxT6suvnZ+sUNlHYJM7QTxbzDwLoiL+z6Mc9CiTVFxx1jWY
	 +FLQ4+GuWFigOJWPGMu9Z5Oyig1Al5uuKE76RErTE0fwcMnKdgJNu/6AD9ldi5Io5Z
	 3+Sx7rmECfjQQh/BwiCTLV0iahKBzfGs3QtLoc1GmywKe6WDCNIN13AGtWhqdkAziS
	 ZlfjlzSrUekdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A33CD6E79;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:55 +0300
Subject: [PATCH net-next v3 10/13] net: phy: add generic helpers for direct
 C45 MMD access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adin1140-driver-v3-10-5debdb3173c4@analog.com>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
In-Reply-To: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590775; l=2682;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=KEFIsY+nz2k4HZCe7o0fb2JTtI08zuGJ0BttX6Nj+lE=;
 b=nQJkHUs+QsBvezjO+21nfGJcNE8zwp5E65EP5hXQ/FO0/zsBT/iOZOy+k0+8l3adH6PTWmvTG
 F86AIruqA1rAzQFImNJ5mjzGfe5tYCh5zSZDDX317cNic1v1r5uyOVe
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295348-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:mid,analog.com:email,analog.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B028641F57

From: Ciprian Regus <ciprian.regus@analog.com>

Some PHYs support direct C45 register access but not C22 indirect MMD
access (registers 0xD and 0xE). When discovered via C22, phylib routes
MMD access through the indirect path, which won't work on these
devices.

Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
write_mmd callbacks that bypass the C22 indirect path and use the bus
C45 accessors directly.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v3 changelog:
 - no change
v2 changelog:
 - New patch
---
 drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..d33d096e700d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2764,6 +2764,31 @@ int genphy_read_abilities(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_read_abilities);
 
+/* Some PHYs support direct C45 register access but not C22 indirect
+ * MMD access (registers 13 and 14). When discovered via C22, phylib
+ * routes MMD access through the indirect path, which won't work on
+ * these devices. These helpers bypass indirect access and use the bus
+ * C45 accessors directly.
+ */
+int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_read(bus, addr, devnum, regnum);
+}
+EXPORT_SYMBOL(genphy_read_mmd_c45);
+
+int genphy_write_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum,
+			 u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
+}
+EXPORT_SYMBOL(genphy_write_mmd_c45);
+
 /* This is used for the phy device which doesn't support the MMD extended
  * register access, but it does have side effect when we are trying to access
  * the MMD register via indirect method.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..432d44188dbc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2297,6 +2297,9 @@ static inline int genphy_no_config_intr(struct phy_device *phydev)
 {
 	return 0;
 }
+int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum);
+int genphy_write_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum,
+			 u16 val);
 int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,

-- 
2.43.0



