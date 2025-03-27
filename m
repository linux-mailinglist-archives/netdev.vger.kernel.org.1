Return-Path: <netdev+bounces-177907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D1A72DA7
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF223B741C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12D20E308;
	Thu, 27 Mar 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNPz+BFx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAE20DD62;
	Thu, 27 Mar 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070770; cv=none; b=Jx95fzrmL9lx+VAtA9XVyA9o3jIrTJpcXjgipZCATkxSj2qxyVGMctWBSAjy1+mFp0ELL1rrzzeXbVFDj5tfhOO/9acbuXODGbdUrs93Pqwx9XKAmhXwl0lgp0YiiWk7g2/7KdvU8VMP4wUyZpchh8rIBES3+oEGwLhcSnUPmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070770; c=relaxed/simple;
	bh=9QlS6ClDSuIBnYSHAXTMCjrqS/UCF1XQgmPuCkVS9NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+liRMX4KXO9w2hwJ8vjUATAmIH7/A1x3TP1S+KPnNSF2YFc0gxw037VKVR1eBF161q4eWD/A4eJ+RepLo3YTHt3bmA3miOpLj9SSYuGh6Y+Wh5Wgla0gcDvciAVRfkYmPyDh9wEVXI1x97UCQ+Sa8c3XSJzI+iMjxEXCtNZP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNPz+BFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26BC4CEDD;
	Thu, 27 Mar 2025 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743070769;
	bh=9QlS6ClDSuIBnYSHAXTMCjrqS/UCF1XQgmPuCkVS9NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNPz+BFxDXYYiOKq6lt6iKNqNuppzLzOkY3Vt3CedtbXloUtPu01nEpSkLQ6/bQOg
	 jnsBPz3mKGJxW1urSjxnScfowSLzkpesarGpBp18RycfPB8v+D0lbjPSHSkbHi8PcH
	 EGPxGpQYlgWhQYTz50Ae1o1bgtzr9PxH/M6vficcSekvSa7iKH+IuciGqAPPKkDMvF
	 p906cGCj0+FTCBQiH9s8OMwL3KaEm175vH/a/lOezAtiF6dghRQzkndWYnpXM80JSC
	 majYgW72wo4u+X/J4M0yFFThmxnvNv5o8p42ASLd6Kv1WBYL0UTEO0PvIWSaDDfYeZ
	 yALjILIDa+a1Q==
Date: Thu, 27 Mar 2025 10:19:25 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v2] rtase: Add ndo_setup_tc support for CBS
 offload in traffic control setup
Message-ID: <20250327101925.GF892515@horms.kernel.org>
References: <20250327034313.12510-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327034313.12510-1-justinlai0215@realtek.com>

On Thu, Mar 27, 2025 at 11:43:13AM +0800, Justin Lai wrote:
> Add support for ndo_setup_tc to enable CBS offload functionality as
> part of traffic control configuration for network devices.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
> v1 -> v2:
> - Add a check to ensure that qopt->queue is within the specified range.
> - Add a check for qopt->enable and handle it appropriately.

Thanks Justin,

This patch looks good to me.
But net-next is currently closed for the merge-window.
So please repost this patch once it re-opens, which
I expect to be around the 14th April.

RFC patches are welcome any time.

-- 
pw-bot: deferred

