Return-Path: <netdev+bounces-178362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF8A76BF1
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923F6165F34
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270F82144D6;
	Mon, 31 Mar 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCTXOpW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B821422E
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438526; cv=none; b=W2VWXR5xVYoF+uAng++Fknb0oifRhgInMNyvActdCpg8yV7E32vVIE+1mvIBHIVpwGTJfNaFqoyddAcFIB3H+pxR4A6qP373q+eAq9CguoLHj4XHYOfKlphedna+jNoBDjMVjK7sBI21kd7h9i8cCSUnv6fADuM+JPKWMZRC3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438526; c=relaxed/simple;
	bh=1i742vZv2sx1qDfIbzIYvJDqm4EeP2nZrnt0i1dtyJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7V1Fhd0CGphm7BH3xugWyGVjZ6CCc73zITVNr52h+TrEYjp7jLO+31lNXWSUiKIIPOhl+MES3t4Wx7OcFF1Z20I2cqiwSNSFPsedo98xYJrNppx/cU75/5NNz6aRRkEkf6sbkShBNnyOeNvQUgvAKj1a5dHJCdGiSafroD26nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCTXOpW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1DAC4CEE3;
	Mon, 31 Mar 2025 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743438525;
	bh=1i742vZv2sx1qDfIbzIYvJDqm4EeP2nZrnt0i1dtyJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCTXOpW41tk5+HQg9zM/GOJ4MRzAwOUbGjv7gAuvkEWiF2F8+r0WQ/8fuxImUu76q
	 mJ0ZbVGvyQ9L9lvsXCIluqu+mBVb2UnG1d6hMbIKDJLkckGAc8NpuIPv/RpiViW7Bn
	 frBVBb1T74XS5WOLBJlvYThNk5HcU8yNyevmnwk1ZdxwqF9NGuWrQ1edN4BnKY+Kuy
	 bBwqF2Sa6K7+0esyTbw3OOIacNTrxsz34DaCbCZSuUOeoUmKYUjpQtAJBItAym2hx1
	 vFnwf6uF2YLXiHJUn2KFPa7CdyRESV7vTMjxFkS/fHu055h1njA8/NFny6cR6kgwC/
	 tuGSK4MIe7m2g==
Date: Mon, 31 Mar 2025 17:28:41 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <20250331162841.GD185681@horms.kernel.org>
References: <20250331-airoha-validate-egress-gdm-port-v3-1-c14e6ba9733a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-airoha-validate-egress-gdm-port-v3-1-c14e6ba9733a@kernel.org>

On Mon, Mar 31, 2025 at 12:14:09PM +0200, Lorenzo Bianconi wrote:
> Device pointer in airoha_ppe_foe_entry_prepare routine is not strictly
> necessary a device allocated by airoha_eth driver since it is an egress

nit: I think it would be clearer if "necessary" was dropped from the line
     above.

> device and the flowtable can contain even wlan, pppoe or vlan devices.
> E.g:
> 
> flowtable ft {
>         hook ingress priority filter
>         devices = { eth1, lan1, lan2, lan3, lan4, wlan0 }
>         flags offload                               ^
>                                                     |
>                      "not allocated by airoha_eth" --
> }
> 
> In this case airoha_get_dsa_port() will just return the original device
> pointer and we can't assume netdev priv pointer points to an
> airoha_gdm_port struct.
> Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> routine before accessing net_device priv pointer.
> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v3:
> - Rebase on top of net tree
> - Fix commit log
> - Link to v2: https://lore.kernel.org/r/20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org
> 
> Changes in v2:
> - Avoid checking netdev_priv pointer since it is always not NULL
> - Link to v1: https://lore.kernel.org/r/20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 13 +++++++++++++
>  drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
>  drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++++--
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index c0a642568ac115ea9df6fbaf7133627a4405a36c..bf9c882e9c8b087dbf5e907636547a0117d1b96a 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2454,6 +2454,19 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
>  	}
>  }
>  
> +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> +			     struct airoha_gdm_port *port)

nit: given the name of the function, perhaps returning a bool is more
     appropriate.

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		if (eth->ports[i] == port)
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +

...

