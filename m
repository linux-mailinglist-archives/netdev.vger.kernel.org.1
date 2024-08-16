Return-Path: <netdev+bounces-119249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DB954F79
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1691F22C24
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB91BD4EA;
	Fri, 16 Aug 2024 17:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069B1BE241;
	Fri, 16 Aug 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827746; cv=none; b=iovbgcy5TyA6sutTUlWin1ySzjAQVAOdtetEOSzwIp+pZ6E4yluV4CMhkbQryj+82gkib+CIwPhgpaotdl0JgZX3cPcjDMn2IMwZrbSZ+b9ZCvXSuvP9Z/+/n/tHapxRYux1mgjYIuquoPSLUqgm7dzHO+4pbALPiPOsanHlAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827746; c=relaxed/simple;
	bh=9718fqdYNAYzKJH1GW1xbNR/gKG0Y44y/Tp8v3ItV6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVoPvW8XwgP4CSPS4bHl1+xCBdG5GVjjSDUH3LmUw8QKcFPrnc5jJeuiIdgH8PWJADm35Eav77ZDDNk7QWY52nluxYGJ4JSoQJHNnSrNnTYi38C/eyEzEsmR3ObIGJ8ffY5Q9qO67MVGgSU26Cyir/LvmTUnLbgq6Nu0G2kQ394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WlpFV0hMsz9sRy;
	Fri, 16 Aug 2024 19:02:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id laL4b9KcLErP; Fri, 16 Aug 2024 19:02:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WlpFT6bcbz9sRs;
	Fri, 16 Aug 2024 19:02:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BE7528B775;
	Fri, 16 Aug 2024 19:02:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TqPwP2e5NScu; Fri, 16 Aug 2024 19:02:21 +0200 (CEST)
Received: from [192.168.232.147] (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 977708B764;
	Fri, 16 Aug 2024 19:02:20 +0200 (CEST)
Message-ID: <a1231b3a-cd4d-4e74-9266-95350f880449@csgroup.eu>
Date: Fri, 16 Aug 2024 19:02:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 00/14] Introduce PHY listing and
 link_topology tracking
To: Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
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
 Romain Gantois <romain.gantois@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240715083106.479093a6@kernel.org> <20240716101626.3d54a95d@fedora-2.home>
 <20240717082658.247939de@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240717082658.247939de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jakub, Russell

Le 17/07/2024 à 17:26, Jakub Kicinski a écrit :
> On Tue, 16 Jul 2024 10:16:26 +0200 Maxime Chevallier wrote:
>>> I lack the confidence to take this during the merge window, without
>>> Russell's acks. So Deferred, sorry :(
>>
>> Understood. Is there anything I can make next time to make that series
>> more digestable and easy to review ? I didn't want to split the netlink
>> part from the core part, as just the phy_link_topology alone doesn't
>> make much sense for now, but it that makes the lives of reviewers
>> easier I could submit these separately.
> 
> TBH I can only review this from coding and netlink perspective, and
> it looks solid. Folk who actually know PHYs and SFPs may have more
> meaningful feedback :(

How can we progress on this ?

Russell, have you been able to have a look at that latest version of the 
series ? I know you reviewed earlier versions already but I understand 
Jakub is willing some feedback from you.

Jakub, as you say it looks solid. I can add to that that I have been 
using this series widely through the double Ethernet attachment on 
several boards and it works well, it is stable and more performant than 
the dirty home-made solution we had on v4.14.

So it would be great if the series could be merged for v6.12, and I 
guess the earliest it is merged into net-next the more time it spends in 
linux-next before the merge window. Any chance to get it merged anytime 
soon even without a formal feedback from Russell ? We are really looking 
forward to getting that series merged and step forward with all the work 
that depends on it and is awaiting.

Thanks
Christophe

