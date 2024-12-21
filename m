Return-Path: <netdev+bounces-153940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1F9FA201
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1491887AF2
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C5178383;
	Sat, 21 Dec 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="R8BXJxLT"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362841C68A3;
	Sat, 21 Dec 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806594; cv=none; b=gqYMj0pRc+i7ksyS2qXnVcz7jj4p4rM83W1HskMW70XX4+6bLTMrh7WjseE+laQoV2DiOxehcB2Z68B7nl24ZWB+QGv5nYeq05ULYr/0AWZZiT5IzhoTVzRbCcd2fzQ0c7z1oOME+LRgfHajWZA+YoXHtnyHyj5ZFXDPiZstedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806594; c=relaxed/simple;
	bh=d5aakrVX4yeTY7hducvdCR/gG2oYHLw7wao3jo+Lq3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX1J3wX85QQg7TD+muI2fZpYqwfBLsYI9aPjsfdAgMjVMrZHMTbeJOfVXHI2BRcWolgspesT866NiwOwzOcM25bbAELXl1dxduj3S2HHtBafcKRFBOlt7buhqvuqLql7XzsTWedT9nK0VVGsQYfxJOoC13GEQ500GQ9DYoem8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=R8BXJxLT; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=EL9sWILBSGTYl+aZk0fVJx8i0jxQ5SOOcBDq3z7WT58=; b=R8BXJxLT9V+pwos6
	FOeczG84Ohn5m6Akr7GQNoT2wQ0NggE5tfA3u0jF3Y+k1iIKmv15LsW/zUBIY1N/je02JiOPM3wCP
	lhEBsD39w5SyIlWeMt5v2Uzcd0G/sDmSD833A6hvO983rrdVVM0N/Kjyj2kPU+aRdIXjmaPZmtFzT
	NSCuI2uxXyvZ9wsib03v6Fp1BR74yZFR7+X0bgpLhFkzcIKmfeb09c/ByPxt3/OeLRCoZt8pF2PuB
	9gcnbLuV6RrC5l0Fbt/meBRuFqw1Yb67+Q22AdZkTcjoihQjKGaIWh6UDjUodaGXsYJj57hUiT5Bl
	JC5T0P3ohJDjn67zgg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4R7-006hEJ-1B;
	Sat, 21 Dec 2024 18:42:49 +0000
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
Subject: [RFC net-next 2/9] i40e: Remove unused i40e_blink_phy_link_led
Date: Sat, 21 Dec 2024 18:42:40 +0000
Message-ID: <20241221184247.118752-3-linux@treblig.org>
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

i40e_blink_phy_link_led() was added in 2016 by
commit fd077cd3399b ("i40e: Add functions to blink led on 10GBaseT PHY")

but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 74 -------------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  4 -
 2 files changed, 78 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 47e71f72d87b..ba780a949a47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4428,80 +4428,6 @@ u8 i40e_get_phy_address(struct i40e_hw *hw, u8 dev_num)
 	return (u8)(reg_val >> ((dev_num + 1) * 5)) & 0x1f;
 }
 
-/**
- * i40e_blink_phy_link_led
- * @hw: pointer to the HW structure
- * @time: time how long led will blinks in secs
- * @interval: gap between LED on and off in msecs
- *
- * Blinks PHY link LED
- **/
-int i40e_blink_phy_link_led(struct i40e_hw *hw,
-			    u32 time, u32 interval)
-{
-	u16 led_addr = I40E_PHY_LED_PROV_REG_1;
-	u16 gpio_led_port;
-	u8 phy_addr = 0;
-	int status = 0;
-	u16 led_ctl;
-	u8 port_num;
-	u16 led_reg;
-	u32 i;
-
-	i = rd32(hw, I40E_PFGEN_PORTNUM);
-	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
-	phy_addr = i40e_get_phy_address(hw, port_num);
-
-	for (gpio_led_port = 0; gpio_led_port < 3; gpio_led_port++,
-	     led_addr++) {
-		status = i40e_read_phy_register_clause45(hw,
-							 I40E_PHY_COM_REG_PAGE,
-							 led_addr, phy_addr,
-							 &led_reg);
-		if (status)
-			goto phy_blinking_end;
-		led_ctl = led_reg;
-		if (led_reg & I40E_PHY_LED_LINK_MODE_MASK) {
-			led_reg = 0;
-			status = i40e_write_phy_register_clause45(hw,
-							 I40E_PHY_COM_REG_PAGE,
-							 led_addr, phy_addr,
-							 led_reg);
-			if (status)
-				goto phy_blinking_end;
-			break;
-		}
-	}
-
-	if (time > 0 && interval > 0) {
-		for (i = 0; i < time * 1000; i += interval) {
-			status = i40e_read_phy_register_clause45(hw,
-						I40E_PHY_COM_REG_PAGE,
-						led_addr, phy_addr, &led_reg);
-			if (status)
-				goto restore_config;
-			if (led_reg & I40E_PHY_LED_MANUAL_ON)
-				led_reg = 0;
-			else
-				led_reg = I40E_PHY_LED_MANUAL_ON;
-			status = i40e_write_phy_register_clause45(hw,
-						I40E_PHY_COM_REG_PAGE,
-						led_addr, phy_addr, led_reg);
-			if (status)
-				goto restore_config;
-			msleep(interval);
-		}
-	}
-
-restore_config:
-	status = i40e_write_phy_register_clause45(hw,
-						  I40E_PHY_COM_REG_PAGE,
-						  led_addr, phy_addr, led_ctl);
-
-phy_blinking_end:
-	return status;
-}
-
 /**
  * i40e_led_get_reg - read LED register
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 29f6a903a30c..c0a4bd53501c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -72,8 +72,6 @@ int i40e_led_set_phy(struct i40e_hw *hw, bool on,
 		     u16 led_addr, u32 mode);
 int i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
 		     u16 *val);
-int i40e_blink_phy_link_led(struct i40e_hw *hw,
-			    u32 time, u32 interval);
 
 /* admin send queue commands */
 
@@ -446,8 +444,6 @@ int i40e_read_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
 int i40e_write_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
 			    u8 phy_addr, u16 value);
 u8 i40e_get_phy_address(struct i40e_hw *hw, u8 dev_num);
-int i40e_blink_phy_link_led(struct i40e_hw *hw,
-			    u32 time, u32 interval);
 int i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
 		      u16 buff_size, u32 track_id,
 		      u32 *error_offset, u32 *error_info,
-- 
2.47.1


