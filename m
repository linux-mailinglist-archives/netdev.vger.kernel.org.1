Return-Path: <netdev+bounces-155269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C39A0195F
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 13:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44554162713
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013E148310;
	Sun,  5 Jan 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="V7KHXts3"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D913C67E;
	Sun,  5 Jan 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736080144; cv=none; b=PBgtMx6UFKfS31nZwr6KEKtkbPX7Frf/sHZmGQU3QPDdCA3UMrdxwBGgTtuMjKBbTu3CbovQCCr/09mYuTDvfAcqEoKaZcWGbPDXKMJTm6vCFBTnVrnDFV8fzOQ7hLqaHDGcbXEDrKiUR+7G5guOu32pSMCMrnT6olkFJUWz2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736080144; c=relaxed/simple;
	bh=+aCilyzQBYQU+nI1w+foCW+lZCbodq8YAcIfHx5aa1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2Veh3VTN6QukhRAgNBK6r1U2oNerdTn9HDVgb+v4v8yQ8wP/GGZpgiFVf7w8cTeahWjCMQYF9vivHECOAFLEKlgNliUTtUMNDhrnrbUttshTiNRmBW3Xc4kOcSmdvoFQ7VkUFxu389aK8vbyC2ajKBsKUEn9MdYkMJ5lXgAs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=V7KHXts3; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kcui1YFlovpQ1x2BkMAS53C/vo7CjqHBMemv//uHBFU=; b=V7KHXts378VGKH0M
	RnBxCEbkOPio4oWuMoJXxDstN4/j8JFvzJxRuZ6bEH7y5WoyfINhTnYA/vVhrkDEaBhvhCJE32DI0
	+oTAe3VQ0Dg8GxQ0R8W8aORZ6LIqwghm3s1pRZDMhjtsuyYwdzMWvZFgbcwS/8Vs0F1EPjVB1ERRh
	1J1CovdvR6N8Trwt9vkO550F9nV2Wi2xEV974fwPeuX5bnIDyv/tZlDMjBsPX3i6momp42Cj/HcpA
	U2x4xBGK6IfYESkrQhEMeKpdZJUtL+LyHEzOwyR0eEy6JsRnEgYS11QUTADZd1S0KwtSHGOGEjQyF
	zxIxinPqaptGz5VzJQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tUPkO-008DTD-1h;
	Sun, 05 Jan 2025 12:28:48 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Date: Sun,  5 Jan 2025 12:28:47 +0000
Message-ID: <20250105122847.27341-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")

but has remained unused.

The functions it references are still referenced elsewhere.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |  1 -
 drivers/net/ethernet/intel/ixgbevf/mbx.c     | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 9b37f354d78c..4384e892f967 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -443,7 +443,6 @@ extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
-extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
 extern const char ixgbevf_driver_name[];
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.c b/drivers/net/ethernet/intel/ixgbevf/mbx.c
index a55dd978f7ca..24d0237e7a99 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.c
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.c
@@ -505,15 +505,3 @@ const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy = {
 	.check_for_ack	= ixgbevf_check_for_ack_vf,
 	.check_for_rst	= ixgbevf_check_for_rst_vf,
 };
-
-/* Mailbox operations when running on Hyper-V.
- * On Hyper-V, PF/VF communication is not through the
- * hardware mailbox; this communication is through
- * a software mediated path.
- * Most mail box operations are noop while running on
- * Hyper-V.
- */
-const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops = {
-	.init_params	= ixgbevf_init_mbx_params_vf,
-	.check_for_rst	= ixgbevf_check_for_rst_vf,
-};
-- 
2.47.1


