Return-Path: <netdev+bounces-143171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D89C1518
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B453B285D66
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182341946DF;
	Fri,  8 Nov 2024 04:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alwh7b0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09473BBEA;
	Fri,  8 Nov 2024 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038982; cv=none; b=n8Pptf+SisX0UYztuHrBtEoLQhrAVM6b1rj9tsAtAngsGtpo4gK1FIl9r1doUFh2eTRRVp/F/17tkCSO1oVRSTUYZi+IgbgbLO2B6xXpOfiOzkaAp+mfe+H+6t/0ixv30+o7iWgtduti3EeTg4e3HexofCABgViqYiO9SYHVy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038982; c=relaxed/simple;
	bh=yf7JU5fBLWjEU8ccpkE6YuYyOOgPIIIfzkIiBJH0mFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktJaHJHvMlPFsgOZEvMxg/HwbX3yayGE61AA0L5WhCO6refcX36KvFXON+nNgYRKgSNSbhqozhwVYNKuDsmH2lbSQzcIT5hON4TGgFLFLDuRJJUwUs5j2iYs1SeFcpomDvuCqyTYyjK8qOYWRORQ2i58Tj/uNPf387tzFSktPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alwh7b0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB7C4CECE;
	Fri,  8 Nov 2024 04:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731038981;
	bh=yf7JU5fBLWjEU8ccpkE6YuYyOOgPIIIfzkIiBJH0mFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=alwh7b0ZScHo44wGMYroZHNE/e0P7HNpp+fW0hjPjJA1AuvNlvMZnp28h2wJ8+MsA
	 V+OBIjhlG50H0VCQLyUDaqT+BtmoFS8o6paG3PKvuB8b/o9c11NSo70V0vvQiSYOfj
	 CuLiEJBLOHXmD12jDbZ6Y1pgRo+NHgEC8K/BW4ESCVcvCNJSBfldK6TSKNb8QGYZRt
	 VJAdsCnNBpsmwp56CBycX4m8F+97/cAKiGfysQ0/ptAGYuqvbN0WcLmA3hQtBf5VNJ
	 s0L7gchBPLlzo7pjirOXUh8ZwdLK2+pvxqUPQIhfqOYNGbQsq53a2ct4EnYmhmu4K3
	 qbHxTi7no+yxQ==
Date: Thu, 7 Nov 2024 20:09:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net-next v2] net: dlink: add support for reporting stats
 via `ethtool -S`
Message-ID: <20241107200940.4dff026d@kernel.org>
In-Reply-To: <20241107151929.37147-5-yyyynoom@gmail.com>
References: <20241107151929.37147-5-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 00:19:33 +0900 Moon Yeounsu wrote:
> +}, mac_stats[] = {
> +	DEFINE_MAC_STATS(tx_packets, FramesXmtOk,
> +			 u32, FramesTransmittedOK),
> +	DEFINE_MAC_STATS(rx_packets, FramesRcvOk,
> +			 u32, FramesReceivedOK),
> +	DEFINE_MAC_STATS(tx_bytes, OctetXmtOk,
> +			 u32, OctetsTransmittedOK),
> +	DEFINE_MAC_STATS(rx_bytes, OctetRcvOk,
> +			 u32, OctetsReceivedOK),
> +	DEFINE_MAC_STATS(single_collisions, SingleColFrames,
> +			 u32, SingleCollisionFrames),
> +	DEFINE_MAC_STATS(multi_collisions, MultiColFrames,
> +			 u32, MultipleCollisionFrames),
> +	DEFINE_MAC_STATS(late_collisions, LateCollisions,
> +			 u32, LateCollisions),
> +	DEFINE_MAC_STATS(rx_frames_too_long_errors, FrameTooLongErrors,
> +			 u16, FrameTooLongErrors),
> +	DEFINE_MAC_STATS(rx_in_range_length_errors, InRangeLengthErrors,
> +			 u16, InRangeLengthErrors),
> +	DEFINE_MAC_STATS(rx_frames_check_seq_errors, FramesCheckSeqErrors,
> +			 u16, FrameCheckSequenceErrors),
> +	DEFINE_MAC_STATS(rx_frames_lost_errors, FramesLostRxErrors,
> +			 u16, FramesLostDueToIntMACRcvError),
> +	DEFINE_MAC_STATS(tx_frames_abort, FramesAbortXSColls,
> +			 u16, FramesAbortedDueToXSColls),
> +	DEFINE_MAC_STATS(tx_carrier_sense_errors, CarrierSenseErrors,
> +			 u16, CarrierSenseErrors),
> +	DEFINE_MAC_STATS(tx_multicast_frames, McstFramesXmtdOk,
> +			 u32, MulticastFramesXmittedOK),
> +	DEFINE_MAC_STATS(rx_multicast_frames, McstFramesRcvdOk,
> +			 u32, MulticastFramesReceivedOK),
> +	DEFINE_MAC_STATS(tx_broadcast_frames, BcstFramesXmtdOk,
> +			 u16, BroadcastFramesXmittedOK),
> +	DEFINE_MAC_STATS(rx_broadcast_frames, BcstFramesRcvdOk,
> +			 u16, BroadcastFramesReceivedOK),
> +	DEFINE_MAC_STATS(tx_frames_deferred, FramesWDeferredXmt,
> +			 u32, FramesWithDeferredXmissions),
> +	DEFINE_MAC_STATS(tx_frames_excessive_deferral, FramesWEXDeferal,
> +			 u16, FramesWithExcessiveDeferral),
> +}, rmon_stats[] = {
> +	DEFINE_RMON_STATS(rmon_under_size_packets,
> +			  EtherStatsUndersizePkts, undersize_pkts),
> +	DEFINE_RMON_STATS(rmon_fragments,
> +			  EtherStatsFragments, fragments),
> +	DEFINE_RMON_STATS(rmon_jabbers,
> +			  EtherStatsJabbers, jabbers),
> +	DEFINE_RMON_STATS(rmon_tx_byte_64,
> +			  EtherStatsPkts64OctetTransmit, hist_tx[0]),
> +	DEFINE_RMON_STATS(rmon_rx_byte_64,
> +			  EtherStats64Octets, hist[0]),
> +	DEFINE_RMON_STATS(rmon_tx_byte_65to127,
> +			  EtherStats65to127OctetsTransmit, hist_tx[1]),
> +	DEFINE_RMON_STATS(rmon_rx_byte_64to127,
> +			  EtherStatsPkts65to127Octets, hist[1]),
> +	DEFINE_RMON_STATS(rmon_tx_byte_128to255,
> +			  EtherStatsPkts128to255OctetsTransmit, hist_tx[2]),
> +	DEFINE_RMON_STATS(rmon_rx_byte_128to255,
> +			  EtherStatsPkts128to255Octets, hist[2]),
> +	DEFINE_RMON_STATS(rmon_tx_byte_256to511,
> +			  EtherStatsPkts256to511OctetsTransmit, hist_tx[3]),
> +	DEFINE_RMON_STATS(rmon_rx_byte_256to511,
> +			  EtherStatsPkts256to511Octets, hist[3]),
> +	DEFINE_RMON_STATS(rmon_tx_byte_512to1023,
> +			  EtherStatsPkts512to1023OctetsTransmit, hist_tx[4]),
> +	DEFINE_RMON_STATS(rmon_rx_byte_512to1203,
> +			  EtherStatsPkts512to1023Octets, hist[4]),
> +	DEFINE_RMON_STATS(rmon_tx_byte_1204to1518,
> +			  EtherStatsPkts1024to1518OctetsTransmit, hist_tx[5]),
> +	DEFINE_RMON_STATS(rmon_rx_byte_1204to1518,
> +			  EtherStatsPkts1024to1518Octets, hist[5])
> +};

Do these macro wrappers really buy you anything?
They make the code a lot harder to follow :(

> +static void get_ethtool_mac_stats(struct net_device *dev,
> +				  struct ethtool_eth_mac_stats *mac_base)
> +{
> +	struct netdev_private *np = netdev_priv(dev);
> +
> +	get_stats(dev);
> +
> +	if (mac_base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	for (int i = 0; i < MAC_STATS_SIZE; i++)
> +		READ_DATA(mac_stats, mac_base, i) = READ_STAT(mac_stats, np, i);
> +}
> +
> +

nit: multiple empty lines, checkpatch --strict should catch this

> +static void get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		for (int i = 0; i < STATS_SIZE; i++) {
> +			memcpy(data, stats[i].string, ETH_GSTRING_LEN);
> +			data += ETH_GSTRING_LEN;

We've been getting conversion patches replacing such code with
ethtool_puts() lately, let's use it from the start.
-- 
pw-bot: cr

