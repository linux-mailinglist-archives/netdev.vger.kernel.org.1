Return-Path: <netdev+bounces-154800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1629FFCF7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103923A322B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A68187FFA;
	Thu,  2 Jan 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Fy17UfgB"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3415C14B;
	Thu,  2 Jan 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839713; cv=none; b=qh79fWmoOg9s9Z8NaRVYetMpo3LX/zeFFxG2tMJyYPTlA9XiixO9Mk4I49DdSRb0jiO0fSxHmAPyzDDkQiozS/PN0bnJ6GxnLNMBMs0pAnHT8Wnq2WF+OIZ0jfXRYTAwlakzU2mb60dS1twki+Pa34hfQXmjyAgYLPT0cw4DJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839713; c=relaxed/simple;
	bh=cMpSLK+TqXGI5ylHvyziqrIhBXLV15jFcdexa8T6me8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHWk36NsTd7U6ACG86I216c+tNNjkq6PZnvgCIA3JfZpsplaPKt/jkQnE9fJZqbHUKXekN+SxbuQ/MK7NTNl2DSsSTszdGNeUMxj9o2fsKoTay7S6SBtWJQnzfs34BxW0Ess4KWHcbD1bXlhiFvjImRArSOdONSvDiBX8dF2tLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Fy17UfgB; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=pdsFoyjvN7jwIB/z6Mz4XwBi+s2/8ncP7Z2rx9wjM1I=; b=Fy17UfgB2f5cLMdE
	QAsTOsZisuOKWyuQTl+YHMRaNPRm8iTWZV3hG8barSz9f88X5Wj9k+ahMUoRVx6qHYSsfw/5kqawv
	55yxP0MXZyagQ59tmId2EWLVD/5vPY6eT+BPmFWHp9atF6n6J59HjZLjdNuxyYGxUqqZ+WkFRzsbl
	rCZUGSQaHsWd184QOcWlFijeNCBxDZy/VzcBJMTZoD/n1GEsfmSb54ktS/hoDiXKwbMhugYOtjeyv
	oAXBKLmT38HNxMh/LxTfb5MXpQitzroCE7ETOuNWt3wCzpatwnacDBiulDfQXBWF80yGkPPTNUjw5
	sQikMH8RrttxvgBYqQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTPCa-007u04-1T;
	Thu, 02 Jan 2025 17:41:44 +0000
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
Subject: [PATCH net-next 1/3] igc: Remove unused igc_acquire/release_nvm
Date: Thu,  2 Jan 2025 17:41:40 +0000
Message-ID: <20250102174142.200700-2-linux@treblig.org>
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

igc_acquire_nvm() and igc_release_nvm() were added in 2018 as part of
commit ab4056126813 ("igc: Add NVM support")

but never used.

Remove them.

The igc_1225.c has it's own specific implementations.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/igc/igc_nvm.c | 50 ------------------------
 drivers/net/ethernet/intel/igc/igc_nvm.h |  2 -
 2 files changed, 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index 58f81aba0144..efd121c03967 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -35,56 +35,6 @@ static s32 igc_poll_eerd_eewr_done(struct igc_hw *hw, int ee_reg)
 	return ret_val;
 }
 
-/**
- * igc_acquire_nvm - Generic request for access to EEPROM
- * @hw: pointer to the HW structure
- *
- * Set the EEPROM access request bit and wait for EEPROM access grant bit.
- * Return successful if access grant bit set, else clear the request for
- * EEPROM access and return -IGC_ERR_NVM (-1).
- */
-s32 igc_acquire_nvm(struct igc_hw *hw)
-{
-	s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
-	u32 eecd = rd32(IGC_EECD);
-	s32 ret_val = 0;
-
-	wr32(IGC_EECD, eecd | IGC_EECD_REQ);
-	eecd = rd32(IGC_EECD);
-
-	while (timeout) {
-		if (eecd & IGC_EECD_GNT)
-			break;
-		udelay(5);
-		eecd = rd32(IGC_EECD);
-		timeout--;
-	}
-
-	if (!timeout) {
-		eecd &= ~IGC_EECD_REQ;
-		wr32(IGC_EECD, eecd);
-		hw_dbg("Could not acquire NVM grant\n");
-		ret_val = -IGC_ERR_NVM;
-	}
-
-	return ret_val;
-}
-
-/**
- * igc_release_nvm - Release exclusive access to EEPROM
- * @hw: pointer to the HW structure
- *
- * Stop any current commands to the EEPROM and clear the EEPROM request bit.
- */
-void igc_release_nvm(struct igc_hw *hw)
-{
-	u32 eecd;
-
-	eecd = rd32(IGC_EECD);
-	eecd &= ~IGC_EECD_REQ;
-	wr32(IGC_EECD, eecd);
-}
-
 /**
  * igc_read_nvm_eerd - Reads EEPROM using EERD register
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.h b/drivers/net/ethernet/intel/igc/igc_nvm.h
index f9fc2e9cfb03..ab78d0c64547 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.h
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.h
@@ -4,8 +4,6 @@
 #ifndef _IGC_NVM_H_
 #define _IGC_NVM_H_
 
-s32 igc_acquire_nvm(struct igc_hw *hw);
-void igc_release_nvm(struct igc_hw *hw);
 s32 igc_read_mac_addr(struct igc_hw *hw);
 s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
 s32 igc_validate_nvm_checksum(struct igc_hw *hw);
-- 
2.47.1


