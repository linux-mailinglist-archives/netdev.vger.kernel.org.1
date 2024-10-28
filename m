Return-Path: <netdev+bounces-139561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28839B311C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E8B20F97
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392601D9320;
	Mon, 28 Oct 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BiDCCJxy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B549143888;
	Mon, 28 Oct 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120206; cv=none; b=Od8F79FMIDCRKVkXxyzwigYaY2BUymJSxtnGoJ27dydJ3EoI0Gm+SoZ2WDOPQ/j0c87qt3yasm1gyiDC+eEdrytiUT20ZNe13EhuqSbOv850nLBBVhXikYLpF1s56cwiUHkXx1XK91Cf/8525TUYR3DyXplQNtk8IQhOEla8uhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120206; c=relaxed/simple;
	bh=kMr7GkU4v/EaA4aAW3icfnmDITpSe81u1ha8Yh+/ApY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLgCjJEw1K8c604MBgKx46CCrVrLxXvJCwfeThkp/du+isrZGwqz6F/CN3inhP8Fi2eZePN53QTjHOCdEdxhUOaqd3KudKCNMuIJyOcZLHm1z4JkdOEKYYuBvKecqW/Qp50pYFv4/cmngzGW4GwbWmdbSNcs0z6ynXeZH5V0fYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BiDCCJxy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mUoFKcSg2a6DsNvLf7qyuJ/R2E3VW/b3MDhNPevm1bw=; b=BiDCCJxyiu+46J60BTe8IIX1AA
	MErDcXWuNw5wPxrnpWCs25FqB/oUHWneHSHopG6eD80v2LNufl3hivh+Bvp6W5muJs+k8Epyoo/01
	KpjIzqTFS7wjdzumiNXJ2KHU0woHRiL0OivQ/uHNoxq4+gtt/EEXNtfMglSltdjhwylo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5PIT-00BRl3-8E; Mon, 28 Oct 2024 13:56:37 +0100
Date: Mon, 28 Oct 2024 13:56:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: add get_ethtool_stats in ethtool
Message-ID: <2502f12c-54ad-4c47-b9ef-6e5985903c1e@lunn.ch>
References: <20241026192651.22169-3-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026192651.22169-3-yyyynoom@gmail.com>

On Sun, Oct 27, 2024 at 04:26:53AM +0900, Moon Yeounsu wrote:
> This patch implement `get_ethtool_stats` to support `ethtool -S`.
> 
> Before applying the patch:
> $ ethtool -S enp36s0
> > no stats available
> 
> After applying the patch:
> $ ethtool -S enp36s0
> > NIC statistics:
> 	tx_jumbo_frames: 0
> 	rx_jumbo_frames: 0
> 	tcp_checksum_errors: 0
> 	udp_checksum_errors: 0
> 	ip_checksum_errors: 0
> 	tx_packets: 0
> 	rx_packets: 74
> 	tx_bytes: 0
> 	rx_bytes: 14212
> 	single_collisions: 0
> 	multi_collisions: 0
> 	late_collisions: 0
> 	rx_frames_too_long_errors: 0
> 	rx_in_range_length_errors: 776
> 	rx_frames_check_seq_errors: 0
> 	rx_frames_lost_errors: 0
> 	tx_frames_abort: 0
> 	tx_carrier_sense_errors: 0
> 	tx_multicast_bytes: 0
> 	rx_multicast_bytes: 360
> 	tx_multicast_frames: 0
> 	rx_multicast_frames: 6
> 	tx_broadcast_frames: 0
> 	rx_broadcast_frames: 68
> 	tx_mac_control_frames: 0
> 	rx_mac_control_frames: 0
> 	tx_frames_deferred: 0
> 	tx_frames_excessive_deferral: 0
> 
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 229 ++++++++++++++++++------------

We can see there is a lot of code being deleted here, yet you are
adding support for stats. It would be good to explain in the commit
message what is really happening here.

> +	DEFINE_STATS(rmon_collisions, EtherStatsCollisions, u32),
> +	DEFINE_STATS(rmon_crc_align_errors, EtherStatsCRCAlignErrors, u32),
> +	DEFINE_STATS(rmon_under_size_packets, EtherStatsUndersizePkts, u32),
> +	DEFINE_STATS(rmon_fragments, EtherStatsFragments, u32),
> +	DEFINE_STATS(rmon_jabbers, EtherStatsJabbers, u32),

Please report the standard RMON statistics via ethtool_rmon_stats. The
unstructured ethtool -S without groups should be used for statistics
which do not fit any of the well defined groups.

    Andrew

---
pw-bot: cr

