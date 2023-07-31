Return-Path: <netdev+bounces-22770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EC9769217
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3821C20B4B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECA17755;
	Mon, 31 Jul 2023 09:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7916FB9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:45:02 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3301BD3;
	Mon, 31 Jul 2023 02:44:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V9hmeh015520;
	Mon, 31 Jul 2023 04:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1690796628;
	bh=PNDJgPhDyZZF07yezO62ol3eDMZ2xv3gX7r6Ga4oJL0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=daZ7mM9pSZxgqPnxeeE2iySGDmOZ94eeIJN6JlOvbfOQulr7fgJ2AJ302a56VzjNM
	 9yXDV/D4zrCVgleHVHjKz6WKosXnVPas2u+zihhhCPd4C25nicfRDGqHZ5cxd/Hpjv
	 rO2n6EETWGdv8EDx5xI8+wwMgQ45t+PbUEclIs4Q=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V9hmw2005748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Jul 2023 04:43:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 04:43:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 04:43:48 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V9hfHP020585;
	Mon, 31 Jul 2023 04:43:42 -0500
Message-ID: <cad30510-19d8-a50b-d5a8-f4ef07724f65@ti.com>
Date: Mon, 31 Jul 2023 15:13:41 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230727112827.3977534-1-danishanwar@ti.com>
 <20230727112827.3977534-7-danishanwar@ti.com>
 <20230728172543.2d5f5660@kernel.org>
From: Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230728172543.2d5f5660@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/07/23 5:55 am, Jakub Kicinski wrote:
> On Thu, 27 Jul 2023 16:58:23 +0530 MD Danish Anwar wrote:
>> +/* Classifier helpers */
>> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
>> +void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
>> +void icssg_class_disable(struct regmap *miig_rt, int slice);
>> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti);
>> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
>> +
>> +/* Buffer queue helpers */
>> +int icssg_queue_pop(struct prueth *prueth, u8 queue);
>> +void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
>> +u32 icssg_queue_level(struct prueth *prueth, int queue);
> 
> If you create the prototypes when the functions are added there will 
> be less need for __maybe_unused. Compiler only cares about prototypes
> existing, not whether actual callers are in place.

So no need to use __maybe_unused tags if I create the prototype in the same
patch where functions are added. This will significantly reduce the number of
__maybe_unused tags. I will try to add the prototypes in the same patch where
these functions are added and drop __maybe_unused tags for them.

-- 
Thanks and Regards,
Danish.

