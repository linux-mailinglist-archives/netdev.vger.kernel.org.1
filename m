Return-Path: <netdev+bounces-251698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gf0KCw0cGkSXAAAu9opvQ
	(envelope-from <netdev+bounces-251698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:04:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171A4F773
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16763B6D346
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47032D7F9;
	Wed, 21 Jan 2026 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1YQoDGr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CE30F7EF;
	Wed, 21 Jan 2026 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961045; cv=none; b=jkiJ5jdO3kaw62XMJUuhWxoGw8q7jzT3dNXqzKqROTbITfx5f+d1Y2DP4wYWHqymDIs+tAUm0tY5tkvW6TzDBTS9PNL4SdpgM9oU7nNYXTApfrUEgFTAIT670cLZftKEp69efksN0z/U7updCzHxXZkkk6ZUDSC7zuzqSURRjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961045; c=relaxed/simple;
	bh=n713X3MNMSqrvZT0f94Zhy1sZtKbysaEfru5CFyu8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJYufycuDRfbESgGYSXGBwZLYsb6MY9KsekDbhQs05rS7nA6tBN/hAn6zwCWgFkBlHVSE10bH13gNsCbMSKdd0DUWu1ARLDrwyjKBI/oPE2dTq3zRBT6jpfNSuBIcL3wSy12znSbPEEZifesBXgEn/f+kDgbLR6eZOOkfAoMMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1YQoDGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2490AC16AAE;
	Wed, 21 Jan 2026 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961043;
	bh=n713X3MNMSqrvZT0f94Zhy1sZtKbysaEfru5CFyu8qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1YQoDGr3YmhCdHDcTcTKeK5VrZf6mfSIcwc97uAnZ928qj53N30NkUWGCjQAzk3g
	 z3icYN1uUBSnoISPgKXyHeibDzjkkUFrxKKe69yAhro5NCkMjbFuAbTdJ0nIcfTvl6
	 C5H3fQgIekO5TcTOA37woRv+QiPiV8P5AN62+C86nfNKS7SH/ljOBsS9rK37JQzmyI
	 yy/DxmGfpNptHX8GZTypgvbH1R8HeZxy1Vnuh8skF2oJ1TqGMs5TIMj1JH2nABSZyh
	 KKAQkoj1c2a9pLNjzyjfp0fkOLtrHigMvnieywovbiJTWfIxi9nB3qknzZU5ImJjPA
	 GlJ1KXJaoSzQw==
Date: Tue, 20 Jan 2026 18:04:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 05/16] net: Proxy net_mp_{open,close}_rxq
 for leased queues
Message-ID: <20260120180402.2b9ab13a@kernel.org>
In-Reply-To: <20260115082603.219152-6-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
	<20260115082603.219152-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	TAGGED_FROM(0.00)[bounces-251698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2171A4F773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 15 Jan 2026 09:25:52 +0100 Daniel Borkmann wrote:
>  	if (!netdev_need_ops_lock(dev))
>  		return -EOPNOTSUPP;
> -
>  	if (rxq_idx >= dev->real_num_rx_queues) {
>  		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>  		return -ERANGE;
>  	}
> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>  
> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);

The white space changes here look haphazard.

> +	rxq = netif_get_rx_queue_lease_locked(&dev, &rxq_idx);

I really hate this function but I don't have any great suggestion on
how to make it better. I'd prefer if there was a clear separation
between the case where we call directly, vs where swapped the queue.
Instead of replacing pointers passed in by reference :| And that'd 
remove the conditional locking too.

> +	if (!rxq) {
> +		NL_SET_ERR_MSG(extack, "rx queue peered to a virtual netdev");

The fact the !rxq means the queue was leased is also fairly random
vs all the subsequent checks.

> +		return -EBUSY;
> +	}
> +	if (!dev->dev.parent) {
> +		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");

mapped? Or belongs?

> +		ret = -EBUSY;
> +		goto out;
> +	}
>  	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>  		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (dev->cfg->hds_thresh) {
>  		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (dev_xdp_prog_count(dev)) {
>  		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
> -
> -	rxq = __netif_get_rx_queue(dev, rxq_idx);
>  	if (rxq->mp_params.mp_ops) {
>  		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
>  #ifdef CONFIG_XDP_SOCKETS
>  	if (rxq->pool) {
>  		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;

All these checks can be factored out to avoid making this function long
and having 5 gotos.

>  	}
>  #endif
> -

Please lease my whitespace be.

>  	rxq->mp_params = *p;
>  	ret = netdev_rx_queue_restart(dev, rxq_idx);
>  	if (ret) {
>  		rxq->mp_params.mp_ops = NULL;
>  		rxq->mp_params.mp_priv = NULL;
>  	}

