Return-Path: <netdev+bounces-174536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A4A5F19F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D667AACBD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C28C26658F;
	Thu, 13 Mar 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr6aDT4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23141266579;
	Thu, 13 Mar 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862934; cv=none; b=Fj8MibGGw3fepyBq7oOLOtHtCOAC5i5f2KV/VF8K5gzFs4rEulfmPLbnACvOeWHYmFfWD13gWpkdkOiLwHeqgNWY5A1ukita93tSkXovcHlR2XFc6eRudlqH3AdAcdlBEQXnDrKPKJHNgvV3T5srlFZ2kW8mEy7DfJbM2KkzuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862934; c=relaxed/simple;
	bh=p/2oxcn9w8UvQgYDHfdz0zRfqYQy++OiE7NPBwM/3uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GfDNrMy9VSTdtQpdMTeay4gfez9o9hg8ALpF5RJ/7NkGgLpbm7xHX0BfmL+W5OaC5L7F7unut0T3nqSjfki8k/3LyJ1ELIcPxYAaKPPZJDx+1fY7ZvAJuxXksnkBSXmaYZqTGrVYIZzUllmyZHdDwMRFnLVrsKFszxpvU6jgKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr6aDT4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA3C4CEDD;
	Thu, 13 Mar 2025 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862933;
	bh=p/2oxcn9w8UvQgYDHfdz0zRfqYQy++OiE7NPBwM/3uA=;
	h=From:Date:Subject:To:Cc:From;
	b=Dr6aDT4q6+J87VIfN3e7SDIVS8LIVOFISSDMl/jpXQWbruDpv87PJgAxdyxmp49Ws
	 MpIlUSLukHsDP2PS7JeU0Z0iDVY/OuUURBiNI563LPfQ3IRPmF1EN4tyt8yP7EOQy1
	 QPc9Xy8MM18PHy69K3wbIejMpaJHP1t0ARpK7i8JkQVy3+bvZt3IKt7LIexxD5OuHd
	 IYpnSReCf2ylbU34aHR0WFZspK0AL08REmPkL+yBZkmzTwvRRYAwkkNOT2cOeHbPs4
	 opOCeDAZG/UjGM0KNaEKDucEIaXpA78zdRwDLvG3fKa/c9Z67q3VkBqLIC88wzTSzZ
	 gGx+qgs6/myPw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 13 Mar 2025 11:47:42 +0100
Subject: [PATCH net-next v2] net: tulip: avoid unused variable warning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-tulip-w1-v2-1-2ac0d3d909f9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM230mcC/x3MTQqAIBBA4avErBtQS4OuEi2kxhoIE7UfiO6et
 Pzg8R5IFJkS9NUDkU5OvPsCVVcwrdYvhDwXgxJKi0Y2mI+NA14SqXNWt3Y2ppug5CGS4/tfDeA
 po6c7w/i+HzOcnqpkAAAA
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

--

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Simon Horman <horms@kernel.org>
v2: Use IS_ENABLED rather than __maybe_unused [Simon Horman]
v1: Initial patch [Helge Deller]
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


