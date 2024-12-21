Return-Path: <netdev+bounces-153941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCF9FA204
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC4F18856A1
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C51862BD;
	Sat, 21 Dec 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rb6jmhXq"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904C185B4C;
	Sat, 21 Dec 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806602; cv=none; b=nW04qS5uDuvZPuUieTt+MNNgUJk3y+pqCfl8cMdziE4u6yxaOnh8m67WFvEla7z5n/ygnrkLSjtmkS6dKpFlvP5FBmOM+wcYTfvGJhDY2gKUwFDpgo/tPhzUkFVvb0IAPY0RdOF50OQWJsyPsLcU6GmY4MtRBdatJpO1TJSmJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806602; c=relaxed/simple;
	bh=xUjMR8E/oB7ectCizWxE8cp7aytblS1UCtWrZAqZ+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPMHibr60Mjo8Hy5OAc4mg9QFzkysiAqWIkqCo1vCknmCXmwwEgNWGnAJkcJlV8toMX/vSvRqiP9CPDzUcznNqr2gG+DgOWSMCIjb8/x54CtP2F5VhJ4xUlaisY5vGTY9nUxRVa2A6PV+aJEvvB3xHooqcSDRTZHsT33TylawvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rb6jmhXq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7DIlELWgzNGvwf4ldWAU2dlgWl8Sx9HJfUGOtuYL0nc=; b=rb6jmhXqCeG5nhsJ
	0/rURDtLdjx2DUq7d3LPzbdJgnhACOUvxYwuhpZBH2iSnQUyNyhbjeFEc3HS+BE1V9UAZb+aEhTul
	IY632KqXQrXW/7rI+bCZrH698HuYRQhXmVuLbllUwryUBvgLOSRqr5F8Gkvpv7ZkSvS576igCwtmX
	w3Yi5u6ZXCQvt+C96+HeHyJapFkIndVWGe4J7IEZrQKJijd6czHJuuH/AwZ+avnQeR9Rm79O6Oipc
	ddEidahJWIkBohGMwwWoSLtvQsjyGIxszBYy/WgyIZSQ9sgaZ+PurjVMfB3jkP293oAHa7apew30w
	TIsPRKw/RuFkaitSoA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4R8-006hEJ-02;
	Sat, 21 Dec 2024 18:42:50 +0000
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
Subject: [RFC net-next 3/9] i40e: Remove unused i40e_(read|write)_phy_register
Date: Sat, 21 Dec 2024 18:42:41 +0000
Message-ID: <20241221184247.118752-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221184247.118752-1-linux@treblig.org>
References: <20241221184247.118752-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

i40e_read_phy_register() and i40e_write_phy_register() were added in
2016 by
commit f62ba91458b5 ("i40e: Add functions which apply correct PHY access
method for read and write operation")

but haven't been used.

Remove them.

(There are more specific _clause* variants of these functions
that are still used.)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 78 -------------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  4 -
 2 files changed, 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ba780a949a47..6779e281a648 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4335,84 +4335,6 @@ int i40e_write_phy_register_clause45(struct i40e_hw *hw,
 	return status;
 }
 
-/**
- * i40e_write_phy_register
- * @hw: pointer to the HW structure
- * @page: registers page number
- * @reg: register address in the page
- * @phy_addr: PHY address on MDIO interface
- * @value: PHY register value
- *
- * Writes value to specified PHY register
- **/
-int i40e_write_phy_register(struct i40e_hw *hw,
-			    u8 page, u16 reg, u8 phy_addr, u16 value)
-{
-	int status;
-
-	switch (hw->device_id) {
-	case I40E_DEV_ID_1G_BASE_T_X722:
-		status = i40e_write_phy_register_clause22(hw, reg, phy_addr,
-							  value);
-		break;
-	case I40E_DEV_ID_1G_BASE_T_BC:
-	case I40E_DEV_ID_5G_BASE_T_BC:
-	case I40E_DEV_ID_10G_BASE_T:
-	case I40E_DEV_ID_10G_BASE_T4:
-	case I40E_DEV_ID_10G_BASE_T_BC:
-	case I40E_DEV_ID_10G_BASE_T_X722:
-	case I40E_DEV_ID_25G_B:
-	case I40E_DEV_ID_25G_SFP28:
-		status = i40e_write_phy_register_clause45(hw, page, reg,
-							  phy_addr, value);
-		break;
-	default:
-		status = -EIO;
-		break;
-	}
-
-	return status;
-}
-
-/**
- * i40e_read_phy_register
- * @hw: pointer to the HW structure
- * @page: registers page number
- * @reg: register address in the page
- * @phy_addr: PHY address on MDIO interface
- * @value: PHY register value
- *
- * Reads specified PHY register value
- **/
-int i40e_read_phy_register(struct i40e_hw *hw,
-			   u8 page, u16 reg, u8 phy_addr, u16 *value)
-{
-	int status;
-
-	switch (hw->device_id) {
-	case I40E_DEV_ID_1G_BASE_T_X722:
-		status = i40e_read_phy_register_clause22(hw, reg, phy_addr,
-							 value);
-		break;
-	case I40E_DEV_ID_1G_BASE_T_BC:
-	case I40E_DEV_ID_5G_BASE_T_BC:
-	case I40E_DEV_ID_10G_BASE_T:
-	case I40E_DEV_ID_10G_BASE_T4:
-	case I40E_DEV_ID_10G_BASE_T_BC:
-	case I40E_DEV_ID_10G_BASE_T_X722:
-	case I40E_DEV_ID_25G_B:
-	case I40E_DEV_ID_25G_SFP28:
-		status = i40e_read_phy_register_clause45(hw, page, reg,
-							 phy_addr, value);
-		break;
-	default:
-		status = -EIO;
-		break;
-	}
-
-	return status;
-}
-
 /**
  * i40e_get_phy_address
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index c0a4bd53501c..bfebe18c0041 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -439,10 +439,6 @@ int i40e_read_phy_register_clause45(struct i40e_hw *hw,
 				    u8 page, u16 reg, u8 phy_addr, u16 *value);
 int i40e_write_phy_register_clause45(struct i40e_hw *hw,
 				     u8 page, u16 reg, u8 phy_addr, u16 value);
-int i40e_read_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
-			   u8 phy_addr, u16 *value);
-int i40e_write_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
-			    u8 phy_addr, u16 value);
 u8 i40e_get_phy_address(struct i40e_hw *hw, u8 dev_num);
 int i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
 		      u16 buff_size, u32 track_id,
-- 
2.47.1


