Return-Path: <netdev+bounces-300811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5MQGLZGRNmpEBQcAu9opvQ
	(envelope-from <netdev+bounces-300811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B16A8EC9
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:11:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=y5QwiBbl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300811-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 625BD3014402
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22E3939D7;
	Sat, 20 Jun 2026 13:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38348315D33
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:11:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961101; cv=none; b=jpnOBYU4iwxLNPb9gCY0aLSOhGZkW6NbVoBrJ88raC7xA8pG4he1UbJ0AkX0vvExlNWA7wMg70p0SAOW/E5r7uzh4oPZenW/hsvYZ5g2rU209jum+9ACPfhW0XMfS2HgeiN2f5ccjn4dEKQU7XvKWdfYEQtQ0vQjmVSNJerY1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961101; c=relaxed/simple;
	bh=AZ97wqsFotxnNxdlCBlxJv+DUkfvEG47RhLX9d0fFeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HA6VwR9c3inizeSIfGce65ZH2Tmr6YAkj8JsVvKjVvPZP3lw0AeIxPH2tULf+ksWPQAnA7UU7M9RRFzS11y4kEcScCV1QbAbrofos4wMY7HnnoNbraoM6IQPA+xqeoICZPcg7ADyKnn5fybEH0JImoEVxcbVYBgtwA1SroRtXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=y5QwiBbl; arc=none smtp.client-ip=212.77.101.12
Received: (wp-smtpd smtp.wp.pl 1146 invoked from network); 20 Jun 2026 15:11:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1781961095; bh=FihQkQb3fTPCIc0JKtlry5IkU/LW6YEej7nzbs09M78=;
          h=From:To:Cc:Subject;
          b=y5QwiBblvPqb04mZWP6PH14QqXA7aJpuNsjvY+riP9TDe5OwxL3Bf4/dNtjiVLgSv
           WqJSxud4DHuNOFtKHDKR2XnxnWHc4aoV6SjJV/187EBwBymIGvG866X2jtNz1Buh0U
           goXZM+QXKuolGL0hA4H8TrJqlLUkfILcD6+ltLrv6Dyk3syydKb2U1s/GzAVwfBqxg
           XbfLHRy9ITTOb5LQDLX8DwPTx+nBSdyF1xfdLuHz/Tz7ez7VcDFJoan20ggjUafkh8
           jQdZN+3mK9ZurqiSpVXDcsNzk4+3Ko5/tedqSIyVGlGhZJMqRXciQLA4rdn3a9XeyX
           ezUmKKkrzV72Q==
Received: from 83.5.151.132.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.5.151.132])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux@armlinux.org.uk>; 20 Jun 2026 15:11:35 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net] net: phylink: print correct c45 phy id when missing PHY driver
Date: Sat, 20 Jun 2026 15:11:13 +0200
Message-ID: <20260620131130.949298-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: a309c6e095426610e04f850591e955b0
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wWP0]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:olek2@wp.pl,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com,vger.kernel.org];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300811-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:dkim,wp.pl:email,wp.pl:mid,wp.pl:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209B16A8EC9

If no PHY driver is found, `phy_id` is returned. `phy_id` holds the c22 ID.
Modules with a rollball bridge support only c45 transfers. The c45 IDs are
stored in the `c45_ids` structure. In the current code these modules report
an ID 0x00000000. This may lead users to mistakenly conclude that the
rollball bridge isn't properly implemented in their SFP module. This patch
fixes the wrong IDs for c45 modules when a driver cannot be found.

Tested on Fiberstore SFP-GB-BE-T (C22) and ONTi ONT-C1TE-R05 (Rollball).

Before:
[ 2440.373985] mtk_soc_eth 15100000.ethernet sfp-lan: PHY i2c:sfp2:11 (id 0x00000000) has no driver loaded
[ 2440.383385] mtk_soc_eth 15100000.ethernet sfp-lan: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[ 2440.395274] sfp sfp2: sfp_add_phy failed: -EINVAL

After:
[   82.573700] mtk_soc_eth 15100000.ethernet sfp-lan: PHY i2c:sfp2:11 (id 0x001cc898) has no driver loaded
[   82.583098] mtk_soc_eth 15100000.ethernet sfp-lan: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[   82.594996] sfp sfp2: sfp_add_phy failed: -EINVAL

Fixes: ffcbfb5f9779 ("net: phylink: improve phylink_sfp_config_phy() error message with missing PHY driver")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/phylink.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..7d7595158bf9 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3917,13 +3917,30 @@ static void phylink_sfp_link_up(void *upstream)
 	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_LINK);
 }
 
+static u32 phylink_get_phy_id(struct phy_device *phy)
+{
+	if (phy->is_c45) {
+		const int num_ids = ARRAY_SIZE(phy->c45_ids.device_ids);
+		int i;
+
+		for (i = 1; i < num_ids; i++) {
+			if (phy->c45_ids.mmds_present & BIT(i))
+				return (phy->c45_ids.device_ids[i]);
+		}
+
+		return 0;
+	} else {
+		return phy->phy_id;
+	}
+}
+
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phylink *pl = upstream;
 
 	if (!phy->drv) {
-		phylink_err(pl, "PHY %s (id 0x%.8lx) has no driver loaded\n",
-			    phydev_name(phy), (unsigned long)phy->phy_id);
+		phylink_err(pl, "PHY %s (id 0x%.8x) has no driver loaded\n",
+			    phydev_name(phy), phylink_get_phy_id(phy));
 		phylink_err(pl, "Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY\n");
 		return -EINVAL;
 	}
-- 
2.53.0


