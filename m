Return-Path: <netdev+bounces-42122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF307CD2DE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 06:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629832815BE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 04:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69886FB9;
	Wed, 18 Oct 2023 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EpHONU+s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B234421
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 04:29:31 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E020C6;
	Tue, 17 Oct 2023 21:29:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39I4T9fo023934;
	Tue, 17 Oct 2023 23:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697603349;
	bh=cZQ8bIcex77OtZzGfuodcGp+jZXgpoUqGf688e2Oi9A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EpHONU+s8vzPXA0BLUP4jjmXSv02btBtX6g1zU5PmILaIMajy9VgkO4+w1aVzYq1M
	 2TCH6JUTZn+LQY3pBDPxe3fqTIOA1ZTaWWUsDJ/UrDKjE8COQUAZlQIyvsKOf8hu51
	 ET7a1Stx14MFmlSeQDx+fartp06/sCGVMed7sLpU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39I4T9kp128885
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Oct 2023 23:29:09 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Oct 2023 23:29:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Oct 2023 23:29:07 -0500
Received: from [10.24.69.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39I4SG8a055260;
	Tue, 17 Oct 2023 23:29:03 -0500
Message-ID: <80f7b668-8589-4f32-82ad-ecb895ec656f@ti.com>
Date: Wed, 18 Oct 2023 09:59:03 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net] net: ethernet: ti: Fix mixed
 module-builtin object
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@kernel.org>, Roger
 Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231013100549.3198564-1-danishanwar@ti.com>
 <4a53722d-e31d-4598-a4a9-cf374c84bc44@app.fastmail.com>
 <7b0a02ad-d23c-2c04-6672-58f16f2cca5a@ti.com>
 <ff6c4489-7816-4fe2-b6da-53c5d3a24331@app.fastmail.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <ff6c4489-7816-4fe2-b6da-53c5d3a24331@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/10/23 5:08 pm, Arnd Bergmann wrote:
> On Fri, Oct 13, 2023, at 13:10, MD Danish Anwar wrote:
>> On 13/10/23 16:08, Arnd Bergmann wrote:
>>> On Fri, Oct 13, 2023, at 12:05, MD Danish Anwar wrote:
>>>> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
>>>> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
>>>> the expected CFLAGS are different between builtins and modules.
>>>>
>>>> The build system is complaining about the following:
>>>>
>>>> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
>>>> ti-am65-cpsw-nuss
>>>>
>>>> Introduce the new module, k3-cppi-desc-pool, to provide the common
>>>> functions to ti-am65-cpsw-nuss and icssg-prueth.
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>
>>> I submitted a different patch for this a while ago:
>>> https://lore.kernel.org/lkml/20230612124024.520720-3-arnd@kernel.org/
>>>
>>> I think I never sent a v2 of that, but I still have a
>>> working version in my local tree. I've replaced my version
>>> with yours for testing now, to see if you still need something
>>> beyond that.
>>>
>>
>> I see your patch addresses different modules. My patch introduces a new
>> module for k3-cppi-desc-pool which is used by both am65-cpsw-nuss and
>> icssg-prueth driver. Where as your patch addresses modules common across
>> different cpsw drivers (davinci-emac, cpsw, cpsw-switchdev, netcp,
>> netcp_ethss and am65-cpsw-nuss). So I think that both these patches are
>> addressing differet warnings.
> 
> Right, I can resend my patch (or Alexander Lobakin can rebase his version)
> after yours makes it in. Note that your patch introduces a warning about
> a missing license and description for the new module, so you should
> probably include this hunk:
> 

Sure Arnd, I'll add this and send v2.

> --- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
> +++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
> @@ -131,3 +131,6 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
>         return gen_pool_avail(pool->gen_pool) / pool->desc_size;
>  }
>  EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");

-- 
Thanks and Regards,
Danish

