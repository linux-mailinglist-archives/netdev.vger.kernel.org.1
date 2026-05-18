Return-Path: <netdev+bounces-289117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLGFAVU/C2pdFAUAu9opvQ
	(envelope-from <netdev+bounces-289117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0516570F8F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1E88301067F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879CB3F6C3E;
	Mon, 18 May 2026 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXdf2Qn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E126ED5D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121580; cv=none; b=DKtJp9OFyZMUWszmmmtnqio40PwmLc0wdpirTpoZn8fw/gkUUU69ZrRFks3GhBfJV5ZfZ9Duq923ehsLZNGv/vcuipvNbtVoXxXPgzyIhG6vVMJwdJuvv62RAieVsKkt3UwJW05E1931w1yz1C9kW9DKrXNUn9GXruPsH1A0x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121580; c=relaxed/simple;
	bh=9ibhTgmdgaVzvd0/WVlmmQhIMZ5I9GFkwHv21SR22uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM9ijT5CNO6CyB7yryeaz6Zb2RnnMCtsa1vYMSaGcXfTeMFTzmscibN71l0lqboat3OZdiR+h/fuQp3lbs+b3hwcVtfFvRpOrw2yRCqO2qT4AA6eBUEjnZSE4G4cJsExp4YwLrW1pA2SVVFN/zQIhGkvkMqIfPGZe3p+scJfaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXdf2Qn; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c58e6eb3edso19378157b3.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779121578; x=1779726378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEH0kDlr/EF8Y5XVB7DOIIT0Vo/0czOU72ejpPKh4QE=;
        b=ezXdf2QnlBjLWokkUmX16ocXYZ/LeIlHH2ECdtigw0mbWF0vSqN700a8yVSs2K8qRc
         sOXRsaMPE9+7ddA+YcZaE6iENq2voDaEUTrVWNu+hBaLbB7mv9zopUIFe9XdOIJieNx5
         A8jpdfey4jZJfnyzLPQ75+h/3dkVqqXJgdCOav+XWMfQwUIGVrXz7jOq2S3U9eMabZh3
         NFRITIdrkHjNI+TezhUiHaMCuOSTwX46vOZKjZC3QQiGnN6ITkXcqvognDXOtTzx/TE4
         xfKZuNXm/BahjtUUamJQljbyL6dcVljxggubKNUUSdOaWAq5YSH+vOf95VK1zuEFxgm8
         3igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121578; x=1779726378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEH0kDlr/EF8Y5XVB7DOIIT0Vo/0czOU72ejpPKh4QE=;
        b=rFUSlAnRUV8OSoeLN0VJ3ZgqIu8P6LyWh6Q95rQstjstk6f4L0HVg+t53iUdpu2cUU
         ZXJ7ih1JhQgsOiPsx0Kg4FZWc+n5Afbn5ukfVWZZXpfv/l8QNV3Z/LplDPyYHdwaecw3
         xS2WzOtgeba/wMjplsTgTSff+oWllfLIok4bw5SjLhmITOyPM+tvKq75YhBSIadSuLfE
         c2GFGcQlgad9/W85Qy+mQkln3XUneSOIycW2KM0AWJfcDur+PzTDqxFA7CcP0N/yzIGE
         ojKBhGAIuw5lT18KQcBGQODG6tn90/DET5Cn6goEC+4EjtN3qwX0T68h1BLoX/WNzv79
         wefQ==
X-Gm-Message-State: AOJu0YynmgEWS7f0+Ebm+18D+WTT/Rr3n34raThkEGMUPbJgNXi22n0B
	ynVzZXksRCpLZ9J7p7A60yJmE99f7ETYYYLpmY6WP+m43jfo65eTm/SA
X-Gm-Gg: Acq92OF5poYmA7ax0cAqGnah/XHvoQ7VTDWtbhKU/eWxTWIbxRrX6BeKXNBd1z5v0B9
	PSZ8GhwuglsNOl54SLVEZaoLIlBvX+VmYm+y7VOfDEJDBhbKLzXFxsnSm2dwWGFAxm6oJyB5gz4
	T8sPlCayhdeepozvYKk9sV2jZnmp3paamIG8vm/nbKRs0Q/7YTM83NenZJBMD84wAlgADIVVWcw
	8lp6kp9+4Y8PwPhkIxjp/lwFlzZ5KD95ewxbJAe7j51dsSOhP4NeJDJTIXPn5JlrbTPqFlkF7Cf
	ngQlCvgCCUtrPQmE9Mxayx7M5cWNCcRxCZAgTx9d6kdBDrZIWk/lEYfZ9Hvba9SOrV9ImiaP+bT
	buHdRzdqKFgVLGgZzSuUzf/ytiQ2EOq7OjCdNzKEC9AJvLfpMJ3DGPKlWFfpWJxNtRYM80ppP2J
	bxgXLTNoWcF8n9bgXd0BxxivbsTbb1cz42124c0VA6Q80UMY0=
X-Received: by 2002:a05:690c:9304:b0:78f:bc2b:83f5 with SMTP id 00721157ae682-7c95a087a51mr151158297b3.20.1779121577988;
        Mon, 18 May 2026 09:26:17 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f806:18::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6ce2f4sm23597927b3.39.2026.05.18.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:26:17 -0700 (PDT)
Date: Mon, 18 May 2026 09:26:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned
 size or SG length
Message-ID: <ags9po+uLZ++7FaP@devvm29614.prn0.facebook.com>
References: <20260517201814.222563-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517201814.222563-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289117-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Queue-Id: C0516570F8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 09:18:14PM +0100, David Carlier wrote:
> The TX dma-buf bind assumes dmabuf->size and every sg_dma_len() are
> PAGE_SIZE multiples: tx_vec is sized dmabuf->size / PAGE_SIZE and
> indexed by virt_addr / PAGE_SIZE, with only a virt_addr < dmabuf->size
> bound check. A non-page-aligned size lets sendmsg() reach the tail
> region past the last populated slot and read one past tx_vec[]. A
> non-page-aligned, non-final SG entry causes the same OOB indirectly
> by desyncing later slots.
> 
> Reject both up front. Real exporters (udmabuf, dma-buf heaps, GPU
> drivers) already page-align, so this only refuses layouts the TX path
> can't back correctly.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/core/devmem.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 468344739db2..e72f48ff9094 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	struct dma_buf *dmabuf;
>  	unsigned int sg_idx, i;
>  	unsigned long virtual;
> +	bool todevice;
>  	int err;
>  
>  	if (!dma_dev) {
> @@ -240,7 +241,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		goto err_detach;
>  	}
>  
> -	if (direction == DMA_TO_DEVICE) {
> +	todevice = direction == DMA_TO_DEVICE;

nit: this code already has precedent for comparing direction directly to
DMA_TO_DEVICE in line, so probably don't need to store in a new
variable. The binding->tx_vec[] assignment down near line 300 also does
this and is missed in this conversion.

Best,
Bobby

> +
> +	if (todevice) {
> +		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
> +			goto err_unmap;
> +		}
>  		binding->tx_vec = kvmalloc_objs(struct net_iov *,
>  						dmabuf->size / PAGE_SIZE);
>  		if (!binding->tx_vec) {
> @@ -267,6 +275,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		size_t len = sg_dma_len(sg);
>  		struct net_iov *niov;
>  
> +		if (todevice && !IS_ALIGNED(len, PAGE_SIZE)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "TX dma-buf SG length must be PAGE_SIZE aligned");
> +			goto err_free_chunks;
> +		}
> +
>  		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
>  				     dev_to_node(&dev->dev));
>  		if (!owner) {
> -- 
> 2.53.0
> 

