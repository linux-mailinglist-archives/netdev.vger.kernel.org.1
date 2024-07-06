Return-Path: <netdev+bounces-109624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6369B92938B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D41C20E65
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6A7D3E3;
	Sat,  6 Jul 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so7RMjU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BA8249F;
	Sat,  6 Jul 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720268881; cv=none; b=Ak9hjGTJpr0c2RBTTuZZiUaDKMSXYhry6C6MLpaCdU4GqE2ueyHorrYyCnFnZmpY5Gf1h29VRRdzCKpOr67whczZHg3EJM/28djh1lkCkSqzYgzh0rJUADK08UAB9fG0udhkkbByHChemE8D8bhzDbpxLFaGoaUHfnk4erxkYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720268881; c=relaxed/simple;
	bh=hsYaAdB5PnzdQQq7GR2Msbjo7dWt4Vmkj2ad3a4XiRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq0eU5He/PlSK/YWOGvoOcZtqi+W40wVvu7BkHKR3FrwFBqhMCTojIUp/1e/9ugKinobMBwMwnmRXFZ991YjBfxm6RwoBey9rXuMrj6dOeJWvKWl6zHEwd8LpdyDpcMoWGKPAe2PkX9W/aCPs0Huw1xgjZ7w70QclpuxUoFihbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so7RMjU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2598C2BD10;
	Sat,  6 Jul 2024 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720268880;
	bh=hsYaAdB5PnzdQQq7GR2Msbjo7dWt4Vmkj2ad3a4XiRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=so7RMjU3NsjXWp5FEx5op21IqqozTWuj8GJb0tp/8EVgD5xr0lWBNdKDZsFwr+soi
	 x1aQ0mxuv2cxkA5/E06e0v/jtQkHTBLo/K7RrGLNcOzJBRN4jG7dvHku5JJ4MXYfjf
	 pW1YBQBHGW9AWmBIdO3ffJ+MiF40O5kDTszdNKIVG0dyIWUu0oBmp7Hl6YG+k23kLZ
	 3Y4aU6X3cmrwp3AMIWFxbHOU+BqBaLsytQ3j0nJBqznlPAYx3dL4pcaakC4/ViDZvt
	 F+Na3T6qdMpLJGPj0kTJGx/qdJjumMdXKHSk8JiZ32Mt6N/BzVMuIpR/xetB6FhBXS
	 HWYX+FJwnfygw==
Date: Sat, 6 Jul 2024 13:27:54 +0100
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
Message-ID: <20240706122754.GD1481495@kernel.org>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <18e837f0f9377b68302d42ec9174473046a4a30a.1720079772.git.lorenzo@kernel.org>
 <20240705190644.GB1480790@kernel.org>
 <Zoj_1JWfd_3Yu71t@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoj_1JWfd_3Yu71t@lore-desk>

On Sat, Jul 06, 2024 at 10:27:00AM +0200, Lorenzo Bianconi wrote:
> > On Thu, Jul 04, 2024 at 10:08:11AM +0200, Lorenzo Bianconi wrote:
> > > Add airoha_eth driver in order to introduce ethernet support for
> > > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > > en7581-evb networking architecture is composed by airoha_eth as mac
> > > controller (cpu port) and a mt7530 dsa based switch.
> > > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > > functionalities are supported now) while QDMA is used for DMA operation
> > > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > > not available yet and it will be added in the future).
> > > Currently only hw lan features are available, hw wan will be added with
> > > subsequent patches.
> > > 
> > > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > ...
> > 
> > > +static const char * const airoha_ethtool_stats_name[] = {
> > > +	"tx_eth_pkt_cnt",
> > > +	"tx_eth_byte_cnt",
> > > +	"tx_ok_pkt_cnt",
> > > +	"tx_ok_byte_cnt",
> > > +	"tx_eth_drop_cnt",
> > > +	"tx_eth_bc_cnt",
> > > +	"tx_eth_mc_cnt",
> > > +	"tx_eth_lt64_cnt",
> > > +	"tx_eth_eq64_cnt",
> > > +	"tx_eth_65_127_cnt",
> > > +	"tx_eth_128_255_cnt",
> > > +	"tx_eth_256_511_cnt",
> > > +	"tx_eth_512_1023_cnt",
> > > +	"tx_eth_1024_1518_cnt",
> > > +	"tx_eth_gt1518_cnt",
> > > +	"rx_eth_pkt_cnt",
> > > +	"rx_eth_byte_cnt",
> > > +	"rx_ok_pkt_cnt",
> > > +	"rx_ok_byte_cnt",
> > > +	"rx_eth_drop_cnt",
> > > +	"rx_eth_bc_cnt",
> > > +	"rx_eth_mc_cnt",
> > > +	"rx_eth_crc_drop_cnt",
> > > +	"rx_eth_frag_cnt",
> > > +	"rx_eth_jabber_cnt",
> > > +	"rx_eth_lt64_cnt",
> > > +	"rx_eth_eq64_cnt",
> > > +	"rx_eth_65_127_cnt",
> > > +	"rx_eth_128_255_cnt",
> > > +	"rx_eth_256_511_cnt",
> > > +	"rx_eth_512_1023_cnt",
> > > +	"rx_eth_1024_1518_cnt",
> > > +	"rx_eth_gt1518_cnt",
> > > +};
> > 
> > Hi Lorenzo,
> > 
> > Sorry for not noticing this earlier.
> 
> Hi Simon,
> 
> no worries :)
> 
> > It seems to me that some of the stats above could
> > use standard stats, which is preferred.
> 
> Please correct me if I am wrong but it seems quite a common approach to have
> same stats in both .ndo_get_stats64() and .get_ethtool_stats():
> - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/mediatek/mtk_eth_soc.c#L212
> - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/marvell/mvneta.c#L435
> - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/intel/i40e/i40e_ethtool.c#L243
> - https://github.com/torvalds/linux/blob/master/net/mac80211/ethtool.c#L52
> - ...
> 
> Do you mean I should just report common stats (e.g. tx_packets or tx_bytes) in
> .ndo_get_stats64()? Or it is fine to just add .ndo_get_stats64() callback (not
> supported at the moment)?

The first option: It is my understanding that it preferred to only
report common stats via ndo_get_stats64.

  "Please limit stats you report in ethtool -S to just the stats for which
   proper interfaces don't exist. Don't duplicate what's already reported
   via rtase_get_stats64(), also take a look at what can be reported via
   various *_stats members of struct ethtool_ops."

   - Re: [PATCH net-next v18 10/13] rtase: Implement ethtool function
     by Jakub Kicinski
     https://lore.kernel.org/netdev/20240509204047.149e226e@kernel.org/

> > Basically, my understanding is that one should:
> > 1. Implement .ndo_get_stats64
> >    (that seems relevant here)
> > 2. As appropriate implement ethtool_stats non-extended stats operations
> >    (perhaps not relevant here)
> 
> Can you please provide me a pointer for it?

Sorry, that was not at all clear.
I meant, as per the quote above, *_stats members of struct ethtool_ops,
other than those that implement extended ops.
e.g. get_rmon_stats.

> 
> Regards,
> Lorenzo
> 
> > 3. Then implement get_ethtool_stats for what is left over
> > 
> > ...



