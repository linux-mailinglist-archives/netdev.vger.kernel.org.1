Return-Path: <netdev+bounces-100711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF168FBA57
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4018E1C21264
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540514A4E1;
	Tue,  4 Jun 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Aw6AXUXw"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4814A0AA;
	Tue,  4 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522034; cv=none; b=RRXze/jPVIMdWdLiqrupF/DQgeAtZMHlCVMwg8+jkXAHex/zPBQFL640KrW4j9gzWKufzw3m7/97ZAkT4D2dXzPBC4IJWC/j46VuZqM/McY5/mzBCyZxvcLXT8FjOHKLdRZkSDZoxeNcw9FP3oSB2tHyIihrePvL60Dm1Wb/Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522034; c=relaxed/simple;
	bh=19j/qX+gL7Lz21NjIobaq4BpyZhEZYE3pB+bAIOQ+Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlrDkVKs+vKxUthDEEmg0SSbdgA8nDcxZS4SZEWnhrljVOmMB5VKjUd8LpLZpNnwwA8txs275g9BrVH0Hrlopbf8JOCQGqQd3pAOCAptXCbf9UoImKwGDwUtH2hFGYTZy11mlIbdEbK/kYg4B+8OABilslQDBGCI9XhjNnN1Grk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Aw6AXUXw; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2A5D08850D;
	Tue,  4 Jun 2024 19:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717522031;
	bh=ouE0lc8aXlYqAz3nRcHf2sJn1wgl70Q+6wn+UFtez/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aw6AXUXwxg4tf93WX2Tk0atTQIrXjd5wUS690PXNsSeHCmkTeyJpdaErauWUwJAXX
	 cIkvi7nHeCL+fjArJnUlp6o+OZGqfgl8CapH2WBAdtBjQCbn/IKAm15FMVR1e9D6or
	 SlonWQ/+SE9k9nuLKq3Wkf+XJ0tksjg4ZVfhRj6ZhJ3bueXb7hgCb4cGJo0/ZGfs3R
	 XINcCN0dJMCAWzxW7QVQV4JCUQ4IH2jTd0P5RdiNjG0lUrqtt9aaoNMftsud0HwU/R
	 9mp6ugcqSPOATYIGb/qxMx7WBtZKY5TzgkD/yIlh/pJQp+ZUgPWiNTF9Z08jpdmc23
	 9H7Tv7y2WQoeQ==
Message-ID: <20b33e48-4cf9-485d-815b-95ef4db8f04d@denx.de>
Date: Tue, 4 Jun 2024 18:55:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] ARM: multi_v7_defconfig: Add MCP23S08 pinctrl
 support
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
 <20240604143502.154463-12-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604143502.154463-12-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/4/24 4:35 PM, Christophe Roullier wrote:
> Need to enable MCP23S08 I/O expanders to manage Ethernet PHY
> reset in STM32MP135F-DK board.
> Put this config in built-in like STMMAC to avoid huge of Ethernet
> messages during boot (deferred)

You're not avoiding any error/defer/messages here, you simply need to 
enable the MCP23S08 GPIO controller driver, so the kernel can use the 
GPIO provided by that driver instance to release the ethernet PHY from 
reset on STM32MP135F-DK, that's all.

