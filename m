Return-Path: <netdev+bounces-115651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F349475DD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8046A1C20D9E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C5142E70;
	Mon,  5 Aug 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk1uHVMt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35C1411E6;
	Mon,  5 Aug 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842245; cv=none; b=ac+IxiBediDOd2zv5sntjNTMHaWw7K06ib6wsep4RLk+d4zgKU7MO1ei1x0TSSk19SRFu7xQmKe4nzhpC1HQKKM6Vg+xiP9IJBDs0B8TB74ROv01Kndlduf1gOspbAI7yD50RQDgfUta7mo5TGTR4blLZ/WokBH19SoQnqvd+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842245; c=relaxed/simple;
	bh=ME/AgEnwNZXu2jfxN3syRxms+BuO/oRMzAuTJsfFHHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKAQ9sYQtkf0tiBJ2/TWz9fz+Vy7D4pLlSjUApaoCxLeJ0msibpV9RlAOSErjeJxG+JNDK6/gjf22QF+cRr4Hph7MeA3h1t981emKi/QMVTn0ZzAR05SoUXpjuBw6vXT6devKNPsezpbPoFt7B9meQIAlSeLPvBn0Tu3OEYzcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk1uHVMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBFAC32782;
	Mon,  5 Aug 2024 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722842244;
	bh=ME/AgEnwNZXu2jfxN3syRxms+BuO/oRMzAuTJsfFHHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sk1uHVMtAmETVt+i2bIQ3jWetVplFPBJtQbYcTPpOuLlUtKVIjYyUsIm6sf5uqXX2
	 GSplFXOVDzzaHwu/RinuDvqTHvHAHe3ZT1Q0BajFMG9ynKpiWoBKraxNHu0wzDOoIo
	 ekVoZ4R8Qdh1UiUZZq3YXNEO7eZ3DcADSgKL9A/XrFP/LztSZjWExPCfeGHVHOrqal
	 nydXmv97T8WGAqaRLlUvUkgvczlECfceZDeo75XLZzP7xn3lOYYpnSSSLLlrYBDRvZ
	 jHGkW0oxzEGKmt5nlhH5c9uZ6Wf/fA7CY9BsOqb37oSBHbHtziUZ7E7FdTda3WROeL
	 lpyhMmkb6qqyQ==
Message-ID: <8c78325a-a0c1-4bc9-88dd-3e52296dd656@kernel.org>
Date: Mon, 5 Aug 2024 09:17:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 3/6] dt-bindings: net: Add DT bindings for DWMAC
 on NXP S32G/R
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dl-S32 <S32@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <AM9PR04MB85066A2A4D7A2419C1CFC24CE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <059e0b5e-7893-4c67-89d6-77c7cc87eccc@kernel.org>
 <AM9PR04MB8506FC5070BEEE98400247B0E2BE2@AM9PR04MB8506.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <AM9PR04MB8506FC5070BEEE98400247B0E2BE2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2024 09:10, Jan Petrous (OSS) wrote:
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Monday, 5 August, 2024 7:10
>> To: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>; Maxime Coquelin
>> <mcoquelin.stm32@gmail.com>; Alexandre Torgue
>> <alexandre.torgue@foss.st.com>
>> Cc: dl-S32 <S32@nxp.com>; linux-kernel@vger.kernel.org; linux-stm32@st-
>> md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; Claudiu
>> Manoil <claudiu.manoil@nxp.com>; netdev@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 3/6] dt-bindings: net: Add DT bindings for DWMAC
>> on NXP S32G/R
>>
>> On 04/08/2024 22:49, Jan Petrous (OSS) wrote:
>>> Add basic description for DWMAC ethernet IP on NXP S32G2xx, S32G3xx
>>> and S32R45 automotive series SoCs.
>>>
>>> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
>>
>> <form letter>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>> people, so fix your workflow. Tools might also fail if you work on some
>> ancient tree (don't, instead use mainline) or work on fork of kernel
>> (don't, instead use mainline). Just use b4 and everything should be
>> fine, although remember about `b4 prep --auto-to-cc` if you added new
>> patches to the patchset.
>>
>> You missed at least devicetree list (maybe more), so this won't be
>> tested by automated tooling. Performing review on untested code might be
>> a waste of time.
>>
>> Please kindly resend and include all necessary To/Cc entries.
>> </form letter>
> 
> Does it mean that scripts/get_maintainer.pl doesn't care about devicetree ML?
> I just tried to recheck, but it still shows me the list I used originally:

It cares and always provides it.

> 
> $ ll outgoing/*.patch
> -rw-rw-r-- 1 hop hop 1998 srp  4 11:33 outgoing/0000-cover-letter.patch
> -rw-rw-r-- 1 hop hop 2518 srp  4 11:33 outgoing/0001-net-driver-stmmac-extend-CSR-calc-support.patch
> -rw-rw-r-- 1 hop hop 2794 srp  4 11:33 outgoing/0002-net-stmmac-Expand-clock-rate-variables.patch
> -rw-rw-r-- 1 hop hop 4427 srp  4 11:33 outgoing/0003-dt-bindings-net-Add-DT-bindings-for-DWMAC-on-NXP-S32.patch
> -rw-rw-r-- 1 hop hop 8610 srp  4 11:33 outgoing/0004-net-stmmac-dwmac-s32cc-add-basic-NXP-S32G-S32R-glue-.patch
> -rw-rw-r-- 1 hop hop 1143 srp  4 11:33 outgoing/0005-MAINTAINERS-Add-Jan-Petrous-as-the-NXP-S32G-R-DWMAC-.patch
> -rw-rw-r-- 1 hop hop 1805 srp  4 11:33 outgoing/0006-net-stmmac-dwmac-s32cc-Read-PTP-clock-rate-when-read.patch
> $ ./scripts/get_maintainer.pl outgoing/*.patch
> Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32 ARCHITECTURE)
> Alexandre Torgue <alexandre.torgue@foss.st.com> (maintainer:ARM/STM32 ARCHITECTURE)
> "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:46/46=100%,added_lines:61/61=100%,added_lines:69/69=100%,added_lines:165/165=100%,added_lines:298/298=100%,added_lines:35/35=100%,added_lines:51/51=100%)
> linux-kernel@vger.kernel.org (open list)
> linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)

Read the form letter carefully. There are several instructions
mentioned. Above commands look sensible but if it still does not work
for you, then I suspect you develop on some old, vendor tree.

BTW, none of other patches made to the list or your threading is
completely broken. See:
https://lore.kernel.org/all/AM9PR04MB85066A2A4D7A2419C1CFC24CE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com/

Best regards,
Krzysztof


