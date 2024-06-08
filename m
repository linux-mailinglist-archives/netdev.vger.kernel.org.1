Return-Path: <netdev+bounces-102026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B89011B4
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32477B2173C
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7291717838B;
	Sat,  8 Jun 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUuREDdc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBD159209
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717853866; cv=none; b=Te0cTypAgz7Xjo6zCl907FbQmAChKCcu8rVaiDasCWMoLpaaRSrNX++mJ939PjlFyKU7WY0/1vShmC6C3GoQeB9/Pn0ayEczI04iQxTdC8CnRfN7uyxcpqnuYGdHuNrWnd0xhbFgKv45Fa8JTdfQYjaKL2q85rJyfGmNO4WcpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717853866; c=relaxed/simple;
	bh=8p6UcwLUsHFP/b/ojXf7udZBUd+3wOD+Ky0dtJkzmgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7jp2heOxevvqrQogKuzF5Lt5Qr2taW+XA9qKSQ4dOvOHBazI0aIpTk3nbHEbDRFd3zK/2YlXae+Jw6jbf4YqQWdtqcWwgIwDFTFQqTVplXjiXcPzI7l5dUwVXdJEOK+TSJXm2e298EYuxfHoc99hyjXs4jMD3Qk+JOlLMDn2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUuREDdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50658C2BD11;
	Sat,  8 Jun 2024 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717853865;
	bh=8p6UcwLUsHFP/b/ojXf7udZBUd+3wOD+Ky0dtJkzmgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUuREDdcdJ17tARi06dzPD9ka/BJ8peLYMCCqbjZOseoY2MavSt3hhSR0ZePv1kQG
	 LNIiMuzsvbPUA12fG1riRzcKOn7YFtzgN/3c5oBjQtV33IUVQi5CMj+/YKeANb2rZw
	 5E1rYWs+DdwVh0e0GFdILnQQFCKPPq0f4ISIGKk4zuo039R/kl4GRj5TCJGhIV9GJ2
	 HGufYJyitJfYW4g3CXxf6BXrEjq+8PaFoCcK+ptmyHS8Eo3zlPX4UIv71yQkIRLymI
	 ITeFYQD6cdZb/efOWiQjG16efiJ519kncTIGbW2JTA09RI2GhGoHWQYRR8AKi92krL
	 qac3Io54hdCEQ==
Date: Sat, 8 Jun 2024 14:37:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: vrf: move to generic dstat helpers
Message-ID: <20240608133742.GI27689@kernel.org>
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
 <20240607-dstats-v3-3-cc781fe116f7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-dstats-v3-3-cc781fe116f7@codeconstruct.com.au>

On Fri, Jun 07, 2024 at 06:25:26PM +0800, Jeremy Kerr wrote:
> The vrf driver has its own dstats-to-rtnl_link_stats64 collection, but
> we now have a generic implementation for dstats collection, so switch to
> this.
> 
> In doing so, we fix a minor issue where the (non-percpu)
> dev->stats->tx_errors value was never collected into rtnl_link_stats64,
> as the generic dev_get_dstats64() consumes the starting values from
> dev->stats.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


