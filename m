Return-Path: <netdev+bounces-38272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EDC7B9E48
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 22583281F84
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAA2773A;
	Thu,  5 Oct 2023 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wLRTr23x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6D27722;
	Thu,  5 Oct 2023 14:04:12 +0000 (UTC)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA147886;
	Thu,  5 Oct 2023 07:02:59 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3959Elmm006036;
	Thu, 5 Oct 2023 13:27:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=vPDJqlOkcYsv+9E6fFIpFrHnKzbiUCA3RfHCCwQImm4=; b=wL
	RTr23xKY7IlRigOfwIllM/hLW5K9GUXkc/7FSGDPEn5YXwseGCyQ/UKylHdKNSuO
	bfP1lheXVsK7D7iQ3dleD2h9+5XOp3LGEB33YQCTPT591qrNYamX19LfD/KdYqIH
	YNg9AorRRHs1+eudFpgYutNUJyZkJVLVwE9kEJ/30sxoLaALrpJWghb5UDQu5ovm
	fI5Ju8eQwkSDDr/dFuvh7DVlz5pFROmhHyBb9sJyLT8t4i7rAj+4QYaPqC0BJ61Y
	3Omq6DOM1nxZoJF3swy7hDQf+Ckf1Hq3U3NyONDtSkf1dpXzrAzmr9FvJQptpPYN
	rvV5RUf4NkD1GEwrgWqQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thtbbrk16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Oct 2023 13:27:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5A34010005C;
	Thu,  5 Oct 2023 13:27:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C59F23D3E2;
	Thu,  5 Oct 2023 13:27:20 +0200 (CEST)
Received: from [10.252.31.76] (10.252.31.76) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:27:18 +0200
Message-ID: <c8804fbe-46e7-2771-e503-4e786df2f97c@foss.st.com>
Date: Thu, 5 Oct 2023 13:27:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 08/12] net: ethernet: stmmac: stm32: support the
 phy-supply regulator binding
Content-Language: en-US
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-9-christophe.roullier@foss.st.com>
 <ZRWfhk0aEDwytGv5@dell-precision-5540>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <ZRWfhk0aEDwytGv5@dell-precision-5540>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.31.76]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 9/28/23 17:45, Ben Wolsieffer wrote:
> Hello,
>
> On Thu, Sep 28, 2023 at 05:15:08PM +0200, Christophe Roullier wrote:
>> From: Christophe Roullier <christophe.roullier@st.com>
>>
>> Configure the phy regulator if defined by the "phy-supply" DT phandle.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> index 72dda71850d75..31e3abd2caeaa 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> ... snip ...
>>   static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
>> @@ -455,12 +496,20 @@ static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
>>   	if (dwmac->enable_eth_ck)
>>   		clk_disable_unprepare(dwmac->clk_eth_ck);
>>   
>> +	/* Keep the PHY up if we use Wake-on-Lan. */
>> +	if (!device_may_wakeup(dwmac->dev))
>> +		phy_power_on(dwmac, false);
>> +
>>   	return ret;
>>   }
>>   
>>   static void stm32mp1_resume(struct stm32_dwmac *dwmac)
>>   {
>>   	clk_disable_unprepare(dwmac->clk_ethstp);
>> +
>> +	/* The PHY was up for Wake-on-Lan. */
>> +	if (!device_may_wakeup(dwmac->dev))
>> +		phy_power_on(dwmac, true);
>>   }
>>   
>>   static int stm32mcu_suspend(struct stm32_dwmac *dwmac)
> Why only turn off the regulator in suspend on the STM32MP1 and not STM32
> MCUs? It seems like this could just go in stm32_dwmac_suspend/resume().
>
> Selfishly, I have a use case for this on an STM32F746 platform, so I
> would like to see support for it and would test an updated version.
>
Hi,

I'm working on MPU boards, I do not have MCU board, so feel free to 
contribute on MCU part ;-)

Thanks

Christophe

>> -- 
>> 2.25.1
>>
> Thanks, Ben

