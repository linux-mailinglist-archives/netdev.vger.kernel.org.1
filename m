Return-Path: <netdev+bounces-245608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDBCD366B
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 21:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812023010A83
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66C2D9492;
	Sat, 20 Dec 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ViUUPHAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4610221FD4;
	Sat, 20 Dec 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766260922; cv=none; b=aUkNUpp+MC/66mPB+xhICjJxXyYbyXyjbktWWoz4f0dF7NN/rWX2Ziz9UfXr3mrefQRJSzxWDQ5hmcsHTJfRMVJK5KkRe6rKoqYuo7pJvxeWdLYdSTmH8GJjWR0Xm5/xsZmPPaMP4wJHdT167eY3IE1rYCvEz4a3L4KNchktudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766260922; c=relaxed/simple;
	bh=5kKbeIpQYlC+J5pgo4UtcLaLbIqQ6oiKLd1tW6tRKnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKxDLCIFcOWRJE4zZkdBNa4tv32ngbyMF7f6JWY6FSZhRhx4+jLxfLOEa6kYGtH/OfXtyQHOQqMPjrIs4ZvrTIwhYF8fN+Y4I4Alm1ZJdwjQ5TVmZ7aIdmmMZW5YnFYbZQgJhOi8qn3U5vuKdcapjpwGX/1qbmcPHTLnFuyl8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ViUUPHAU; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id X387vKqIujSZXX387vYcny; Sat, 20 Dec 2025 21:00:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1766260847;
	bh=8Pk5490Lymfl43c8CVeM5uGSmRWzFQngTBtF9P11se8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ViUUPHAUgTrvDypEq1diTu3fKDVNIPu9pHxYm2o3HT2D1r+gF67siKsfquJlHN5B8
	 hjo0peu4o+C1FP9fzERzVzChbmpnYZjMZuUtv2MbnLqVTLaS7P2S2aQID5UYF2tugu
	 5ogfsxYwRmm7yIG8ixuqvzdfHN/OqOCw4j48jxvTtJruix5RC98zQwKgn8r6Gu+ZGf
	 kibyiV0xKodbWAkzIBVe4iYVQEsrFGa+WdPXyDBc46IQEpX+YbOUOzZiMQXEAvVpwt
	 Dasi5+Pqwoa39LFD9AKLFuoTBuo7BzXyVfLBpsss3DEeWE8hq/x0yfP3D8jUeyrhDx
	 8lEt53+2P8f/g==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Dec 2025 21:00:47 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <df7cc79c-0f46-4346-a016-1b208346bdf5@wanadoo.fr>
Date: Sat, 20 Dec 2025 21:00:42 +0100
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
References: <tencent_7C21405938B40C8251F2CFE0308CD7093908@qq.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <tencent_7C21405938B40C8251F2CFE0308CD7093908@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/12/2025 à 20:01, Jerry Wu a écrit :
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
>   		int num_active_ports = 0;
> +		struct net_device *bond;
>   		unsigned long bond_mask;
>   		u8 aggr_idx[16];
>   
> -		if (!bond || (visited & BIT(lag)))
> +		if (!ocelot_port || !ocelot_port->bond || (visited & BIT(lag)))

ok, but it would be clearer if this was a v3 of the patch.

It is also usually welcomed to explain what has changed between versions 
below the ---.

CJ

>   			continue;
>   
> +		bond = ocelot_port->bond;
>   		bond_mask = ocelot_get_bond_mask(ocelot, bond);
>   
>   		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {


