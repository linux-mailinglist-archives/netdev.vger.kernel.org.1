Return-Path: <netdev+bounces-48569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F397EEDF9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2316F1C20ADE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA9D50E;
	Fri, 17 Nov 2023 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DbdkWOd6"
X-Original-To: netdev@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238ED4E;
	Fri, 17 Nov 2023 00:59:04 -0800 (PST)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id DBE37660738B;
	Fri, 17 Nov 2023 08:59:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700211542;
	bh=mSTx9zqrnn7lEW3vy1lR7oqBFFa9rnmtFZ28Q6NNZVo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DbdkWOd67zaj48dorFbegWDEOnLilRSxAU8IMF9PEe0F3jKz8ilpktpVWopTE3fH+
	 5Z87CfSU9O3WNHKZW1ItpEkyMx4Ya7uIPxvq4JzuvwCpqqGR2xICYIKyKf1Qlo3UZs
	 eHpvZ9Hw4p980MVZBsRw355Ten8C4Y948Fco6COVodqFW/wI7R2leK+kCER69RAtCM
	 2GyK6AJNfeOSlYC8tSxMrpviinpmOomwJMxHYYu53j+MA82eIJmlfjhSJ7XaobvyzB
	 K8rub3V9G4grfYMtnn1FYWe0TSHBEwawSS9QEYcFMtfaGhp/D5BsdXknVUeoEMLAgD
	 ExQE65vA9LPbQ==
Message-ID: <84fd076b-6db4-4251-aff8-36befc28e574@collabora.com>
Date: Fri, 17 Nov 2023 10:58:58 +0200
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
In-Reply-To: <b4a3a139-4831-447e-94ed-d590986aed8c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/17/23 10:49, Cristian Ciocaltea wrote:
> On 11/17/23 10:37, Geert Uytterhoeven wrote:
>> On Thu, Nov 16, 2023 at 6:55 PM Conor Dooley <conor@kernel.org> wrote:
>>> On Thu, Nov 16, 2023 at 03:15:46PM +0200, Cristian Ciocaltea wrote:
>>>> On 10/30/23 00:53, Cristian Ciocaltea wrote:
>>>>> On 10/29/23 20:46, Andrew Lunn wrote:
>>>>>> On Sun, Oct 29, 2023 at 06:27:12AM +0200, Cristian Ciocaltea wrote:
>>>>>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>>>>>>> RGMII-ID.
>>>>>>>
>>>>>>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
>>>>>>> yes, add the mdio & phy sub-nodes.
>>>>>>
>>>>>> Please could you try to get this tested. It might shed some light on
>>>>>> what is going on here, since it is a different PHY.
>>>>>
>>>>> Actually, this is the main reason I added the patch. I don't have access
>>>>> to this board, so it would be great if we could get some help with testing.
>>>>
>>>> @Emil, @Conor: Any idea who might help us with a quick test on the
>>>> BeagleV Starlight board?
>>>
>>> I don't have one & I am not sure if Emil does. Geert (CCed) should have
>>
>> I believe Esmil has.
>>
>>> one though. Is there a specific test you need to have done?
>>
>> I gave it a try, on top of latest renesas-drivers[1].

[...]

>>
>> Looks like it needs more non-coherent support before we can test
>> Ethernet.
> 
> Hi Geert,
> 
> Thanks for taking the time to test this!
> 
> Could you please check if the following are enabled in your kernel config:
> 
>   CONFIG_DMA_GLOBAL_POOL
>   CONFIG_RISCV_DMA_NONCOHERENT
>   CONFIG_RISCV_NONSTANDARD_CACHE_OPS
>   CONFIG_SIFIVE_CCACHE

Also please note the series requires the SiFive Composable Cache 
controller patches provided by Emil [1].

[1]: https://lore.kernel.org/all/20231031141444.53426-1-emil.renner.berthing@canonical.com/

