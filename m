Return-Path: <netdev+bounces-273357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOJ/HL39ymk2CgYAu9opvQ
	(envelope-from <netdev+bounces-273357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FD3621B4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B984030225F9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA383E9284;
	Mon, 30 Mar 2026 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3G8FamUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96843B6BE7;
	Mon, 30 Mar 2026 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910834; cv=none; b=AZmWuEoR7evfLXfz0cI/HZrtUTWf7z1YrvPufRFlHxbNCIiqghQ6ZTjEkgxOMWlXMRHQT1iy7znHLWTn8ZEI+hDaWC8kodK4ux04QPygW+GhfcxZPuSSEYmSwmLPbNHHDdaRwRrE6pnQYvyYy4RvpyT/hfYpb9suS3psoFcTYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910834; c=relaxed/simple;
	bh=9OQ5A6dxr02B5ohtk009vHuj8hPYVMN/qRsxoF5jI1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+LdSNfSNvgfRJf9aHxMkVbuu2EhhaN2aoAOsQNJfAL6Ueo6Ptgv4mSHYhhw7Ydt/xNnINNRGBNdWhqYctEB+K3iWy4NTR/xaZkVAe0XNGPzY+5gFduvjZ2gwhbXCPOmmtQAnj+4F4QMP3TZMhjodyw87S+Ed9upk6UqbqFrIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3G8FamUu; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 083BEA5881;
	Tue, 31 Mar 2026 00:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774910828; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mE/fYI2gz39/bXx6Kl23gFy1SRMoiaQnerxd9LpncLg=;
	b=3G8FamUu1tdme3DzwsYI1L3dxx1M5yVZ3d5D6efUEt96d705FwhVM/tK6/5fexyfFhDOOd
	JyxkWO7kVoaCxeo5maAVkyd+Gxb5iMnm6LdH3U2KCPUQ0eTxS/d7TZHAnXJCiZsX/5Vy1Y
	51gA0NAnEoS2aPjpqPr/p7c7Q/+4Q81WQGX+HgVlWwuDFx06aWai6V50ajkwNUNhzVwxG2
	RwvKSds7F8zvmlaER6EUzOBy5bzD03QG0BbwAUB/UH5mFjghhcohTXgz5wHD279J9kCmuz
	kaHvCvkuNHVdbFPubMxatAb80Fo4T+pHe8/aLxK1RJCF4jklbdPkHUMH0h9qDQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net: phy: microchip: enable downshift by default on LAN88xx
Date: Tue, 31 Mar 2026 00:46:27 +0200
Message-ID: <20260330224630.579937-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330224630.579937-1-nb@tipi-net.de>
References: <20260330224630.579937-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273357-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[raspberrypi.com,tipi-net.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,lunn.ch:email]
X-Rspamd-Queue-Id: DF8FD3621B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
auto-negotiation attempts by default. This ensures that links with
faulty or missing cable pairs (C and D) fall back to 100Mbps without
requiring userspace configuration.

Users can override or disable downshift at runtime:

  ethtool --set-phy-tunable eth0 downshift off

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/microchip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index bc293d2dd130..802b8a6e54e6 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -346,7 +346,7 @@ static void lan88xx_set_mdix(struct phy_device *phydev)
 
 static int lan88xx_config_init(struct phy_device *phydev)
 {
-	int val;
+	int val, err;
 
 	/*Zerodetect delay enable */
 	val = phy_read_mmd(phydev, MDIO_MMD_PCS,
@@ -359,6 +359,11 @@ static int lan88xx_config_init(struct phy_device *phydev)
 	/* Config DSP registers */
 	lan88xx_config_TR_regs(phydev);
 
+	/* Enable downshift after 2 failed attempts by default */
+	err = lan88xx_set_downshift(phydev, 2);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
-- 
2.51.0


