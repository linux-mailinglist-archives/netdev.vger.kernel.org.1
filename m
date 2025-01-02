Return-Path: <netdev+bounces-154796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A43E9FFCEA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20795162A7B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00569188904;
	Thu,  2 Jan 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="G/wxJMXO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13022188587;
	Thu,  2 Jan 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839474; cv=none; b=oFl/eFUP0bjwd5hhzJ9iabCZohRr2xRm0aT/A/BgS0Et8D2O9tmKKsiGzBUvoSwHEcxMf1rUH8p+OesWhey8hmOFMpmKoQ/yLoR5vs/5g2w/TAOvtwrZJmsiALSVqMooQryv7f77/I4ehp6AeH0NH0uY+OJZGN/e21UKSnEPPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839474; c=relaxed/simple;
	bh=xUjMR8E/oB7ectCizWxE8cp7aytblS1UCtWrZAqZ+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU0OFP58OzL1JBBpm0rbtzBVt3pfbaifNaJwc+Oown64t6lA5mvo8hJUsXHjLk5IyMusTqmXxVRCplK6XyXuTv5f7kVD55yzjCyC/U17FRwILRjspkLkoFDCHW0MtfU/toDBJmEmL575DDcXs1zDtRmBdTOA5KNSVLUbF7fSPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=G/wxJMXO; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7DIlELWgzNGvwf4ldWAU2dlgWl8Sx9HJfUGOtuYL0nc=; b=G/wxJMXOnwSiyXLm
	/jhG9ErKR7SQM/1v/z4Sb9UOGec54mTBIhfqwXhb72NJw6WP4ZYli1i2O1yHtduJ884uXnF/lZYNK
	TnOGmPrqrQzRyn2WJquxVVjDNpWi0mMjCFy1QSpPxu/ICyHuGqRLHY6Uoe42XjmvymVmFW1odUmy6
	vIBaXVq6MhDP6LdDu8kVVC0aHAUpg+x3tGVNk2Qx9Bl6/veu8ADyCgZUXwrVCgSYkjfyzJ5tjCOcP
	XjchSFfYT4jSXvyJx4vk+7Cm1fYjpUFSvIyD/KstGUNDL4SGn+mo+p+FPeRLTHfPa8tWQMYMZomPl
	c4upQ6hKrIrbPv6UYw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8M-007tod-0P;
	Thu, 02 Jan 2025 17:37:22 +0000
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
Subject: [PATCH net-next 3/9] i40e: Remove unused i40e_(read|write)_phy_register
Date: Thu,  2 Jan 2025 17:37:11 +0000
Message-ID: <20250102173717.200359-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
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


