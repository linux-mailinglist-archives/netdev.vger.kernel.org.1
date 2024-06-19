Return-Path: <netdev+bounces-104891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7AF90EFD1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345011C21581
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAE15689A;
	Wed, 19 Jun 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="tcN0pOCX"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185EA155C96;
	Wed, 19 Jun 2024 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806177; cv=none; b=sMV/fxVQ2AHiTRwZBKzS0V4XwVBR+KHunrZcPFku/HW0QJ1tF8NxZxiRYZHgikRYEu1Ax2En6npD5jVhUe4gcv6Z7LgLCu7Av9gC7Uqh2PESdVXSrWeacMFa1Yh/1GCwUDTRkVtrOA7B0XPmwy5iVj6RZHFZb1xbLsvo0TiDet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806177; c=relaxed/simple;
	bh=sdRwQprYhm7EtS8OamNEvXChwrklyDQpf7pQLyUt0uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBV4xVuDa3Ij+1gW1O3/nULmNuwmXDW1NNHvOENlRoXMafWWXYEsx0fzWbz6i9SZRmzIzzAkP6FVZv36SfovTnaUPy6+dANp9QsRbKn9DIZY0fq5xW3+M337d+ECemaH4Vyaf58I0NeqW5MINj/aN10GnKmHzRZ36aYfdf7lfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=tcN0pOCX; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B24F58843F;
	Wed, 19 Jun 2024 16:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718806174;
	bh=W+VSNt45NLEYJtGrso2mYxCqQHq/lLBlTtM72NrS57c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tcN0pOCXkYF90NDtuWQxeY/Nd1uvHwuM76gH/zf8rbw30RTe2jGdUW0QnFGyitKGi
	 VQohQlKN7RwQ3+iEFzip2vRk5XJaswEOzwRyLTa3kwIdP2/e4SfhN5DHGrlJ/2Vc8m
	 i2sZRpU36fL6ZOOLQ8EjwalpU2ergpGPIYALgsyVUUvXa70EsHZZjAyHvqyjOfZ0zR
	 mv4wBSPZqiOevHwu9IPJnAMn47L1wo+cMWSng0rdcRRgUnvm0f37o1o4zaL0b5VNtR
	 GDbXcctfKnIdjbTvLfZI1hUcCOZMVj3MLDSYN+VvcijCoI+syW3MCVtrrIG6IO1PYM
	 cr1HnpXx85NNw==
Message-ID: <2b7248d6-3afb-4228-80d8-6f7090eb90af@denx.de>
Date: Wed, 19 Jun 2024 15:45:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: st: add eth2 pinctrl entries in
 stm32mp25-pinctrl.dtsi
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
 <20240619125815.358207-3-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240619125815.358207-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/19/24 2:58 PM, Christophe Roullier wrote:
> Add pinctrl entry related to ETH2 in stm32mp25-pinctrl.dtsi
> ethernet2: RGMII with crystal.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>

