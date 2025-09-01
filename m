Return-Path: <netdev+bounces-218826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C105B3EAEB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B32F3AA6B6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB12DF140;
	Mon,  1 Sep 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnCxcj6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893352DF135;
	Mon,  1 Sep 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740236; cv=none; b=m0qplDU2KMHGRGyRLe36aBiHB9zmUJt3Z1xPQ8jdPu6296uTL8Eb0PfheEoQYj5Tg5L7uhxTtV8v3bJcl5/IZVs5Y6JiYYlZ12avd6awX3mQ/SQwvmYV1LhBv73kHx74SDp5a2F2DPs8jV2Rzb8O8O/NykIcCDI2KVgtITA328A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740236; c=relaxed/simple;
	bh=Z6Bw+FcjIx5936FqSyasEITeMW7G2tVVJ6eaKgA8l4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy+PZh2BrtSPpM1LKTR7VqAQJLR1WralZSIvM3Go4UGVwKfxLUguyvY4Ykz6AbKmwHuDNdpmkLgPHVbOWNMPuKVLFORo+g3zzxyIL5/ldhTb0N+eIZN/qiw536nfvLH2Z+dKv5333jx1/JgS00B8869HDccpAeXmF48P8SMOueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnCxcj6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24263C4CEF0;
	Mon,  1 Sep 2025 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740236;
	bh=Z6Bw+FcjIx5936FqSyasEITeMW7G2tVVJ6eaKgA8l4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnCxcj6hmR3kyzFGjXyzGmi+Ebjv1J9Oo9OIj93UmdWU9kULjfM4TSPiQHqD86GIg
	 gaBATn92CB4h6hY0lpJwhGxe0hmQ3bB9d71Ne5FVNdTn8/S/W+hUTtYRtTK1+iOmzm
	 aO8R9+mTGcbFwDiT2mAQ+KqbaOoIXKDFnxGJFGfcrdH3GU3lxXjNOY2UWRubiJIU0v
	 8SF3VlxhFs6iZFJdc/0Cbm53TpsPRhc5P2WhSrJrG59oX5sjXC0+Gf9QlPPhEd4UBm
	 j0gSyZ6ZIUbbAYz6bxqnpJCpQ5pUzHnouZ7L6Q24poIF1Hz5oFeWBoJWGjp/1D4EQ2
	 uuoluUILDgrSg==
Date: Mon, 1 Sep 2025 16:23:52 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: thunder_bgx: use OF loop instead of fwnode
Message-ID: <20250901152352.GG15473@horms.kernel.org>
References: <20250830214217.74801-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830214217.74801-1-rosenp@gmail.com>

On Sat, Aug 30, 2025 at 02:42:17PM -0700, Rosen Penev wrote:
> The loop ends up converting fwnode to device_node anyway.
> 
> While at it, handle return value of of_get_mac_address in case of NVMEM.

I think that this part should be a separate patch.
Possibly targeted at net with a Fixes tag.

> 
> Simplify while loop iteration.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> @@ -1514,14 +1510,13 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  	/* We are bailing out, try not to leak device reference counts
>  	 * for phy devices we may have already found.
>  	 */
> -	while (lmac) {
> +	while (lmac--) {
>  		if (bgx->lmac[lmac].phydev) {
>  			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
>  			bgx->lmac[lmac].phydev = NULL;
>  		}
> -		lmac--;
>  	}

The update to this look looks correct to me, even without the rest of
the patch separate. If so, I'm wondering if it should also be a separate
patch. Again, possibly for net with a Fixes tag.

> -	of_node_put(node);
> +	of_node_put(child);
>  	return -EPROBE_DEFER;
>  }

...

