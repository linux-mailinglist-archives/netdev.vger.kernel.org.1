Return-Path: <netdev+bounces-104890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DA90EFCF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03FE1F216C9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA25155C83;
	Wed, 19 Jun 2024 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="We5TTLnA"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9415098E;
	Wed, 19 Jun 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806175; cv=none; b=ENMkIGFQKhhOLZBa4i0uu8Fds3XGEZr1cmwycr98x24sHLBEyKwkd9GZtOBIv7XNoPbPg7sVs8klFa7kOMHOvYc7rjqeSsyorAMbdGXyuQdVag/DGhA7XmhOsf8L4z7xxvRlbPUMUDD70O+9xSTOMh7hg8bmuB6kxu2trncrAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806175; c=relaxed/simple;
	bh=Al0kBfLHssYAQy6/oy1Pf41V356seJgU3boW8IIW+OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pG9fXU+bZ2biLx6EV3XOXHkQjD5GFdubTXcrmECIpYAUqHS4XAXUd/KsB7db7l9cvCGIXAP+l3NV/spb8ZbQUgH5yAEdl3kZoqrlyPoTzMctz9vepmo77/BPI3xyXvKXH24rGfPh+Y0j+Oy7Gr/hylAOqioRnBL7Pkh1Eij4g20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=We5TTLnA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3230488428;
	Wed, 19 Jun 2024 16:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718806172;
	bh=2tFlSH74W8+2RQdC7szAY3eA9dHEvz08hbHTqrK0XfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=We5TTLnA2KguroNAn1p/cOOT8Ip6tdK4hpfzcourjB0PUyH5Fgt1SPPYqmJbqBqjH
	 xGXIw10XqFrHbZUbSUUuv7LyrSZ05nE/zlYPV9MY4YeiWAjunddTuP+xqf04ftW+qR
	 65IWkp3jHlIWMJbqrozS0WuaN6ghr4QakICIcjE8ouwm8vyU3DFDoEgYXSLzalrBpE
	 KF+LkTJUBWYC94KASjOOutc5DFo3rxh8Gk/qgSauMai2SVVaIfaua9Xu25Zdi+37cw
	 GofTAIEwLmX5W4DokVt+mawMYer9OImFVWZNl1gSEdQoH/f6DzTJD0Zo2osti/DYqo
	 1906YPkNSM3+Q==
Message-ID: <d9a03fa6-5d35-4a18-9ae7-8dad98f65dc6@denx.de>
Date: Wed, 19 Jun 2024 15:44:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: st: add ethernet1 and ethernet2
 support on stm32mp25
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
References: <20240619125815.358207-1-christophe.roullier@foss.st.com>
 <20240619125815.358207-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240619125815.358207-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/19/24 2:58 PM, Christophe Roullier wrote:
> Both instances ethernet based on GMAC SNPS IP on stm32mp25.
> GMAC IP version is SNPS 5.3
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

I don't have an MP2 device, so I cannot provide much technical feedback. 
But from the DT standpoint, this looks OK, so

Reviewed-by: Marek Vasut <marex@denx.de>

