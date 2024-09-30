Return-Path: <netdev+bounces-130309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA598A09C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DDBB27AA0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8219CC2B;
	Mon, 30 Sep 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fI/8/wTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9B19ABA3;
	Mon, 30 Sep 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695321; cv=none; b=Ps8Fruo1eOmsnRVm8VL3ssz04y6CXbxvWy1H5mT5BfloMyywuosV4TYojYpvmSfbalSUBoqD2PQEjPUU45Le2edymkKK7+8Kzqb86eikQEIJddGBY6MxE3xmOVcBVH+bRJmXq6RHsSgB9lbG6SdhKfYPSuIqPYNBjKlZNUOnWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695321; c=relaxed/simple;
	bh=PmT9O/+7fwVt790lDpgSQowywQ0NFr1wjwDGR8wZGuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNSw4GZjN//espLkOl2P9K5LzfAy5jdb4SYJKAEKr8mAS8+1RzpTSXnj1jOh3cjqf9XqPYaKmHfoljBGn2IPDINuZetksRV1xgGVjtPZnHuuiRoILYvCgx3aMl3bdiXA5bC3KsF4/h33vZJBekSOb2mJGtTyV++WbF/emQSKPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fI/8/wTg; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RF4M5sp1M89dXG5TKYPlc4/p+FQQxzTT+AquUnods1A=;
  b=fI/8/wTgbpT6vBh1PM5rYudE7uS62YQ4nXCzxZ/NVCKH6UlVWUjRLhd/
   Bkublc0NZ60/cyxnlT9W0CSfRCb3cGxqKBP883vvCKW56EZWRXJBNPCW4
   zD4qjLQF8omsa0jpyKF6ldnQaUYgMaCkmO/y/uxSocAqLGd01dy0PVNoJ
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956915"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: kernel-janitors@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 33/35] drivers/net/ethernet/intel: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:19 +0200
Message-Id: <20240930112121.95324-34-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/intel/e1000/e1000_hw.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c   |    7 +++----
 drivers/net/ethernet/intel/ice/ice_common.c     |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index f9328f2e669f..1b7e78018b8f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3839,8 +3839,8 @@ static s32 e1000_spi_eeprom_ready(struct e1000_hw *hw)
  * e1000_read_eeprom - Reads a 16 bit word from the EEPROM.
  * @hw: Struct containing variables accessed by shared code
  * @offset: offset of  word in the EEPROM to read
- * @data: word read from the EEPROM
  * @words: number of words to read
+ * @data: word read from the EEPROM
  */
 s32 e1000_read_eeprom(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
 {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e8031f1a9b4f..f2d342ffc6d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1045,9 +1045,9 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
 /**
  * i40e_aq_get_phy_capabilities
  * @hw: pointer to the hw struct
- * @abilities: structure for PHY capabilities to be filled
  * @qualified_modules: report Qualified Modules
  * @report_init: report init capabilities (active are default)
+ * @abilities: structure for PHY capabilities to be filled
  * @cmd_details: pointer to command details structure or NULL
  *
  * Returns the various PHY abilities supported on the Port.
@@ -1948,7 +1948,6 @@ int i40e_aq_get_switch_config(struct i40e_hw *hw,
  * i40e_aq_set_switch_config
  * @hw: pointer to the hardware structure
  * @flags: bit flag values to set
- * @mode: cloud filter mode
  * @valid_flags: which bit flags to set
  * @mode: cloud filter mode
  * @cmd_details: pointer to command details structure or NULL
@@ -2534,9 +2533,9 @@ int i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
  * @hw: pointer to the hw struct
  * @sw_seid: Switch SEID (to which rule refers)
  * @rule_type: Rule Type (ingress/egress/VLAN)
- * @count: length of the list
  * @rule_id: Rule ID that is returned in the receive desc as part of
  *		add_mirrorrule.
+ * @count: length of the list
  * @mr_list: list of mirrored VLAN IDs to be removed
  * @cmd_details: pointer to command details structure or NULL
  * @rules_used: Number of rules used in internal switch
@@ -3444,8 +3443,8 @@ int i40e_aq_start_lldp(struct i40e_hw *hw, bool persist,
 /**
  * i40e_aq_set_dcb_parameters
  * @hw: pointer to the hw struct
- * @cmd_details: pointer to command details structure or NULL
  * @dcb_enable: True if DCB configuration needs to be applied
+ * @cmd_details: pointer to command details structure or NULL
  *
  **/
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 009716a12a26..8a61e13eca1d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5301,8 +5301,8 @@ ice_aq_get_output_pin_cfg(struct ice_hw *hw, u8 output_idx, u8 *flags,
  * @hw: pointer to the HW struct
  * @dpll_num: DPLL index
  * @ref_state: Reference clock state
- * @config: current DPLL config
  * @dpll_state: current DPLL state
+ * @config: current DPLL config
  * @phase_offset: Phase offset in ns
  * @eec_mode: EEC_mode
  *
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 3be1bfb16498..f6559b1d1433 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2635,9 +2635,9 @@ void ixgbe_release_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 /**
  * prot_autoc_read_generic - Hides MAC differences needed for AUTOC read
  * @hw: pointer to hardware structure
- * @reg_val: Value we read from AUTOC
  * @locked: bool to indicate whether the SW/FW lock should be taken.  Never
  *	    true in this the generic case.
+ * @reg_val: Value we read from AUTOC
  *
  * The default case requires no protection so just to the register read.
  **/


