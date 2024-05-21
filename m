Return-Path: <netdev+bounces-97287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1688CA831
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7956B20632
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381713FB88;
	Tue, 21 May 2024 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="ozh+1Wpm"
X-Original-To: netdev@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34354C12C;
	Tue, 21 May 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274481; cv=none; b=FRLv96eFnrLXLwLfxEZuX7ssh+nNUP3IAvSY28xONvY2qBnZwiiU8g73FLFoMwC2WvGSMO2s105SsbwM5fM2yK44R0o3WsCZe7AK/rz7iMFCcnJB1rtRFH2EkN4iiUVmL5k+0nQMWsXwybS0cHXpmgmeoaVKuklFSaPaz7RfcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274481; c=relaxed/simple;
	bh=WtgR3bLQuAmZGGWX0wAEK013PqHleBU86WX+TrhdJMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/T8XGUlJzQnFpdiu7MuAk1l334rOAUXhO3zP2FcYEIZFN2xSqKv+wYbeaws7IDk2/YKxFm41YLypnCDbm0E8dPjj5PrufOrAlqRiNoqWmDIfHoDLzc9L24VwjEU+VViAtlW7CmoOp6MKu1/Ba5YBWwdMTfbCA1l2IKa1PVx0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=ozh+1Wpm; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1s9JOI-0005RQ-R5; Tue, 21 May 2024 02:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=At4Se3gmzXZDGmwHKvKP5TWbdoV3Trjfqo3NAyHAEuk=; b=ozh+1Wpmncnavt
	AXFMGDLI3yCG9nqxjQi3xlHXRuhCzCApw8YnG8znPIHwDqpu5GrBy26vTZMzCufUViwsBtDh3BYxR
	jTzIva7f2/3crqmJeA4/dY3PzI5uwCw0oMchnHKGXxUgFZifjKiqGM1390FwklEfehOtrQTfOZI37
	WbO0AthpQZ49HleONx99rQZsIdIpY1pCU1SMI0gQIOCWxmZk+x9NzbKx4xDEZfSjyTjE94nvRhekB
	Lh9MCGJEpp+UPBXlZmxO4HVKLy6HrR8Savea8k8hJ0dXWo6H+K9SZfsAQFvqG1pGBM319e3TD8lSD
	/uyeuZ69LxWkr/W2qmuA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Othacehe <othacehe@gnu.org>,
	Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: [PATCH] net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061
Date: Tue, 21 May 2024 08:54:06 +0200
Message-ID: <20240521065406.4233-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following a similar reinstate for the KSZ8081 and KSZ9031.

Older kernels would use the genphy_soft_reset if the PHY did not implement
a .soft_reset.

The KSZ8061 errata described here:
https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ8061-Errata-DS80000688B.pdf
and worked around with 232ba3a51c ("net: phy: Micrel KSZ8061: link failure after cable connect")
is back again without this soft reset.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Tested-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 13e30ea7eec5..1d769322b059 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5327,6 +5327,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.probe		= kszphy_probe,
 	.config_init	= ksz8061_config_init,
+	.soft_reset	= genphy_soft_reset,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
-- 
2.41.0


