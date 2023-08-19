Return-Path: <netdev+bounces-29022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD277816AE
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49930281E87
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB8A3F;
	Sat, 19 Aug 2023 02:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF504A3C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:32:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F94220;
	Fri, 18 Aug 2023 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692412328; x=1723948328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1ASKrWZR21qiCs/uTkTgFEuUcWckcx/+Gm2AG2f6Q8=;
  b=OUhi6+vrL7GcucGZ5xfwNbnpBH8VFlVOZhUoLS096RG62Ypuo4j/1yzI
   60vxLCEg+gbBLJ8HfQf6sL683LHmTMP81gSbcqAy36Qfd88lbfc93iMj0
   /cagO+S17zYyGw9lAKCquYABLfkOHQKzNBqO0j2nUjpmG58+Ct/pUj+2S
   vZ1g81QcK6Hr+m+rLTnAhEJBi+ihM6f6rfFmvesmUW1hYNech2wGcV2SN
   GxEEcJ2kTT0Y00KZmBjHN1U/E+Rbr13usn/XZdLeohdiuZugImn6/VVik
   0xYQRwEG05COBSmdWMowi1x5uU9kVFpA+a7IBLs74BWiFh24V7ApaYKpC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="439629412"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="439629412"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 19:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="800660794"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="800660794"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 19:31:42 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues with coe
Date: Sat, 19 Aug 2023 10:31:31 +0800
Message-Id: <20230819023132.23082-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230819023132.23082-1-rohan.g.thomas@intel.com>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add dt-bindings for the number of tx queues with coe support. Some
dwmac IPs support tx queues only for a few initial tx queues,
starting from tx queue 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..0c6431c10cf9 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -313,6 +313,9 @@ properties:
       snps,tx-queues-to-use:
         $ref: /schemas/types.yaml#/definitions/uint32
         description: number of TX queues to be used in the driver
+      snps,tx-queues-with-coe:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: number of TX queues that support TX checksum offloading
       snps,tx-sched-wrr:
         type: boolean
         description: Weighted Round Robin
-- 
2.19.0


