Return-Path: <netdev+bounces-154791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0759FFCDB
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BE416293E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A41B07AE;
	Thu,  2 Jan 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pI3yzMfo"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95E17DE2D;
	Thu,  2 Jan 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839463; cv=none; b=FabLz8sRsdwaWKG5f6xk7uMZSLNmenssXINKwo5Z2j5oDQRIeG+zizpOsiXNQsl+0mwHSzaXYeBXStHNqIAw/FuyHJba8gdGMdzla9Ovigbzl4LZL8dSLXI9cNF8jP4GCP0/HhIaE27+DZeYDS/SCk4brqLPM4OtW822vEsXd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839463; c=relaxed/simple;
	bh=2V+mkMkZMtrcK6RLl8VjKFvSR2ev3DFv/exct3JqjrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFjRxzfwj4zgqnt30cIqb9sE1lx7yZYN8JYRwmDRYl154s1XYUCkotvHigOKxfrWxMX8nNAsJVRtAJ2Hw4HzBqsbs8aoABnmM2dkze+Dt8wO9TE60fNQ9qyWUjQ8j5tJ1OX2VzgfzYtDJcN5bNfksXcbdZlWnSCUyG6zOv2N7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pI3yzMfo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=x615MsWYT5rVAxhQdHYSvyCEahENSJGHVCkwtBCOTXQ=; b=pI3yzMfoc3/Xy+X0
	pwVR84LxUrBZzincoftsfsOd1Q3GFgsRXOKxRp1djNOsUS+8mX8m52xuiBSzPwhkfqYk37XnhqSGm
	xs/lcqjVckGcpjOej8XQU994Y1/tlOA8Wy/0rK35M7zHE76f70LESr8qtgPZ6uhKB1g61BURp5YMW
	iOV/AQsweLIEt4XbslW3zhgtq0Tec57QK3LoyIzlZPQnGMjz5/P9fYSxZshYM3rrX/Os00pHRpkJH
	QGWk+BNbAqPb56n2rMmFOO2oD+wQKdg8dwVMBqhi/bA7HGuk6yRarpREMaYGPgV5W2PjXoYjVsOaN
	/TAgvkVKzRe+D6Pj+w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8Q-007tod-0s;
	Thu, 02 Jan 2025 17:37:26 +0000
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
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 9/9] i40e: Remove unused i40e_dcb_hw_get_num_tc
Date: Thu,  2 Jan 2025 17:37:17 +0000
Message-ID: <20250102173717.200359-10-linux@treblig.org>
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

The last useof i40e_dcb_hw_get_num_tc() was removed in 2022 by
commit fe20371578ef ("Revert "i40e: Fix reset bw limit when DCB enabled
with 1 TC"")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 13 -------------
 drivers/net/ethernet/intel/i40e/i40e_dcb.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 8db1eb0c1768..352e957443fd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1490,19 +1490,6 @@ void i40e_dcb_hw_set_num_tc(struct i40e_hw *hw, u8 num_tc)
 	wr32(hw, I40E_PRTDCB_GENC, reg);
 }
 
-/**
- * i40e_dcb_hw_get_num_tc
- * @hw: pointer to the hw struct
- *
- * Returns number of traffic classes configured in HW
- **/
-u8 i40e_dcb_hw_get_num_tc(struct i40e_hw *hw)
-{
-	u32 reg = rd32(hw, I40E_PRTDCB_GENC);
-
-	return FIELD_GET(I40E_PRTDCB_GENC_NUMTC_MASK, reg);
-}
-
 /**
  * i40e_dcb_hw_rx_ets_bw_config
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index d76497566e40..d5662c639c41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -253,7 +253,6 @@ void i40e_dcb_hw_rx_cmd_monitor_config(struct i40e_hw *hw,
 void i40e_dcb_hw_pfc_config(struct i40e_hw *hw,
 			    u8 pfc_en, u8 *prio_tc);
 void i40e_dcb_hw_set_num_tc(struct i40e_hw *hw, u8 num_tc);
-u8 i40e_dcb_hw_get_num_tc(struct i40e_hw *hw);
 void i40e_dcb_hw_rx_ets_bw_config(struct i40e_hw *hw, u8 *bw_share,
 				  u8 *mode, u8 *prio_type);
 void i40e_dcb_hw_rx_up2tc_config(struct i40e_hw *hw, u8 *prio_tc);
-- 
2.47.1


