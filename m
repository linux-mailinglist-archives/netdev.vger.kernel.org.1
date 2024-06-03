Return-Path: <netdev+bounces-100245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F28D850A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE5B25E89
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670A6131736;
	Mon,  3 Jun 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DswH2Hl4"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323612FF8F;
	Mon,  3 Jun 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425015; cv=none; b=Z6y9fJjvHX7LiXHQdyYm8d0g3OgaBFN4jHkbKkZfGpKFvtAj2wdW7G2hGbKaf8ctEef2MZiXcvevsH/429qiDkl62GzIKZQfzi+BQw3HZQirS1en2wO2p205Z4CHFOVNi73x40mdSCf5Qpnkkp82I58YXeXVPrclrtcLBlTAkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425015; c=relaxed/simple;
	bh=ME5S3rAewxYALP3zD16ZoCCOZWcPEkdGdMEBDqRV3k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSfdgOL9YSr54mHDtK4msptGmgklAuXuTX6U0G67WWBoRRevHYoMrb79mhSLPemBhlLMhVnxvGUgTFu54LlKGosgGOQZVmGH387TgEKJX5gxcVy+sPgh1vnpPJLuWnPdRHmhiFz0NQScFMzGK3WiyV5/Vr3+4tto52PHUu6SKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DswH2Hl4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 02E8E88297;
	Mon,  3 Jun 2024 16:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717425012;
	bh=tzwKWRYiq4hn9T72ICEyR6cTqBmlVIAQNA4M5kMLnKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DswH2Hl4e4qu+NnV3vVaNwmvbrLFMnaoy4MtJ7XyQT0Jevcn1FxJDp198TJHuiWtf
	 SRpsUjirB9iTqa2NLNNJL6mM/eHgeb7MwftO0vvTga7MNzgpDR4ocUvAC1DCWSaF66
	 IhITTRRjiIIdmn2+pOsLQibUr8xJl1nG+Wu+lW3xQWI/c9Zp0MNe28puVzgJ7oXzyz
	 VpyygSkmecDroHLAcd6nmaEeUaSnof8xNCUz0vnXpatowaO4fFC6aFv05C6g8sKSJW
	 EdFCuBuinronpATl6Wr8mCEdDt1DhomPEsq80gGZBqpatm4mqFTQdSr0v9Z6m++XD+
	 IpAShCtSL3VYg==
Message-ID: <eaa69915-e356-47ac-859e-933fe430a750@denx.de>
Date: Mon, 3 Jun 2024 15:09:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] ARM: multi_v7_defconfig: Add MCP23S08 pinctrl
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
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-12-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240603092757.71902-12-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/24 11:27 AM, Christophe Roullier wrote:
> Need to enable MCP23S08 I/O expanders to manage Ethernet phy

PHY in capitals.

> reset in STM32MP135F-DK board
> STMMAC driver defer is not silent, need to put this config in
> built-in to avoid huge of Ethernet messages

This second sentence is not correct, you are not enabling this GPIO 
controller driver to silence a warning, you are enabling this driver to 
let the PHY driver release the PHY from reset.

