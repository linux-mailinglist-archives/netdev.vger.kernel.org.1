Return-Path: <netdev+bounces-219047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7AB3F902
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E20E7A89F1
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ED02E8E12;
	Tue,  2 Sep 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avcvqApW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9812E88AB;
	Tue,  2 Sep 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802776; cv=none; b=KcjghasdIv69po36dM94BP7BH6qmkuMqDsHOcrViTq3jIqbLif4OE8Y/HEHjFNMKrwVTqsoqTCj6NyNBu5OmCvt51KVLWFZDNGgbZKQO5kr48wpYX5E+dPoGwlkkAjbU5VcT4rdMhPRRFrl1xA173DBCgR5FPtbDqYoCt0buyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802776; c=relaxed/simple;
	bh=GqQBnpp4wNo5IrpS+dDD3ZmSdJ84h1ijcsEKl+MQtXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBq1TdObaa0iY2Ggc3RKISI+1OxIsZyVSJpKWVpBUXA8riB8PQgGyQ9blTANSAHsvEsXuDVsZN9LTkFe7j0TzqYOQB2NTdwOcErdWvU4Xo/Y8vwmZJXm3DB5LfGlWIsEk/GMVR/u0j4A77PPoaBvMIbI85hkkIlv1a0tUxEGH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avcvqApW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3711C4CEF5;
	Tue,  2 Sep 2025 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802776;
	bh=GqQBnpp4wNo5IrpS+dDD3ZmSdJ84h1ijcsEKl+MQtXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avcvqApWLBuqn9A6bZhaaG14hjJtYoEqm5Uxd8vTCxg8/yETODppkoW+xxc9RsAV6
	 97j21X/2F3NKcAYrSzil7Mqa4m2t2v4z95WOj9WXlbi8P5o6ZnpcWnC/aZCFe8QT5n
	 ckVRxR7X5dNxOf4u9Ihwh2cII7MD5T2JhFGBv3asALPiovpB9huR/sz1uyC7Xm9HiL
	 mpgyGFXHvHszqdfuY3nX/5iPKaTEBXbeiRdkj/DRBi0RM6dMnaR6OZphhMaFEYnMFS
	 QWbFOllzDcpQBHcrRsXrpUanH9oNL4R3p17kWDYL2oqCvCIP9f4fd5F5064Z67V1uO
	 OA9c2BTLpKnAQ==
Date: Tue, 2 Sep 2025 09:46:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <20250902084611.GR15473@horms.kernel.org>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829124843.881786-3-jchng@maxlinear.com>

On Fri, Aug 29, 2025 at 08:48:43PM +0800, Jack Ping CHNG wrote:
> Add mxl_eth driver to introduce the initial implementation of ethernet
> support for Maxlinear LGM SoC.
> LGM SoC has a multi port MAC controller to interface with the PHY. It also
> has a master MDIO interface to control the external MDIO configured
> devices.
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>

...

> diff --git a/drivers/net/ethernet/maxlinear/mxl_eth.c b/drivers/net/ethernet/maxlinear/mxl_eth.c

...

> +static int mxl_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)

Hi Jack,

I think it would better for the return type of mxl_eth_start_xmit to be
netdev_tx_t to match the signature of the .ndo_start_xmit member of const
struct net_device_ops.

Flagged by Clang 20.1.8 with
KCFLAGS=-Wincompatible-function-pointer-types-strict

drivers/net/ethernet/maxlinear/mxl_eth.c:56:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
   56 |         .ndo_start_xmit = mxl_eth_start_xmit,
      |                           ^~~~~~~~~~~~~~~~~~

> +{
> +	dev_kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops mxl_eth_netdev_ops = {
> +	.ndo_open       = mxl_eth_open,
> +	.ndo_stop       = mxl_eth_stop,
> +	.ndo_start_xmit = mxl_eth_start_xmit,
> +};

...

