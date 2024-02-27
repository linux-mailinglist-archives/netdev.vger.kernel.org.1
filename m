Return-Path: <netdev+bounces-75473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E086A124
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D6C1F23190
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12314F983;
	Tue, 27 Feb 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="o63+GAqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE014F965
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067076; cv=none; b=p27PnUfBVGGup8WEN+iR2QBNwWhJhH7evqlbue04yhyvypuCukPEbIUKPOCiGIAH23ZWx/aPsE90VlAzfzRrQ2TgCCcazlHvVEV83IX7GX+yuSNJVfrl3QrGP1rRZWG9RcmkHjIWPEbBxL0D+51lyabQdC1SVv65XzEjkcPQ4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067076; c=relaxed/simple;
	bh=C0EhGGIcvZ5dia6z/DMgXS0/s8mPCNUY3CZZl/PV8yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGRLMka+PFZ08PXXkm70+T3IUcwTpJbDrW64leJpPgoO/w1Az4aoczlsT3+qRyhlgyNXotfqOEd6yJgWBOqf8sy6QfjKywLaC0s+N97LMxbTLkSMq06vFFvE2V5CX4qrDwSAZ0GJ7b0JwDxgHEzpWbjL7eGEyqVmG3SfhErmdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=o63+GAqK; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id f4PjrRU7nxsbMf4PxrnVkm; Tue, 27 Feb 2024 21:51:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709067074;
	bh=7fh9n2YY+v7xWTDGOZYJY6/nuH13jrBRMC/bW8tKScA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o63+GAqKGfx/mlADiFhta1gyxBFJ8uc639Wp16WrZKT6slPdnUDf17LNyr9/4eh//
	 sDAicxQKAatVayHw1tHwmP6X4Y8F7GXuzcPSj2qBAFCuzAARKkhnWPYUZiPr7TSv8/
	 4vbVBkC29wH8xASlmKeSWdw5FXA5LlBNvayZ+gBHD5aAUfCODUU5BnnGjWnsAQ/ZRO
	 ap6xlASO0me8gaNIKO3O/ZITYI5HMMeQui98osjS3WjiFvEHlHgcN+6EFlFvCuO4L0
	 09Ggdh6XcrocUN3r4stlWPKqLRrVcrh/FYfT/mw5+ZYMnsf6FGgpMxC0QMGLnmsxxs
	 bDRdjBlEij6Cw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 27 Feb 2024 21:51:14 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 2/2] net: tehuti: Fix leaks in the error handling path of bdx_probe()
Date: Tue, 27 Feb 2024 21:50:56 +0100
Message-ID: <9090b599c7574892b77a9521e3ddb3a52a154205.1709066709.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs when allocating the net_device, all the one already
allocated and registered should be released, as already done in the remove
function.

Add a new label, remove the now useless 'err_out_disable_msi' label and
adjust the error handling path accordingly.

Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/ethernet/tehuti/tehuti.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index 938a5caf5a3b..6678179885cb 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -1965,7 +1965,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ndev = alloc_etherdev(sizeof(struct bdx_priv));
 		if (!ndev) {
 			err = -ENOMEM;
-			goto err_out_disable_msi;
+			goto err_out_free;
 		}
 
 		ndev->netdev_ops = &bdx_netdev_ops;
@@ -2031,13 +2031,13 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (bdx_read_mac(priv)) {
 			pr_err("load MAC address failed\n");
 			err = -EFAULT;
-			goto err_out_disable_msi;
+			goto err_out_free_current;
 		}
 		SET_NETDEV_DEV(ndev, &pdev->dev);
 		err = register_netdev(ndev);
 		if (err) {
 			pr_err("register_netdev failed\n");
-			goto err_out_free;
+			goto err_out_free_current;
 		}
 		netif_carrier_off(ndev);
 		netif_stop_queue(ndev);
@@ -2046,9 +2046,14 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	RET(0);
 
-err_out_free:
+err_out_free_current:
 	free_netdev(ndev);
-err_out_disable_msi:
+err_out_free:
+	while (--port >= 0) {
+		ndev = nic->priv[port]->ndev;
+		unregister_netdev(ndev);
+		free_netdev(ndev);
+	}
 #ifdef BDX_MSI
 	if (nic->irq_type == IRQ_MSI)
 		pci_disable_msi(pdev);
-- 
2.43.2


