Return-Path: <netdev+bounces-80667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92D88045B
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 19:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C257282359
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F562B9C1;
	Tue, 19 Mar 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CY1lyTcE"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9528383;
	Tue, 19 Mar 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871669; cv=none; b=Il6bndQBGEQB/TPfP4SvsAkVqFT23/4fw/cFP6g7x9VsH+8zKAOhexfsNMkMBgM07goLG+Q7FC5vA7KaAL6PBI8wfDgzAkFwaI6PCiBCLYpAzyo6VPcExdRLdzl8yyM5cbr6lLItk0OPMoOUUBp/80JwhebhNmO3zTeBTFfMHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871669; c=relaxed/simple;
	bh=9+OK1+c/8JOBYR1YQueWcR3S1IUR3nOrsBdURiXOeQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OH3+3vIUffQjFmf71FhHsxNCTgFMLKC2O94gD/7DkyQyeyY2SC4dkzy+KuEZUA1Z6d1ptLZPPD8Rpw5G3oO03/StNDrKYH80nWB1rJFXzkadxMcAkNmo3NJqwBMlUqGiutqNHrnaerk2A4ERBTm/nJy2QcVg0TvA5vvp7sQKMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CY1lyTcE; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 23B77879E8;
	Tue, 19 Mar 2024 19:07:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710871664;
	bh=BAVXIaMxVuPkFRS9oEYN4x4tDrjCx4Yiuoc6W+g6TAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CY1lyTcEI+HjM0Eqxn5Gxkcpaw8eQBNFRH6gH+MF2MWgQfiSwac1kLdSpOERiHDMg
	 w4ZUew46ru2XterW2I7S8rF39bdziqfyiOuW1++RIXCD2eJ2OKP9OAUsSmGV41vfPh
	 86MB4Iw0Z2QHfsMYdyj2+0f63eKxAo+a7qbnEoOsF3bQryYYDO89OBVlaQv9oM4a5l
	 Ur5Wl0q2dcWyp5N0+dv8eIz8Y24nur2e/isXYAJSEYx8M77p1CebJxZFSUQUEsWzqk
	 5dguYlDdrpYH4mjt20ngkVMnbcQlRdlTB6UiTTJkgHthwmycGFyd+hdABMEAl87MYP
	 xqcz5tBrm8w0A==
Message-ID: <878e72e6-8a75-4593-8080-e3d9b3f7f523@denx.de>
Date: Tue, 19 Mar 2024 19:07:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT
 binding
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240309031609.270308-1-marex@denx.de>
 <20240317-spotter-imminent-1a29a152648b@spud>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240317-spotter-imminent-1a29a152648b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/17/24 4:03 PM, Conor Dooley wrote:
> On Sat, Mar 09, 2024 at 04:15:12AM +0100, Marek Vasut wrote:
>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
>> This chip is present e.g. on muRata 1YN module. Extend the
>> binding with its DT compatible.
> 
> How come there's no fallback here? Looking at the binding patch there's
> no device-specific handling done, what's incompatibly different between
> this device and some of the other ones supported by the hci_bcm driver?

For posterity, should be addressed in V2.

