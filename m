Return-Path: <netdev+bounces-237879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBBC51124
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C3A3B1985
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7782F531F;
	Wed, 12 Nov 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vi/Gk5XL"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC062F5318;
	Wed, 12 Nov 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935396; cv=none; b=nMYVig8+rRy322MKXtFW6mlzIeynUuAhag+x/SH6PwiFKZSZdK8tfHiP/j6/ha+YaDgcJNjuuuPNiEhz+KLs/6I/afP1hQvlelyWjpciecqf/reom8e4pet9IoUVNHeyA9wEbCS9hWm+nAdtOtg50yXCtlLb+S+IiJrZ1SRtwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935396; c=relaxed/simple;
	bh=D2VhTMOIho5TF5gmeTYsJz1QMNfT6fyktvgzdUCAGF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRHVGAfjFyKx/7KnBcKFIubH0LmvtMIRTXZuzppaMMxVoVAIoehRTYZHvx4Jv2ClX51hwVdgpSCgj2cn5Go6qeLTjz/R3W/Yz20gNVf6vQwMFMWD8gYD5yc9gkdWgF1ypYHzq2Araq9yyN9SPay4pmj+AEpWwb8VbkoXpW9nO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vi/Gk5XL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 41D4D4E4164B;
	Wed, 12 Nov 2025 08:16:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E91766070B;
	Wed, 12 Nov 2025 08:16:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D00810371904;
	Wed, 12 Nov 2025 09:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762935389; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HQnMOSoBh6c02XpaM92rHFo3ekXwzKheXU/0txW3bog=;
	b=vi/Gk5XLFGdPJ7ioZPuZQMq1Sw+qBGaB2Ibv2uhLkgVRAFIsTHFnB5wiGmnJsH+lEQ6qCV
	KR3geUy9jHdD3rpPNj0UAev3bdA1gOAkxKr62rt5HgQ/rqbOiOu+5w6Lwcvkgu4R4opMfl
	qJBgCadS4hhctbc1ioqQJKIFBT/wMdZcNDqamrTovDLBGo2GPEXyGVGiZEk6Gk4EWsCx9v
	GGVQnQaULWqeyhaaLU5WMJT0oUCnv2qSB8uyBc5bPWmF5xZMNGK5UaJOtagxQ3q/G2wRjt
	hxnPc6/6K8H8U3baaySQ00ln7aW5kILINmz9UUEtgpMsv0SFu3FAnGXg7rTwQQ==
Message-ID: <dd488c39-3aa3-43f6-8cf7-abca4af3cc7a@bootlin.com>
Date: Wed, 12 Nov 2025 09:16:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 01/15] dt-bindings: net: Introduce the
 ethernet-connector description
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Antoine Tenart <atenart@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20251106094742.2104099-1-maxime.chevallier@bootlin.com>
 <20251106094742.2104099-2-maxime.chevallier@bootlin.com>
 <56410c74-3d0e-4cdc-87a0-230cad8f691a@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <56410c74-3d0e-4cdc-87a0-230cad8f691a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/11/2025 04:34, Andrew Lunn wrote:
> On Thu, Nov 06, 2025 at 10:47:26AM +0100, Maxime Chevallier wrote:
>> The ability to describe the physical ports of Ethernet devices is useful
>> to describe multi-port devices, as well as to remove any ambiguity with
>> regard to the nature of the port.
>>
>> Moreover, describing ports allows for a better description of features
>> that are tied to connectors, such as PoE through the PSE-PD devices.
>>
>> Introduce a binding to allow describing the ports, for now with 2
>> attributes :
>>
>>  - The number of lanes, which is a quite generic property that allows
>>    differentating between multiple similar technologies such as BaseT1
>>    and "regular" BaseT (which usually means BaseT4).
> 
> You still use lanes here, but the implementation has moved on to
> pairs.
> 
> Please add my Reviewed-by when you fix this.

Arg, I've made updates on lanes -> pairs, but as you point out I have
missed a few :( thanks for spotting this,

Maxime

> 
> 	Andrew


