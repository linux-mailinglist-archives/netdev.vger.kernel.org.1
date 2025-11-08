Return-Path: <netdev+bounces-237007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02313C43193
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 18:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BEF3A1B72
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24C227EB9;
	Sat,  8 Nov 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBB0NZLp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A932116E0
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622418; cv=none; b=sJBSzhUD/KbmmBcwnxsaq47L9C51j6SM8oHlSGpT5TAhYacRtXJlZkkalxngBLlEJF7ZSH80o3BzzVdyNJINFN6Fi73n2jrdo15AMp5bUuOBymJCCVRCkBBHHggXMgZLkKaKcmVhlWnd/EEUmw4jtJtPUKrbLZDvXOvbpTASxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622418; c=relaxed/simple;
	bh=4uBXZNjEeUsMFg1PyKHuxUfuFeuIUqbxNWqH+XsncZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6IeXoKCWxVB0FPVsjO+gUEdScDw/5PuBFpxAeg5AQbTqYI813Kx6CPzqsgL6AfSgA6mD38KrQJ4etkQ6afAG1p7eMFvxq9ZsJ3vn7MGf9732/lFUNlH04TCLur/wFxRqqrce5zNdYSbF8ZsY5EibK7PmvMvFMNcug9RBLfYtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBB0NZLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533CAC4AF09;
	Sat,  8 Nov 2025 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762622418;
	bh=4uBXZNjEeUsMFg1PyKHuxUfuFeuIUqbxNWqH+XsncZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBB0NZLp5IH2E2etese6w6N2OmdjvSftvJX5j98h1R8XtJu21Q7Dfhq51/XRWtgrH
	 hGr4UIa+biFRFYlok4QKaNz8i1PExtd5xQPoBt5ukAjyafVjOa3uctbi8Lhy6hTBuq
	 RDfyP/jmtOk/BBdbZ3XeKr1N4c81dpgZxrZ6HxQmsyHEN+kQ55F/x/wS8fSaD2EItr
	 EHiiq4/jamcGK1luSUdnwf8jLfsf5fsdJdslUSvaFhPNc/tHYyoUA3K7nlo3D0z8fq
	 a+B5U3ghKA+IPCsziyZQFhGvbMqmtQXMlwmbEA29VwCRWQHKs64bIPvopCeyatp7ZV
	 zvHPGj4ZxFPEQ==
Date: Sat, 8 Nov 2025 17:20:15 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan][PATCH iwl-next v9 01/10] idpf: introduce local
 idpf structure to store virtchnl queue chunks
Message-ID: <aQ97z8ZZToGIxb3X@horms.kernel.org>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-2-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021233056.1320108-2-joshua.a.hay@intel.com>

On Tue, Oct 21, 2025 at 04:30:47PM -0700, Joshua Hay wrote:

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c

...

> @@ -1237,6 +1242,8 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
>  
>  	return vport;
>  
> +free_qreg_chunks:
> +	kfree(adapter->vport_config[idx]->qid_reg_info.queue_chunks);

I think that the following is also needed here, to avoid a subsequent
double-free.

	adapter->vport_config[idx]->qid_reg_info.queue_chunks = NULL;

>  free_vector_idxs:
>  	kfree(vport->q_vector_idxs);
>  free_vport:

...

> @@ -3658,6 +3668,11 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
>  	rss_data = &vport_config->user_config.rss_data;
>  	vport_msg = adapter->vport_params_recvd[idx];
>  
> +	err = idpf_vport_init_queue_reg_chunks(vport_config,
> +					       &vport_msg->chunks);
> +	if (err)
> +		return err;
> +
>  	vport_config->max_q.max_txq = max_q->max_txq;
>  	vport_config->max_q.max_rxq = max_q->max_rxq;
>  	vport_config->max_q.max_complq = max_q->max_complq;
> @@ -3690,15 +3705,17 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
>  
>  	if (!(vport_msg->vport_flags &
>  	      cpu_to_le16(VIRTCHNL2_VPORT_UPLINK_PORT)))
> -		return;
> +		return 0;
>  
>  	err = idpf_ptp_get_vport_tstamps_caps(vport);
>  	if (err) {
>  		pci_dbg(vport->adapter->pdev, "Tx timestamping not supported\n");
> -		return;
> +		return err == -EOPNOTSUPP ? 0 : err;

If a non-zero value is returned here, then
the allocation (of adapter->vport_config[idx]->qid_reg_info.queue_chunks)
made in idpf_vport_init_queue_reg_chunks() will be leaked.

I think it should be both freed and set to NULL in this error path.
Which I think suggests a helper to do so here and elsewhere.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/


>  	}
>  
>  	INIT_WORK(&vport->tstamp_task, idpf_tstamp_task);
> +
> +	return 0;
>  }

...

