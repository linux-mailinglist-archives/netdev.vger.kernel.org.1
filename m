Return-Path: <netdev+bounces-100243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E68D8503
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353DF1F20EC2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D012F581;
	Mon,  3 Jun 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="IyVcxsq+"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7D12EBF5;
	Mon,  3 Jun 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425012; cv=none; b=FPfeeB13mdhnccHPXGdMkC190PtJOKnhKbkszS8MKWYL8/zriV9nQ+zavca4515RHuZzegfE9eBg8BZe2TJupfT4ewomHc6be8ej7/x1C0kE+dRTXio/bKw0I9USF+oXKRw3W6tXkWEV4eZzSDU2w5ayAmqxz8wxhY/UW8klLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425012; c=relaxed/simple;
	bh=v2cZ/gm0pQ+mp42tOs97sf9MG+F1s6qk/Ct0nVZxUlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eORDW784kuK7myFLLoFgfFzibKcI3LwA8jkxmNKRRzN9M6SP0iVRS0nNM/vvNzPVE01MaH0hh/CV/Z77g0cQIFf2OV1o6mV25tX8RovfPqK7Mzbf0wLVrBU76AFEDHRqucc6q3Fyv5yWQaOct3PBOtAFTYkfvwPI4ikeTvD+JvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=IyVcxsq+; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 22234882EF;
	Mon,  3 Jun 2024 16:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717425009;
	bh=SfqsBTN3MtJf9fvXPp4/6/xuI3PMILN+3xSeSA4Cei4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IyVcxsq+9lZG5RBF3xAWjE/kj1VnNaYETJnaQiVRIJnjT1A02Fzz9O1IivX2ORKZa
	 sQZ6WrChIsT1BmvyyBsJHKFaj9kjcM4F1W4Xwm9KZ3sve/nvsUQOEKeUKUHuvFu71o
	 7atXrfHkATgEPxXQlLYVPW8FGXAZBOarUZ9GHuvp5XKh84bhycEgJoZ9+DFlqTjHGR
	 cYBe8IX5dETTrSUklIVoalCPYR/2PBkd6j0t35Ev3qCOydst78xISHQA4TpO7BhVT4
	 MKghslcyFkCJ5g1Pr3BB3ABga4u29i56ObCJlSLTXXehD8FlZqtSSiQcwh9tVd8b0s
	 0eoHhFY7qS92w==
Message-ID: <e753d3fa-cdfd-426c-9e66-859a4897ec3b@denx.de>
Date: Mon, 3 Jun 2024 15:03:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] ARM: dts: stm32: add ethernet1 and ethernet2
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
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-9-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240603092757.71902-9-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/24 11:27 AM, Christophe Roullier wrote:
> Both instances ethernet based on GMAC SNPS IP on stm32mp13.
> GMAC IP version is SNPS 4.20.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

I think it would be best to split off the DT patches into separate 
series so they can go through Alexandre and have the netdev patches go 
through netdev . In the next round, please send 01..07 as separate 
series and 08..10 as another one , and I suspect 11 as a separate patch.

