Return-Path: <netdev+bounces-45138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B937DB166
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F30B20C7B
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5D14F94;
	Sun, 29 Oct 2023 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E8YqVXFq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70715487;
	Sun, 29 Oct 2023 23:35:22 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5FD75;
	Sun, 29 Oct 2023 16:35:20 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id AE1E86606F9A;
	Sun, 29 Oct 2023 23:35:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698622519;
	bh=MTCi2I9f4ISCBGs2/Fbga3HK8s3ZEp9YzqbtdDcEFuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E8YqVXFqTKOb1b7+V+LvVodpgloKNhOi/cvEi6BPPS05bV806a0qSmpHGA//N3snW
	 h99teObkzlP/UFwAKAFDk9Nk8YCnqRNsEwoz2CN5Rsz/xZx7qxxDU+MnPU99ernPYA
	 qEGXl+IYNDpATcKw1tbJeqffsMuMAd6omfTp3+MCNL7mmmkWf1/A/3L9JRX5eVfdTQ
	 JonkmqtldtU5gK/6FKezwzsNBda3DWs0J0gxEoBAJDXLwyo1vO6ZcNftj1XXfll6PA
	 kW+TEy+Z0LEQweOfGiqxPYeyOUsDCnTxbFLxy+5EnLQV/skyhiNO95EHGcV8RU1FUG
	 yDP1+OLtXJmdg==
Message-ID: <7eab89f4-bfd0-441c-8b02-aa9d0f0cdace@collabora.com>
Date: Mon, 30 Oct 2023 01:35:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] riscv: dts: starfive: visionfive-v1: Enable gmac
 and setup phy
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
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
 <20231029042712.520010-12-cristian.ciocaltea@collabora.com>
 <f379a507-c3c1-4872-9e4f-f521b86f44d4@lunn.ch>
 <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>
 <e837e707-5b01-4b7b-8362-0dc62883fdba@lunn.ch>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <e837e707-5b01-4b7b-8362-0dc62883fdba@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/23 00:50, Andrew Lunn wrote:
> On Mon, Oct 30, 2023 at 12:41:23AM +0200, Cristian Ciocaltea wrote:
>> On 10/29/23 20:45, Andrew Lunn wrote:
>>> On Sun, Oct 29, 2023 at 06:27:11AM +0200, Cristian Ciocaltea wrote:
>>>> The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
>>>> RGMII-ID, but requires manual adjustment of the RX internal delay to
>>>> work properly.
>>>>
>>>> The default RX delay provided by the driver is 1.95 ns, which proves to
>>>> be too high. Applying a 50% reduction seems to mitigate the issue.
>>>
>>> I'm not so happy this cannot be explained. You are potentially heading
>>> into horrible backwards compatibility problems with old DT blobs and
>>> new kernels once this is explained and fixed.
>>
>> It seems the visionfive-v2 board also required setting some delays, but
>> unfortunately no details were provided:
>>
>> 0104340a67b1 ("riscv: dts: starfive: visionfive 2: Add configuration of
>> mac and phy")
> 
> That board also uses a YT8531 PHY. Its possible this is somehow to do
> with the PHY. Which is why testing with the Microchip PHY is
> important. That should answer the question is it a SoC or a PHY
> problem.

There is also YT8531S, which looks compatible with YT8521, but YT8531
seems to be a bit different. Regardless of what VisionFive v2 is using,
it would be indeed interesting to find out how the Microchip PHY behaves
in this context.

Regards,
Cristian

