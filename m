Return-Path: <netdev+bounces-208227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB502B0AA67
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D046D1C489BB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF32E974C;
	Fri, 18 Jul 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMXHVGb3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950162E92AB
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864692; cv=none; b=Arote9VHQfC2QNMnfF1lt0jrM5ySlGtpSxD6O+iNzqVADOiH1tbde30jOzVacYxzSJzznPU5suTzKcoernp2urgwOUdMUYZj8PpIDKnXbyj658+Bj7vMtmDSMaRa+SQYxwLczSg50SX5r1XV9ho503xWnDofA85e8M0b7TRaPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864692; c=relaxed/simple;
	bh=Tu7SBkY4In4RAY4eyBvHFGljmhfw8osd2Y5k8s5p5Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9DMS9rhg6KrH5q+vY2KwLbR0+XCotsP/6PwQCsdroo6OfYYqZAKhgs5t6ebpXerO3h/LrqtekdvXRGDZkREcZpkhwmKkKOcic9oohlepAbwCJf+on0H3+znKHeaRURSkQgAo6p3odFb6644/AF8A+J6LPBiuzglwXJOFIM3gY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMXHVGb3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864690; x=1784400690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tu7SBkY4In4RAY4eyBvHFGljmhfw8osd2Y5k8s5p5Co=;
  b=WMXHVGb3P5dn+ua6wFWbzYlvovq18Qneb8iwTPWwI4KvnzOWi9sqtA0h
   ewklhlkv6J7UfUloATjd9FjuftCbbsjuXVllBIa1O4Wz5qzihr8ZZt6qd
   l7YtlKSQnnxujg6jiv62UbxV0vYlCkdOFZ9rf11WTsVtGVuyUUPPh3mCe
   lrRuqOWcj9cAaBy4hexS5C1ZJxJ2srylw8xU4uM570WGnWG7DPBPnqYgS
   6sLvj5Bwn3CVhWgh1PIDVCP5zmSWUbLwsR0L3YvT5GK0vQDIUQm2+Ffjn
   5Sw9m8fVW5pjtZDx7ZKgHEsVPxb/4luXZKa1ZX4URqmHQC5FmxK6Cmi+D
   A==;
X-CSE-ConnectionGUID: Q+t015UJSQOzCuYbGrk1fA==
X-CSE-MsgGUID: RU0bD4IeQASIX0INAr9C1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320593"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320593"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:24 -0700
X-CSE-ConnectionGUID: RpuCygosSVmLuSszIiGyhw==
X-CSE-MsgGUID: LoTosDSXQVqlDvJRqPNrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506897"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	paul.greenwalt@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 07/13] ice: add E835 device IDs
Date: Fri, 18 Jul 2025 11:51:08 -0700
Message-ID: <20250718185118.2042772-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

E835 is an enhanced version of the E830.
It continues to use the same set of commands, registers and interfaces
as other devices in the 800 Series.

Following device IDs are added:
- 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
- 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
- 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
- 0x1261: Intel(R) Ethernet Controller E835-C for backplane
- 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
- 0x1263: Intel(R) Ethernet Controller E835-C for SFP
- 0x1265: Intel(R) Ethernet Controller E835-L for backplane
- 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
- 0x1267: Intel(R) Ethernet Controller E835-L for SFP

Reviewed-by: Konrad Knitter <konrad.knitter@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  9 +++++++++
 drivers/net/ethernet/intel/ice/ice_devids.h | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c   |  9 +++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b4fe096ace08..b542e1e0f0c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -171,6 +171,15 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E830_XXV_QSFP:
 	case ICE_DEV_ID_E830C_SFP:
 	case ICE_DEV_ID_E830_XXV_SFP:
+	case ICE_DEV_ID_E835CC_BACKPLANE:
+	case ICE_DEV_ID_E835CC_QSFP56:
+	case ICE_DEV_ID_E835CC_SFP:
+	case ICE_DEV_ID_E835C_BACKPLANE:
+	case ICE_DEV_ID_E835C_QSFP:
+	case ICE_DEV_ID_E835C_SFP:
+	case ICE_DEV_ID_E835_L_BACKPLANE:
+	case ICE_DEV_ID_E835_L_QSFP:
+	case ICE_DEV_ID_E835_L_SFP:
 		hw->mac_type = ICE_MAC_E830;
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index 34fd604132f5..bd4e66df0372 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -6,6 +6,24 @@
 
 /* Device IDs */
 #define ICE_DEV_ID_E822_SI_DFLT         0x1888
+/* Intel(R) Ethernet Controller E835-CC for backplane */
+#define ICE_DEV_ID_E835CC_BACKPLANE	0x1248
+/* Intel(R) Ethernet Controller E835-CC for QSFP */
+#define ICE_DEV_ID_E835CC_QSFP56	0x1249
+/* Intel(R) Ethernet Controller E835-CC for SFP */
+#define ICE_DEV_ID_E835CC_SFP		0x124A
+/* Intel(R) Ethernet Controller E835-C for backplane */
+#define ICE_DEV_ID_E835C_BACKPLANE	0x1261
+/* Intel(R) Ethernet Controller E835-C for QSFP */
+#define ICE_DEV_ID_E835C_QSFP		0x1262
+/* Intel(R) Ethernet Controller E835-C for SFP */
+#define ICE_DEV_ID_E835C_SFP		0x1263
+/* Intel(R) Ethernet Controller E835-L for backplane */
+#define ICE_DEV_ID_E835_L_BACKPLANE	0x1265
+/* Intel(R) Ethernet Controller E835-L for QSFP */
+#define ICE_DEV_ID_E835_L_QSFP		0x1266
+/* Intel(R) Ethernet Controller E835-L for SFP */
+#define ICE_DEV_ID_E835_L_SFP		0x1267
 /* Intel(R) Ethernet Connection E823-L for backplane */
 #define ICE_DEV_ID_E823L_BACKPLANE	0x124C
 /* Intel(R) Ethernet Connection E823-L for SFP */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index af68869693ed..204e906af591 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5897,6 +5897,15 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_QSFP), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_SFP), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_QSFP56), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_SFP), },
 	/* required last entry */
 	{}
 };
-- 
2.47.1


