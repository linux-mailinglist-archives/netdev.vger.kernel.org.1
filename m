Return-Path: <netdev+bounces-106140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45814914F29
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F7A282A63
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01005140E2E;
	Mon, 24 Jun 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oqJj2A2l"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76E140373;
	Mon, 24 Jun 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237113; cv=none; b=gN0pn3UUU4QOtAHGsxNNWFkgX4teVeICYgdnpHaveqx3r8AAJvdb4KW912Z58gKCZdbeEGSSgyzt/oS4ZZaBvkf4hVsALFKVd0hPZRbfMww1nP+SXoI4pP/ZQ8IdgYLVhqrMEnuUqseVXWjhGMNDTwOPLSAa4akqLdHxNeA0RSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237113; c=relaxed/simple;
	bh=gzyqOvHJXSOAcQSP/iCtAmnzm40usfAzhKwXvGEBZwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0EZtWn2PQrT49Dy1OYCocUsjKbblsTwvLuXh+lLovc7hQ6njm3xQxA5PGBDqQFwZFB07z2OBvj99AkXvJdQ7oSBD9lhACvytZPg069qm/ZEWVlSnz4zZG9Mcz9a/urWZeV6cANOobDnO9x5OD1zDmk/TdrXXwSK0AYwja/WMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oqJj2A2l; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A927C88137;
	Mon, 24 Jun 2024 15:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719237104;
	bh=sqgSKvUDUPjj1EuuHc/BmohVKbxV/GhorsLMOrnqXTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oqJj2A2lvo8HWch5yLQPLiyYA1vsFBnPT09Yh3RwTx2IrIGNviVJjUqbG1A+YKJXW
	 iIIG0d7FJEAiKiqFYSWgGEIi4x2DsUD3Y0JXHIbHvNwNHNQQ2S4AQK2d2nLkrpHMK/
	 jTvPWgzzz8rGAq7LyongBZNpWNnhdxyBFnHwEMoCeaH9zulCQXF2mP1LGD7YWUCkLj
	 QnuiYHIAXKTf+Sw6qhz3M70ELtW/JsExrwp+j580JBg3DOaEtGg1ud/hu7w8a2RRRm
	 z+jRGZSVPki17yGIKVBJwJaYu+D5mi31Hq92/fw1QrZnq9qWCOFwSHQUXDSRWIbv6H
	 L0v0HNXKIrOpQ==
Message-ID: <447ed9cd-3f0a-4519-a932-6f8377daa44a@denx.de>
Date: Mon, 24 Jun 2024 14:22:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v3 2/2] net: stmmac: dwmac-stm32: stm32: add
 management of stm32mp25 for stm32
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
References: <20240624071052.118042-1-christophe.roullier@foss.st.com>
 <20240624071052.118042-3-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240624071052.118042-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/24/24 9:10 AM, Christophe Roullier wrote:
> Add Ethernet support for STM32MP25.
> STM32MP25 is STM32 SOC with 2 GMACs instances.
> GMAC IP version is SNPS 5.3x.
> GMAC IP configure with 2 RX and 4 TX queue.
> DMA HW capability register supported
> RX Checksum Offload Engine supported
> TX Checksum insertion supported
> Wake-Up On Lan supported
> TSO supported
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Marek Vasut <marex@denx.de>

