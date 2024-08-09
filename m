Return-Path: <netdev+bounces-117148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593794CDF3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EF1F2301F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DA19148D;
	Fri,  9 Aug 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxrlU6WM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57F175D2C;
	Fri,  9 Aug 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196996; cv=none; b=W5FvDdwB0MBzZFtGxVMdbWwlx5H0XQbYRn0dbIImPy1ODZRU9Rf8w7CVpPRM5lvyylthBndcYo9pTHIo9/h6QMXdF9ssoM3lAuuZj6GN4pAgDUh+Y3XPKM2q8UYhg40kpL4Gfx2IA/tWscXBZXRfYW/B3+SNbt6Uiw84dV4RpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196996; c=relaxed/simple;
	bh=km1bJkPPQGurldrwmYem5p7vDz5dgJsB7r0C5f9d1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlPnbkDpGmRWmuXxkoS7yIW3VdtKfNXTgCeAKue9jQ+Bi2LOf5oFzclgSgboIjWiW8GOtLBu2jHOeVttiZl9APvEJ+/72LOfsM7eOEl7kScuwWlHpOJ5TZKMdlmhbxwL8W0BGedRce10lroHSPTT5UN1d2bOero2fH5p/wwtLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxrlU6WM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ECCC32782;
	Fri,  9 Aug 2024 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723196995;
	bh=km1bJkPPQGurldrwmYem5p7vDz5dgJsB7r0C5f9d1Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxrlU6WMHEYz2Pz5cOJtAMv+PnUDWKPkTZK6CbbZlJ/Q7byyhkzqNnt5p8XUfI5lh
	 UwPN3XYvFgRpl62UvqUFPXPYg/Rjmqf63vZjmYo8fK4g8MLRuZn/Z34SafSdKkEZXS
	 zb78AODKXeEgw58BxRW7hBZYCKu57LXqSOqSvfB5/73wdkxdOawhgvy8oNjE14DXJs
	 gewwpKHBZN8cOXbkxb5+SXfPXG9e9/Zr6lXSNIoQSUfzjvidEtt3Vmd9rnzBJne3XI
	 F+nSpGFPu1nmTt7mlBVSAJh2rJ29PBhj+HUnTYLU7yc6iv6BXkpY5pI5dCaeLMli6x
	 /FnFwtiEIs/JQ==
Date: Fri, 9 Aug 2024 10:49:51 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: fs_enet: Fix warning due to wrong type
Message-ID: <20240809094951.GI3075665@kernel.org>
References: <ec67ea3a3bef7e58b8dc959f7c17d405af0d27e4.1723101144.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec67ea3a3bef7e58b8dc959f7c17d405af0d27e4.1723101144.git.christophe.leroy@csgroup.eu>

On Thu, Aug 08, 2024 at 09:16:48AM +0200, Christophe Leroy wrote:
> Building fs_enet on powerpc e500 leads to following warning:
> 
>     CC      drivers/net/ethernet/freescale/fs_enet/mac-scc.o
>   In file included from ./include/linux/build_bug.h:5,
>                    from ./include/linux/container_of.h:5,
>                    from ./include/linux/list.h:5,
>                    from ./include/linux/module.h:12,
>                    from drivers/net/ethernet/freescale/fs_enet/mac-scc.c:15:
>   drivers/net/ethernet/freescale/fs_enet/mac-scc.c: In function 'allocate_bd':
>   ./include/linux/err.h:28:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>         |                                                 ^
>   ./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   drivers/net/ethernet/freescale/fs_enet/mac-scc.c:138:13: note: in expansion of macro 'IS_ERR_VALUE'
>     138 |         if (IS_ERR_VALUE(fep->ring_mem_addr))
>         |             ^~~~~~~~~~~~
> 
> This is due to fep->ring_mem_addr not being a pointer but a DMA
> address which is 64 bits on that platform while pointers are
> 32 bits as this is a 32 bits platform with wider physical bus.
> 
> However, using fep->ring_mem_addr is just wrong because
> cpm_muram_alloc() returns an offset within the muram and not
> a physical address directly. So use fpi->dpram_offset instead.
> 
> Fixes: 48257c4f168e ("Add fs_enet ethernet network driver, for several embedded platforms.")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Simon Horman <horms@kernel.org>

