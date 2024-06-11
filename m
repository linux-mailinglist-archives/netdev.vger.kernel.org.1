Return-Path: <netdev+bounces-102586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735D903D52
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4221C248C9
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF917D341;
	Tue, 11 Jun 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="acRpc38v"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD517CA01;
	Tue, 11 Jun 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112550; cv=none; b=CHL382og7xomiUgM8vmwPP3rh7B7Mgx4DJVmhcVMGx3YKFAAFhsgk/d0x2qx5mimklL0I3p6PPFFHl1SH4pHWoZ4JHFm34E+eMkGz+mh8042qwJmrQ4WznPGFfHp8uvpTWy4qwgFXl94qtKvs3MEz3JTyGg2v3TvWe9eqa7VbL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112550; c=relaxed/simple;
	bh=BMP9w47+jx4M2agblJj0+ixb5r1r7O+4fLzBZBqWW3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDG+Z24v3htYvB0rj/w7uz5YzY5+GvVSeBgirNgDpzLuzxCbHZTjiCE4/LNkNz1OpNum7dHnMpd/L9l38rIVOnbJmDAS9IIzYyzwvOaDkDS33GiKqyqBwDwvDd7Es0aH6UfI0qAQIhWURM2KgSTTAx/ZHBBkEg0Y9Dz7Ib5hKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=acRpc38v; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4364C886AE;
	Tue, 11 Jun 2024 15:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718112541;
	bh=HemWINfH/epw+LZFgUcstNjd+LDPJilMaixFK22+03Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=acRpc38vKy22z8IOCx6o/g1Z8cXPaHREocz/f0ymJuu/zSVZ/NdhDO1t0LhouEEPc
	 rp6XJBfvRdHSTfxOR0kaB5mGKoT7CxxzIBcXMmH+LuMeqMzPDJPWDa5Jv/Bl9/buEH
	 2IRH9fHbaP9iaDmE26pCk+2KAdeqI2yW8uU6kiSGZSyN4m/U1andbOEe6dM8dIjlLi
	 35fbfnglEeWiYNXyf/uL7HgN5Fq+YYAlh/MnZ4QRJLshxBWVtIBGlVDH8LMFQh7zfD
	 u8bN0jDc7qBRuIzi4Zs+mzs+UGguNDtZduItpB8pizQfnS82yd9EZ11PJs31X9QvL0
	 hKofLqcYUCxSQ==
Message-ID: <de1625ea-1ba8-4ebd-9442-59c7d9a6d04c@denx.de>
Date: Tue, 11 Jun 2024 15:05:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
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
References: <20240611130110.841591-1-christophe.roullier@foss.st.com>
 <20240611130110.841591-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240611130110.841591-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/11/24 3:01 PM, Christophe Roullier wrote:
> Both instances ethernet based on GMAC SNPS IP on stm32mp13.
> GMAC IP version is SNPS 4.20.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>

