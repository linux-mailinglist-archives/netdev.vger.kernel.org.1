Return-Path: <netdev+bounces-38321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37EC7BA66D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E26A3B2097A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C6030D0F;
	Thu,  5 Oct 2023 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsxUgb7L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197230CE1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:34:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D594E2108
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523606; x=1728059606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtkjdjRsIBfQCWD+DcqTfjuYememdao/bPtdTFeFFZY=;
  b=KsxUgb7LWQlPp4S9QHF28FLwTSZrTf9NBYFuuMyZGWlX2sNPTsIVQ5oh
   pGCVdX8zJUEP24E7s6J3C5CQvyF5QpqiczFb+mN6X94LGTwX0+TjkuaKG
   Iha3rplqnNvWF881t97D1IXbMbxNpMEmEqZjQGjjYoMJhuS2ddeOFxG4O
   BwAcc7A4/hC2YExT8Jd3bPiSVxaYvQXdePxTLhLa8P8kaLwosmPcBZRmf
   RsiXwyKx9WOvJivVzfxWzluqbIdc9W+hSL+NfNqOXmqrwYH5jmTOo8Y3S
   w5RWphc/7vpdLcoq3sJLZxZEDlhrLj4sjXpFxfjkiOVIXUmad53Y2uZxv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152668"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607743"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607743"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 4/9] virtchnl: Add header dependencies
Date: Thu,  5 Oct 2023 09:28:45 -0700
Message-Id: <20231005162850.3218594-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
References: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ivan Vecera <ivecera@redhat.com>

The <linux/avf/virtchnl.h> uses BIT, struct_size and ETH_ALEN macros
but does not include appropriate header files that defines them.
Add these dependencies so this header file can be included anywhere.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index dd71d3009771..6b3acf15be5c 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -4,6 +4,10 @@
 #ifndef _VIRTCHNL_H_
 #define _VIRTCHNL_H_
 
+#include <linux/bitops.h>
+#include <linux/overflow.h>
+#include <uapi/linux/if_ether.h>
+
 /* Description:
  * This header file describes the Virtual Function (VF) - Physical Function
  * (PF) communication protocol used by the drivers for all devices starting
-- 
2.38.1


