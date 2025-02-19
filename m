Return-Path: <netdev+bounces-167557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D59A3AD5E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E128C3A6140
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA84C79;
	Wed, 19 Feb 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7phsBD+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF01DFE1
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926009; cv=none; b=n5oOQRSa6jTHj+aQbtYsEHrmotm54Cc4rMKBK4lkm+k0PWtjIPDRwcZGGVHq9USJR2Dbl3b4i2mDjF6JA/oTrNamiwyXxL/fNoN45YHK1BpNwAtB/pyggIV3iDFPk69SEwYvWj6Hk0RwojQAdW+O1I/5ezDSTYnzOL7pAYY/BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926009; c=relaxed/simple;
	bh=zGbubETGCRqeJQMQNzMgFlOJVkMyhq8dQ5UlQFeNLf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pZMV2rt1Qt8KBUDENWBLml+ke6YUcQanJ3YkMchPsy9TcroebK2A12DMQDYmAH9uNCZXMhZ2jjbTouZCVcUmPpPiT0/NSN63VdabyqePWx3rQX1LWrMelwomdtkFCSLGgljBSePHUyIp35b7orNMH+7Uu26C65Mz1t0OuxqVbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7phsBD+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739926008; x=1771462008;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=zGbubETGCRqeJQMQNzMgFlOJVkMyhq8dQ5UlQFeNLf0=;
  b=P7phsBD+O2c9BMsIhsCL2Pu3GOvPIQ7YW4qfrUBh/E9CncFf4BJe3uuN
   orUmCANjLrU+lb+WYfbX6Y6lIdDsFo8HhkyYzv61uVzvsCpPXahJRvCJ/
   nEANfVwQ2oeJJc3zZOrRXNUcuQhGyDWwYjmKmIRFzPY4pIMFZyGyAqSSS
   k5nm0Ji8WOb5MvVT/WfXajB9Af77/JrGXtz0nPU7DRe0z2Ms090Lg/2Xg
   CZbWnLEE5HHhl0BONckZU2mzJvWB9OJnxQaGC1whxrhsE4kvnhZu7OcU5
   qgWOmQN4KCZxitaMNhLUF7iEvEsDkETGG84rBkJvaSeA868viPww7wTD+
   w==;
X-CSE-ConnectionGUID: L5UsYLbYTUqURmf0Xzagxg==
X-CSE-MsgGUID: tWsn6NKfTtOXLv8eTIG6eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40903530"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40903530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 16:46:47 -0800
X-CSE-ConnectionGUID: 1SGFXMt3SI6YVH/GjwWtbg==
X-CSE-MsgGUID: lXALLm4tSw6WF4Uhetj+yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="115213758"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 16:46:47 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 18 Feb 2025 16:46:34 -0800
Subject: [PATCH iwl-net] ice: fix Get Tx Topology AQ command error on E830
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com>
X-B4-Tracking: v=1; b=H4sIAOkptWcC/x2MWw5AMBAAryL7bZOqiMdVxEfZLYuUtIJE3F3jc
 yaZeSCwFw7QJA94PiXI5iJkaQLDZNzIKBQZtNKF0lmF84Jc5QqJdlw3Q+JGtHJjzZZ6soMulYF
 Y756j/s8tyLWi4wO69/0Azh+q13IAAAA=
X-Change-ID: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Paul Greenwalt <paul.greenwalt@intel.com>

With E830 Get Tx Topology AQ command (opcode 0x0418) returns an error when
setting the AQ command read flag, and since the get command is a direct
command there is no need to set the read flag.

Fix this by only setting read flag on set command.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 03988be03729b76e96188864896527060c8c4d5b..49bd49ab3ccf36c990144894e887341459377a2d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
 			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
 					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
 
-		if (ice_is_e825c(hw))
-			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 	} else {
 		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
 		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
-	}
 
-	if (!ice_is_e825c(hw))
-		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		if (hw->mac_type != ICE_MAC_GENERIC_3K_E825 &&
+		    hw->mac_type != ICE_MAC_E830)
+			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+	}
 
 	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
 	if (status)

---
base-commit: f5da7c45188eea71394bf445655cae2df88a7788
change-id: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


