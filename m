Return-Path: <netdev+bounces-215893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E2B30D0D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7961CE464B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECEC28C878;
	Fri, 22 Aug 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3JIG0HV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8B393DC5
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834826; cv=none; b=QeGxmQCWSyvlfMC9QWaw+R8UxRUPurYx59vt3/6Im3MTQDlb4f75454CLgRDmcFfBEZTFmtGOSEJxGlJQHI0EMjuKIGHuo24tH02OszBWTe0+2z78yRx6yvn9+eOsTyb9WjWs3rnHl1yopF8qwezoW2Q9QgXjUOP1SDKDp6scwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834826; c=relaxed/simple;
	bh=wbVjOsY5Z7wq4og65pAyGpbZsbKIX8V0zwAOY4sBADY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=paJgMpsmYjY0gXJHL7tRcBaCsWZJj5bJ62vnfiydcWR71IY+auweZR7rPRBJp4G1yTV4tktrU42pgFIkmo/6a80jZPWa1pk6UnOuoC+tHtGLECWBDH3LVVj/5w3/rOJC4b/M92wOpg+HF+1G6rsc+itIi8PLAOc/1UAfdOhnOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3JIG0HV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755834825; x=1787370825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wbVjOsY5Z7wq4og65pAyGpbZsbKIX8V0zwAOY4sBADY=;
  b=j3JIG0HVpk4gE+bM6eeG9/s7nI23zidnMDzIfo/AOKYv42GMMG7KxSBv
   vithpXh4eEQxGbnKjW0YD9s3aWl63q7dvpvFvv4ubk5XKdzp4fvty/aBq
   uzlacFtdxnDwNyVnTXegX5nUWgCtaznINoiBBYtmD9s7Qrmg6tRKnCyNK
   FAU1omSs3HcT7uiMtCSvlUFAc3QrcgIS6fP4n0TrtoUnofnVjP+nwye8d
   07y6Ro/PK7UlFH9AcZ5Mb5WuTohnfUKAg7MD1KQ/u/BbrBGGqBen+zmXo
   SbNCZp7+RXeYrSSBSQUwgi6WJJh2m7ABoc9ykzIBbaxR2WU/WWU5ksdWA
   Q==;
X-CSE-ConnectionGUID: /WS7qEEKQ0OF9KMkPj1gxQ==
X-CSE-MsgGUID: nXMpGebXRR2cp+yS6oRQLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69508584"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69508584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:53:41 -0700
X-CSE-ConnectionGUID: iIxUq8mwQEuXhg0dErotEg==
X-CSE-MsgGUID: XF27WU2PRxCP7AoMA8Es5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192253219"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2025 20:53:40 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com
Subject: [PATCH iwl-net 2/2] idpf: fix possible race in idpf_vport_stop()
Date: Thu, 21 Aug 2025 20:52:48 -0700
Message-Id: <20250822035248.22969-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20250822035248.22969-1-emil.s.tantilov@intel.com>
References: <20250822035248.22969-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Make sure to clear the IDPF_VPORT_UP bit on entry. The idpf_vport_stop()
function is void and once called, the vport teardown is guaranteed to
happen. Previously the bit was cleared at the end of the function, which
opened it up to possible races with all instances in the driver where
operations were conditional on this bit being set. For example, on rmmod
callbacks in the middle of idpf_vport_stop() end up attempting to remove
MAC address filter already removed by the function:
idpf 0000:83:00.0: Received invalid MAC filter payload (op 536) (len 0)

Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 89d30c395533..01ab42fa23f9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -888,7 +888,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
-	if (!test_bit(IDPF_VPORT_UP, np->state))
+	if (!test_and_clear_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	netif_carrier_off(vport->netdev);
@@ -911,7 +911,6 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	idpf_vport_intr_deinit(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
-	clear_bit(IDPF_VPORT_UP, np->state);
 }
 
 /**
-- 
2.37.3


