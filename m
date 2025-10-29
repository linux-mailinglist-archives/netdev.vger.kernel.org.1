Return-Path: <netdev+bounces-234189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E61C1DA91
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819F618999A9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B230F944;
	Wed, 29 Oct 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCd2Oi06"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A83002BD
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779633; cv=none; b=csK5y7uoWwCkGOu8jzXtrWIMIUI+Q5pJoar1DOunkPOb/hnW9k5g0o3AE8ao4ftaUJYAQ5rLlxTYhhR0prQqw4IWZPvp9QMOts1utk5ZJofeETyMkRxgBFmwSyI1UXoDUxNGB15r2Tfl85tSQMhpbcpNmojtbinyBhrNWfng2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779633; c=relaxed/simple;
	bh=OPZ6zWEiyglV1nEnm6UJD3TbmHqttkCraoCQVwng804=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o++uZxYuPSo8PZX7NgS6sUH6c1bIsFph6KMdVPq3sCwP0janWODmKF/h1fCy2asU5YDF+xSTGjrmfMlT6PS7d/VZS8j5Tyz239A77xu5yQLNaJ8T0jf/XhCuZ0bkuLuEuFpQnhYfNsOSU1cuYMm4pQneFD7C1eprkKJfwW4kvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCd2Oi06; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779632; x=1793315632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPZ6zWEiyglV1nEnm6UJD3TbmHqttkCraoCQVwng804=;
  b=cCd2Oi06iX7jwbLEgglFQksCmFklzw0/uEV3VSve0aJNY7HkA+VAj8mp
   ChXZv8IMxjQKI3us+tbAG0reZQca7Xnim2z5AcOe5+IPAv9vMZtVxw+t7
   JKyXsFYE62YZ9T7kF0/9fM9MW7s+jvRqx4XKbWSOJmqZS5yWbyRBj5gXa
   ZxsXI5TsLw9WL37itK9Mr0SddWfVMY93+rHIhOPS2WddwOXhmYC093DHO
   TkV3FxoWNI/Q+FvaXyEfX8PYGC0sZ4COCBS1+diBLTNg/9Gp9UH2jL23u
   XiLDD4GZ70CHa5bpPJUKaNIJTg9h8gyTHurNGaiq9QozM38PlNBT79A3y
   A==;
X-CSE-ConnectionGUID: 2MR23Z7BSlWmJW7Nru8XCw==
X-CSE-MsgGUID: j6NpO9b/Qy2LbvKV6trNCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817610"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817610"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:47 -0700
X-CSE-ConnectionGUID: BAqnoEjLSAeOgG3rjhHKBw==
X-CSE-MsgGUID: rebFWgdGTFe4z0y6YNZC6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729704"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 7/9] idpf: remove duplicate defines in IDPF_CAP_RSS
Date: Wed, 29 Oct 2025 16:12:14 -0700
Message-ID: <20251029231218.1277233-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

Remove duplicate defines from the OR operation when defining IDPF_CAP_RSS.

Duplicate definitions were introduced when IDPF_CAP_RSS was originally
defined and were left behind and went unnoticed during a previous commit
that renamed them. Review of the original out-of-tree code confirms these
duplicates were the result of a typing error.

Remove the duplicates to clean up the code and avoid potential confusion.
Also verify no other duplicate occurrences of these defines exist
elsewhere in the codebase.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ca4da0c89979..50fa7be0c00d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -734,13 +734,11 @@ static inline bool idpf_is_rdma_cap_ena(struct idpf_adapter *adapter)
 }
 
 #define IDPF_CAP_RSS (\
-	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_UDP		|\
 	VIRTCHNL2_FLOW_IPV4_SCTP	|\
 	VIRTCHNL2_FLOW_IPV4_OTHER	|\
 	VIRTCHNL2_FLOW_IPV6_TCP		|\
-	VIRTCHNL2_FLOW_IPV6_TCP		|\
 	VIRTCHNL2_FLOW_IPV6_UDP		|\
 	VIRTCHNL2_FLOW_IPV6_SCTP	|\
 	VIRTCHNL2_FLOW_IPV6_OTHER)
-- 
2.47.1


