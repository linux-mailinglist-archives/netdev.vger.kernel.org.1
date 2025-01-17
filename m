Return-Path: <netdev+bounces-159348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5219A15326
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109E53A1CA9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CC194A75;
	Fri, 17 Jan 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIoBaieD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7533062
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128989; cv=none; b=UIpd/WT5v90HP+Vjw4q6BP2K8bbnxjk+G1kTOLLbZi5inbGCJ5nSC10muoR84aleqICYRYLeeg/1zvLyLW1lpmQkZxtREnVXcZc+cOnIBmEqgUfeWUSL/mwzt+gTxs47FfAVB5HI6eV8lRiAfBsAvWzRgl3I0zQiSXmDXdjLnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128989; c=relaxed/simple;
	bh=u9mqR5GFsnLVc3LLaI0YgiNR9Lw9j+cHWpZrt16d0EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4fZSZzUXFPXGeaIR2w6eV8CJWfY6tZHVQAtasWZUQYGPcLzqlSAhapGHOl7oWZqRlcusJU6nQEn9YTnumbRWSt16ZifByfa+dXb+731yaeoKQbdShmRpXwbZI/EcaXQRP5p+SOa9S1MYBFh1bWieIVafUqAO+eJK25nc9TPDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIoBaieD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737128989; x=1768664989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u9mqR5GFsnLVc3LLaI0YgiNR9Lw9j+cHWpZrt16d0EQ=;
  b=PIoBaieDs32DnWRxrgYUz+m8PEnph0hWD/cevl2zT45RUVskc0ftISmG
   aXdpgQadbR7rOV+6hSsqmOFsjj+SGxklqNrXPPBsy5i4LfDylDZ3qjnJR
   1zVGhA9Hj13QOrTNaU4RTRz7x1YCK9uSHH/Uxqqw9ZJPvX5XvxpDLmehX
   WZUarBDK4vYQdY/XjboFUca/5Y7sIzqFml7hrBsT3Rq2i6JuAAeRJe0Xe
   lRAuQxRH3ne/JHbk4Zp9dqkyPwxd3XCDwPjOX0qBDvzatK3aXrAqhM1QG
   iUakTh5U0yoODIEHfpkEG27vjcWRoa5tBggBeLJpU+oXtPziDs9mhNubz
   w==;
X-CSE-ConnectionGUID: aDMPlLk1QtycBQUXzCn6Mw==
X-CSE-MsgGUID: mROQFUKgQJe0tveSVwe1AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48055140"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48055140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:49:48 -0800
X-CSE-ConnectionGUID: 6vsFm0MGSISAu6IVpNSOeg==
X-CSE-MsgGUID: BlOmfEYzQmyKPg/KmioWAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="106389208"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.2.76])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jan 2025 07:49:45 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	yuehaibing@huawei.com,
	maciej.fijalkowski@intel.com,
	przemyslaw.kitszel@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v2] ixgbe: Fix possible skb NULL pointer dereference
Date: Fri, 17 Jan 2025 16:49:35 +0100
Message-ID: <20250117154935.9444-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
encoding. Propagate this logic to the ixgbe_put_rx_buffer().

The commit also relaxed the skb NULL pointer check - caught by Smatch.
Restore this check.

Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20..c682c3d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2098,14 +2098,14 @@ static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
 
 static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 				struct ixgbe_rx_buffer *rx_buffer,
-				struct sk_buff *skb,
-				int rx_buffer_pgcnt)
+				struct sk_buff *skb, int rx_buffer_pgcnt,
+				int xdp_res)
 {
 	if (ixgbe_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && !xdp_res && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
@@ -2415,7 +2415,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			break;
 		}
 
-		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
+		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt,
+				    xdp_res);
 		cleaned_count++;
 
 		/* place incomplete frames back on ring for completion */
-- 
v1 -> v2
  Provide extra details in commit message for motivation of this patch.

2.43.0


