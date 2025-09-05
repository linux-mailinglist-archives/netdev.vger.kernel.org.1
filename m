Return-Path: <netdev+bounces-220354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8230B4587A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81052A43DB7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D2819CCEC;
	Fri,  5 Sep 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+m8CXw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323418A6DB
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077711; cv=none; b=ShYowPmHzfqoOTCpBITRhcnzgSl1gStwMq2n7XcL6/htqcnHbtksFQSzGHYal8mJPsHWS9dtXWqlhYxYyG7+UsVPDZIi0SnsNkZCUg0sG8iZiAtoq5zYi3rQWre3Pw0lMVj02YSF1lQghHCkMmGSBzKbDFFw6L8FXN7l0uVyBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077711; c=relaxed/simple;
	bh=Y+slr3p117oNGx67X0y2iu32EwoLn9c0IOFNr6d3bhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2wpTISzcSsv8muQ5YiTvd/m8xMwrqx+qpE660e03/LNd9b2KM4yGIYnKWykY7evHesuMBWuhVkky5ZA4q1GH3nu2XBGqVonINzXUCVgI+l365Q48CIRAyJwzXuZtoe64/XajVCfP7wv+Tf/YYPGrbjhO44o7ZXPjUaOHaIKGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+m8CXw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480FBC4CEF1;
	Fri,  5 Sep 2025 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757077710;
	bh=Y+slr3p117oNGx67X0y2iu32EwoLn9c0IOFNr6d3bhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+m8CXw2nQfppPF2qHID5eGaG3GufSFpXdx2twmC77s1dgkrS9jVuHV1Qy2VkQhMS
	 Ofh/Nh0x95H5XJFuukJdVwwG41Pu/i448pNkJ4mfvRQy7Eim2aLAh0AmZu3eBhmf+i
	 wg0VQAnLRWItYelEoKTK0ZNPtj0BlmuLWxFm6u3ZSdMKflJ1IDYp7pyM6ZszQAGnIf
	 IsmNg4RBpcWlpFXVAdFUmVNFEE8jjqq5Zxg/M4Im+97VbDx72RAY272SVgGukQQMix
	 AMIvmBlgwhBZPTsrOUhJud/DPg4KTN8wsaSK6nVD7iwsgLlTMsuytcUs0ebiB371WT
	 oM2Hw6/++iN1A==
Date: Fri, 5 Sep 2025 14:08:27 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] udp_tunnel: use netdev_warn() instead of
 netdev_WARN()
Message-ID: <20250905130827.GD553991@horms.kernel.org>
References: <20250905055927.2994625-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055927.2994625-1-alok.a.tiwari@oracle.com>

On Thu, Sep 04, 2025 at 10:59:22PM -0700, Alok Tiwari wrote:
> netdev_WARN() uses WARN/WARN_ON to print a backtrace along with
> file and line information. In this case, udp_tunnel_nic_register()
> returning an error is just a failed operation, not a kernel bug.
> 
> A simple warning message is sufficient, so use netdev_warn()
> instead of netdev_WARN().
> 
> The netdev_WARN use was a typo/misuse.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1 -> v2
> Modified commit message as discuss with Simon.
> https://lore.kernel.org/all/20250903195717.2614214-1-alok.a.tiwari@oracle.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


