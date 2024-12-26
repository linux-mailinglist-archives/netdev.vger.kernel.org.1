Return-Path: <netdev+bounces-154307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AEB9FCBFD
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F287162517
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677C113BC35;
	Thu, 26 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WXEOyl0f"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4113B7A1;
	Thu, 26 Dec 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231971; cv=none; b=Zy8m8xQRWsdmstfmP2uxE+DXToVLJlPz/eAHwumg3zGZRgbHXuM2/bBIrjglXBNMtTIsmxWsZi5OI3j9JlGw28hjs5F7db+qXOf/9FA8gVF7DQYR6vvPd5HQaDOQUkSseswsBQaIWz6pIqb1xg4/rVtctQ2WxPrWzIUP6rzKJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231971; c=relaxed/simple;
	bh=Fi0bn4ckJEgIGDpgKWy3yhL85HYvSuIMnanl4g6FpyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jieOnMl0lcfdTAC4zTMBEJU6MGW3RutTUa4A1j3at5BB3HFgeB+3xhAu8VpqfUXLM0k2bzv6IFY50rlzBaprJrfmyKNev3d17s0Dr7WDREKd0Q3dnnSvTfGnenR3E/cKjCNfM39F9cWxgWbBlXBDbCRE8e+FOz/Pml11p4kdo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WXEOyl0f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7AmYte8oTBIV4rhftXrsFRb4h3cQ6cpdyY2nNfyPAUo=; b=WXEOyl0fxXdhgbXP
	SlSEZIGhcqhU98vojNJqoUO2SX68Jgx6zyaCNiCGarFacJysuHxtXRooWGDfvzGmrCn4h7P1QefC4
	z1USatp7VaiZkVchLulP0KoGlLzO0u62j2kbHmiJGUt2PEbiaDwWnHg0P2b5fA0QqpajbP2wIFnes
	xEq6AOCtC8BnF4pivVd+j6ch/0Jx2Ih5TLUTKPt54eNrqJIeeP+m27fMqURqwypwB6IZrHUxYA7Fb
	n3DOibfxxFo92xKNuxW+mUrQRFg4NQXL9alBvsFIHiE/oxaLkjUC7buQB0XbOmc0nW5XBlbZch+o3
	plsTbZlXiQPoR8rTWQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQr5u-007IaP-1M;
	Thu, 26 Dec 2024 16:52:18 +0000
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
Subject: [RFC net-next 3/3] igc: Remove unused igc_read/write_pcie_cap_reg
Date: Thu, 26 Dec 2024 16:52:15 +0000
Message-ID: <20241226165215.105092-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226165215.105092-1-linux@treblig.org>
References: <20241226165215.105092-1-linux@treblig.org>
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


