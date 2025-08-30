Return-Path: <netdev+bounces-218433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE0B3C749
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AF01B2685B
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6B223ED5E;
	Sat, 30 Aug 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whx7RI3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B75464E;
	Sat, 30 Aug 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756519765; cv=none; b=H5aMlN+XOL9HPls3W2Ry24B1sEZ9OlGeqTFbdhBASsNPb1cztO9Hb6xTAyT+EZrgCS+c+JZAD8CJ8/LoXxtRj6YmO+4598t2H2ajSKt3/+mXJ60P2FFxF8X6zYhcN1PVoKR1X30WLAw6ewsmu0hA+Pya14+hNqRUxmIH2vDsxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756519765; c=relaxed/simple;
	bh=7QpLsmRPvLH7QubZDXeiT+GNdUI7LMkOu8jIio2t33o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+6bIKlVUh/a4NR4lH2cnTkVCliiQ3P72+dcRtvDbQgrzlOOlUVUMcWtEIgj1xln7n3pJ1kJN6xq13O/3fKiFz/Ewud8WnOw0G2C9OGYbWHd7Xcc074Tz3L8THGJdludg4rnU643DrVrF02qTSbQRE4phAGRK7iwwl8xbclfxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whx7RI3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017FCC4CEF0;
	Sat, 30 Aug 2025 02:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756519765;
	bh=7QpLsmRPvLH7QubZDXeiT+GNdUI7LMkOu8jIio2t33o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Whx7RI3X3/kw+lAfHbSoVteua9OmHAJI4znEGNcF0wBeoDUaA/TvWWvX+e0Cw5mqQ
	 GKRWA7Das1SHv3qCS2YM8ks56QLgqLverrct2svR4ejlcJF4LLSCA4LinmmpX9nCQj
	 CUjH2S2jeCJ+ySRtjlxwuxSI9N8hULaAlnRXX+lCqWEgqEKuyy8oPRbm6rSxkwoFnV
	 YU8/9ZGxPURaUcMxvxTkxDcb12YMkXsIfxtcK4YrWPkki7Wf5RxFCA5Pkg7V6E348u
	 RUm15kSAKJLhWrTPbfhXv0o5KPBzxcwy2xFBxQxR9ktveTWKzuKeNCr/JDNj4GjVEq
	 IqYhq5Z80regA==
Date: Fri, 29 Aug 2025 19:09:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Shay Drory <shayd@nvidia.com>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ozsh@nvidia.com, mbloch@nvidia.com,
 tariqt@nvidia.com, saeedm@nvidia.com
Subject: Re: [RFC net-next] net: devlink: add port function attr for vport
 =?UTF-8?B?4oaU?= eswitch metadata forwarding
Message-ID: <20250829190924.5e730888@kernel.org>
In-Reply-To: <ilh6xgancwvjyeoqmekaemqodbwtr6qfl7npyey5tnw5jb5qt2@oqce6b5jajl2>
References: <20250828065229.528417-1-shayd@nvidia.com>
	<ilh6xgancwvjyeoqmekaemqodbwtr6qfl7npyey5tnw5jb5qt2@oqce6b5jajl2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 11:03:41 +0200 Jiri Pirko wrote:
> Thu, Aug 28, 2025 at 08:52:29AM +0200, shayd@nvidia.com wrote:
> >In some product architectures, the eswitch manager and the exception
> >handler run as separate user space processes. The eswitch manager uses
> >the physical uplink device, while the slow path handler uses a virtual
> >device.
> >
> >In this architectures, the eswitch manager application program the HW to
> >send the exception packets to specific vport, and on top this vport
> >virtual device, the exception application is running and handling these
> >packets.
> >
> >Currently, when packets are forwarded between the eswitch and a vport,
> >no per-packet metadata is preserved. As a result, the slow path handler
> >cannot implement features that require visibility into the packet's
> >hardware context.  
> 
> A vendor-specific slow path. Basically you provide a possibility for
> user to pass a binary blob to hw along with every TX'ed packet and
> vice versa. That looks quite odd tbh. I mean, isn't this horribly
> breaking the socket abstraction? Also, isn't this horribly breaking the
> forwarding offloading model when HW should just mimic the behaviour of
> the kernel?

I suppose will be told at some point that it's for debug.

