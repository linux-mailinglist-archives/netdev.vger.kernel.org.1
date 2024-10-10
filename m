Return-Path: <netdev+bounces-133984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C99979CF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFE21C22669
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42948F9CB;
	Thu, 10 Oct 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FatR5lce"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5B645
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521475; cv=none; b=noykooXurZP2Nq8U5zH5yp3BpVIQ8dEceANn65SnhP+fZji/JEEu5E+XZVmTaHTY8EPk+sE4BU7NzE3/QXbdXXf7PH+lyndJmq87NVeEG/rAAIiL+qXwUi2yxQSNk0W3WmRw2fAxjOTTwsRfLsGTFT7GTGlURpyOH2wP1EVficE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521475; c=relaxed/simple;
	bh=DZ1+Ni+zYQzQzWABkg+ZFJmTNb+vX7MUgbMJrlxAxOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QToWxBBlC9YV9Ac6v7A7TR6ZRFVO96CXmLHZHebi7gVLbBvMUq7QGlvZ20alrRPwCG9jUDdvM99wUuIBYKwkLTJzEcZj+YiFPgLLZAFy1812r2zq5d+Ao1i5BjgOuIe3V0uNPvpErXFciD74NDAykTByMmCO7hTBScm+7NjqXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=FatR5lce; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ECC4A2C01F6;
	Thu, 10 Oct 2024 13:51:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728521469;
	bh=wFush8R/tfUQ876cxTMS5lnSrCNVewI9v7fOknWucnE=;
	h=From:To:Cc:Subject:Date:From;
	b=FatR5lce087PbElKHflBHo0ljlTEJ3++5Gg2rHf35wgLeY5HBXbq2blNgpunNifeq
	 OwJ9XdcrAC40BFIcYJNZszDxB3E50+Thtqi6KAG2/3N+uJM8iWh7FqPqJIqAy4Uqe+
	 bQIIKC5Teh45PdrpBv93fbb1Gy+li1KUC+dpIKkfPVpFAK1KBc6bRNa6+tB8mOUYca
	 QIgDZws3StiMpQMx++stBGM0cLAYBtED2s5s6A6SPRVh1q90vLJIyaIOZA/L4tdt0C
	 lAJqgUkUB8/crSBCgQTkv4T8YP4jwC4DV8Hq7xv6YdZcRU6FxmiLAyiM/tcyjrWgWt
	 f3SQ38q1DOjZg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670724fd0000>; Thu, 10 Oct 2024 13:51:09 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id BCB7113ED7B;
	Thu, 10 Oct 2024 13:51:09 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id B7C572A0BF8; Thu, 10 Oct 2024 13:51:09 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] net: phy: aquantia: poll status register
Date: Thu, 10 Oct 2024 13:49:34 +1300
Message-ID: <20241010004935.1774601-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670724fd a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=CGjx52yEnwgpAtm7to8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The system interface connection status register is not immediately
correct upon line side link up. This results in the status being read as
OFF and then transitioning to the correct host side link mode with a
short delay. This causes the phylink framework passing the OFF status
down to all MAC config drivers, resulting in the host side link being
misconfigured, which in turn can lead to link flapping or complete
packet loss in some cases.

Mitigate this by periodically polling the register until it not showing
the OFF state. This will be done every 1ms for 10ms, using the same
poll/timeout as the processor intensive operation reads.

If the phy is still expressing the OFF state after the timeout, then set
the link to false and pass the NA interface mode onto the phylink
framework.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
Changes in v1:
- Ignore timeout error
- Set link status to false in OFF case

 drivers/net/phy/aquantia/aquantia_main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
index dcad3fa1ddc3..cad9ba4d4dbe 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -42,6 +42,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_XAUI	4
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII	6
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
+#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
=20
 #define MDIO_AN_VEND_PROV			0xc400
@@ -348,9 +349,19 @@ static int aqr107_read_status(struct phy_device *phy=
dev)
 	if (!phydev->link || phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return 0;
=20
-	val =3D phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS)=
;
-	if (val < 0)
-		return val;
+	/**
+	 * The status register is not immediately correct on line side link up.
+	 * Poll periodically until it reflects the correct ON state.
+	 * Only return fail for read error, timeout defaults to OFF state.
+	 */
+	ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
+					MDIO_PHYXS_VEND_IF_STATUS, val,
+					(FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val) !=3D
+					MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF),
+					AQR107_OP_IN_PROG_SLEEP,
+					AQR107_OP_IN_PROG_TIMEOUT, false);
+	if (ret && ret !=3D -ETIMEDOUT)
+		return ret;
=20
 	switch (FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val)) {
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR:
@@ -377,7 +388,9 @@ static int aqr107_read_status(struct phy_device *phyd=
ev)
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
 		phydev->interface =3D PHY_INTERFACE_MODE_2500BASEX;
 		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF:
 	default:
+		phydev->link =3D false;
 		phydev->interface =3D PHY_INTERFACE_MODE_NA;
 		break;
 	}
--=20
2.46.0


