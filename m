Return-Path: <netdev+bounces-155415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C702A02486
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457F27A15AD
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7EC1DD529;
	Mon,  6 Jan 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzguXv6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676B1DC9B6
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164005; cv=none; b=qsKDJSq/qiqSYwqDuKJgVvo1MdSM9JhUp1ldI0hVxeLNW8i017Khx796i6wbaS3C91u37frvaucEutnUWkwaxFBZGghx/Pfxsn6Mhab/uHRLtlJ1s/YNMKgyno3vm5CPvNUDxgDT64v4xME8I58cb1+e6Gb6ArYt7aO/H+7o3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164005; c=relaxed/simple;
	bh=5ZSPwqoLzQxrvlYZ22fMOJZBbUCBFLwgI7F0pVMEugE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3PRX3bqXX695akKLTjii1mSZAQdqohnESjzyy7bq5cwh+1RsUyavRKhGU9uSobUlyw3Gl2zfTnT9vR7c8lxD5OyeWgV4dub3jlFOaKe9JFu80bykW7ekMZDVKEr6IGORqoXKV8GgHypkBi8P9199tz3GiczbEQovea3UGXMJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzguXv6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AC4C4CED2;
	Mon,  6 Jan 2025 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736164005;
	bh=5ZSPwqoLzQxrvlYZ22fMOJZBbUCBFLwgI7F0pVMEugE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzguXv6MyGcNriC4c7uI8/fljcWS14cKvGVSfQoHV5Vo1/ao5lHtLguur1fih2V4V
	 vPxeGrOdjZruVQofcIqCXS8r0DjcznKO0FU0UK+xDif47xRKn38aFLHI4GW0wZdAKA
	 lC+In8fkyH/AHip6CW9cnncC1fQkWOGzs2IpVCTRS0NLPhxSdghGuzbNSTnfrd/R9q
	 n4BCZ1hBbAjB1iYoLvt3yXapQXa+par8MirE8Vau/5XAjZFk1qFk87/eLY5/RyhmX5
	 8zv50TZFdAe/TiUbcU4zszZxzVhKDXRrFra8FW7B3Hx+DMRVbWseNnLJZG6Fo/FG3Y
	 iwLPXpLuR+dyQ==
Date: Mon, 6 Jan 2025 11:46:41 +0000
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	netdev@vger.kernel.org, Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>
Subject: Re: [PATCH iwl-next v6] ice: Add E830 checksum offload support
Message-ID: <20250106114641.GI4068@kernel.org>
References: <20241218091145.240373-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218091145.240373-1-paul.greenwalt@intel.com>

On Wed, Dec 18, 2024 at 04:11:45AM -0500, Paul Greenwalt wrote:
> E830 supports raw receive and generic transmit checksum offloads.
> 
> Raw receive checksum support is provided by hardware calculating the
> checksum over the whole packet, regardless of type. The calculated
> checksum is provided to driver in the Rx flex descriptor. Then the driver
> assigns the checksum to skb->csum and sets skb->ip_summed to
> CHECKSUM_COMPLETE.
> 
> Generic transmit checksum support is provided by hardware calculating the
> checksum given two offsets: the start offset to begin checksum calculation,
> and the offset to insert the calculated checksum in the packet. Support is
> advertised to the stack using NETIF_F_HW_CSUM feature.
> 
> E830 has the following limitations when both generic transmit checksum
> offload and TCP Segmentation Offload (TSO) are enabled:
> 
> 1. Inner packet header modification is not supported. This restriction
>    includes the inability to alter TCP flags, such as the push flag. As a
>    result, this limitation can impact the receiver's ability to coalesce
>    packets, potentially degrading network throughput.
> 2. The Maximum Segment Size (MSS) is limited to 1023 bytes, which prevents
>    support of Maximum Transmission Unit (MTU) greater than 1063 bytes.
> 
> Therefore NETIF_F_HW_CSUM and NETIF_F_ALL_TSO features are mutually
> exclusive. NETIF_F_HW_CSUM hardware feature support is indicated but is not
> enabled by default. Instead, IP checksums and NETIF_F_ALL_TSO are the
> defaults. Enforcement of mutual exclusivity of NETIF_F_HW_CSUM and
> NETIF_F_ALL_TSO is done in ice_set_features(). Mutual exclusivity
> of IP checksums and NETIF_F_HW_CSUM is handled by netdev_fix_features().
> 
> When NETIF_F_HW_CSUM is requested the provided skb->csum_start and
> skb->csum_offset are passed to hardware in the Tx context descriptor
> generic checksum (GCS) parameters. Hardware calculates the 1's complement
> from skb->csum_start to the end of the packet, and inserts the result in
> the packet at skb->csum_offset.
> 
> Co-developed-by: Alice Michael <alice.michael@intel.com>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Co-developed-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


