Return-Path: <netdev+bounces-185885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F31A9BFD5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001521B65A41
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972F217727;
	Fri, 25 Apr 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="OuVgSLTU"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80FA29;
	Fri, 25 Apr 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566511; cv=none; b=s2R9ka18XU5rlUKfXO91KL9llEbTSi9A+zP1r5isgvHp37oyQfYw5v2gqw5RrvLk2XGqjRhxJzZWfO8bOdByPP8HklI+ptIiwnSUFcXMnCVNb54n5aKR2x1KKg2XNImvLcSU8TN36S1n6ok3+4OnyHUx0XD8tptFPywWtFR/3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566511; c=relaxed/simple;
	bh=NXDMzhuqaItzHEjDVf+ZgFR1PH/wdyRxk4SgLXzkHDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErmJEn7AShV9rJJ2pYAUmolSYU/AiS8Cz1YZEqJ5g4L11WBkkteivQHEUUXj12PwSNkRlvDnCZqNPWR/tTmsiuv1gorb87CYu84eZqp9s0Ih+xBSiipEFwYx+wqa2dpwJxfSFfNfmvW7U2DINQATbueItxzb4z8XSZLex2lnZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=OuVgSLTU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745566506; x=1746171306; i=wahrenst@gmx.net;
	bh=NXDMzhuqaItzHEjDVf+ZgFR1PH/wdyRxk4SgLXzkHDQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OuVgSLTUEYhGuQsmoTURxhXjQmjpj8p7y+FH62KYAiHahqT4/ZEa0N2ZySWEyAQq
	 v50nr/2py9CEApi6LaqYSK3Dlkm+5jTCT0oV4Ds2n4JvSgJ7aU4D5wVo8qe28CtUj
	 Spt+U2UCRNHbNdTM2OY8PxoZjZHuGeUsdvar0kTEbvs0vhIna886HZCoXyD62tEQS
	 geMUjlKcFNcQypnelcnIp3svBB/vF0O66uXaK+4JcibC24LLN3iFvoSbPKb/LCr/g
	 n/o/HCyNv+vLcVnDRAeCVxMMHos0w4kY5BKVJ8sQJJ4b+3OMtbXGyeAc+ahJoNJKn
	 5unCSfB31DaOCoAwaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1u8Uhh2Cal-00HZ7x; Fri, 25
 Apr 2025 09:35:06 +0200
Message-ID: <7e261db8-7b3a-4425-93ce-b7bac3746da1@gmx.net>
Date: Fri, 25 Apr 2025 09:35:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net: vertexcom: mse102x: Fix possible stuck of
 SPI interrupt
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20250423074553.8585-1-wahrenst@gmx.net>
 <20250423074553.8585-2-wahrenst@gmx.net> <20250424181828.5d38001f@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250424181828.5d38001f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tVlU/3meqyPYXQAO8i99zAJp+CxOy0p6mpe5wHTqo3xrs3/0C2T
 v0MucHglZ5KjI0Je2v5mWlIX+j1vtESN7ODdSe5YDGYC4a3ZW5dOXvqk/B4MfD2Ba4NuPTo
 OcSi6OrH0j0IP4PUbhacngV9bzMglFBFpoRGQbeKz8X/Ol42sKjvaRmC7MQsTm3WSHl3sft
 UR1sDbpsK/JQIoKz9TyCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ON+3jz9YBOo=;6QORVE+LuOKnt0CtxO5Wor0tc8j
 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

Hi Jakub,

Am 25.04.25 um 03:18 schrieb Jakub Kicinski:
> On Wed, 23 Apr 2025 09:45:49 +0200 Stefan Wahren wrote:
>> The MSE102x doesn't provide any SPI commands for interrupt handling.
>> So in case the interrupt fired before the driver requests the IRQ,
>> the interrupt will never fire again. In order to fix this always poll
>> for pending packets after opening the interface.
> Wouldn't this cause invalid_rts or some other error counter
> to increment every time the user opens the device?
you are right, this would increase the invalid_cmd counter.

I'm missed to mention in the cover letter, that this series is only the=20
first part of two patch series. The first one only contains fixes, which=
=20
should be backported. The second one contains improvement, which can go=20
to net-next.

Regarding the invalid_cmd there is already a patch in my backlog, but I=20
didn't consider this as a real fix:

net: vertexcom: mse102x: drop invalid cmd stats

Since the SPI implementation on the MSE102x MCU is in software, it=20
cannot reply to SPI commands in busy state. So drop the scaring=20
statistics about "invalid" command replies.

https://github.com/chargebyte/linux/commit/9f8a69e5c0d6c4482e89d7b86f72069=
b89a94547

Should I add it as a fix?

Regards

