Return-Path: <netdev+bounces-104418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99090C713
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7A4B23B2F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6314D71C;
	Tue, 18 Jun 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqqoL4MZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6819139D0C;
	Tue, 18 Jun 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699133; cv=none; b=XTOTa2s4hXbWTNp0eHKW4Mi1lJfYDe40PCVeKmAGCQYIhSNz2zPZzZG7QaAQA9/AtSlZ6/b2S1wfxSbOYJYVfO6hwKS9WRUnD7wZirq8lgceR38xQc29bEYsxDcAzWzSC9ENYKxCLer5k6mDZgZqC5fjtrpDv2bx/Qa3NPNt/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699133; c=relaxed/simple;
	bh=QZB8fHDIjOnQPiFT+614qTT2f4FhbW7aTgu//lNGJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+wFJLi0uM0Bj2iMtKA+/KFPOWxxO/Hywv7j4qOzBKgOrIanE6TvgQx6XfQjV9Cn3g9MLB25Wl5cBG/4mJP2wFV6BDCGeT3RuHkNLXqChWRKDWzgwz6vxCLOOwicwvwm0rqnYUZjKgi3Tq7OyTYqUFj9O8p9owGNhnb7xVLI/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqqoL4MZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325ABC4AF1A;
	Tue, 18 Jun 2024 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718699133;
	bh=QZB8fHDIjOnQPiFT+614qTT2f4FhbW7aTgu//lNGJho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqqoL4MZ5OETxeD2FwhJk6e65JRq8fDu6IiHj70QFOFMHYfuDtPFADnyYFrXOaDk2
	 ytSY6CjxaLCwuqB3crxfaUvevf0mnS/7kgYYPp8ebhlUr3GB0GJ+9Zr1tKkjdQ5lxp
	 jNV+pVBZ1UqjD62lhlYrKkv+6XqyPf5c2likm5wzkCMc5YhgqlRZSHdv/QbdPfRVZg
	 GlaJAMhjjX7XlJeuPKnlNaWSgoSnmaa9MqHnCxjaFJoCAPNCRo1woPCLM5XyYNaOUB
	 THhKw6R7QJI2l8ytvwnPRnnlu5/pcK0JIuXFS4NLS5weB7PzuFVxNE9dJWB15wHA3X
	 85FfFxm//RYxg==
Date: Tue, 18 Jun 2024 09:25:28 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 03/10] octeontx2-pf: Create representor netdev
Message-ID: <20240618082528.GD8447@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-4-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:06PM +0530, Geetha sowjanya wrote:
> Adds initial devlink support to set/get the switchdev mode.
> Representor netdevs are created for each rvu devices when
> the switch mode is set to 'switchdev'. These netdevs are
> be used to control and configure VFs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> +void rvu_rep_destroy(struct otx2_nic *priv)
> +{
> +	struct rep_dev *rep;
> +	int rep_id;
> +
> +	rvu_rep_free_cq_rsrc(priv);
> +	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
> +		rep = priv->reps[rep_id];
> +		unregister_netdev(rep->netdev);
> +		free_netdev(rep->netdev);
> +	}
> +	kfree(priv->reps);
> +}
> +
> +int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> +{
> +	int rep_cnt = priv->rep_cnt;
> +	struct net_device *ndev;
> +	struct rep_dev *rep;
> +	int rep_id, err;
> +	u16 pcifunc;
> +
> +	priv->reps = kcalloc(rep_cnt, sizeof(struct rep_dev *), GFP_KERNEL);
> +	if (!priv->reps)
> +		return -ENOMEM;
> +
> +	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
> +		ndev = alloc_etherdev(sizeof(*rep));
> +		if (!ndev) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "PFVF representor:%d creation failed",
> +					       rep_id);
> +			err = -ENOMEM;
> +			goto exit;
> +		}
> +
> +		rep = netdev_priv(ndev);
> +		priv->reps[rep_id] = rep;
> +		rep->mdev = priv;
> +		rep->netdev = ndev;
> +		rep->rep_id = rep_id;
> +
> +		ndev->min_mtu = OTX2_MIN_MTU;
> +		ndev->max_mtu = priv->hw.max_mtu;
> +		pcifunc = priv->rep_pf_map[rep_id];
> +		rep->pcifunc = pcifunc;
> +
> +		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
> +			 rvu_get_pf(pcifunc));
> +
> +		eth_hw_addr_random(ndev);
> +		err = register_netdev(ndev);
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "PFVF reprentator registration failed");

Hi Geetha,

(The most recently allocated) ndev appears to be leaked here.

I think that one way to address this could be to moving the contents of
this loop into a separate function that unwinds the most recent allocation
on error.

Highlighted by Smatch (although it seems a bit confused here).

 .../rep.c:184 rvu_rep_create() warn: 'ndev' from alloc_etherdev_mqs() not released on lines: 184.
 .../rep.c:184 rvu_rep_create() warn: 'ndev' from register_netdev() not released on lines: 184.

Sorry for not bringing this up earlier: it is at least the third time I
have looked over this, and for some reason I didn't notice this the other
times.

> +			goto exit;
> +		}
> +	}
> +	err = rvu_rep_napi_init(priv, extack);
> +	if (err)
> +		goto exit;
> +
> +	return 0;
> +exit:
> +	while (--rep_id >= 0) {
> +		rep = priv->reps[rep_id];
> +		unregister_netdev(rep->netdev);
> +		free_netdev(rep->netdev);
> +	}
> +	kfree(priv->reps);
> +	return err;
> +}
> +
>  static int rvu_rep_rsrc_free(struct otx2_nic *priv)
>  {
>  	struct otx2_qset *qset = &priv->qset;

...

