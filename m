Return-Path: <netdev+bounces-225776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14779B98287
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1484A547C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79072224B05;
	Wed, 24 Sep 2025 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GCN4JXvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B44C98;
	Wed, 24 Sep 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686106; cv=none; b=Ow8dfzLCU9RT4i3QStWKVAVNgrikzlTVgBkZIrozGdKtC+d26CquYD5kUC9xuj6nsx1j30ORxTSRH6oNpJmxKNaa4N7Njy27VEKDJM/mje6qR++D1HRiRcojcY0Po23QfVC/9yZf2gMj44uKBqyKuE+a0pliEyl32dDnWHdT/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686106; c=relaxed/simple;
	bh=GLI4abl8FZ4HfkmnRdlogF0X6++XTS/tUyrTv2strik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7jg/n+NufNMx3/MNnaXg6HadiQr/1BBPuUINBjMSD3BDQmwMT0YChBg1ylQH2Bn+V10OZSbPLXudT+sZQ7NLLhQuoLdsVeJzqdxYqzi6T0Xh/I8OZSBGeks7NjID54bBc3K0HN0Sl0mO36eI5UTrASjkv3fIC2qnCdqe3hgLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GCN4JXvy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22D034E40CF2;
	Wed, 24 Sep 2025 03:54:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D3384606B6;
	Wed, 24 Sep 2025 03:54:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF2FD102F1886;
	Wed, 24 Sep 2025 05:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758686096; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=g+qDq5wTJI6x9EY39D0tJB9MH6r0WcMVdVhtkKarOt0=;
	b=GCN4JXvy5Jr2Cc5svIW5gg1tIvUpzdNR4vXL3iilzXOvA0IDaSnXsAipk852bsHFxPGIar
	8xzEeaC3wRS7xz17WwtS9be1O0lZdzovwkekvueR4jPF20QzmTvDy5Eq7nR2JGLrRuKNSg
	Ku8B522sIzaksIy3APEcrUHJ7wxRltQdFreb3Em9UPhhxCvlEUtSvVjcr+qiOZXaP+j8Yl
	IAewYMc7DqVeRLKEno1S6nCb+rdumy5n1bjCodVN71F+Mm5tjr8DpQQfvqkUvJdnPQmJIq
	y4ltufGnQ4H3zsCCGOJOSY/k69w417eWj3go6jOn9ibxoz7FxppNR2aVFDu9SA==
Message-ID: <ff7432c4-27ce-45a1-ac4d-c18d612ef04d@bootlin.com>
Date: Wed, 24 Sep 2025 09:23:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 13/18] net: phy: marvell10g: Support SFP
 through phy_port
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20250921160419.333427-1-maxime.chevallier@bootlin.com>
 <20250921160419.333427-14-maxime.chevallier@bootlin.com>
 <20250923182429.697b149b@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250923182429.697b149b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 24/09/2025 06:54, Jakub Kicinski wrote:
> On Sun, 21 Sep 2025 21:34:11 +0530 Maxime Chevallier wrote:
>> +/**
>> + * phy_port_restrict_mediums - Mask away some of the port's supported mediums
>> + * @port: The port to act upon
>> + * @mediums: A mask of mediums to support on the port
>> + *
>> + * This helper allows removing some mediums from a port's list of supported
>> + * mediums, which occurs once we have enough information about the port to
>> + * know its nature.
>> + *
>> + * Returns 0 if the change was donne correctly, a negative value otherwise.
> 
> kdoc likes colons after return so:
> 
>   Returns 0 -> Return: 0
> 
> sorry for only providing an automated nit pick..

It's OK, the series no longer applies with Russell's sfp_module_caps 
series being here, so a new version is due anyway.

Russell, I missed this series of yours as I wasn't available at all at 
that time, but as this phy_port series has been in the pipe for quite a 
while, and you commented on the used of sfp_parse_support et.al. that 
was being replaced, I'd have appreciated to be in CC :(

Given my schedule, next iteration is probably going to be for the next 
cycle anyway so no harm :)

Thanks,

Maxime

> 
>> + */
>> +int phy_port_restrict_mediums(struct phy_port *port, unsigned long mediums)


