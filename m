Return-Path: <netdev+bounces-19951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38075CF39
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2BB1C21009
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742C200DF;
	Fri, 21 Jul 2023 16:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB901F946
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C49C433C7;
	Fri, 21 Jul 2023 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689956578;
	bh=Ew/4v1UbqQoZb20JkMzVmOCzBgdeH1pynDMmIlPkrEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eQZfFq4H2O53duuZx0xDupi2JgSJ+w6qoYQwPDqw0N9WeaLxg0UDAhgWguoUy+HeH
	 6kR3WQuNy1RtWqPJcV9+jAlF+QSl/ZdNN2rjEDzw56/aMxO8u6jQ2G9sjT+Vo/Abco
	 JS3TF41A4nHUJbhiKGBM971t50MOf37nEgb19kUNbMSEVuPicvcQ7dV1e6Uf2LWInW
	 q5SyIEgjyzCdBJQtwtPR5afInW7MJXZcSFQ4TlQ21fSQfmNLRAB/z0pxkDr/xPwbWT
	 PFG7vztmFl/tr2eI7+N13atfihHYhofUnv81z5uu9IKb+5+rtlRsiaUpbYqKXHE6rN
	 U/bKoy49yJHOg==
Message-ID: <68485bf5-0550-4954-cbaa-7f6a5443e4aa@kernel.org>
Date: Fri, 21 Jul 2023 18:22:50 +0200
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
To: Florian Fainelli <f.fainelli@gmail.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
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
 <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2023 17:59, Florian Fainelli wrote:
>>>> +	/* Rx VLAN HW Stripping */
>>>> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
>>>> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
>>>
>>> Why? Drop.
>>>
>>
>> This is an dts option export to dts for user to choose whether or not they
>> Want a Hardware stripping or a software stripping.
>>
>> May I know what is the reason to drop this?
> 
> Because the networking stack already exposes knobs for drivers to 
> advertise and control VLAN stripping/insertion on RX/TX using ethtool 
> and feature bits (NETIF_F_HW_VLAN_CTAG_RX, NETIF_F_HW_VLAN_CTAG_TX).
> 
> What you are doing here is encode a policy as a Device Tree property 
> rather than describe whether the hardware supports a given feature and 
> this is frowned upon.

That's even better reason...

Best regards,
Krzysztof


