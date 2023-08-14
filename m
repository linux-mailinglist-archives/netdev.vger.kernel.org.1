Return-Path: <netdev+bounces-27219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A7277AFA6
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 04:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BD280CC6
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 02:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20DB1842;
	Mon, 14 Aug 2023 02:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765D1381
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 02:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795EFC433C8;
	Mon, 14 Aug 2023 02:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691981293;
	bh=ciiPZ0XV44zYsaM7zV31cWAMKtbrCPScK0+W4m3gTYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dWqnZZebzX9cTi9ZTbLsaLH2yQV86sX/gkq3M5t8OOrGXFuaWUScPHMiYFsHYnbxa
	 kbPCiUd8+TWE2QQ4ZzILlvSikuBQMx1PyyE+6my3xXTmRyOtDsRQVrKqNSBPA+8kYM
	 /aEdcgiDOIe+RZcFjFVRyKXW2NE++2W1+g+XDTOB/e5hu1BcIJupjPobxfGcEOejZR
	 ORb5YzIQSKq/aAv49L6G4pk4f3QdLwl8mN40Wm4FWtI05fxBkghpGJ7s1AGeMVdv5H
	 Im//9swhE/J8zqv57S4eKrGY2dCmpescaN9LSxqIjwgqQWHHAfTN6pLvmn2DSVYObR
	 3O8vscTgWpD9g==
Message-ID: <bc6858ef-833f-2eb8-7f19-02ba9063ac0f@kernel.org>
Date: Sun, 13 Aug 2023 21:48:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the
 Agilex5
Content-Language: en-US
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Turquette, Mike" <mturquette@baylibre.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
 <d58e289b54f66c239ae09e94728716b7.sboyd@kernel.org>
 <DM6PR11MB32915E1D8C2981100A83B4ABA216A@DM6PR11MB3291.namprd11.prod.outlook.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <DM6PR11MB32915E1D8C2981100A83B4ABA216A@DM6PR11MB3291.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/23 07:53, Rabara, Niravkumar L wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Boyd <sboyd@kernel.org>
>> Sent: Thursday, 10 August, 2023 5:27 AM
>> To: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
>> Cc: Ng, Adrian Ho Yin <adrian.ho.yin.ng@intel.com>; andrew@lunn.ch;
>> conor+dt@kernel.org; devicetree@vger.kernel.org; dinguyen@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linux-clk@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Turquette, Mike <mturquette@baylibre.com>;
>> netdev@vger.kernel.org; p.zabel@pengutronix.de; richardcochran@gmail.com;
>> robh+dt@kernel.org; wen.ping.teh@intel.com
>> Subject: Re: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the Agilex5
>>
>> Quoting niravkumar.l.rabara@intel.com (2023-07-31 18:02:33)
>>> diff --git a/drivers/clk/socfpga/clk-agilex.c
>>> b/drivers/clk/socfpga/clk-agilex.c
>>> index 74d21bd82710..3dcd0f233c17 100644
>>> --- a/drivers/clk/socfpga/clk-agilex.c
>>> +++ b/drivers/clk/socfpga/clk-agilex.c
>>> @@ -1,6 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0
>>>   /*
>>> - * Copyright (C) 2019, Intel Corporation
>>> + * Copyright (C) 2019-2023, Intel Corporation
>>>    */
>>>   #include <linux/slab.h>
>>>   #include <linux/clk-provider.h>
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/platform_device.h>
>>>
>>>   #include <dt-bindings/clock/agilex-clock.h>
>>> +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
>>>
>>>   #include "stratix10-clk.h"
>>>
>>> @@ -41,6 +42,67 @@ static const struct clk_parent_data mpu_free_mux[] = {
>>>            .name = "f2s-free-clk", },
>>>   };
>>>
>>> +static const struct clk_parent_data core0_free_mux[] = {
>>> +       { .fw_name = "main_pll_c1",
>>> +         .name = "main_pll_c1", },
>>
>> We're adding support for something new? Only set .fw_name in that case, as
>> .name will never be used. To do even better, set only .index so that we don't do
>> any string comparisons.
>>
> Yes we are adding Agilex5 SoCFPGA platform specific clocks.
> I will remove .name and only keep .fw_name in next version of this patch.
>   
>>> +       { .fw_name = "peri_pll_c0",
>>> +         .name = "peri_pll_c0", },
>>> +       { .fw_name = "osc1",
>>> +         .name = "osc1", },
>>> +       { .fw_name = "cb-intosc-hs-div2-clk",
>>> +         .name = "cb-intosc-hs-div2-clk", },
>>> +       { .fw_name = "f2s-free-clk",
>>> +         .name = "f2s-free-clk", },
>>> +};
>>> +
>> [...]
>>> +
>>>   static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
>>>                                         int nums, struct
>>> stratix10_clock_data *data)  { @@ -535,6 +917,51 @@ static int
>>> n5x_clkmgr_init(struct platform_device *pdev)
>>>          return 0;
>>>   }
>>>
>>> +static int agilex5_clkmgr_init(struct platform_device *pdev) {
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct device *dev = &pdev->dev;
>>> +       struct stratix10_clock_data *clk_data;
>>
>> Maybe call this stratix_data so that clk_data.clk_data is stratix_data.clk_data.
> 
> Will fix this in next version.
> 
>>
>>> +       struct resource *res;
>>> +       void __iomem *base;
>>> +       int i, num_clks;
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       base = devm_ioremap_resource(dev, res);
>>
>> This is a single function call, devm_platform_ioremap_resource().i
> 
> Noted. Will fix in next version.
> 

When you resend a V3, just send this patch. I've already applied the 
other 4 patches.

Dinh

