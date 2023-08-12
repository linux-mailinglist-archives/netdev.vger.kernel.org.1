Return-Path: <netdev+bounces-26980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2D5779BDB
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4655F281DCE
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9087E;
	Sat, 12 Aug 2023 00:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40034EA4
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 00:26:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE030FD;
	Fri, 11 Aug 2023 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691799963; x=1723335963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzMspkoRjZSTF98G6zs1qc9H9wNrpCApCbts9zpRdEU=;
  b=LFnExbIwMjNx+lZtX64GYogeqQ+iYCLo9aAtJ1C1sZ7tWM/kcSKwfJIR
   6oKvoAHnLO9VhHVfGaOoOhVfntwZ09C2tuO/+cfuRDbAboYOsE6qxYyuW
   CeIwY1MDgRYhNcDwqm1vYOEur0NEOYZ1rVjJfsWV8RII83RCdujlZRkKs
   cBpgVABgj9c0OHSnE87fKoennJ2HV+UuWj5SADHwSyKAD/5zORDUskRnO
   nUm9YfbXy+WMPEOID7qpmtpgkPD4bgOC3H2xGrtO6JZv/kg+TyiSGR5i0
   1vuaWDBAKxY3KTx2ePW+fpBO/DLBeVKvmWApegiKrf1nu0aN6rGEDIeDI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375500078"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375500078"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="979370609"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="979370609"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.80.24])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 17:26:01 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	emil.s.tantilov@intel.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	alan.brady@intel.com,
	madhu.chittim@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	decot@google.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH net-next 1/2] scripts: kernel-doc: parse DEFINE_DMA_UNMAP_[ADDR|LEN]
Date: Fri, 11 Aug 2023 17:25:48 -0700
Message-Id: <20230812002549.36286-2-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
References: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
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

At present, if the marcos DEFINE_DMA_UNMAP_ADDR() and
DEFINE_DMA_UNMAP_LEN() are used in the structures as shown
below, instead of parsing the parameter in the parenthesis,
kernel-doc parses 'DEFINE_DMA_UNMAP_ADDR(' and
'DEFINE_DMA_UNMAP_LEN(' which results in the following
warnings:

drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
parameter or member 'DEFINE_DMA_UNMAP_ADDR(dma' not described in
'idpf_tx_buf'
drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
parameter or member 'DEFINE_DMA_UNMAP_LEN(len' not described in
'idpf_tx_buf'

struct idpf_tx_buf {
	DEFINE_DMA_UNMAP_ADDR(dma);
	DEFINE_DMA_UNMAP_LEN(len);
};

Fix the warnings by parsing DEFINE_DMA_UNMAP_ADDR() and
DEFINE_DMA_UNMAP_LEN().

Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 scripts/kernel-doc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d0116c6939dc..cfb1cb223508 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1168,6 +1168,10 @@ sub dump_struct($$) {
 	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
 	# replace DECLARE_FLEX_ARRAY
 	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
+	#replace DEFINE_DMA_UNMAP_ADDR
+	$members =~ s/DEFINE_DMA_UNMAP_ADDR\s*\($args\)/dma_addr_t $1/gos;
+	#replace DEFINE_DMA_UNMAP_LEN
+	$members =~ s/DEFINE_DMA_UNMAP_LEN\s*\($args\)/__u32 $1/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
-- 
2.38.1


