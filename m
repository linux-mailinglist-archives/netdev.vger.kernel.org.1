Return-Path: <netdev+bounces-45305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1097DC05D
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0921F20FD4
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734219BDF;
	Mon, 30 Oct 2023 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LmtduLEB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C019BB9;
	Mon, 30 Oct 2023 19:25:42 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325CDF;
	Mon, 30 Oct 2023 12:25:40 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4741D6607391;
	Mon, 30 Oct 2023 19:25:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698693938;
	bh=6na0ZR9aRO2R+DcqR2Kg6XuMNOs2U7/usUJoSt63Jgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LmtduLEBohoIBG17lrvwaFniYQs/4Q5D32PuptdSL5aD2RAX16HbMTi+8EipJ+IQC
	 Pzftnslukemi/OoXAbwqDIgklKwAqidK7OXx/Ro1P8Vv1sUl7Te6vHnz+CObirBhrS
	 4m29csR86buGnD8lU5+3qgV/0Eg4XBkgpfuspHu21ocwhtpmftwBrpyQNA6xFJD89G
	 OIa1Bxluoq/aIC6QzFqKx/u5U0xGhMpUC+iKjDGGUvXlhCcTbhE7qrldVA0j2pumUZ
	 Lj5hczfNdPAYj+lW3amRKLQ6ce8584wbGU7BUWxHvzmzhAkzNiUaId7bsEd/rdtICZ
	 1fOk7dLUtWHiQ==
Message-ID: <e70fda8c-a924-44ab-be76-292f315b852a@collabora.com>
Date: Mon, 30 Oct 2023 21:25:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] dt-bindings: net: starfive,jh7110-dwmac: Drop
 superfluous select
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-3-cristian.ciocaltea@collabora.com>
 <9c9120d6-dd28-4b6d-be8d-46c0cab8f26a@linaro.org>
 <77ea127f-1040-489c-8ee3-d27df16fb995@collabora.com>
 <6b91a6df-4549-4ca8-9659-c6107f4f8c75@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <6b91a6df-4549-4ca8-9659-c6107f4f8c75@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/23 09:27, Krzysztof Kozlowski wrote:
> On 29/10/2023 22:08, Cristian Ciocaltea wrote:
>> On 10/29/23 13:18, Krzysztof Kozlowski wrote:
>>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>>> The usage of 'select' doesn't seem to have any influence on how this
>>>> binding schema is applied to the nodes, hence remove it.
>>>>
>>>
>>> It has. Why do you think it doesn't? You should see new errors from
>>> dwmac schema.
>>
>> This patch came as a result of testing both variants (w/ and w/o
>> 'select') with several different compatible strings and seeing
>> consistent output:
>>
>> - "starfive,jh7110-dwmac", "invalid";
>> - "starfive,jh7110-dwmac";
>> - "invalid", "snps,dwmac-5.20";
>> - "invalid"
>>
>> Did I miss something?
> 
> Testing all bindings? The select is there to prevent matching unrelated
> bindings.

Indeed, my bad, as I've been using DT_SCHEMA_FILES to restrict the scope
during initial testing and missed to include later other schemas for an
extended validation (note that since [1] it's possible to specify a list
of file paths separated by ':').

Will drop this in v3.

[1] 25eba1598c8e ("dt-bindings: Fix multi pattern support in
DT_SCHEMA_FILES")

Thanks,
Cristian

