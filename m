Return-Path: <netdev+bounces-178699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96130A78541
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CDA3AB403
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C221B9C1;
	Tue,  1 Apr 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLP0JpKv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB124213E7B
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550569; cv=none; b=CC6h/3VDwMN5NESm2arTgLlFvxzc6nf29bIjp68Oz+QgjkKpUQXGsd/lcWHuDHK07TtzNdNyAhHSTgzg6P0qcJSatkzdFXPs/1AlQPXz8ktDqfBMWHIf2xl1N+zWktudzWfG5YlZG9NIerKKnpVWTcc9cJVUlKr6qamGPAnSE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550569; c=relaxed/simple;
	bh=v60S6CK068CXw5LqEBg3g5eGz5n2mMx+UTlpFbENs0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azIAtD3Mf+tvkQZI+VEaoMoteFWw4helz61iTVH2Pov9f4t9DaRdZMsyV5lHxE6E+CBMhMEplIz3PLlSulD9zwNah3A+tajgyr7DB9IY4MAd7jNmNVDsLAGom0akNEMcH9Gfgez7K7kRULJm9Zcyg9TTOTY2kNpi8GCTJrdAYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLP0JpKv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550568; x=1775086568;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v60S6CK068CXw5LqEBg3g5eGz5n2mMx+UTlpFbENs0g=;
  b=HLP0JpKvs4pAf4ZQz+ThV7f02LdDZoT1MvC2cWWvSgB34x/n1sQx9ygv
   OGBjb3w9N606kGRN+CLwmYfpXOIbzXgr+JDLwTi6+P3MD5iHGfP8jT79u
   2yZ/knKoN4Q4EMQit6p6GUF1R1WPxfQT7I7VkYDWi4efHGqLjWuQm9h+J
   yWJyBevLdvBIcdu/S1Y3PuvbZbvyveEfJQo9klJzCkCkmNUHc0/CL9CLo
   MNTQLcKgvVnd//HqzTMbHxr1HYwWSiCq30CfbdmDF6g65iQdkQzYd8+jf
   1Ousp8qc0xq12WHSuztr9qjuSdvyk01elOkCLXMwe07IBIcnCz/eLoW8f
   g==;
X-CSE-ConnectionGUID: 70D7LIhkTTmpA4Y5p1JRlQ==
X-CSE-MsgGUID: fvuJregaR8mT9DHydwJ8Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55527599"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55527599"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
X-CSE-ConnectionGUID: 4NMSO+7wQGOQXU4NTo+J0Q==
X-CSE-MsgGUID: D3mvMJEISPiz14zAb88Hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127354847"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 01 Apr 2025 16:35:30 -0700
Subject: [PATCH iwl-net v4 2/6] igc: increase wait time before retrying PTM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-jk-igc-ptm-fixes-v4-v4-2-c0efb82bbf85@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, vinicius.gomes@intel.com, 
 rodrigo.cadore@l-acoustics.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Christopher S M Hall <christopher.s.hall@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Mor Bar-Gabay <morx.bar.gabay@intel.com>, 
 Avigail Dahan <avigailx.dahan@intel.com>, 
 Corinna Vinschen <vinschen@redhat.com>
X-Mailer: b4 0.14.2

From: Christopher S M Hall <christopher.s.hall@intel.com>

The i225/i226 hardware retries if it receives an inappropriate response
from the upstream device. If the device retries too quickly, the root
port does not respond.

The wait between attempts was reduced from 10us to 1us in commit
6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 1 us"), which
said:

  With the 10us interval, we were seeing PTM transactions take around
  12us. Hardware team suggested this interval could be lowered to 1us
  which was confirmed with PCIe sniffer. With the 1us interval, PTM
  dialogs took around 2us.

While a 1us short cycle time was thought to be theoretically sufficient, it
turns out in practice it is not quite long enough. It is unclear if the
problem is in the root port or an issue in i225/i226.

Increase the wait from 1us to 4us. Increasing to 2us appeared to work in
practice on the setups we have available. A value of 4us was chosen due to
the limited hardware available for testing, with a goal of ensuring we wait
long enough without overly penalizing the response time when unnecessary.

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Fixes: 6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 1 us")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 2ff292f5f63be29e42dc4491a56602d811cf22cc..d19325b0e6e0ba684abbe10482fecce92e405420 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -574,7 +574,10 @@
 #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
 #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
 
-#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */
+/* A short cycle time of 1us theoretically should work, but appears to be too
+ * short in practice.
+ */
+#define IGC_PTM_SHORT_CYC_DEFAULT	4   /* Default short cycle interval */
 #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
 #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */
 

-- 
2.48.1.397.gec9d649cc640


