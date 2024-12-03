Return-Path: <netdev+bounces-148699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848D9E2EE7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4988B2CD53
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B520CCC3;
	Tue,  3 Dec 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE14gN64"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3320C460
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262936; cv=none; b=bf5wAspvuZs0A0owyBc8Yw6O4Sd2QPUWmRFBE6twKfQnzLqaCIgLk+Xxvhv8qeWFrGj5li68oPfHwZVuSargZlEQ/MU0x6BtX8/wkqKhbbr7TO0XULvSnAEyvOMiCJJq3H0yoTnoZri5RtZGMpRa17BL41uDA6JXu527lWSygdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262936; c=relaxed/simple;
	bh=0W5qozaNSgmHSLoawvjWMy8/uDST6NkV9LAZd90ADUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXTKzu1I4YXLMGm+PyFVDW0ajANildGhlIb7+axbZO2Ctqh2uNbe0ofMNQBsO8EuO3M0AcBrFh6ihH56Wi9c3VoIDThYONZ2VpKlQDHnsdb+bq3XqYJFHMUxjsWVN1E4V07x7VnB1ILHy0OidbOpD2iftzj+/wS8AKdhU1nndIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE14gN64; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262935; x=1764798935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0W5qozaNSgmHSLoawvjWMy8/uDST6NkV9LAZd90ADUg=;
  b=nE14gN644NpmbtLexcv0UaZJNxPQymzU5cyGpFkEgzrRaDPchJzWXVxa
   sUO5DMsQgArNjY0iQHSFRuIz+XQ9tDbOfKxpmk5JVv/uBo35NqzoayXmO
   7CrBDO8AmF5Ccr6iMPlbJEmQhHvwiL/e28U6+6ulGD+qjvezMCkFDPpuN
   2+wiszL9ls4rBh/0VQUxV9+F6sgeDDVx9DJ5+hD6fuim960d+NHh2oQNA
   XEBzC9vervcQBePdR3QTPQtEOV7yFDVL6kv1v0E3FC8/lv5A4Z7lUS0yK
   yJqlQ9iNY6b7Br3cMHkqzwq6hTLmu2X6TtPm4JEkBAyYbAmywz628I0qc
   w==;
X-CSE-ConnectionGUID: BIcN0AIARMOTKbY3nVxYVA==
X-CSE-MsgGUID: oyIDR7fnSmOlWRj2k2Wp8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087151"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087151"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:30 -0800
X-CSE-ConnectionGUID: g4GhHTQWTmO2iaqqDVoTMw==
X-CSE-MsgGUID: MFFFVKzyTGSQzztiEbI/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578888"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:30 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Yifei Liu <yifei.l.liu@oracle.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 7/9] ixgbe: downgrade logging of unsupported VF API version to debug
Date: Tue,  3 Dec 2024 13:55:16 -0800
Message-ID: <20241203215521.1646668-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ixgbe PF driver logs an info message when a VF attempts to negotiate an
API version which it does not support:

  VF 0 requested invalid api version 6

The ixgbevf driver attempts to load with mailbox API v1.5, which is
required for best compatibility with other hosts such as the ESX VMWare PF.

The Linux PF only supports API v1.4, and does not currently have support
for the v1.5 API.

The logged message can confuse users, as the v1.5 API is valid, but just
happens to not currently be supported by the Linux PF.

Downgrade the info message to a debug message, and fix the language to
use 'unsupported' instead of 'invalid' to improve message clarity.

Long term, we should investigate whether the improvements in the v1.5 API
make sense for the Linux PF, and if so implement them properly. This may
require yet another API version to resolve issues with negotiating IPSEC
offload support.

Fixes: 339f28964147 ("ixgbevf: Add support for new mailbox communication between PF and VF")
Reported-by: Yifei Liu <yifei.l.liu@oracle.com>
Link: https://lore.kernel.org/intel-wired-lan/20240301235837.3741422-1-yifei.l.liu@oracle.com/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h | 2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 6493abf189de..6639069ad528 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -194,6 +194,8 @@ u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg);
 	dev_err(&adapter->pdev->dev, format, ## arg)
 #define e_dev_notice(format, arg...) \
 	dev_notice(&adapter->pdev->dev, format, ## arg)
+#define e_dbg(msglvl, format, arg...) \
+	netif_dbg(adapter, msglvl, adapter->netdev, format, ## arg)
 #define e_info(msglvl, format, arg...) \
 	netif_info(adapter, msglvl, adapter->netdev, format, ## arg)
 #define e_err(msglvl, format, arg...) \
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 9631559a5aea..ccdce80edd14 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1048,7 +1048,7 @@ static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,
 		break;
 	}
 
-	e_info(drv, "VF %d requested invalid api version %u\n", vf, api);
+	e_dbg(drv, "VF %d requested unsupported api version %u\n", vf, api);
 
 	return -1;
 }
-- 
2.42.0


