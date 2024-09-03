Return-Path: <netdev+bounces-124534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A82969E5E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E861C23812
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48A1CA6B3;
	Tue,  3 Sep 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdC2qd2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B391CA687
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367926; cv=none; b=bwa/XUMIrTyXk02bAj9an4v8t71GdL1zQ8jOVMtpJQ7RNqajtVegSErg/BQhE7/4SpXwRZ52BYspd8OEV8J9aqNLWLhMPk4f2+lVkn8pLVZ5nqlYEBci1xmfzr3rCniEYxO0gecmE1Irlwje2k3SuHldDlm3PVsN3GqCOLL6PNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367926; c=relaxed/simple;
	bh=oFipX6t3zWJWuLzg3PJTL0agvfjcyRCHaG1+kzIXap4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDTvSM8bzlUYy/nVZ40KOt/I0T2I0doDTMi93Qh2nVF27DbB2D8xkghnYns6boBZdf39vIDKyiYPWG3Q+UGhScortJlj3sRahJWtAbKPD7xepO5DLYYjvMoTE026q9865w8WVKK5gvMuBOZTAnjg2MU9c+77gH5H3vYnxSODwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdC2qd2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96179C4CEC4;
	Tue,  3 Sep 2024 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725367926;
	bh=oFipX6t3zWJWuLzg3PJTL0agvfjcyRCHaG1+kzIXap4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdC2qd2V5ebPBIoRxhz1AiY1JLMLg0GX5oyfzuSF9cLbOTQQ6cOktKk14wz5VOJ5F
	 8UbUlF/0+1W7tFbjqU3jArxLvrJPh14xn73CzC4TplZxFJlM6BAtkH3J9woKo97OHL
	 YQv8+B7GLVPZFENfn+PiG79WB1vKLWWtc1e7PusGtFxo3KJVpvrpHfhSp+dPy/nNFe
	 SniYAjcFfU9qbjVtVzBatxZw+uheUM3kOKFO9JSNoiB7PhoakL2yfmF30AeiiT61Wv
	 CVA+OmUjJkUDgFgThWlc3Z05KN/0EF+gvPjcH7YwElqtxmOiGCi8bhCUNQLPW1JjvK
	 Ui0HFYnTQfjvg==
Date: Tue, 3 Sep 2024 13:52:01 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, jdamato@fastly.com
Subject: Re: [PATCH net-next v3 2/2] eth: fbnic: Add support to fetch group
 stats
Message-ID: <20240903125201.GA1833@kernel.org>
References: <20240902173907.925023-1-mohsin.bashr@gmail.com>
 <20240902173907.925023-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902173907.925023-3-mohsin.bashr@gmail.com>

On Mon, Sep 02, 2024 at 10:39:07AM -0700, Mohsin Bashir wrote:
> Add support for group stats for mac. The fbnic_set_counter help preserve
> the default values for counters which are not touched by the driver.
> 
> The 'reset' flag in 'get_eth_mac_stats' allows to choose between
> resetting the counter to recent most value or fetching the aggregated
> values of the counter.
> 
> The 'fbnic_stat_rd64' read 64b stats counters in an atomic fashion using
> read-read-read approach. This allows to isolate cases where counter is
> moving too fast making accuracy of the counter questionable.
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
> ---
> V3: Fix nit

It might have been better to mention what the nit was (spelling).

> 
> V2: https://lore.kernel.org/netdev/20240827205904.1944066-2-mohsin.bashr@gmail.com
> 
> V1: https://lore.kernel.org/netdev/20240822184944.3882360-1-mohsin.bashr@gmail.com/

This above notwithstanding, this looks good to me: It implements standard
statistics, and there was no substantial review from v1 and v2 to address.

Reviewed-by: Simon Horman <horms@kernel.org>

