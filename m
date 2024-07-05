Return-Path: <netdev+bounces-109563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50B928DB1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612CB1C22347
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213016C87B;
	Fri,  5 Jul 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDvWHpRw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3B132123;
	Fri,  5 Jul 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720206411; cv=none; b=uH01wO0rqoT1k5WVxbUlBydBpyPuk0lXlfSL7Muxkf9fJD/Y87CsVKTygSQWB4vqP5YCCYp6FxsOrbzvlOFmcu7tt+zLrqYgWQkKtfoAoGpudVlQu/gokdnWFFROKSADuJHWi1Y2jCEnxz4N8aisY/EW6GQ3aSLNso0z8PVTBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720206411; c=relaxed/simple;
	bh=j4MuF92z2EKiY/5L3DApQW0zmVLPdA45D4u81qgwpWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0YLwa6GAl9WKy6uUa06t5U6Z5U2fC8C/STAUMdNns/41VhjzgVJ85c8pRX2zTXP+90crAGEbeQJBx9uI4PybLcVOHJm4Sqbusn7Il96HNvcVa2vT5pSv1NsRp05yxAxOSCa/kmDbIHAHB9iexeHF33pNurTN1xn6YffetpcBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDvWHpRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD784C116B1;
	Fri,  5 Jul 2024 19:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720206411;
	bh=j4MuF92z2EKiY/5L3DApQW0zmVLPdA45D4u81qgwpWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDvWHpRw/lmPxOGy4hO9IQckVgCvC+okPPJwvp9vG2ReHcDE4a6tQ8GYV/gNaAofE
	 K1dHeJwjGPjtLtdKwJOfKVzv7NHqtPsPVPxUzZysovrpz5iY8q+rRhWBIg8XpCtAig
	 FTo0qy+gNIUHTNZSAv9LGVH7xCadznpA8LtHsicoDtO37GaLIwhC8ZQV7rboD11r2r
	 tZwBe48M0fMYDVLAqbcISE4qKtZoZ6MFfP7bJA9beaPa4NxULuZ7YuRUiWsL7WwRF6
	 ZuZ2NREAg3Xtn8RK/BwvdwBbn6ZtyscQvTjRo7oLwVBKYY6/nJwah/opr8KkFmjcIq
	 1W3fV+n3QdgBw==
Date: Fri, 5 Jul 2024 20:06:44 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v5 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <20240705190644.GB1480790@kernel.org>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <18e837f0f9377b68302d42ec9174473046a4a30a.1720079772.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e837f0f9377b68302d42ec9174473046a4a30a.1720079772.git.lorenzo@kernel.org>

On Thu, Jul 04, 2024 at 10:08:11AM +0200, Lorenzo Bianconi wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> en7581-evb networking architecture is composed by airoha_eth as mac
> controller (cpu port) and a mt7530 dsa based switch.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> +static const char * const airoha_ethtool_stats_name[] = {
> +	"tx_eth_pkt_cnt",
> +	"tx_eth_byte_cnt",
> +	"tx_ok_pkt_cnt",
> +	"tx_ok_byte_cnt",
> +	"tx_eth_drop_cnt",
> +	"tx_eth_bc_cnt",
> +	"tx_eth_mc_cnt",
> +	"tx_eth_lt64_cnt",
> +	"tx_eth_eq64_cnt",
> +	"tx_eth_65_127_cnt",
> +	"tx_eth_128_255_cnt",
> +	"tx_eth_256_511_cnt",
> +	"tx_eth_512_1023_cnt",
> +	"tx_eth_1024_1518_cnt",
> +	"tx_eth_gt1518_cnt",
> +	"rx_eth_pkt_cnt",
> +	"rx_eth_byte_cnt",
> +	"rx_ok_pkt_cnt",
> +	"rx_ok_byte_cnt",
> +	"rx_eth_drop_cnt",
> +	"rx_eth_bc_cnt",
> +	"rx_eth_mc_cnt",
> +	"rx_eth_crc_drop_cnt",
> +	"rx_eth_frag_cnt",
> +	"rx_eth_jabber_cnt",
> +	"rx_eth_lt64_cnt",
> +	"rx_eth_eq64_cnt",
> +	"rx_eth_65_127_cnt",
> +	"rx_eth_128_255_cnt",
> +	"rx_eth_256_511_cnt",
> +	"rx_eth_512_1023_cnt",
> +	"rx_eth_1024_1518_cnt",
> +	"rx_eth_gt1518_cnt",
> +};

Hi Lorenzo,

Sorry for not noticing this earlier.
It seems to me that some of the stats above could
use standard stats, which is preferred.

Basically, my understanding is that one should:
1. Implement .ndo_get_stats64
   (that seems relevant here)
2. As appropriate implement ethtool_stats non-extended stats operations
   (perhaps not relevant here)
3. Then implement get_ethtool_stats for what is left over

...

