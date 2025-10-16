Return-Path: <netdev+bounces-230237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29CBE5B3C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D35F3555CF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC32DF6F9;
	Thu, 16 Oct 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/stxcCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E72D47EA;
	Thu, 16 Oct 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760654308; cv=none; b=Fr1FEdTHRy6kBvaOcwtbAe+bI2NmB3IJnidqCJNrQ75np+057l52TrVEzj+nI6OvzxCdP3/n1TZ4+Gw8RLsI5wIov3KZlm3kfx+eR5U+F/WbpfGvhEfOdxTZfXH9sxKHD65dSblzJUgJhevPNI6UCQk/CcZU5fLeWEmJNd8RXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760654308; c=relaxed/simple;
	bh=wKiMbSW2btYDCEkP84aOaJFVlmVRonaPBFbWDEDZHFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVgCiQ0dErC8Cs23MDY9y6cP3xaqdQl8F67s/AGAO1Oolwd2P5yy+sDoabMM+79eRFsjjGt3xWRnUpz75O0xGJgiOpro2Rzp2I96+bYJSWo7j5R02KpleGPR3TIxVGYz4+wRYgb7NFrsawAK3C3qU+1DGrLkLvWn3+EAf+/riUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/stxcCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF5AC4CEF1;
	Thu, 16 Oct 2025 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760654307;
	bh=wKiMbSW2btYDCEkP84aOaJFVlmVRonaPBFbWDEDZHFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/stxcCnyU19kW79L2FppuFlO8lYB5qFsnejfj8L2Q4yE+5XxPaFW7fqbjFymaMhT
	 ui2hEnh0ZWj8ydcpC38Yi6vEOzcogIigVULPG2On2iUDljyjynurBYY+fKLOfaYBjz
	 gQW2i/SnzDSXHdIcJIfgMEWmmNNT0Y5qc+Rl31hYFLmxzvc/jYtowDQ+62nx218lhg
	 IrAmWqHEOe1jb6VGo8c1Z24/35soaWGBZmnURt20/OlzCwFvYaHdTJ/o9/PO32pShq
	 dxa2FkfC0bX9LG9zPUBR0kTDWf/7D6WRBnfyKj3MzOSo54CZgXQCfYkUyCnCG/DVuP
	 qrL3uSJyTh45g==
Date: Thu, 16 Oct 2025 15:38:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20251016153826.70867a6e@kernel.org>
In-Reply-To: <20251014033551.200692-4-mmyangfl@gmail.com>
References: <20251014033551.200692-1-mmyangfl@gmail.com>
	<20251014033551.200692-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 11:35:47 +0800 David Yang wrote:
> Motorcomm YT921x is a series of ethernet switches developed by Shanghai
> Motorcomm Electronic Technology, including:

>  drivers/net/dsa/Kconfig  |    7 +
>  drivers/net/dsa/Makefile |    1 +
>  drivers/net/dsa/yt921x.c | 2898 ++++++++++++++++++++++++++++++++++++++
>  drivers/net/dsa/yt921x.h |  504 +++++++

We need a MAINTAINERS entry covering the new driver. See also:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
And: 
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#supported-status-for-drivers

> +
> +	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
> +			mib->rx_128_255byte + mib->rx_256_511byte +
> +			mib->rx_512_1023byte + mib->rx_1024_1518byte +
> +			mib->rx_jumbo;
> +	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
> +			mib->tx_128_255byte + mib->tx_256_511byte +
> +			mib->tx_512_1023byte + mib->tx_1024_1518byte +
> +			mib->tx_jumbo;
> +
> +	/* Flush all writes */
> +	smp_wmb();

Barriers don't flush anything, they order visibility of writes.
You don't have a matching smp_rmb() AFAICT so this looks unnecessary.

> +	/* other mirror tasks & different dst port -> conflict */
> +	if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
> +			    YT921X_MIRROR_IGR_PORTS_M)) != 0 &&

nit: you can delete the != 0

> +	    (val & YT921X_MIRROR_PORT_M) != dst) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Sniffer port is already configured, "
> +				   "delete existing rules & retry");

please don't wrap strings, it's okay to go over 80 chars
Makes it easier to find them by grepping if they are not broken up
-- 
pw-bot: cr

