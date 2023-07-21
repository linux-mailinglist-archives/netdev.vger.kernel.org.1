Return-Path: <netdev+bounces-19950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB675CF2A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F3C2826F8
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2865200CD;
	Fri, 21 Jul 2023 16:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0C1F94D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8DC433C9;
	Fri, 21 Jul 2023 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689956548;
	bh=9LpmD5uO93V8k4qPmv5QFl14qrmyvndUuSFfp2XhlnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b+pTEQVY8tlhkGJFSfrK9njudzpErbDYj9xNVxU5I5+IdVYoO27AXO+5bkE7XnrrJ
	 88Cz3DwunJM+UC6AE8RS8VUKbXgTK2wbnQlbLGzOKGvbn6stS93nVm/fzpZc08jrd/
	 5aR9ChloCGqYCUNidkoteNg81EDhzc/pNUb77SWXUKw+EA2oMGOoH6ym4YplTOdG7l
	 L+Mu99v7f6fYsklq840Nk0QwU/QfD1AbQG/VvdMBtIIgC4YUNs+fPDdUWnMOkM+Fk3
	 eBaLpok6kZuirpVRkfzSjyRQ/oNGeFcquln5PNtrt0ISByk92b/i9k3dam0upfe4hY
	 TjuKisLNOmzkw==
Message-ID: <0f997467-c5c4-6d25-080d-94422127d51d@kernel.org>
Date: Fri, 21 Jul 2023 18:22:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Content-Language: en-US
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
 "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
 "Tham, Mun Yew" <mun.yew.tham@intel.com>,
 "Swee, Leong Ching" <leong.ching.swee@intel.com>,
 "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
 Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
 <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
 <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2023 17:30, Ng, Boon Khai wrote:
>> git
>>> a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> index 23d53ea04b24..bd7f3326a44c 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> @@ -543,6 +543,12 @@ stmmac_probe_config_dt(struct platform_device
>> *pdev, u8 *mac)
>>>  			plat->flags |= STMMAC_FLAG_TSO_EN;
>>>  	}
>>>
>>> +	/* Rx VLAN HW Stripping */
>>> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
>>> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
>>
>> Why? Drop.
>>
> 
> This is an dts option export to dts for user to choose whether or not they 
> Want a Hardware stripping or a software stripping. 
> 
> May I know what is the reason to drop this?

Because we do not print simple confirmation of DT properties parsing.
It's usually useless and obvious from DT.

To be clear - we talk about dev_info.

Best regards,
Krzysztof


