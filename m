Return-Path: <netdev+bounces-48649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA87EF18A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63242281BC3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C41C2A8;
	Fri, 17 Nov 2023 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l4V9cavg"
X-Original-To: netdev@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2930DD50;
	Fri, 17 Nov 2023 03:19:36 -0800 (PST)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id ADD726601711;
	Fri, 17 Nov 2023 11:19:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700219974;
	bh=h2jcyuHxfZJvtCW/6nbh9J0OGrBeJS/78VqRCazEDN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l4V9cavg+Usm4d4l1NP4QhqbJ0vO/LogHGKqbNYkR30f9w5CnxCWk9EkZ3RodIQJx
	 rfPgRlQ4EfYvyFKbv1IqRhOioL9pysvwb+gH0AhXdcHfAbUhk3Yyb45+kKSQa2esqd
	 VeEvo8D+lFAt0NWppFw2pZjrIWTAxcGZmVLqC54pDoxv5TDXo+cQGUKh+b7BBe7ap+
	 PcJJMrdDnMS1iRwscQ1hUepm36wPoSues76Hmsa3/al6nYLYwHZHPtJt3zDjtDPIDP
	 +Dm5zhbGtZzVSVVlTC4HTUaTikOS2qlPw1mBHny4wUHM8ijJraYVQtGVZB3zgesPdo
	 E5MgVGbufksNw==
Message-ID: <e2f4ba34-24db-4669-bac4-ac64ea7761cf@collabora.com>
Date: Fri, 17 Nov 2023 13:19:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <f253b50a-a0ac-40c6-b13d-013de7bac407@lunn.ch>
 <233a45e1-15ac-40da-badf-dee2d3d60777@collabora.com>
 <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com>
 <20231116-stellar-anguished-7cf06eb5634a@squawk>
 <CAMuHMdXdeW9SRN8hq-0722CiLvXDFVwpJxjFTGgdc2mhT=ppYw@mail.gmail.com>
 <b4a3a139-4831-447e-94ed-d590986aed8c@collabora.com>
 <84fd076b-6db4-4251-aff8-36befc28e574@collabora.com>
 <CAMuHMdVXAx+b6=70PdgJrpbegBkDpb3w1UF0_u1Odi=JoYL2-w@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAMuHMdVXAx+b6=70PdgJrpbegBkDpb3w1UF0_u1Odi=JoYL2-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/17/23 11:12, Geert Uytterhoeven wrote:
> Hi Cristian,
> 
> On Fri, Nov 17, 2023 at 9:59 AM Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> On 11/17/23 10:49, Cristian Ciocaltea wrote:
>>> On 11/17/23 10:37, Geert Uytterhoeven wrote:
>>>> On Thu, Nov 16, 2023 at 6:55 PM Conor Dooley <conor@kernel.org> wrote:
>>>>> On Thu, Nov 16, 2023 at 03:15:46PM +0200, Cristian Ciocaltea wrote:
>>>>>> On 10/30/23 00:53, Cristian Ciocaltea wrote:
>>>>>>> On 10/29/23 20:46, Andrew Lunn wrote:
>>>>>>>> On Sun, Oct 29, 2023 at 06:27:12AM +0200, Cristian Ciocaltea wrote:
>>>>>>>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>>>>>>>>> RGMII-ID.
>>>>>>>>>
>>>>>>>>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
>>>>>>>>> yes, add the mdio & phy sub-nodes.
>>>>>>>>
>>>>>>>> Please could you try to get this tested. It might shed some light on
>>>>>>>> what is going on here, since it is a different PHY.
>>>>>>>
>>>>>>> Actually, this is the main reason I added the patch. I don't have access
>>>>>>> to this board, so it would be great if we could get some help with testing.
>>>>>>
>>>>>> @Emil, @Conor: Any idea who might help us with a quick test on the
>>>>>> BeagleV Starlight board?
>>>>>
>>>>> I don't have one & I am not sure if Emil does. Geert (CCed) should have
>>>>
>>>> I believe Esmil has.
>>>>
>>>>> one though. Is there a specific test you need to have done?
>>>>
>>>> I gave it a try, on top of latest renesas-drivers[1].
>>
>> [...]
>>
>>>>
>>>> Looks like it needs more non-coherent support before we can test
>>>> Ethernet.
>>>
>>> Hi Geert,
>>>
>>> Thanks for taking the time to test this!
>>>
>>> Could you please check if the following are enabled in your kernel config:
>>>
>>>   CONFIG_DMA_GLOBAL_POOL
>>>   CONFIG_RISCV_DMA_NONCOHERENT
>>>   CONFIG_RISCV_NONSTANDARD_CACHE_OPS
>>>   CONFIG_SIFIVE_CCACHE
> 
> CONFIG_DMA_GLOBAL_POOL and CONFIG_RISCV_NONSTANDARD_CACHE_OPS were
> indeed no longer enabled, as they cannot be enabled manually.
> 
> After cherry-picking commit e14ad9ff67fd51dc ("riscv: errata: Add
> StarFive JH7100 errata") in esmil/visionfive these options become
> enabled. Now it gets a bit further, but still lots of CCACHE DataFail
> errors.

Right, there is an open question [2] in PATCH v2 08/12 if this patch
should have been part of Emil's ccache series or I will send it in v3
of my series.

[2]: https://lore.kernel.org/lkml/4f661818-1585-41d8-a305-96fd359bc8b8@collabora.com/

>> Also please note the series requires the SiFive Composable Cache
>> controller patches provided by Emil [1].
>>
>> [1]: https://lore.kernel.org/all/20231031141444.53426-1-emil.renner.berthing@canonical.com/
> 
> That series does not contain any Kconfig changes, so there must be
> other missing dependencies?

There shouldn't be any additional Kconfig changes or dependencies as 
those patches just extend an already existing driver. There were some 
changes in v2, but they are still compatible with this series (I've 
retested that to make sure).

My tree is based on next-20231024, so I'm going to rebase it onto
next-20231117, to exclude the possibility of a regression somewhere.

I will also test with renesas-drivers.

Thanks,
Cristian
 
> Perhaps I should just defer to Emil ;-)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

