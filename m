Return-Path: <netdev+bounces-122813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEE962A6B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8552821F7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C291A0AFE;
	Wed, 28 Aug 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RexoaOpi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526BB1A08B0
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855861; cv=none; b=vCYfNzADNIlSGZ+/10FDoNr2gTGsWqmmZEtXHDS0exZAqdsPOqxbrlKeeFS3MqNrS70cODwOWrf3LHZCrpkSQMintZBiCINFcMBZAR+9rWaON8lsNq1VdcBqGXpCbmVWdhPCCiKQvjldk6EwOCmP+wMyAhIrndG97KWAG4x/ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855861; c=relaxed/simple;
	bh=LfEypMyI2YOLOsHELLnwYyPfDOkZsw34uqKRseNBYmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHJqEA5U86CxbDMdo2B59Vqk333HVXQJtrIhi6ChTLxFGERiJlaIsNgStFhoEPRlKRoDy9g4lsc5wzlSJSbjiABusdbzyj21Nl6PkKv2WsVz7sLOx8LRWmk6U6sJuLOQKhSN422+Q7rz8JM9JD5OT5AcizexyRMUq/HbZRT7Pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RexoaOpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA7C4CEE3;
	Wed, 28 Aug 2024 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724855860;
	bh=LfEypMyI2YOLOsHELLnwYyPfDOkZsw34uqKRseNBYmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RexoaOpiYHN1vBH8QCVDTathYOsW3WRj/ClWJIk4sVZqV3W2rJwAB0Noga126XCKH
	 PQdvG/GFQusK4drE7/YI+T0lXWBIJb+JGKnqcDCTaEonAhNNyaNMXAxlD4usHDyzfa
	 4uu4MqJ51TRiX0UuSdvwcQg+qA6NXe0LNM0om1FyWfQJijxKSEk7SY3ysG3BCVJIFe
	 5dXbFrzimVRi/W3zkKRvVPPVh6P/A0Ei7LUw+YU2stmYiM3GUtI2zLRVSKgntUS5Yf
	 KLK+eUNYBvdrNvS0ePJjFF5RaAC/zMV3haaSJ9M5OTza2DqfZdAXxmf/xtC9iEAo/I
	 mzmRU+9kLachg==
Date: Wed, 28 Aug 2024 15:37:36 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add support to fetch group
 stats
Message-ID: <20240828143736.GH1368797@kernel.org>
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
 <20240827205904.1944066-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827205904.1944066-3-mohsin.bashr@gmail.com>

On Tue, Aug 27, 2024 at 01:59:04PM -0700, Mohsin Bashir wrote:
> Add support for group stats for mac. The fbnic_set_counter helps prevent
> overriding the default values for counters which are not collected by the device.
> 
> The 'reset' flag in 'get_eth_mac_stats' allows choosing between
> resetting the counter to recent most value or fecthing the aggregate

nit: fetching

> values of counters. This is important to cater for cases such as
> device reset.
> 
> The 'fbnic_stat_rd64' read 64b stats counters in a consistent fashion using
> high-low-high approach. This allows to isolate cases where counter is
> wrapped between the reads.
> 
> Command: ethtool -S eth0 --groups eth-mac
> Example Output:
> eth-mac-FramesTransmittedOK: 421644
> eth-mac-FramesReceivedOK: 3849708
> eth-mac-FrameCheckSequenceErrors: 0
> eth-mac-AlignmentErrors: 0
> eth-mac-OctetsTransmittedOK: 64799060
> eth-mac-FramesLostDueToIntMACXmitError: 0
> eth-mac-OctetsReceivedOK: 5134513531
> eth-mac-FramesLostDueToIntMACRcvError: 0
> eth-mac-MulticastFramesXmittedOK: 568
> eth-mac-BroadcastFramesXmittedOK: 454
> eth-mac-MulticastFramesReceivedOK: 276106
> eth-mac-BroadcastFramesReceivedOK: 26119
> eth-mac-FrameTooLongErrors: 0
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

...

