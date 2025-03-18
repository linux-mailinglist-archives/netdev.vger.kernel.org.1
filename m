Return-Path: <netdev+bounces-175743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA400A675A3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C0417D5C7
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB1520DD45;
	Tue, 18 Mar 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw3vspTL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8020D4FE;
	Tue, 18 Mar 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306056; cv=none; b=l2n62RPfjqqeotsHvX0QJZolZNEcWTLH6giU/SgHTQ7Eqzk/Fl5DiVpxtkTFDRqcztkQh8j6nOLSprfPH7FoCRqF3svNhWnnuXfrOkvGdrdMcnStKAmhqcAkQI4/7OeXz0tkr4yA1ftwmASFtnAghBob6hYmEm3dycRkq69rVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306056; c=relaxed/simple;
	bh=MQJNg6mROFDZ7aRUJyj8+ib7C6toJaNGkiuTO74TuVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pF0PljLy5o50ZdHYFuwK41JYYsGgoo+MqmxLh3dGAgQLptQJSVx8jz1dgz050YTUQJkGD7BDEtt8LnnxI77peJLbCKfa2sxS7LC5Jrn3oxAV9D4c3090C49FH+6kuWec5flZ6doYgu1Xy50sEFsZLjIjs9UjJzISR631WzwmIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw3vspTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160E1C4CEE3;
	Tue, 18 Mar 2025 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306055;
	bh=MQJNg6mROFDZ7aRUJyj8+ib7C6toJaNGkiuTO74TuVs=;
	h=From:Date:Subject:To:Cc:From;
	b=kw3vspTLYcuBLz+iPQk+dJ4KMTcNmA3+xP7dYcNp8M+DQP5rpmuxJPQjoLWF+bx+B
	 vZLHezaDIuJvUeYzG2EVwBQH8Xjq6GCCbHm3uSrV5FvXyH9UUpBL732JJf53sIubJw
	 bfGzVNY/qidjvHrJwB1nXWtbTMa+Zrzd0emXl/FKowoifTvxcUHmAOrHZZg0KLaiLj
	 +a3lUANpcFLeAGzoUUuxn41W/dC/IPpvhhXzj53evIjW+FTqxbouJ5ngyDzvgqOqAk
	 +9qizX8kUlvLBTb6+/p/bDgXy3zS4Ln9Ko69BIZNEVqAND21ngPpYnLvkk218QsgcI
	 WGLTJAR81ByGg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 18 Mar 2025 13:53:34 +0000
Subject: [PATCH net-next v3] net: tulip: avoid unused variable warning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-tulip-w1-v3-1-a813fadd164d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN162WcC/2WNQQqDMBBFryKz7pSYVMWueo/iIpiJDpUoSWotk
 rs3ZNvl433ePyGQZwpwr07wtHPg1WVQlwrGWbuJkE1mkEI2QtUK43vhDT81Umd1c9OmbbsR8nz
 zZPkoqSc4iujoiDBkM3OIq/+Wj10W/5/bJdYo9SiMMr3obf94kXe0XFc/wZBS+gEN5fRPqwAAA
 A==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Helge Deller <deller@gmx.de>, netdev@vger.kernel.org, 
 linux-parisc@vger.kernel.org
X-Mailer: b4 0.14.0

There is an effort to achieve W=1 kernel builds without warnings.
As part of that effort Helge Deller highlighted the following warnings
in the tulip driver when compiling with W=1 and CONFIG_TULIP_MWI=n:

  .../tulip_core.c: In function ‘tulip_init_one’:
  .../tulip_core.c:1309:22: warning: variable ‘force_csr0’ set but not used

This patch addresses that problem using IS_ENABLED(). This approach has
the added benefit of reducing conditionally compiled code. And thus
increasing compile coverage. E.g. for allmodconfig builds which enable
CONFIG_TULIP_MWI.

Compile tested only.
No run-time effect intended.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v3:
- Fix mangled commit message
- Link to v2: https://lore.kernel.org/r/20250313-tulip-w1-v2-1-2ac0d3d909f9@kernel.org

Changes in v2:
- Use IS_ENABLED rather than __maybe_unused
- Link to v1: https://lore.kernel.org/netdev/20250309214238.66155-1-deller@kernel.org/

Note about v1:
- Original patch by Helge Deller
---
 drivers/net/ethernet/dec/tulip/tulip_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index 27e01d780cd0..75eac18ff246 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -1177,7 +1177,6 @@ static void set_rx_mode(struct net_device *dev)
 	iowrite32(csr6, ioaddr + CSR6);
 }
 
-#ifdef CONFIG_TULIP_MWI
 static void tulip_mwi_config(struct pci_dev *pdev, struct net_device *dev)
 {
 	struct tulip_private *tp = netdev_priv(dev);
@@ -1251,7 +1250,6 @@ static void tulip_mwi_config(struct pci_dev *pdev, struct net_device *dev)
 		netdev_dbg(dev, "MWI config cacheline=%d, csr0=%08x\n",
 			   cache, csr0);
 }
-#endif
 
 /*
  *	Chips that have the MRM/reserved bit quirk and the burst quirk. That
@@ -1463,10 +1461,9 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&tp->media_work, tulip_tbl[tp->chip_id].media_task);
 
-#ifdef CONFIG_TULIP_MWI
-	if (!force_csr0 && (tp->flags & HAS_PCI_MWI))
+	if (IS_ENABLED(CONFIG_TULIP_MWI) && !force_csr0 &&
+	    (tp->flags & HAS_PCI_MWI))
 		tulip_mwi_config (pdev, dev);
-#endif
 
 	/* Stop the chip's Tx and Rx processes. */
 	tulip_stop_rxtx(tp);


