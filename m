Return-Path: <netdev+bounces-22078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588F765E66
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 23:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A23F1C216E3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393251CA1E;
	Thu, 27 Jul 2023 21:52:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5F1CA1A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 21:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680C2C433C7;
	Thu, 27 Jul 2023 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690494745;
	bh=Ci/kQ+3GXmZ9KWTZr+IFy1WrIkY5Ht6Ig6pJfUkdeDo=;
	h=From:Date:Subject:To:Cc:From;
	b=kp+CBFFrgbVA9nunVmFfFov2c6X35oqh2h5sc8XEvUINx8ARq6p8FjI3csT5rWwqO
	 xgSDi2/+G6YESrMG2cVTnPzO0ID+rjGkRzKxHbgGkdKJsuuIuGxrj68zHgohSviUSJ
	 5PhBleO1JhFktaVuMNAVCOBQueyCgqDaDHlrjZJtxUrgAxcvk4LGPq6VybKE2I4Ofi
	 KJvkVsBSARXq/xijcHzaVykzJgKqFz9tFoU91pwrRb+ueq9TxaF2P8EY0Jt3ztGh3g
	 KsxHhhDlqpEwHnDC8D0g8H6kG+0YwAhBWPeFb57n1jVA9otNCQXIlWPj0sLNepXbM3
	 4XVfIdSRnk89Q==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 27 Jul 2023 22:52:18 +0100
Subject: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
X-B4-Tracking: v=1; b=H4sIABHnwmQC/x2MSwqAIBQArxJvneAPhK4SLdSe9TZWWlGId09az
 sBMgYyJMMPQFUh4U6YtNhB9B361cUFGc2OQXCpupGH5jcdlPSYW8WQotQhKuyYctGZPGOj5f+N
 U6wdNSuQKXwAAAA==
To: Jassi Brar <jaswinder.singh@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ci/kQ+3GXmZ9KWTZr+IFy1WrIkY5Ht6Ig6pJfUkdeDo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwucVsRSi9lgKrSxbjfqZ9spBLrUU4uPGExUZQ
 fK4hbw2O6KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMLnFQAKCRAk1otyXVSH
 0E+qB/4xv+rjWIsXLmaGzgl8gXmDKVoJJddQspvU1fkqxvAehiVocxiYQMny4dDJsUDQpMmdidH
 OEmt5Pz5wO8Bm3cKwgh+itjcK7FpGYDAJhVX+eIByTC8EKviHUhgJ8dAgcmkCF1WU6YSkH/FYLG
 12OtRQaGB0zamvBW6ANKMjVGR5PHmPUrufOWMY+uAZ8Q2VKhLTwXI2hoY4ma+HttMRdyRKg1IUu
 svM6QaXtVn17vOXqcX4gxro82hASks4OmDwPaa99SuGh8M9wVvpnSr5frWiSue+eXEPs8mtRAwJ
 RuFK/zY/RN5tJz5jGHyehh71GzSyPDX6UR3hCBgFkZUv7iEA
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
the system is also used with DT.  Since the firmware used with DT is the
same (the firmware interface is selectable in the firmware
configuration) and the firmware configures the PHY prior to running the
OS we can use the same workaround.

Limit this to the SynQuacer, though practically speaking this is the
only currently known system using this device.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 2d7347b71c41..ae4d336efaa4 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1845,10 +1845,20 @@ static int netsec_of_probe(struct platform_device *pdev,
 {
 	int err;
 
-	err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
-	if (err) {
-		dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
-		return err;
+	if (of_machine_is_compatible("socionext,developer-box")) {
+		/*
+		 * SynQuacer reports RGMII but is physically
+		 * configured with TX and RX delays, since the
+		 * firwmare configures the PHY prior to boot just
+		 * ignore the configuration.
+		 */
+		priv->phy_interface = PHY_INTERFACE_MODE_NA;
+	} else {
+		err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
+		if (err) {
+			dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
+			return err;
+		}
 	}
 
 	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);

---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230727-synquacer-net-e241f34baceb

Best regards,
-- 
Mark Brown <broonie@kernel.org>


