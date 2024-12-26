Return-Path: <netdev+bounces-154306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535849FCBFC
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD3E1882E55
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229F126C0D;
	Thu, 26 Dec 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="SzKyHP6r"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D283CC1;
	Thu, 26 Dec 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231964; cv=none; b=SiQsdx1oeh2TuEV7sseosOHvC8FD9z9q/tCr/60El5qqPd9lfAs80zPMSMtJFXbgQ6hwu63eKhlYnh+BmKf/SG0uco0iliQ62JrYebmAo2jkvuCST3+P7Y9DTibPy0jLW5Fp20PY2R34/OkG08/tY5SNEINthH4qZ8gI1wtESho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231964; c=relaxed/simple;
	bh=cMpSLK+TqXGI5ylHvyziqrIhBXLV15jFcdexa8T6me8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsTWcnLIAQqdOhfk2j1ZJbmES3FNwnwldmWX0xdOfjIJdaNBaIjrlQuxOM8AVU4ARtl3ZasUYF3tLCszH9pexRGBPAEZbeJj0/rXyjiNXct+iNKs8NqGiSL/Qe5A2myjGrC3jUbFcyCtl4k9grTcxEkQCHnJruQRrxklvET13t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=SzKyHP6r; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=pdsFoyjvN7jwIB/z6Mz4XwBi+s2/8ncP7Z2rx9wjM1I=; b=SzKyHP6r9yFoZfQj
	GObburqqgBg5LtQqlBjJefLXBMgrh3rtBd0IWjZUFyljWso6JxyCPa897IOZoIexayjLo7arfhKyF
	zozh/jPxxNnES6GvMrJfR5WbHz8W8e8KfSaUNnYBtaJGcUtOzYdtgWvTPUyxcQlQP+ky1xkDX2UIe
	R6Qy9LTwvjf96k8k1ldkBs8ZlPd8DEZo4a7pynVUA0iNmVPGRfDN74yEo0dtyPuqG0s2V5g2OsV54
	b5dst4qS/St0WdU9GjJq/PrcBrrJkla+lgVZnRCAV817Q7W77/ZJl8kEKdo4czM5VpmieQXMxT4vQ
	nY4MdThk8Bhc1urWtA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQr5s-007IaP-37;
	Thu, 26 Dec 2024 16:52:17 +0000
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
Subject: [RFC net-next 1/3] igc: Remove unused igc_acquire/release_nvm
Date: Thu, 26 Dec 2024 16:52:13 +0000
Message-ID: <20241226165215.105092-2-linux@treblig.org>
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


