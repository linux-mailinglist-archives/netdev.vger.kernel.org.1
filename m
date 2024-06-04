Return-Path: <netdev+bounces-100710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4288FBA54
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906371C23B39
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B534149E17;
	Tue,  4 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MxWm7+sx"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063F149C79;
	Tue,  4 Jun 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522032; cv=none; b=hAFaDMmSDGVqAyA4B1f5n1RXfgY8rsQLbUvdMCfWPz4D28BCIeWyqxThQjqsfDC23oLWeeDqAbJ+Lb20I68eDRR4g6x05kJsU2e11xxwChGk6aPDd3aqcNwtQz5V+4xy+sJ1bG4wuzkta+u/RD3T9Ee48T8M7efUlu21Yh5ktFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522032; c=relaxed/simple;
	bh=RIzXKfDhl9Ekyd2nhcKmDBuTQNp0l4FlcxM2THRKcW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPyR9StoCBpzr84YGVzKqoYEGeCQ1f3hrAshbLo2e1tohrN3qsJ3FHVs1tJxNRApiABkJWIK2r+YXccACTQXCYYhsaxcZtkw+B+punV2vV8RUwLnVsA8UJEFk3QFwWpIOjoNPAr60sCaZVAjZdOZ+XSRL3E3lMcU22ADwlsmt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MxWm7+sx; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 58E348850B;
	Tue,  4 Jun 2024 19:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717522029;
	bh=RIzXKfDhl9Ekyd2nhcKmDBuTQNp0l4FlcxM2THRKcW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MxWm7+sxwnNHjOYrokKndvjjtTOEgiXXEqEBJfhOZeEm/RDMoowQfgTCy18mwlQO7
	 P9yInaFPTrPVlhOIEdM/R5V+J+JoRyD8+VKGrNM4spXpa1+DSRrW7ZttLo9uQLzNWA
	 O3Fyy0EV30fSclVXanY84g/FhPLJ93TcAuwL1Mfid2plXKLHsyykavTNphD45F9Pvc
	 rqWThod9miilq2SMNkFgHtPMoNi15+ENPgyK3Mbuu2Obp8pR3jVS1Z7YI+Gts8jZWg
	 a/72cQZbCQ9XZgn33Qf7RWBqhcFY/R/fAasZG3Yj+Y/ScZWGvuKjmMGVdzfIUVuE+v
	 UojIe7iTOTPTA==
Message-ID: <c2242ba3-3692-4c5f-a979-0d0e80f23629@denx.de>
Date: Tue, 4 Jun 2024 18:52:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] ARM: dts: stm32: add ethernet1 for
 STM32MP135F-DK board
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-11-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604143502.154463-11-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/4/24 4:35 PM, Christophe Roullier wrote:
> Ethernet1: RMII with crystal
> PHY used is SMSC (LAN8742A)

Doesn't the STM32MP135F-DK come with two ethernet ports ?
Why not enable both ?

