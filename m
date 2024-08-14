Return-Path: <netdev+bounces-118512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997B951D21
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADDD1C23915
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D621B32B7;
	Wed, 14 Aug 2024 14:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BA1B29C2;
	Wed, 14 Aug 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645877; cv=none; b=MIH1INcwOx6nSbY02Xx/ErsRRlDujmuSPLbqQVl0KGNZ87ENkYXh+iLSeTHTNf4rDC7yAJbTcz9vKcLoczeBKWgNgP2RNdb+km481h4tNkPIxi5SsS2MmwkhS8JsodmsHMxUqE/UXS0dOyeiNRGtDVwNI6IHBQlgdDT0NafZx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645877; c=relaxed/simple;
	bh=2tDV/1VsKQYTOmnMpeJpatftHLYLI+LoozCYciQtYCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noTBNqKh6Htm5fFqd+6lcWHNTR38nztg8Q3PLASoVJaEWvaa/XCeCsUXPBhUSqctTlUcUnSOZ4hhXCGKMDQSOfjRYc/mTlKbJ76QLYj0qvBHwswKYIF03q3FIlfDUpyB1wakQTAzzt8dO7wOsMzLEI2/dblyslUHATMWjxZfrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW024Nk9z9sPd;
	Wed, 14 Aug 2024 16:31:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jx_b2X4VnZYF; Wed, 14 Aug 2024 16:31:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW023MFfz9rvV;
	Wed, 14 Aug 2024 16:31:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FC358B775;
	Wed, 14 Aug 2024 16:31:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id A01nv7Omov-2; Wed, 14 Aug 2024 16:31:14 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DBF38B764;
	Wed, 14 Aug 2024 16:31:13 +0200 (CEST)
Message-ID: <c9946a25-7a1f-41e9-8986-44b51c7c9b90@csgroup.eu>
Date: Wed, 14 Aug 2024 16:31:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 08/14] netlink: specs: add ethnl PHY_GET
 command set
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-9-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-9-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> The PHY_GET command, supporting both DUMP and GET operations, is used to
> retrieve the list of PHYs connected to a netdevice, and get topology
> information to know where exactly it sits on the physical link.
> 
> Add the netlink specs corresponding to that command.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   Documentation/netlink/specs/ethtool.yaml | 55 ++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 586f1da8eb7b..d96a8050172b 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -39,6 +39,11 @@ definitions:
>           - ovld-detected
>           - power-not-available
>           - short-detected
> +  -
> +    name: phy-upstream-type
> +    enum-name:
> +    type: enum
> +    entries: [ mac, phy ]
>   
>   attribute-sets:
>     -
> @@ -1088,6 +1093,35 @@ attribute-sets:
>         -
>           name: total
>           type: uint
> +  -
> +    name: phy
> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: index
> +        type: u32
> +      -
> +        name: drvname
> +        type: string
> +      -
> +        name: name
> +        type: string
> +      -
> +        name: upstream-type
> +        type: u32
> +        enum: phy-upstream-type
> +      -
> +        name: upstream-index
> +        type: u32
> +      -
> +        name: upstream-sfp-name
> +        type: string
> +      -
> +        name: downstream-sfp-name
> +        type: string
>   
>   operations:
>     enum-model: directional
> @@ -1880,3 +1914,24 @@ operations:
>             - status-msg
>             - done
>             - total
> +    -
> +      name: phy-get
> +      doc: Get PHY devices attached to an interface
> +
> +      attribute-set: phy
> +
> +      do: &phy-get-op
> +        request:
> +          attributes:
> +            - header
> +        reply:
> +          attributes:
> +            - header
> +            - index
> +            - drvname
> +            - name
> +            - upstream-type
> +            - upstream-index
> +            - upstream-sfp-name
> +            - downstream-sfp-name
> +      dump: *phy-get-op

