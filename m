Return-Path: <netdev+bounces-26413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B004F777B98
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23B81C21703
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D96200D6;
	Thu, 10 Aug 2023 15:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84B1E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:05:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3526B5;
	Thu, 10 Aug 2023 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691679955; x=1723215955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RawPqX9svb99qPDhe7S8fUKSgh+O6y7Vx5VMTsgl/C4=;
  b=fmLvRELQe/1ys7Enqdsuop3DPN0Sx/DMUiCqrip0Fn719Bgaarv0O5sV
   Fp2gLw2tpFlN9N/xZUJPVxgrhyPoV/iGxuADOhAG4mC8DQam6ymmuaIbQ
   ip2o4qFb5XTLOW/fM2wSeX1PByiK/0lrRAmjDp9nZTvqhK8tYM6d9ZwJv
   ozSXaUWZlf1iT42RXHQA87WvUizkWNPRsqT2bR7xN35w+CFKS59qU3Uxr
   motYs7y/h2nX3H2J8jWq5AcPKXSs6wUAJUso8o5RsN6+0nX3lxJpBvFYu
   s5+vU/AvYZsKlvWEKkfhzourrmVFSBQDHQu6g6To0o3qyytaMhV+GGrF1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368901693"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="368901693"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="978821540"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="978821540"
Received: from pglc00052.png.intel.com ([10.221.207.72])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2023 08:03:44 -0700
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
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Tx queues with coe
Date: Thu, 10 Aug 2023 23:03:27 +0800
Message-Id: <20230810150328.19704-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20230810150328.19704-1-rohan.g.thomas@intel.com>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add dt-bindings for the number of tx queues with coe support. Some
dwmac IPs support tx queues only for few initial tx queues, starting
from tx queue 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..ad26a32e0557 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -313,6 +313,9 @@ properties:
       snps,tx-queues-to-use:
         $ref: /schemas/types.yaml#/definitions/uint32
         description: number of TX queues to be used in the driver
+      snps,tx-queues-with-coe:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: number of TX queues support TX checksum offloading
       snps,tx-sched-wrr:
         type: boolean
         description: Weighted Round Robin
-- 
2.26.2


