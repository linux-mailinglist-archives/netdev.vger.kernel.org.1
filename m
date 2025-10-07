Return-Path: <netdev+bounces-228091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944DBC140D
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385503BE1B5
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF91A9F8D;
	Tue,  7 Oct 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUz95jFY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CD849C;
	Tue,  7 Oct 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837611; cv=none; b=BAomrjW5oL8fRj6h0cCRXnSv2MxK+/QRDRtfRHJhU4ZGu6eWOR8V8vKCY3JcB40I2fwAfGqy+GQeaZaAgb8sIOFVyB0XEGoEB8vcZ4+0M+WqcNdkODZ0VWtPAp5NEH4Hvah2ZM4Rb4oKi0Ch79dp7/FlKCmKsAuSdeGmNotBMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837611; c=relaxed/simple;
	bh=8pLnvnpocOAdClJwUURQKyQYxaw0xZVCv1VjIpDfUng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LV6SjLfCVXsBsNIe1Cmjgfw5RMU37cx/BKnYUrFg/qPSVz+KzGcxC9aCmFEsg/Ll2WqdwICcBvlohQhCDJsREzM/Mg/aK2AfrF43NsGZeDf2cqUNk0t5EWvjnHiL4X7pdGOkCQ0V17TzDF1zp7+qUDCzi7iaKVcDvjaB+V1ECYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUz95jFY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759837611; x=1791373611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8pLnvnpocOAdClJwUURQKyQYxaw0xZVCv1VjIpDfUng=;
  b=SUz95jFY4nloJF7qx7SW3SISuBmUOA2UlkdnUcxozfN0d0RTXRX32pQe
   q3wPgLkDj0coZ4D7ZWyw4KNPTSxykeLoZLeIoD0TdkSCpkr+pXJrskwQS
   hPCt1bjNdMgft1ZWQbxLNNwnddlznPkVNYahdl7giO+6CGXdak1payzU+
   /oXyD0YK378kKqQQgldOKGoKnd9ROU6qLBzHmekqoorwagtOlrX/CEPoh
   2yJn2diIfaFR1ISRNomBZ2Y3QS/o5ipiYjrEeA8x2G3SC75O23ZEeD32k
   shMO+ZfjafCn7lgs0ZYtPb1LI+3dY7iVr/WKA01qoDVxeNdcRxej9o6kn
   g==;
X-CSE-ConnectionGUID: hkXd2OzlTpu4A73PSvAwng==
X-CSE-MsgGUID: O9fSXcEyS9eTqenF8fJfnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61051702"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61051702"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 04:46:50 -0700
X-CSE-ConnectionGUID: wHswlvNBTRmdap7II1wjmA==
X-CSE-MsgGUID: C22g09TOQGm85xoIVeYbtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180546026"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 07 Oct 2025 04:46:46 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 28F492879A;
	Tue,  7 Oct 2025 12:46:45 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Chittim Madhu <madhu.chittim@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] idpf: fix LAN memory regions command on some NVMs
Date: Tue,  7 Oct 2025 13:46:22 +0200
Message-ID: <20251007114624.9594-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPU SDK versions 1.9 through 2.0.5 require send buffer to contain a single
empty memory region. Set number of regions to 1 and use appropriate send
buffer size to satisfy this requirement.

Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fa3ce1e4f6ac..af8b3ebee4d4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1016,6 +1016,9 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 	struct idpf_vc_xn_params xn_params = {
 		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
 		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
+		.send_buf.iov_len =
+			sizeof(struct virtchnl2_get_lan_memory_regions) +
+			sizeof(struct virtchnl2_mem_region),
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
 	int num_regions, size;
@@ -1028,6 +1031,8 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 		return -ENOMEM;
 
 	xn_params.recv_buf.iov_base = rcvd_regions;
+	rcvd_regions->num_memory_regions = cpu_to_le16(1);
+	xn_params.send_buf.iov_base = rcvd_regions;
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
-- 
2.47.0


