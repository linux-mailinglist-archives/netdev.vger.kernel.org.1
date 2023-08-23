Return-Path: <netdev+bounces-30071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78E785E4B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAFA28126E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE591F168;
	Wed, 23 Aug 2023 17:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB2C139
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:10:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED2E79;
	Wed, 23 Aug 2023 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692810621; x=1724346621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrRC0v01qmst+o9CFPIeg2m8CpONvn/tnWf4Ftn+KSE=;
  b=K61eDsNPl5P0pMhnDdUk/6lZkgHwxK6W06d6iz0Y9UhYfUUJq4UPp+RV
   lLFKYndBnyTlrTae7DutOHEoG09dBK44dnvizUndqhJCfk00UrE+9fqwi
   IRl339RGMc0b3s1tmThPQmZ936OEm2w6UMQtpHT7x1dpV0gVfXUmqWWA4
   Kn99l95gFuw/zS1wpC355tUwjSbNTsixFRodP4s9SxHg+T01CpwNX0TOM
   u9Ye7KZ177Sp/0IT8QM8+RclH2jlp1HSahipwB9aYyEjnk2T6BxcmBrXs
   XUTvygGYogMXqD3XghGADV360lOrTsWe9W8C+FFBRs9pJ2oNeV+367791
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="376945463"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376945463"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 10:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="806782503"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="806782503"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2023 10:10:15 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: fancer.lancer@gmail.com
Cc: alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	joabreu@synopsys.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	robh+dt@kernel.org,
	rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues with coe
Date: Thu, 24 Aug 2023 01:10:04 +0800
Message-Id: <20230823171004.6825-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <l7yajzhpuotn62pjkxk43qtcn3u4zltpyqcvo224737bjg3eab@bzu6pirxbvh2>
References: <l7yajzhpuotn62pjkxk43qtcn3u4zltpyqcvo224737bjg3eab@bzu6pirxbvh2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>On Tue, Aug 22, 2023 at 05:15:25PM -0700, Jakub Kicinski wrote:
>> On Sat, 19 Aug 2023 10:31:31 +0800 Rohan G Thomas wrote:
>> > +      snps,tx-queues-with-coe:
>> > +        $ref: /schemas/types.yaml#/definitions/uint32
>> > +        description: number of TX queues that support TX checksum offloading
>> 
>
>> Is it going to be obvious that if not present all queues support
>> checksum offload? I think we should document the default.
>
>This question is debatable:
>1. By default the DW xGMAC and DW QoS Eth IP-cores are
>synthesized with only the very first Tx queue having Tx COE enabled.
>2. If TSO is disabled then the Tx COE can be individually enabled
>for each queue available on DW QoS Eth controller and for the very
>first N queues on DW xGMAC controller.
>3. If TSO is enabled then the Tx COE will be automatically and always
>enabled for as many first queues as there are TSO-capable
>DMA-channels.
>4. At the current state the STMMAC driver assumes that all Tx Queues
>support Tx COE.
>
>The entry 4 can't be changed since we'll risk to catch regressions on
>the platforms with no property specified. On the other hand it partly
>contradicts to the rest of the entries. I don't know what would be a
>correct way to specify the default value in this case. Most likely
>just keep the entry 4 and be done with it.
>
>BTW I just noticed that but the suggested "snps,tx-queues-with-coe"
>property semantic will only cover a DW XGMAC-part of the case 2. DW
>QoS Eth can be synthesized with Tx COE individually enabled for a
>particular queue if TSO is unavailable.

Hi Serge,

Didn't know about a different IP configuration supported by DW QoS Eth IP. If
this is the case, I think we can have a flag 'coe-unsupported' for any TX
queue subnode as below.

+          snps,coe-unsupported:
+            $ref: /schemas/types.yaml#/definitions/flag
+            description:
+              TX checksum offload is unsupported by the TX queue. If TX checksum
+              offload is requested for a packet to be transmitted through this
+              TX queue then have a software fallback in the driver for checksum
+              calculation.

If this is okay, I can rework the patch based on this. Covers both DW QoS Eth IP
and DW XGMAC IP cases.

>
>-Serge(y)
>
>> -- 
>> pw-bot: cr

BR,
Rohan

