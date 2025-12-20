Return-Path: <netdev+bounces-245607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFDCD365E
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 20:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 267DF30080E8
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414B2F25F8;
	Sat, 20 Dec 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QMWzrV4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE341E230E;
	Sat, 20 Dec 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766260706; cv=none; b=IyvoItYO7+ynudM4TBOefMC5P0Y86p4FprLA1CzHWyVu1Nt8zfecHKJr3z2Mfr58+A0F9cGv7EWRkp0qndbknsXIfchqSNO07Z0aFA/0SDhTN3n8rYCePlaVr59BZcHBXKJkwVjUriiPcwaekOCn/alEs9676vsW2jka/NyR75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766260706; c=relaxed/simple;
	bh=wnoxMdahOiGvkt8X71n3cTuyUxRHttTa2qaleBNlJME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYDeoBnIDCrGPP/5QK7TYlDMihE+3kwsCeiCMOE16sQlJL4UqpG02B0bS3wf15669Mu45QTPjdu9DwByzQLp08TKZ6+J8osOh0MuMBgxQOfXF/cewBtAyx5Hd8Joo053exduRNqlXUshXdLxUIrGaREfF52veNaoITd+p+S2Jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QMWzrV4q; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id X35cvCbuuDhrpX35dvrLYx; Sat, 20 Dec 2025 20:58:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1766260692;
	bh=stnyRzQHlAv/TXZD0An+N21D90X52eRkeV04ajDvM9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QMWzrV4qsW9nMIkZwrs2KWfJD5x8sE+8WUUaMFodQopq1Rp2qMrmB3x3JqCiPQPrq
	 EkDHEvT7H1wHc3IFb+V2lcU1H8uubWh2IHuXwWAgRykLc+0xnT4Cx/FS4yDX0doH8Y
	 o7lPzEgDdo+7p36nXz05S/irfBlcd68it0PKCUDbZzni92Zc6wxROwq5MthF1eYiql
	 sa7CSEg2GvjswMBU9uAS0CxtkL5OU1yC+Z7nKmDF6Rzp+WhgIfkiCJRFf1RmXNbVnQ
	 vCItpM76F36v3o/GsEJXO5m7VgT4X8LhZd6iCaVgy88aa1jHhkETkLMU1dKW9hVDan
	 JmOg7Vf97sNiw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Dec 2025 20:58:12 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <4958770f-3e36-4d90-80ea-4bfca69bb61a@wanadoo.fr>
Date: Sat, 20 Dec 2025 20:58:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: mscc: ocelot: Fix crash when adding interface
 under a lag
To: Jerry Wu <w.7erry@foxmail.com>, vladimir.oltean@nxp.com
Cc: claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_03A0A4FC04B804E36C8245084CD6052D8406@qq.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <tencent_03A0A4FC04B804E36C8245084CD6052D8406@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/12/2025 à 19:56, Jerry Wu a écrit :
> Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
> fixed a similar issue in the lan966x driver caused by a NULL pointer dereference.
> The ocelot_set_aggr_pgids() function in the ocelot driver has similar logic
> and is susceptible to the same crash.
> 
> This issue specifically affects the ocelot_vsc7514.c frontend, which leaves
> unused ports as NULL pointers. The felix_vsc9959.c frontend is unaffected as
> it uses the DSA framework which registers all ports.
> 
> Fix this by checking if the port pointer is valid before accessing it.
> 
> Fixes: 528d3f190c98 ("net: mscc: ocelot: drop the use of the "lags" array")
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
> ---
>   drivers/net/ethernet/mscc/ocelot.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 08bee56aea35..6f917fd7af4d 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -2307,14 +2307,16 @@ static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
>   
>   	/* Now, set PGIDs for each active LAG */
>   	for (lag = 0; lag < ocelot->num_phys_ports; lag++) {
> -		struct net_device *bond = ocelot->ports[lag]->bond;
> +		struct ocelot_port *ocelot_port = ocelot->ports[lag];

Hi,

Does it compile?

Should this be struct ocelot_port *port = ocelot->ports[lag]; ?

CJ

>   		int num_active_ports = 0;
> +		struct net_device *bond;
>   		unsigned long bond_mask;
>   		u8 aggr_idx[16];
>   
> -		if (!bond || (visited & BIT(lag)))
> +		if (!port || !port->bond || (visited & BIT(lag)))
>   			continue;
>   
> +		bond = port->bond;
>   		bond_mask = ocelot_get_bond_mask(ocelot, bond);
>   
>   		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {


