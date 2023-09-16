Return-Path: <netdev+bounces-34226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66F7A2E3C
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B41C20AD5
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030407461;
	Sat, 16 Sep 2023 06:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341D6FDE;
	Sat, 16 Sep 2023 06:33:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34F19A8;
	Fri, 15 Sep 2023 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694846006; x=1726382006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52OjBIdYros6Vg0OVslLmr8CvSafvNPl+icnhq/BIUM=;
  b=Hz8Z33cxTnU78cyT9Xg/LWY5J/w8FRNV233VPoBk/5NMt4fzpvhdzjql
   3wnCRf1hMUo1f3Bv9rH6XPr80yM8XK+ixWx76RvqdHLbkgo4ttVI4BWiQ
   skP5KsFNFGVHRJfyF+qa0bj6ZnGuBj3Lq7yU06kw0fZTuE95ByrOYmI8q
   QmyjJI246dUC/CZh21r6jCZORHPWYKliIy6fzJ3lzt7hnVRe7ojSeNi+q
   b9+1lb8OATGpsvqUP1J2PxwzqZ/ry2+S3BaKGDFlUJhUzT7gpNoo9bj03
   6rnFVz8aKLQciDhEI1rkSFJ8G8ZOh10EPuae6SI87Gw+7iQiLR2Qq3Sv+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359637798"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="359637798"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 23:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="780351413"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="780351413"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2023 23:33:21 -0700
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
	fancer.lancer@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v7 1/2] dt-bindings: net: snps,dwmac: Tx coe unsupported
Date: Sat, 16 Sep 2023 14:33:11 +0800
Message-Id: <20230916063312.7011-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916063312.7011-1-rohan.g.thomas@intel.com>
References: <20230916063312.7011-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add dt-bindings for coe-unsupported property per tx queue. Some DWMAC
IPs support tx checksum offloading(coe) only for a few tx queues.

DW xGMAC IP can be synthesized such that it can support tx coe only
for a few initial tx queues. Also as Serge pointed out, for the DW
QoS IP tx coe can be individually configured for each tx queue. This
property is added to have sw fallback for checksum calculation if a
tx queue doesn't support tx coe.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..5c2769dc689a 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -394,6 +394,11 @@ properties:
               When a PFC frame is received with priorities matching the bitmask,
               the queue is blocked from transmitting for the pause time specified
               in the PFC frame.
+
+          snps,coe-unsupported:
+            type: boolean
+            description: TX checksum offload is unsupported by the TX queue.
+
         allOf:
           - if:
               required:
-- 
2.25.1


