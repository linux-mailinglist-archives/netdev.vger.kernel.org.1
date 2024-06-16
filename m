Return-Path: <netdev+bounces-103830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE5909BF4
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 08:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2501F218EE
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E016DED1;
	Sun, 16 Jun 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="nPovZ99v"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787A16C864;
	Sun, 16 Jun 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718520607; cv=none; b=nIXfqbDHmpYrgaVq43ahMU3KZnoP19ojK4yyzhA6oFM/pEw+JOGATEfbHBsrO0SlEoM6cuF/gEOsZOG+sdNYl0mqfhJRSzTKWXV79z4U+xrbxdMdVyO/1hTvLO0XvPkNQQiOvREYlYcdwe5ys24trPWXkeE2UP+S2OZab1EaKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718520607; c=relaxed/simple;
	bh=zvYytH/tkPFqEpQ06iZFxiNfJaS+oXW2wNzfOOiScQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CY0XgQN+hpRio4X1trgFJ9o3e+vrnTqP1P2JsEZLDDvcQGNGC0zuivJrtNf3BrLNc2Zmjq0Sg0ka+USuVNn1Kq4W0pktqqKw58yCZiD5w8ur+dyvWD9ODMZGJPUt2XzRP1W1/nG2/ELz48Wrfu4ng9WA7hBErpvYvUL3vIncnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=nPovZ99v; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31BDC240003;
	Sun, 16 Jun 2024 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718520596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oepipccJ4+xfU5ZrXbRCGP8qtlNKoyECJMJmUGJDpJY=;
	b=nPovZ99vizahHrb9+csaQlYDereOrVESm1iKgeJv+z7U5QelYHYKWGbOhnECUgXNIbta+Y
	lYDd7pwaEHTudVGST8KuALea8IfEi4UF8pRHEzFLXReUBbZAMpkBtEbXCIS9xrZ+T6nnrG
	uqXjO+B3exmqcPQqMg6tNLKARyks0mfjcXpe+n3YZun2dhUNh4ct99MI/HcGBturj69PQ7
	fPx9XqL0AJlLya9RlPE5gkHgD+Xc0d7iU9Hp00eFQav8g1zk9lD9NaDzuV7FVWK77HjaBS
	AaZP6407I9ukj4gICe4YwX1jihFmZOAfhQxIpGMHo+wmWzMt7dqKms7yBcMA4A==
Message-ID: <a26d619c-fc63-4b2d-8313-210a37b1661a@arinc9.com>
Date: Sun, 16 Jun 2024 09:49:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: mt7530: factor out bridge
 join/leave logic
To: Matthias Schiffer <mschiffer@universe-factory.net>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 15/06/2024 01:21, Matthias Schiffer wrote:
> As preparation for implementing bridge port isolation, move the logic to
> add and remove bits in the port matrix into a new helper
> mt7530_update_port_member(), which is called from
> mt7530_port_bridge_join() and mt7530_port_bridge_leave().
> 
> No functional change intended.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>   drivers/net/dsa/mt7530.c | 103 +++++++++++++++++----------------------
>   1 file changed, 46 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 598434d8d6e4..ecacaefdd694 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1302,6 +1302,50 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>   		   FID_PST(FID_BRIDGED, stp_state));
>   }
>   
> +static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
> +				      const struct net_device *bridge_dev, bool join)
> +	__must_hold(&priv->reg_mutex)

Please run git clang-format on the patch.

> +{
> +	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
> +	struct mt7530_port *p = &priv->ports[port], *other_p;
> +	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	u32 port_bitmap = BIT(cpu_dp->index);
> +	int other_port;
> +
> +	dsa_switch_for_each_user_port(other_dp, priv->ds) {
> +		other_port = other_dp->index;
> +		other_p = &priv->ports[other_port];
> +
> +		if (dp == other_dp)
> +			continue;
> +
> +		/* Add/remove this port to/from the port matrix of the other
> +		 * ports in the same bridge. If the port is disabled, port
> +		 * matrix is kept and not being setup until the port becomes
> +		 * enabled.
> +		 */
> +		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))

Would be helpful to mention in the patch log that
dsa_port_offloads_bridge_dev() is now being used instead of
dsa_port_offloads_bridge().

> +			continue;
> +
> +		if (join) {
> +			other_p->pm |= PCR_MATRIX(BIT(port));
> +			port_bitmap |= BIT(other_port);
> +		} else {
> +			other_p->pm &= ~PCR_MATRIX(BIT(port));
> +		}
> +
> +		if (other_p->enable)
> +			mt7530_rmw(priv, MT7530_PCR_P(other_port),
> +				   PCR_MATRIX_MASK, other_p->pm);
> +	}
> +
> +	/* Add/remove the all other ports to this port matrix. */

I would add to this comment: When removing, only the CPU port will remain
in the port matrix of this port.

To not omit the original comment:

	/* Set the cpu port to be the only one in the port matrix of
	 * this port.
	 */

> +	p->pm = PCR_MATRIX(port_bitmap);
> +	if (priv->ports[port].enable)
> +		mt7530_rmw(priv, MT7530_PCR_P(port),
> +			   PCR_MATRIX_MASK, p->pm);

I see changes to have the code streamlined. Overall, I would appreciate a
more verbose patch log.

Arınç

