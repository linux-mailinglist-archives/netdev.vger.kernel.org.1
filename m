Return-Path: <netdev+bounces-154802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54879FFCFB
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166AD1881BA1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBD1AC884;
	Thu,  2 Jan 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eZX1CAuy"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF216EBE8;
	Thu,  2 Jan 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839714; cv=none; b=JwNk2fDnEgA6yCd/NFDEL15qaWWHFMorp6/krVrwwApQ2vqQZaIYsi1Uwgxa+sK3/Z74XVgOooWE0kJyHonpDQ15bPv9U8yZl3UiTLrPtnGCN6+c1NawsZFp+MyIDn9Gz1FKBAjlXqQ4qIvIQzXi7hmMIDrfWkYVSd8Y/7SWXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839714; c=relaxed/simple;
	bh=Fi0bn4ckJEgIGDpgKWy3yhL85HYvSuIMnanl4g6FpyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlKk1+pJXFrDYftMlxDZMGeM84rANrxYboDbwBDM4rXh6/FS+bo8x4EYLDZUDv5RXvcs9Q4PzwHgef/GE+eiVUyjNqZBA+RhFR+VKkyeC1eKaBopl4H1THGIxm8nBycuUo+gX9JZtJyZJ+aLsYwRxEDgT0vhEcNtCbvQ9mHBqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eZX1CAuy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7AmYte8oTBIV4rhftXrsFRb4h3cQ6cpdyY2nNfyPAUo=; b=eZX1CAuydvfqHvVp
	PRoGyZI90PuSx8iEZoNUzUIp99xN7QQ6NEca7FKzdfEjGqJwVlPiranManolBAyuUG7/GZ72w39lc
	fLA122L4mlaQiGqg0BFoZ5xGeAoY/ZwQjZ5xgJN8kGw6IsEa36rYr/TqRIbh2/OThUo25zSa3fA1B
	2jKrg3rJAssXlGdSyed7Mwk8LvkvDkjhgROdp2S3qH+MRJlJsRu1qnvlG/Nxxyg9s0C7TKRQtPQUQ
	0EC906u1aPudUTFqKkv35iijvsOw2jHwupiLtSjmiPBBLJ5VYM/hSoPv22t6nlMzj8n7CqC2Z2q06
	j3KksT/A+aHEJi7nGA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTPCb-007u04-2Q;
	Thu, 02 Jan 2025 17:41:45 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 3/3] igc: Remove unused igc_read/write_pcie_cap_reg
Date: Thu,  2 Jan 2025 17:41:42 +0000
Message-ID: <20250102174142.200700-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102174142.200700-1-linux@treblig.org>
References: <20250102174142.200700-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last uses of igc_read_pcie_cap_reg() and igc_write_pcie_cap_reg()
were removed in 2019 by
commit 16ecd8d9af26 ("igc: Remove the obsolete workaround")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/igc/igc_hw.h   |  3 ---
 drivers/net/ethernet/intel/igc/igc_main.c | 25 -----------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 7ec7e395020b..be8a49a86d09 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -279,7 +279,4 @@ struct net_device *igc_get_hw_dev(struct igc_hw *hw);
 #define hw_dbg(format, arg...) \
 	netdev_dbg(igc_get_hw_dev(hw), format, ##arg)
 
-s32  igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-s32  igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-
 #endif /* _IGC_HW_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9c92673a7240..f58cd6940434 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6779,31 +6779,6 @@ static const struct net_device_ops igc_netdev_ops = {
 	.ndo_get_tstamp		= igc_get_tstamp,
 };
 
-/* PCIe configuration access */
-s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	if (!pci_is_pcie(adapter->pdev))
-		return -IGC_ERR_CONFIG;
-
-	pcie_capability_read_word(adapter->pdev, reg, value);
-
-	return IGC_SUCCESS;
-}
-
-s32 igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	if (!pci_is_pcie(adapter->pdev))
-		return -IGC_ERR_CONFIG;
-
-	pcie_capability_write_word(adapter->pdev, reg, *value);
-
-	return IGC_SUCCESS;
-}
-
 u32 igc_rd32(struct igc_hw *hw, u32 reg)
 {
 	struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
-- 
2.47.1


