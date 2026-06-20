Return-Path: <netdev+bounces-300809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id loHLNDePNmrpBAcAu9opvQ
	(envelope-from <netdev+bounces-300809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBB6A8EAB
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:01:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=llei0qmC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300809-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8BE301DCDA
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02D390CAB;
	Sat, 20 Jun 2026 13:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4E379EF0
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:01:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781960498; cv=none; b=MVLSaVRUlWsB0D2YRVfbvkQBHfV/ZpHOlQJEN6tYxLoqo8Q9ynSt7RK01Oycvktrpjup5iLlMma7lzJeH4FF83VxjPICKou9tiwcl/uaaMX1X2w7OwfBqnW1OuwvLcBpyZ91tDWwBw+lC2j8Qby6K7ofKzf27KGEc1lWRqCRxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781960498; c=relaxed/simple;
	bh=AZ97wqsFotxnNxdlCBlxJv+DUkfvEG47RhLX9d0fFeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlzJ90OQ5GN0sfquSyj7o47N+IMmvHTeSan7afXFA2S8rBR0iVsQfpmOql8Uf7UeMsb20EUJ+9Jfk5uKXosmH+8Tw99MwbHU59JyzhfKM2IA9kyitpLb/Q2a7hDpZ3MFOLFOvtPe/ZsiDXeQpuqJods3s/WGx+b8jk/EhqPj+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=llei0qmC; arc=none smtp.client-ip=212.77.101.9
Received: (wp-smtpd smtp.wp.pl 1931 invoked from network); 20 Jun 2026 15:01:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1781960493; bh=FihQkQb3fTPCIc0JKtlry5IkU/LW6YEej7nzbs09M78=;
          h=From:To:Cc:Subject;
          b=llei0qmCwpn4ljCXSLn0C3nXFJDV8y8PqsJnp15h4W3p/2CFR+FJDEG9ByNf5akWR
           jJNuX3fiZl8HnhSPGgm3ODK5sYve5gqsgbdQiLIpD2qIyvP6+xGBIWmqG4VBxwHBhO
           gLiMLGT4XyKPX095H6fkHLf8SoJZfouAucj/yM1de9yw7vSIzLmNfM5v8IGdRLfQ8J
           hQgD36EU5ZEuWYMN4ZiSPvunhUaeArNgblqw2+0yJvnFNCRFX/V+PkWvMmLcY1CezH
           xYps8izbyhlrr8IHI2xz11gVdVAkyGiu/IkDA5n16Fg8yZtDdHOLveyjFEKtaqzndd
           b0LkDjckacVTg==
Received: from 83.5.151.132.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.5.151.132])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux@armlinux.org.uk>; 20 Jun 2026 15:01:33 +0200
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
Subject: [PATCH next] net: phylink: print correct c45 phy id when missing PHY driver
Date: Sat, 20 Jun 2026 15:00:58 +0200
Message-ID: <20260620130131.946866-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 578fef9df83779c954a1b5d4c63bac5a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UeNk]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:olek2@wp.pl,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com,vger.kernel.org];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300809-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:dkim,wp.pl:email,wp.pl:mid,wp.pl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10DBB6A8EAB

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


