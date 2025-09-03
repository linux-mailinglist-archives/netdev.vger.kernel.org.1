Return-Path: <netdev+bounces-219695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D7B42AD4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A06E1C23161
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106EF36933D;
	Wed,  3 Sep 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVpCJhoz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E42EC08F
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931146; cv=none; b=qnWnAzaHw6xhBElkFm0AzxgyEwdr1WXe5nGzenP3pHSUxwe0ST3z4CPZMbz3OAGY23YxHWknUfpESfhFJP9IEt1IGJ8Ibs9aiHx+OKW+3d4Kk5INVIwRrHQMdIwXQ1eoMf/p30u8BMFMhtsVUa26BLBV8rYllSJm7R6R82liyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931146; c=relaxed/simple;
	bh=rhW/oLG9kyPX7VUpQdOWv4tesMIRsEXryuItSy/rrJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSe6U72wnAZ5qAYyivm1xreJ7PbqM06Z3C++nxXtlmLFKdJl45wC8rsj78SWgZnGNOrGfKb4QbEtI06NTHtSD7k/V/WpXzy/W5LPFcptzbwk5C0xD7f3xV33oVak4M1VsawHA9JPdtM4XUZ37mkQEC3cxXVuPdXce6K+qrdyIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVpCJhoz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931144; x=1788467144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhW/oLG9kyPX7VUpQdOWv4tesMIRsEXryuItSy/rrJw=;
  b=UVpCJhozZ4QQlgTzPIRNJxq2WMs2gZ5FW8e9X4L0vJqGT8AsxQMlR56C
   k5SN55iQtQ6+uZCtz0le7LTF7aohsT0gmUxhQ5ltegGPAhelOF3XO9+6Q
   AMTbQ+07yOPgJzSiO8ppYWfZzkgmid6E0KBFz/IAlRqQX5XCTfg3YFrzO
   ItTnYtwcKR6TxDKCe7Fab7Y2SzShOUZt8fd5HtUTHYWYwzGSYSy8JcGt5
   Hj6p7bShHT71HxMrJf3Ri/wyghhmiwiCEOshPIGNwO0ICTMS7H1baavwI
   dAFkOrNoaKq1OEXoSPrki5gN4zIvTGIMVFjKFIIgT1FxLUl8uS6SR9Nxx
   g==;
X-CSE-ConnectionGUID: 8IztR9DyQNGAeLCZcc1fBA==
X-CSE-MsgGUID: qQZGfQz5RD69uaLvO/uoQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173038"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173038"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: FKco+/v9SDO1JahI70NSjg==
X-CSE-MsgGUID: 4+UJVIrOThW4ggn/p2qZwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823455"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacek Kowalski <jacek@jacekk.info>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 5/9] e1000: drop unnecessary constant casts to u16
Date: Wed,  3 Sep 2025 13:25:31 -0700
Message-ID: <20250903202536.3696620-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Kowalski <jacek@jacekk.info>

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Additionally replace E1000_MNG_VLAN_NONE with resulting value
rather than casting -1 to u16.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000.h         | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 3 +--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 75f3fd1d8d6e..ea6ccf4b728b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -116,7 +116,7 @@ struct e1000_adapter;
 #define E1000_MASTER_SLAVE	e1000_ms_hw_default
 #endif
 
-#define E1000_MNG_VLAN_NONE	(-1)
+#define E1000_MNG_VLAN_NONE	0xFFFF
 
 /* wrapper around a pointer to a socket buffer,
  * so a DMA handle can be stored along with the buffer
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index d06d29c6c037..726365c567ef 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -806,7 +806,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)EEPROM_SUM) && !(*data))
+	if (checksum != EEPROM_SUM && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index f9328f2e669f..0e5de52b1067 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3970,7 +3970,7 @@ s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 
 #endif
-	if (checksum == (u16)EEPROM_SUM)
+	if (checksum == EEPROM_SUM)
 		return E1000_SUCCESS;
 	else {
 		e_dbg("EEPROM Checksum Invalid\n");
@@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
 		}
 		checksum += eeprom_data;
 	}
-	checksum = (u16)EEPROM_SUM - checksum;
+	checksum = EEPROM_SUM - checksum;
 	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
 		e_dbg("EEPROM Write Error\n");
 		return -E1000_ERR_EEPROM;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d8595e84326d..292389aceb2d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -313,8 +313,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
 		} else {
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
 		}
-		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
-		    (vid != old_vid) &&
+		if (old_vid != E1000_MNG_VLAN_NONE && vid != old_vid &&
 		    !test_bit(old_vid, adapter->active_vlans))
 			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),
 					       old_vid);
-- 
2.47.1


