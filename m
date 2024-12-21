Return-Path: <netdev+bounces-153939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A29FA1FB
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21E61886EF5
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878D19DF47;
	Sat, 21 Dec 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="c25Ih/ut"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31288188591;
	Sat, 21 Dec 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806588; cv=none; b=hedvcVldVMeUmPFWJw+mMycsJZjF2/W60yshoDioCbkE1n9DIcUZiQ5bGPfizxl0uMHbFANVRiUcXgf6HFpVMxtsi40PcPsEz0rNUrax3OJkQXka1sofTbn9N2HEPsZLx1ZWeSEZGTmSxp77mUw6+yEtzJhBLO4pjpdoSnF/LmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806588; c=relaxed/simple;
	bh=zNGBfQywrFoQ32YI5ifjS9JTkIyLGzeczUkR7HkHCAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShRkebxHny3MgP8axDuVzfLN9ihGK9g/4kSd1232htdUC6xbIJ7tj4wGvnZrAyymUFkMJBzSF6wpdMm1CHP7DFpaRb7PwFPDIIRQrK47DBTYqO/mck7vDt9oXzwvmnHSnr7QzImqimZ4h3l/e+bBjT3rPFOBC9Mvyown7bbk+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=c25Ih/ut; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ESstb2gN9zjOHFqyaaQuZOnSt7MEsAnOTlexp0z34JA=; b=c25Ih/utsWRi3DWA
	147FFrR5nBXdXpNodZvrzGOgfr3B7ytR0K2xWnQITyw1uin31c8G1YA0yd8A0Tv9EtPmQ0VFg/MQx
	eo02FIb1NZLm9N2MNGeJgOSljpYORnypArSAwmx/M6LcGHhgylXizMJX4WeAdvuo4kSqAHMUjZHz5
	Ms6dN5DqI6wpQAk/7iNFIlyiwiSyExZ2rB/Y+4SBQqCpGCXSomV4UXQl5Gt3GmpOEYOQTF/LsH8pA
	rqsPkMtyK3R66GKHJTKDqPNDbMww/VWjm+MQ0PmKjrDRcwjuvtNhmraVtlsqAfUxEEmTXETnNezm3
	cajLspVR3Dn/XLn2kA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4RA-006hEJ-28;
	Sat, 21 Dec 2024 18:42:52 +0000
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
Subject: [RFC net-next 7/9] i40e: Remove unused i40e_commit_partition_bw_setting
Date: Sat, 21 Dec 2024 18:42:45 +0000
Message-ID: <20241221184247.118752-8-linux@treblig.org>
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

i40e_commit_partition_bw_setting() was added in 2017 by
commit 4fc8c6763957 ("i40e: genericize the partition bandwidth control")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c | 83 ---------------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 399a5dbf3506..ce63a7cfe955 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1311,7 +1311,6 @@ int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
 int i40e_get_partition_bw_setting(struct i40e_pf *pf);
 int i40e_set_partition_bw_setting(struct i40e_pf *pf);
-int i40e_commit_partition_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
 
 void i40e_set_fec_in_flags(u8 fec_cfg, unsigned long *flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 276dde0bc1d4..8a333d0e2218 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12576,89 +12576,6 @@ int i40e_set_partition_bw_setting(struct i40e_pf *pf)
 	return status;
 }
 
-/**
- * i40e_commit_partition_bw_setting - Commit BW settings for this PF partition
- * @pf: board private structure
- **/
-int i40e_commit_partition_bw_setting(struct i40e_pf *pf)
-{
-	/* Commit temporary BW setting to permanent NVM image */
-	enum i40e_admin_queue_err last_aq_status;
-	u16 nvm_word;
-	int ret;
-
-	if (pf->hw.partition_id != 1) {
-		dev_info(&pf->pdev->dev,
-			 "Commit BW only works on partition 1! This is partition %d",
-			 pf->hw.partition_id);
-		ret = -EOPNOTSUPP;
-		goto bw_commit_out;
-	}
-
-	/* Acquire NVM for read access */
-	ret = i40e_acquire_nvm(&pf->hw, I40E_RESOURCE_READ);
-	last_aq_status = pf->hw.aq.asq_last_status;
-	if (ret) {
-		dev_info(&pf->pdev->dev,
-			 "Cannot acquire NVM for read access, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, last_aq_status));
-		goto bw_commit_out;
-	}
-
-	/* Read word 0x10 of NVM - SW compatibility word 1 */
-	ret = i40e_aq_read_nvm(&pf->hw,
-			       I40E_SR_NVM_CONTROL_WORD,
-			       0x10, sizeof(nvm_word), &nvm_word,
-			       false, NULL);
-	/* Save off last admin queue command status before releasing
-	 * the NVM
-	 */
-	last_aq_status = pf->hw.aq.asq_last_status;
-	i40e_release_nvm(&pf->hw);
-	if (ret) {
-		dev_info(&pf->pdev->dev, "NVM read error, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, last_aq_status));
-		goto bw_commit_out;
-	}
-
-	/* Wait a bit for NVM release to complete */
-	msleep(50);
-
-	/* Acquire NVM for write access */
-	ret = i40e_acquire_nvm(&pf->hw, I40E_RESOURCE_WRITE);
-	last_aq_status = pf->hw.aq.asq_last_status;
-	if (ret) {
-		dev_info(&pf->pdev->dev,
-			 "Cannot acquire NVM for write access, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, last_aq_status));
-		goto bw_commit_out;
-	}
-	/* Write it back out unchanged to initiate update NVM,
-	 * which will force a write of the shadow (alt) RAM to
-	 * the NVM - thus storing the bandwidth values permanently.
-	 */
-	ret = i40e_aq_update_nvm(&pf->hw,
-				 I40E_SR_NVM_CONTROL_WORD,
-				 0x10, sizeof(nvm_word),
-				 &nvm_word, true, 0, NULL);
-	/* Save off last admin queue command status before releasing
-	 * the NVM
-	 */
-	last_aq_status = pf->hw.aq.asq_last_status;
-	i40e_release_nvm(&pf->hw);
-	if (ret)
-		dev_info(&pf->pdev->dev,
-			 "BW settings NOT SAVED, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, last_aq_status));
-bw_commit_out:
-
-	return ret;
-}
-
 /**
  * i40e_is_total_port_shutdown_enabled - read NVM and return value
  * if total port shutdown feature is enabled for this PF
-- 
2.47.1


