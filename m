Return-Path: <netdev+bounces-213415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F13B24E46
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2730B62994
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6178028A701;
	Wed, 13 Aug 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="QDym78Rx"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F2266B64;
	Wed, 13 Aug 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099968; cv=none; b=c9q/wekY++4qIeWf2ryOfSuc4oA9AXeSSHfO1RU4di2Vev5jwNejTNdLYlwdqkvAnAsAAaeP/Tmey1ptHY99kCUixKssE7MlNEnsrIec4QDSQu15eaG4Zt4lF9Opg/cbYrUg/bM+0ZcjYduLbcEQj3WW8wQvQKr4aISjo5bS2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099968; c=relaxed/simple;
	bh=RCmAwDxNt1PIR7OpoBOFNGkPBIbB4x3yJFeHpEVtMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMHfNFPTLbl0aMFuH5wjchx32hnMIlvVSNg1SXQItSezrV1ecivohwMgRPbYCxeMJkEiPO+StU2OiMHd/IxKNpormW6glVReOTYGesxwIFh+iQEVVCl/W0p+Z3sOWgswRMus6KUA67CaiixfAj/y+C2V8xD6SfI21EYpDN15lBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=QDym78Rx; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 313A11048D3;
	Wed, 13 Aug 2025 17:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1755099961;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fwnnh6NScMg7DN+lhTiCoztNmrprowcLnPlrvfBvqDo=;
	b=QDym78Rx3XHd6DNtvD4N7rbni95Y/2Bz5SaZFAgM99fOzsGSL3IttortGPIignNU2DnIL3
	zqn814Zh8lahzT0O9vTimuVUo41ubDdCJp9xQNnszsC99rLTGwkK30RC8AcX3SOA8/n9ey
	kYDDE5yT6ohNnvfNAIm5/rvTeJ4TPGn8hORi/BzztF74X+I9Nqw3zdTuP8quNsw3LtMi4A
	q7v0znRjfTHPt6b6Bd0ywqjbwfy1q9jm0wBF2+PPGbvWWXaoGqBcc73yQzy0ixrh7SJ4Ib
	8FUtu3xyezjX8DmTxcbmduPiwJXnLzlaMCRjXhbvOx6R3PkloO+ECfk4ztS2Hg==
Date: Wed, 13 Aug 2025 17:45:53 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jesse Van Gavere <jesseevg@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Pieter Van Trappen
 <pieter.van.trappen@cern.ch>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Simon Horman <horms@kernel.org>, Tristram Ha
 <tristram.ha@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
Message-ID: <20250813174553.5c2cdeb3@wsk>
In-Reply-To: <20250813152615.856532-1-frieder@fris.de>
References: <20250813152615.856532-1-frieder@fris.de>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Frieder,

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
> HSR ports. This is set up when creating the HSR interface via
> ksz9477_hsr_join() and ksz9477_cfg_port_member().
> 
> At the same time ksz_update_port_member() is called on every
> state change of a port and reconfiguring the forwarding to the
> default state which means packets get only forwarded to the CPU
> port.
> 
> If the ports are brought up before setting up the HSR interface
> and then the port state is not changed afterwards, everything works
> as intended:
> 
>   ip link set lan1 up
>   ip link set lan2 up
>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
> 45 version 1 ip addr add dev hsr 10.0.0.10/24
>   ip link set hsr up
> 
> If the port state is changed after creating the HSR interface, this
> results in a non-working HSR setup:
> 
>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
> 45 version 1 ip addr add dev hsr 10.0.0.10/24
>   ip link set lan1 up
>   ip link set lan2 up
>   ip link set hsr up
> 
> In this state, packets will not get forwarded between the HSR ports
> and communication between HSR nodes that are not direct neighbours in
> the topology fails.
> 
> To avoid this, we prevent all forwarding reconfiguration requests for
> ports that are part of a HSR setup with NETIF_F_HW_HSR_FWD enabled.
> 
> Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for
> KSZ9477") Signed-off-by: Frieder Schrempf
> <frieder.schrempf@kontron.de> ---
> I'm posting this as RFC as my knowledge of the driver and the stack in
> general is very limited. Please review thoroughly and provide
> feedback. Thanks!

I don't have the HW at hand at the moment (temporary).

Could you check if this patch works when you create two hsr interfaces
- i.e. hsr1 would use HW offloading from KSZ9744 and hsr2 is just the
  one supporting HSR in software.

> ---
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 11 +++++++++++
>  include/net/dsa.h                      | 12 ++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c index
> 7c142c17b3f69..56370ecdfe4ee 100644 ---
> a/drivers/net/dsa/microchip/ksz_common.c +++
> b/drivers/net/dsa/microchip/ksz_common.c @@ -2286,6 +2286,17 @@
> static void ksz_update_port_member(struct ksz_device *dev, int port)
> return; 
>  	dp = dsa_to_port(ds, port);
> +
> +	/*
> +	 * HSR ports might use forwarding configured during setup.
> Prevent any
> +	 * modifications as long as the port is part of a HSR setup
> with
> +	 * NETIF_F_HW_HSR_FWD enabled.
> +	 */
> +	if (dev->hsr_dev && dp->user &&
> +	    (dp->user->features & NETIF_F_HW_HSR_FWD) &&
> +	    dsa_is_hsr_port(ds, dev->hsr_dev, port))
> +		return;
> +
>  	cpu_port = BIT(dsa_upstream_port(ds, port));
>  
>  	for (i = 0; i < ds->num_ports; i++) {
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 55e2d97f247eb..846a2cc2f2fc3 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -565,6 +565,18 @@ static inline bool dsa_is_user_port(struct
> dsa_switch *ds, int p) return dsa_to_port(ds, p)->type ==
> DSA_PORT_TYPE_USER; }
>  
> +static inline bool dsa_is_hsr_port(struct dsa_switch *ds, struct
> net_device *hsr, int p) +{
> +	struct dsa_port *hsr_dp;
> +
> +	dsa_hsr_foreach_port(hsr_dp, ds, hsr) {
> +		if (hsr_dp->index == p)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

I thought that we already had such function implemented. Apparently I
must have been wrong.

>  #define dsa_tree_for_each_user_port(_dp, _dst) \
>  	list_for_each_entry((_dp), &(_dst)->ports, list) \
>  		if (dsa_port_is_user((_dp)))



-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic

