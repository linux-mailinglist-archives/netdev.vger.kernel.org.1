Return-Path: <netdev+bounces-113030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E188A93C61E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98670281A07
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279519CD16;
	Thu, 25 Jul 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib4mSpA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAE7482;
	Thu, 25 Jul 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919882; cv=none; b=VKGYVr37k95zPTJDtKqvjHRZc7J9Io5xl8pvZD3+izC/NQ9euRFpjVgjlDpklYvN+Rdd8WS+twwxmSXaiPC0RLdOkzS+dxmTa1qwbE+XR0Vu8WBmfclzJG4VxE+N6B4I5oOGCuYBzbNrOLz8vtu8g8v+/xbKiNfOgC+eRXz4FRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919882; c=relaxed/simple;
	bh=4wEp9ildGGBM0btWemEtrLyvUTx7yYO7eMfkrWkPVfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zid4BEG/k1oFxZ5l9CoPUndzeOtoJ1yBg/LLeSwPV+oYJEpPyChUg2+tgCTXJWcNqKR5m6tzC//0GlwRUvuQNOcLMVKlVuKqgiSfJ6a35mPSl9GsXF+CGCMwV6lVvDEjzx0LQ2ml0ugFeg/4zZA+OlTGK2QVpeWioD3T0KoMOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib4mSpA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB2BC116B1;
	Thu, 25 Jul 2024 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721919882;
	bh=4wEp9ildGGBM0btWemEtrLyvUTx7yYO7eMfkrWkPVfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ib4mSpA36nSnsM1u4L5SQ1K04uJJbd5V7AhJ644MTZyhfaYyBrf/KQNcGIZ7Qjodr
	 i16qNQqhC8YWqevqr+a4EAl/6IL7v/RtPOcNlI52Y5wGmuvy8fuHXQS8Jc2UCkxTcL
	 /EqzCIc56r4pS0hW09re62tqqTXmJHPv3XhkUu9P648Cef/ZkAq43HjT8MVFA68xmy
	 zlyl5dNI69bqab8EaxrT0DfDxifkm9D1Yz/zlG+Eldm++qXhaJOtg+9EPdDH9+Er66
	 P1d8TeDM8uoxQX5OZPEj1DS1D9M3VSZsBNWYm1mbHxaBULtmZb+75bpMMR3UkdByHn
	 MzyYQnY+YhX4w==
Date: Thu, 25 Jul 2024 08:04:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stefan Chulski <stefanc@marvell.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Don't re-use loop iterator
Message-ID: <20240725080440.41c2fd97@kernel.org>
In-Reply-To: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>
References: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 11:06:56 -0500 Dan Carpenter wrote:
> This function has a nested loop.  The problem is that both the inside
> and outside loop use the same variable as an iterator.  I found this
> via static analysis so I'm not sure the impact.  It could be that it
> loops forever or, more likely, the loop exits early.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 8c45ad983abc..0d62a33afa80 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -953,13 +953,13 @@ static void mvpp2_bm_pool_update_fc(struct mvpp2_port *port,
>  static void mvpp2_bm_pool_update_priv_fc(struct mvpp2 *priv, bool en)
>  {
>  	struct mvpp2_port *port;
> -	int i;
> +	int i, j;
>  
>  	for (i = 0; i < priv->port_count; i++) {
>  		port = priv->port_list[i];
>  		if (port->priv->percpu_pools) {
> -			for (i = 0; i < port->nrxqs; i++)
> -				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[i],
> +			for (j = 0; j < port->nrxqs; j++)
> +				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[j],
>  							port->tx_fc & en);
>  		} else {
>  			mvpp2_bm_pool_update_fc(port, port->pool_long, port->tx_fc & en);

Stefan, can you comment? priv->bm_pools are global (not per port)
AFAICT, so this may be semi-intentional.

