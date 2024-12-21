Return-Path: <netdev+bounces-153938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E19FA1FA
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7DF188E308
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73419CC3A;
	Sat, 21 Dec 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sIEJCMOj"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F318801A;
	Sat, 21 Dec 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806588; cv=none; b=SOZyPmn6LzdC4qZpc1Kq7WhYt2drN2tVEoQ11siKRlJPJomaFV1gycznPEvnb516bjhUftIePkDYgDjF5p7D8K3B8qiMPBcoM2RcOvwub9Ma8UpmlhLsl9UlrmYxjDrfrhDhffh6KyGREBjhasYaHn7pT8tAVb7r8vjLrIAGRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806588; c=relaxed/simple;
	bh=z+Q5Y1kWZlIGR9qgrDBLazhhhORiuKi4ZZf+9r7/IFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRbbaDnUaABJpDmQqMMo6sSMzMeAoHXxxPTMEX75qPBOdNUZpPREhv3JxFuS4AcQ81Yuwe146f6m1If+OgIeGVnhOKxcERpzVdNc5op9LspprFzX+s+tgrgDxZaeFmQi/rfOsTDqCuRdXYZxricNRl5aprjQnI5w4A6hA/Tv7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sIEJCMOj; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=FHOyfnH3rlGUJjO2RlOCqMv+WOTqlvg/BjenCsxYWAs=; b=sIEJCMOj/ZmNzxgU
	8+7jpQNjG+gvEWPgOStarSSR7gJMeR9Yi265lR2nnGhF/T7xVPhbKaOByfWX/HMAECST4n47Hu1Sa
	iDbQ2hSNEXPf0PET3IKKAkonJ1xyJpbH9DhyjeWJURwwsD+bMUVruD7y8GvkUYVXMu5IW1UbmB6TS
	aSGutnkNEUTuIXH7KEdnS+AVaxrogI6Ivd7QN/fhSpE1HuFUlU886VsXa1EGZ2VzqvJgBSH7LXzwz
	eh3jealcuFZ5cvd+kdG1N4AphiPE/UtPwxHM7Wd0N+KcedyhFbPgVT3hlq/6v6ktcsYf1Xkbmm/Pa
	jvaVR+AKeg0yd8Xegw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4RC-006hEJ-2N;
	Sat, 21 Dec 2024 18:42:54 +0000
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
Subject: [RFC net-next 9/9] i40e: Remove unused i40e_dcb_hw_get_num_tc
Date: Sat, 21 Dec 2024 18:42:47 +0000
Message-ID: <20241221184247.118752-10-linux@treblig.org>
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

The last useof i40e_dcb_hw_get_num_tc() was removed in 2022 by
commit fe20371578ef ("Revert "i40e: Fix reset bw limit when DCB enabled
with 1 TC"")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
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


