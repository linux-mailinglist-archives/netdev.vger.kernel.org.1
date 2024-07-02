Return-Path: <netdev+bounces-108347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF791EFE5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1471C2228A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648C537E7;
	Tue,  2 Jul 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJSZf6ex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588C130A46;
	Tue,  2 Jul 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904666; cv=none; b=IlEZ3+lWbCYbzJhdAWuFVmwSyyKDre45Lblnv/7hZkotzb7q4+Ox2UjiS9s0ZkzCA4V++9gpUty0IiWsetpGAWzSxdoIZeTffUBFxIWmYfwZn6Tcldv6C9Dw8Ixi+TjgP+jzLMPIo0un1L8+OEtvIu7iD7P+aVaTLCdnBThj/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904666; c=relaxed/simple;
	bh=+ajUOihIy3DbqQQu8hvDT/sgpxHbxvCFzk5+TeNikrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSp3VfeTrLEXe4YVUlC0UgcTEvZQIexTPaU5tyIK8ViQgAN75xBP2dzKrL8GhNy2XvqMUxaIyg34pTxcIypAhJCWAj3WzGjTx6DhMWVPsrEGKqFnvG8RYe3rKgPBP5AU9Tgy2vdmZ8H12ZY/JFKrROy/1bfZ13RbtKHMa9btPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJSZf6ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662F4C116B1;
	Tue,  2 Jul 2024 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719904665;
	bh=+ajUOihIy3DbqQQu8hvDT/sgpxHbxvCFzk5+TeNikrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJSZf6exkhCWicKbl/kX3AwxGqEYrAXUOvp7T+6rCc8jICWjWzyTzQuCmcncO1IdN
	 ViBEHaNrDIwxLx9ZbztKsvJrr3eKpcJFTcqMrHAD3fv8DAykFrkMUchICFN96brT8Q
	 SHVZnQrbvKKHSQ89UwUdSeWfgoSNQlYB8UD9hVsXNhUZzspTsBTQLW4A8PPdo7+Iqk
	 NEiPQRGSGMcPQ24FBr5yuNuxgDC/cV7+jNt22PpXDvTwvzLonK3m4x45uI8VQORcUL
	 4lhQWWwWSPc+xhmgPh3JbRx1As0KPAPGjBvAiyKVPflfjXL6LSvdtYhiTdDRyWSBi0
	 GYaz5ZZITQ7LA==
Date: Tue, 2 Jul 2024 08:17:39 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v4 2/2] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <20240702071739.GA606788@kernel.org>
References: <cover.1719672695.git.lorenzo@kernel.org>
 <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>

On Sat, Jun 29, 2024 at 05:01:38PM +0200, Lorenzo Bianconi wrote:

...

> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c

...

> +#define INT_IDX4_MASK						\
> +	(TX8_COHERENT_INT_MASK | TX9_COHERENT_INT_MASK |	\
> +	 TX10_COHERENT_INT_MASK | TX11_COHERENT_INT_MASK |	\
> +	 TX12_COHERENT_INT_MASK | TX13_COHERENT_INT_MASK |	\
> +	 TX14_COHERENT_INT_MASK | TX15_COHERENT_INT_MASK |	\
> +	 TX16_COHERENT_INT_MASK | TX17_COHERENT_INT_MASK |	\
> +	 TX18_COHERENT_INT_MASK | TX19_COHERENT_INT_MASK |	\
> +	 TX20_COHERENT_INT_MASK | TX21_COHERENT_INT_MASK |	\
> +	 TX20_COHERENT_INT_MASK | TX21_COHERENT_INT_MASK |	\

Hi Lorenzo,

One more thing that I forgot to note yesterday:
the two lines above appear to be duplicates of each other.

Flagged by Coccinelle.

> +	 TX22_COHERENT_INT_MASK | TX23_COHERENT_INT_MASK |	\
> +	 TX24_COHERENT_INT_MASK | TX25_COHERENT_INT_MASK |	\
> +	 TX26_COHERENT_INT_MASK | TX27_COHERENT_INT_MASK |	\
> +	 TX28_COHERENT_INT_MASK | TX29_COHERENT_INT_MASK |	\
> +	 TX30_COHERENT_INT_MASK | TX31_COHERENT_INT_MASK)

...

