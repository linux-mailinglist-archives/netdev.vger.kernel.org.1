Return-Path: <netdev+bounces-103831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B6909BF6
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 08:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D6E1C20BE2
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9B16D33B;
	Sun, 16 Jun 2024 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="URJDSw0R"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22016C6B9;
	Sun, 16 Jun 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718520739; cv=none; b=LqCJiYAXTCssuRnQVNYaXRSDcYHRwtxgAzKaYva78WPeo1cfOrUOZug2dwNU0Mx3Wvxk2VSV0WtnFZWih9O0cXA0l8lZPaAjQ8/bTUOkBgG6W4csn7HhDJaJyM6s2w8ysFtnARPr4NGj1PBHPPPB4ODX1Am2/ySp5R1MAwBjC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718520739; c=relaxed/simple;
	bh=zS4o3OQMs27DD48GGi2eICvp90N88lJ+aBAPOVqrmwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2pgnhdoeST01H7Ta6DzSXioEKzsQuLV3IYB6QKpExpUvxuDJJmjB+wDtCmkgxij60/78X2M3ciqyR0A0I0PT+RpcVb6Z9s6H5CDuRRqstUii2xDOKvv4rDp/hXiHHfUgqgCOPofdZbaulAq3aR8vHbyQ/Cjnu2E5MNKJo9bzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=URJDSw0R; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97DDD60002;
	Sun, 16 Jun 2024 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718520728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0NRmtqRvui5lSo5ejnM/TPk8rKVveCep0FEncp4fz4=;
	b=URJDSw0ROWgdxLyQtqGmBp3FXbS76oXFWhc0w52aDEtrc/HKQglNGK6LONCjXGd714mjG6
	XqAiiFe883IQS2HqxURq/0PjL6JqX18nnNA4tE27d+VGRJU3O/Io89dpgOqMNN8SN+Klmj
	1nQPJV3jeC6e87iaEotBC2U6CJ6f/qXYUddXHpIQ73ND/MUDgq1bTd9xs7SFpdKujb88jr
	R3wbbAlKdRxKqouXDqWp7NATeHngafn4eF71LQFNqbBNDzsdHkZuL333NbLqWdrPhsRx2m
	S8UsuSLVXZTbqalksayOP9CG6ADxKReCk6iJhRVgXgbcHEBmDGYVftrQzk4nYg==
Message-ID: <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
Date: Sun, 16 Jun 2024 09:52:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
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
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 15/06/2024 01:21, Matthias Schiffer wrote:
> Remove a pair of ports from the port matrix when both ports have the
> isolated flag set.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>   drivers/net/dsa/mt7530.c | 21 ++++++++++++++++++---
>   drivers/net/dsa/mt7530.h |  1 +
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index ecacaefdd694..44939379aba8 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1303,7 +1303,8 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>   }
>   
>   static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
> -				      const struct net_device *bridge_dev, bool join)
> +				      const struct net_device *bridge_dev,
> +				      bool join)

Run git clang-format on this patch as well please.

>   	__must_hold(&priv->reg_mutex)
>   {
>   	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
> @@ -1311,6 +1312,7 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>   	struct dsa_port *cpu_dp = dp->cpu_dp;
>   	u32 port_bitmap = BIT(cpu_dp->index);
>   	int other_port;
> +	bool isolated;
>   
>   	dsa_switch_for_each_user_port(other_dp, priv->ds) {
>   		other_port = other_dp->index;
> @@ -1327,7 +1329,9 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>   		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
>   			continue;
>   
> -		if (join) {
> +		isolated = p->isolated && other_p->isolated;
> +
> +		if (join && !isolated) {
>   			other_p->pm |= PCR_MATRIX(BIT(port));
>   			port_bitmap |= BIT(other_port);
>   		} else {

Why must other_p->isolated be true as well? If I understand correctly, when
a user port is isolated, non isolated ports can't communicate with it
whilst the CPU port can. If I were to isolate a port which is the only
isolated one at the moment, the isolated flag would not be true. Therefore,
the isolated port would not be removed from the port matrix of other user
ports. Why not only check for p->isolated?

Arınç

