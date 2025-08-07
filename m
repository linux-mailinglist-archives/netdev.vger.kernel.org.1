Return-Path: <netdev+bounces-212059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8EFB1D999
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27463BCD53
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3962A25EF90;
	Thu,  7 Aug 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="sTDPq+Ke"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9725D536;
	Thu,  7 Aug 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575397; cv=none; b=FS3CLPm5nYpuCxKGQ7uDxLH4xQlWJmy3W13C5oB90M6HndxjTdKbSmriOdXXeFyG8FXJCL5Da7CDxENEgRIz84WUPACA/5NmR3JlhMDhgLotLfnNjgt094FvoQuI4RExInp5lvuIt2vnVwca3RPqn5a3/JKNujcCykQFqoKlLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575397; c=relaxed/simple;
	bh=bjEiiI161dYTrY0Cw3+ZZGVoX2NnHUSvIH1QPcitc9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6Lm6nmTyJXwz9u5uuemdRKmtcReykE0s//C2TeM1IS+9KnY55c22tOLpFqUgaSOKoeGb916uT/gtDGlvTPOBJ2pCwFgn8v5cL4kL+7bdOh/q+h6gRmosi1fp2faVVqH6l3ThCi49eSJi0oeDdnLHCi2GxK6hwWutoSucUWakcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=sTDPq+Ke; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 59F64A037B;
	Thu,  7 Aug 2025 16:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=H0mVJmCWOicg9EcBRx/NfEzNMf28ZNNzr0DbLGreYW8=; b=
	sTDPq+KeRzVhg8O8HZh3s+/CBi+XOgzUpJh3dvxLrDj+Zepd0UBhtKG5UhaE5gEq
	EGTNtMdmWUeCbvzjfmJaM7s6vru4SeO24VeAncROkyH0f2ashTFdZMmUGY1ybR1a
	3dmA1Cw4q3hyrNnR9yJSAV+N7TYlh+6tnYM7G1bHa7skl0l081x223l5HcMtS9Sc
	YYqLeyzCsaqFOpJj8s8VKFm7acYeArpWdh5CuNCh+I2IJJwmU9cjpZkNLlx8C+Kf
	trjs0kEyUBWstsRT47V4N2pOuE1j4rBpFcMcE1V9nr3lFg8+0NwyNZJipQ/WCV6I
	ZzTLfnXIW/cyK4AcAxKETlnlM13q4/0IHrQspKYfDvQ6RG9yKp25c1yDUodv1duP
	Eib+g65a9x/wP+xSS4rcTMwiEsaupZNkyfHxwiWAw1tJg1cJHjLu23uLs7/ArPPl
	vPxe+3+AJfkUHylTxZG9hN2fvacPXWJlbx0GBdHEd2Ld2elQ9mmZ2bt4UhDHNSLE
	O1nx6rr05auXZyAPSyqYUyLIAl+JplGAbXf//RGyBwOoNKLhWi/8HyaKE+FoyW0Q
	D/G3FIfOMiHVsBtizDiQ8pFtC8fr4otul9ve1tL8ZKr7kOkxStMf9gUzmrZ3BEuJ
	PTPWW4g9GzzMx/eOJDt2M/6QQcmb58BEWcIWxsvr+sQ=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Rob Herring <robh@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "David S. Miller" <davem@davemloft.net>, "Sergei
 Shtylyov" <sergei.shtylyov@cogentembedded.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net v2] net: mdiobus: release reset_gpio in mdiobus_unregister_device()
Date: Thu, 7 Aug 2025 15:54:49 +0200
Message-ID: <20250807135449.254254-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1754575389;VERSION=7995;MC=2460790112;ID=765739;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E667361

From: Buday Csaba <buday.csaba@prolan.hu>

reset_gpio is claimed in mdiobus_register_device(), but it is not
released in mdiobus_unregister_device(). It is instead only
released when the whole MDIO bus is unregistered.
When a device uses the reset_gpio property, it becomes impossible
to unregister it and register it again, because the GPIO remains
claimed.
This patch resolves that issue.

Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support") # see notes
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Cc: Csókás Bence <csokas.bence@prolan.hu>
[ csokas.bence: Resolve rebase conflict and clarify msg ]
Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---

Notes:
    Changes in v2:
    * Rebase onto net-next (from 6.12)
    * Clarify msg after talking with Csaba in person
    * Collect Andrew's tag
    
    Link to v1:
    https://lore.kernel.org/all/20250709133222.48802-3-buday.csaba@prolan.hu/
    
    Note to stable@:
    * for 6.12 and before, the above v1 patch can be used.

 drivers/net/phy/mdio_bus.c          | 1 +
 drivers/net/phy/mdio_bus_provider.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index fda2e27c1810..cad6ed3aa10b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -91,6 +91,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
+	gpiod_put(mdiodev->reset_gpio);
 	reset_control_put(mdiodev->reset_ctrl);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 48dc4bf85125..f43973e73ea3 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -443,9 +443,6 @@ void mdiobus_unregister(struct mii_bus *bus)
 		if (!mdiodev)
 			continue;
 
-		if (mdiodev->reset_gpio)
-			gpiod_put(mdiodev->reset_gpio);
-
 		mdiodev->device_remove(mdiodev);
 		mdiodev->device_free(mdiodev);
 	}

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.43.0



