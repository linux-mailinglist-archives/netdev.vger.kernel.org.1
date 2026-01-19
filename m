Return-Path: <netdev+bounces-251148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C860D3AE94
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAC753013A29
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CD38756E;
	Mon, 19 Jan 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foczGcnf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365138756A;
	Mon, 19 Jan 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834865; cv=none; b=k53a3lnGXByCeJ3ubEj6rWxnwcGFqvgAdJjN5p3/38/+/goF+WBJMIwQmcVN4sTevg3sEmjfXtFCl5kaXOctRKQLElHIWuIZUcXHeWbY/5DmX5BqtNsHn9tWbS1appCcGA5ZHunsVc4YBDMIkAYbxAgbmD5WU7yiD/TKgFKkDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834865; c=relaxed/simple;
	bh=rZWOjmKSKkWcZ0Iz8CSlQeyUKq9sNPT5pR7SlwnYWic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4XaRPZo2uJcpO153TBUmfyHqCZ58Ts4DMyUpu12LxWN6ebY3o23Vz4NCZOCWzeTqTYyoqmiTgmh+bCq1vIvkOy1wuz61ssSRztkF9QcHEVWYBG1d9i7NsjgPupF3EGTrRscEpG0JXD+zYecUKunH+YSdlxoFStDRxxqFLq4DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foczGcnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F31EC116C6;
	Mon, 19 Jan 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768834865;
	bh=rZWOjmKSKkWcZ0Iz8CSlQeyUKq9sNPT5pR7SlwnYWic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foczGcnfDQ72HZUZ8pW9lkg8zpMvn1xLg9KV1ZOdP8dTAQWMqzj6SNBdRiiORiXTG
	 71EssndGKlhT6FMzxaP4HOKjgriqGvSP2Szc2SZVQNhqddUa25b+Fi238aWgGv8Ak9
	 k84DVcVbdp3T35Z8ajQRLohSPPPvBvSRJITFKKG6AxXYuVlGbaKSeDLMgxz3w3Vexg
	 k/8vtQWyrevBh+CCnmFVJh4NAMGDthQARHj2q38yT4kx728hgQw87MEb9y9Th7zfIt
	 G74Ww2/1QPd1Apc+U1Tfzbwu7Tc6piaaBSr4jymfQiyqr/lN8m4vluoD9d6MhR6LNj
	 HdlRXzy++s+vA==
Date: Mon, 19 Jan 2026 15:01:00 +0000
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Message-ID: <aW5HLPxp5oBzZVIM@horms.kernel.org>
References: <20260114065743.2162706-1-hkelam@marvell.com>
 <20260114065743.2162706-3-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114065743.2162706-3-hkelam@marvell.com>

On Wed, Jan 14, 2026 at 12:27:43PM +0530, Hariprasad Kelam wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c

...

> +
> +int otx2_devlink_traps_register(struct otx2_nic *pf)
> +{
> +	const u32 groups_count = ARRAY_SIZE(otx2_trap_groups_arr);
> +	const u32 traps_count = ARRAY_SIZE(otx2_trap_items_arr);
> +	struct devlink *devlink = priv_to_devlink(pf->dl);
> +	struct otx2_trap_data *trap_data;
> +	struct otx2_trap *otx2_trap;
> +	int err, i;
> +
> +	trap_data = kzalloc(sizeof(*trap_data), GFP_KERNEL);
> +	if (!trap_data)

Hi Hariprasad,

If the code reaches this line then the function will return an
error value, and pf->dl->trap_data will be NULL.

> +		return -ENOMEM;
> +
> +	trap_data->trap_items_arr = kcalloc(traps_count,
> +					    sizeof(struct otx2_trap_item),
> +					    GFP_KERNEL);
> +	if (!trap_data->trap_items_arr) {
> +		err = -ENOMEM;
> +		goto err_trap_items_alloc;
> +	}
> +
> +	trap_data->dl = pf->dl;
> +	trap_data->traps_count = traps_count;
> +	pf->dl->trap_data = trap_data;
> +
> +	err = devlink_trap_groups_register(devlink, otx2_trap_groups_arr,
> +					   groups_count);
> +	if (err)
> +		goto err_groups_register;
> +
> +	for (i = 0; i < traps_count; i++) {
> +		otx2_trap = &otx2_trap_items_arr[i];
> +		err = devlink_traps_register(devlink, &otx2_trap->trap, 1,
> +					     pf);
> +		if (err)
> +			goto err_trap_register;
> +	}
> +
> +	return 0;
> +
> +err_trap_register:
> +	for (i--; i >= 0; i--) {
> +		otx2_trap = &otx2_trap_items_arr[i];
> +		devlink_traps_unregister(devlink, &otx2_trap->trap, 1);
> +	}
> +	devlink_trap_groups_unregister(devlink, otx2_trap_groups_arr,
> +				       groups_count);
> +err_groups_register:
> +	kfree(trap_data->trap_items_arr);
> +err_trap_items_alloc:
> +	kfree(trap_data);

And if the code reaches this line then the function will
return an error value, with pf->dl->trap_data set to a pointer
which has been freed.

> +	return err;
> +}
> +
> +void otx2_devlink_traps_unregister(struct otx2_nic *pf)
> +{
> +	struct otx2_trap_data *trap_data = pf->dl->trap_data;
> +	struct devlink *devlink = priv_to_devlink(pf->dl);
> +	const struct devlink_trap *trap;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(otx2_trap_items_arr); ++i) {
> +		trap = &otx2_trap_items_arr[i].trap;
> +		devlink_traps_unregister(devlink, trap, 1);
> +	}
> +
> +	devlink_trap_groups_unregister(devlink, otx2_trap_groups_arr,
> +				       ARRAY_SIZE(otx2_trap_groups_arr));
> +	kfree(trap_data->trap_items_arr);

But, if otx2_devlink_traps_register returns an error value then
otx2_devlink_traps_unregister will be called. And the like above
will dereference pf->dl->trap_data.

> +	kfree(trap_data);
> +}

Flagged by Claude Code with Review Prompts [1].

https://github.com/masoncl/review-prompts/

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index a7feb4c392b3..5da1605a1a90 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -3282,6 +3282,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_mcam_flow_del;
>  
> +	err = otx2_devlink_traps_register(pf);
> +	if (err)
> +		goto err_traps_unregister;
> +
>  	/* Initialize SR-IOV resources */
>  	err = otx2_sriov_vfcfg_init(pf);
>  	if (err)
> @@ -3314,6 +3318,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_shutdown_tc(pf);
> +err_traps_unregister:
> +	otx2_devlink_traps_unregister(pf);
>  err_mcam_flow_del:
>  	otx2_mcam_flow_del(pf);
>  err_unreg_netdev:
> @@ -3514,6 +3520,7 @@ static void otx2_remove(struct pci_dev *pdev)
>  	/* Disable link notifications */
>  	otx2_cgx_config_linkevents(pf, false);
>  
> +	otx2_devlink_traps_unregister(pf);
>  	otx2_unregister_dl(pf);
>  	unregister_netdev(netdev);
>  	cn10k_ipsec_clean(pf);
> -- 
> 2.34.1
> 
> 

