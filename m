Return-Path: <netdev+bounces-154798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2499FFCED
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68E41880857
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC214BF8F;
	Thu,  2 Jan 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UGBNNMY5"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACB133987;
	Thu,  2 Jan 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839612; cv=none; b=Mx94YwMJjK2X3isnICkmilYUXvFmKiC7NipzmaRiw/78/FDTTSm4X0pvyp36rctrFBsnVi6KBwlNDbPiDneUN7qDWUXhWUItyHXg2UohvTY4dzT3JhKXaB93fr5m4ID5oLpIceESHZXMkJw3/NL+hZXYTqO1R5tHTgy4uCVFYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839612; c=relaxed/simple;
	bh=BJzrw74EndrPPXS4tjkut+DXSBdGyJ0cd+6p2kSCjHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CU901BYrKCDoyRgHP/3FonvxQxVpAiQn1+B8L2npIwk3hmMZthON0/L2SzD5mRG04ReZvTfxHXt1aMATVi3vKuquKqxNvpFs8EGK70Pbe61ULQkf9idhT5n+shMrwvRI/K8wAz23fkSgZxPm8GuXyKQKDMwS5vZh+RhIRCdmQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UGBNNMY5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kNbPgneaX7GZilz8mvKDzcGBDi52SBp2xJS4zJPPs40=; b=UGBNNMY5S2N65FfU
	VuLFvGVF9UjUbk9MztliPzB4Wtoij4RwOQpPAByMJPyFrKngzigb9sFVmL1M3oSb7s/CzhOxgoCzz
	BWMxHlK2W1xqbI2Bv2fz66oEXLLd3kGa1aRoVFP76Z6SVEw61ZNFAxMIiYxr4/w6FUdjWe2iup4jH
	fMMYaGTk13QstT/IW3gBbK0so0Wz5H/ZcwG6bRFq7GQ309UF+p/NqFyV5cQdRRwrmRGCl5Bgahb57
	7cPX27akYtIeDNb13grTcSOcLfwLiF/qWNNaKcuThdZHDreKQjTImoSRp8seWdCN5mT1HPZURmDUK
	dpEQbGrkwDt7PIQGzQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTPAx-007ty0-28;
	Thu, 02 Jan 2025 17:40:03 +0000
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
Subject: [PATCH net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Date: Thu,  2 Jan 2025 17:40:02 +0000
Message-ID: <20250102174002.200538-1-linux@treblig.org>
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
index 130cb868774c..a43cb500274e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -439,7 +439,6 @@ extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
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


