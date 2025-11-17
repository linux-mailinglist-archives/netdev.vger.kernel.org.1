Return-Path: <netdev+bounces-239245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E405FC6638C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC54A4EFDFE
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A843446BC;
	Mon, 17 Nov 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXL+7Frd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB530217B;
	Mon, 17 Nov 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413765; cv=none; b=fvEZ6SkSp+J3Nj8bM7LwegObG2RePGo6yeOkaSTQZ2uDVmwMCHAfY/psE9iq6xZHB3FMoqqoUqxFnAfo79NbzXN1Jf9QqXpkFaI3HQ2lQBnf/9VsVrsxNTgJEepD3RZ5pLyjmNUbfkDPfM1rt/yMsM1mRwTBirn4I0+xetzbQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413765; c=relaxed/simple;
	bh=v2TilITkDJ2tL/jDdt/62ng7+B27BobzbCQT9r0dXfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4ezE3/CkeFJhl6luEXm6b+I5puOkZTm2zWREYF1c9eHhGiZ1Gr7Axov+Tl10AmJfPQw5I0htM6Ru547vs6MpQ1EA/a7rXe1ScJgjQ8QKo2qB24uzHTzYtzgYTzUlxTqbTmn5FT7SfzBF+9DdbviWkKixijyVzuXu05gh/gqZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXL+7Frd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43548C2BCB8;
	Mon, 17 Nov 2025 21:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413765;
	bh=v2TilITkDJ2tL/jDdt/62ng7+B27BobzbCQT9r0dXfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXL+7FrdEV6yxxSYUFmr0AfsRnRWEYsHOhHygW0gdgzKY8vBpISSFg1ZrrskbLaqD
	 PmL4jLGu2rgdUDj/VoS2npQM+95FsS3OpUasQJFCkqrivJKxfTohSkS4l7l7lKLR+F
	 ghTWjod7PnP3ecHjfnxwEEFpjVZ1aNjBhfWN7zdAfdcXQ1WS0ulgGLEaF+N+NIeg9A
	 lGzI59z+RWYnQfiGGobEFKOI0D1l0Z9Ta2PMeCgliJkjRZto/9holuIC/6yEJPlmOR
	 P2YE6p933CwqY0aJKEj/+k909FoQPqBcSbN5w7rrUlKQkx+vd5ucWdTJT6ZBQ8JCal
	 NLXX7PfBjaC8A==
Date: Mon, 17 Nov 2025 21:09:14 +0000
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
	pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
	praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 3/3] net: ti: icssm-prueth: Adds support for
 ICSSM RSTP switch
Message-ID: <aRuO-ib0us1JCrxc@horms.kernel.org>
References: <20251113101229.675141-1-parvathi@couthit.com>
 <20251113101229.675141-4-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113101229.675141-4-parvathi@couthit.com>

On Thu, Nov 13, 2025 at 03:40:23PM +0530, Parvathi Pudi wrote:

...

> @@ -1012,17 +1074,77 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>  	hrtimer_cancel(&emac->tx_hrtimer);
>  
>  	/* stop the PRU */
> -	rproc_shutdown(emac->pru);
> +	if (!PRUETH_IS_EMAC(prueth))
> +		icssm_prueth_sw_shutdown_prus(emac, ndev);
> +	else
> +		rproc_shutdown(emac->pru);
> +
> +	/* free table memory of the switch */
> +	if (PRUETH_IS_SWITCH(emac->prueth))
> +		icssm_prueth_sw_free_fdb_table(prueth);

The conditional block above appears to open-code icssm_prueth_free_memory()
which is also called below. I don't think this this duplication causes
any harm, as it looks like the second, indirect, call to
icssm_prueth_sw_free_fdb_table() will be a noop. But it does seem
unnecessary.

>  
>  	/* free rx interrupts */
>  	free_irq(emac->rx_irq, ndev);
>  
> +	/* free memory related to sw */
> +	icssm_prueth_free_memory(emac->prueth);
> +
> +	if (!prueth->emac_configured)
> +		icss_iep_exit(prueth->iep);
> +
>  	if (netif_msg_drv(emac))
>  		dev_notice(&ndev->dev, "stopped\n");
>  
>  	return 0;
>  }

...

