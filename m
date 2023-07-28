Return-Path: <netdev+bounces-22450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C6B7678AC
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06281C209A2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D331FB3F;
	Fri, 28 Jul 2023 22:52:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109F525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 22:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97588C433CA;
	Fri, 28 Jul 2023 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690584735;
	bh=/VxquELnUb4G2FURJ1lShYSnMPZoWyDDj/JtcT/O038=;
	h=From:Date:Subject:To:Cc:From;
	b=SXbqMisz2YGQcuuUD6CnCnsM+La5M9h7N/Qh3nRef2LDxSxhI+e1NzE+Is0pWdnc/
	 Jy+H0XG0Z86EFr6pgG79LsEdY60jC2pGEYzz/2pxPh4SoEKa2SHanOCZ8ruOo4Bjfm
	 r45C/P+gGz/xPlnrkM6OLVnLLX1bhy8wT91MQfZJyWIJ5TSAT2WmrMDG1V4c4xl9Ta
	 aBgDXYPRjQs+j+CSpdRiQM+Ug32gTF5//4kPYpUrK76ji+yntbYPNOgoT6RnaOODgU
	 moaW7wBJNgCiBk2Yim4/b910q+4A0+f9aFUwEQmh7DfGDgc28f2jIZmOOZawVQiF64
	 OBLR0LVJ0beHA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 28 Jul 2023 23:51:03 +0100
Subject: [PATCH v2] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFZGxGQC/3WMQQ6CMBAAv0L27Bpaaqqe/IfhAO0WGk3BLTYS0
 r9buXucSWY2iMSeIlyrDZiSj34KBeShAjN2YSD0tjDIWja1lhrjGl7vzhBjoAVJKuEa1RfRQ2l
 mJuc/++/eFh59XCZe930SP/vvlAQKVFa7k1HGnO3l9iAO9DxOPECbc/4CofclDKsAAAA=
To: Jassi Brar <jaswinder.singh@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/VxquELnUb4G2FURJ1lShYSnMPZoWyDDj/JtcT/O038=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkxEac/HgX4BM2ZmomaS9LhsHegblYFAkBMWx3s
 XFDBAbcIPmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMRGnAAKCRAk1otyXVSH
 0BSjB/9Da88h6x31LhquQ0af5opa2737G1k++8n6+9Avn+iYmb2GaxANvyu38XUl0pDkAzdLXxg
 x9Mpf9tYrafwb7eeD04TKZdcU+OB000IHy9sizl+Pt+/JJbkrXYLK4VWHfrXiDeKWvd0LpweBTv
 LYmQWgMGjzdT+rnw+zEmjlFbq9MbUMLAR5t3OEYpa4Sk+fot2XMxrRUvlVTNw5GATslKyYgB9Lo
 QSP22A+wW/Y3Q7rfDnmy1brKOIdyLf/pFxLCxa45+fOoicMoBHNPrm+Dd1CE6tWfY/Tub8j1z/Q
 Dz3Oaf17PfY5bHkryYoU8+BuP+rozCiAKLps4nHjdTvWcVYP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
property on ACPI systems") the SocioNext SynQuacer platform ships with
firmware defining the PHY mode as RGMII even though the physical
configuration of the PHY is for TX and RX commits.  Since
bbc4d71d63549bc ("net: phy: realtek: fix rtl8211e rx/tx delay config")
this has caused misconfiguration of the PHY, rendering the network
unusable.

This was worked around for ACPI by ignoring the phy-mode property but
the system is also used with DT.  For DT instead if we're running on a
SynQuacer force a working PHY mode, as well as the standard EDK2
firmware with DT there are also some of these systems that use u-boot
and might not initialise the PHY if not netbooting.  Newer firmware
imagaes for at least EDK2 are available from Linaro so print a warning
when doing this.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Unlike ACPI force what appears to be the correct mode, there are
  u-boot firmwares which might not configure the PHY.
- Link to v1: https://lore.kernel.org/r/20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org
---
 drivers/net/ethernet/socionext/netsec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 2d7347b71c41..cdb05db3d6ac 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
 		return err;
 	}
 
+	/*
+	 * SynQuacer is physically configured with TX and RX delays
+	 * but the standard firwmare claimed otherwise for a long
+	 * time, ignore it.
+	 */
+	if (of_machine_is_compatible("socionext,developer-box") &&
+	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
+		dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
+		priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+	}
+
 	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 	if (!priv->phy_np) {
 		dev_err(&pdev->dev, "missing required property 'phy-handle'\n");

---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230727-synquacer-net-e241f34baceb

Best regards,
-- 
Mark Brown <broonie@kernel.org>


