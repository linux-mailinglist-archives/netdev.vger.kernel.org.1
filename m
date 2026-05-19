Return-Path: <netdev+bounces-289612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHM0ByvRDGrImQUAu9opvQ
	(envelope-from <netdev+bounces-289612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:07:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B50B584FFA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2B0A303810F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2643E3175;
	Tue, 19 May 2026 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvk7k1J0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39132848A0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224871; cv=none; b=S1UssMjeF4mHsD/EUdqBgngcqFxmhkI0ms1eY4+D0b+3hmiraMLlBHwzlOIE0YGqoN2anko664SORvFyNbr8+aewuLA2pPQgoSC+nKll44ugKUiHeFdm4HR3hCmELShNfAjQviq1WUpms2uMRbUj9P7Nigq2TI4uRX0VKb7sFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224871; c=relaxed/simple;
	bh=8Da4dPOOKKC9Yw0fFkeVaJMYMU3MEjd7WJQsKu8y03k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gajuIMe0Ey0G+H7ZYjDuLeS2WbtrWcax2RYlscouahG1VnYMB1RV9Imq4NdLf44hMj0h6KFa4exztTk2e+dsurmvYomMcGnt9mz9BeHjGSyqBPDtOsKB/N3oSiV6HVdSUod/qmH0+3W5eD9072Qf2fkaWEOCpTnraRXqrTu4+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvk7k1J0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90cbb2b50ccso319243285a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779224868; x=1779829668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QeekahOvLmAA/dYAwVekuXUChV8CZojKF427f4ixlQQ=;
        b=Lvk7k1J0rAwHXxw50LFHzA6K3iRoNoQbSO63eMTs3w7slIRoI4LfahfOZfN4mKDscU
         1ol2gL/5rIpQQ4yY86iO6/qGgOPVmqe77niTPaJatpfN7nZ77MQQU6uFzA2b8TS7MW2o
         oBu8+5zN5rN4WbV6zkM/k1pUoKa1FO3Bcpls5W71P1eAVajepPZdg4ix8dPD5c2jzLB6
         meFdGbM5Yf8crnXKpxMdCXdHLlOATZhMRTPP2OvZ/RC6wSmiPjEpJjPjcoYpqfBSpLy7
         0UCP/iwzMP/3m7BuWbxmAQgLdR4Q+9wDUj/ZzPDnhu6v00dCv8sjs/I2OQ5KNI/LhGMG
         TM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779224868; x=1779829668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeekahOvLmAA/dYAwVekuXUChV8CZojKF427f4ixlQQ=;
        b=WJieGnL7Gj/JI5+ab5HnezG5ErpKsczxeCzV2R5vhrXzT73iLG0hCjNBLRi6sHFzXS
         oP56fpHD2TJa2ddvtHkhdKnZXt9hs6zZjfrc8tCj2qCFsl5jSZEjHahBtXmy5oklAWJ4
         ISOrnsL/zIW0WW4Wfr0azIWFdsCndMRV3p2VnAxC+oiF0OWTDupXxg0jM//oa2AVn2Ko
         VyupgT34TIVka5ag7O6i1h3Kihy+s4zE4W7xUJb8NZ3czvI7i4YOdRp9HQfTfCWANqSq
         fuSZA1vHOz8ohwKk0aEt5W9D0Tgx7nthmNXusY+ey50u6TPoZ+Ar3gwYELLWnnjeidNG
         owbg==
X-Gm-Message-State: AOJu0YzF/R9HqzcA7MgnIgl0Q5Ajwk93Uz8g0axX/l8LDiZM9gZWqNFL
	8a+7Lh9/OWgcmWJVw6EpRAvs5aVTZP1B2b+tah9Kr6ilEbR6AL2nFF/S
X-Gm-Gg: Acq92OFEOC/obG2YlyrukFKooWXDd0m+cIEOwBmYM6ZwgyoW6JHKDcR+iEkW/3SXZ5W
	mmHh+zjXQiqny0G1cXRU6gZuGrBscFwywv1Wqajch+/dH6iacicslumNTYn0sMS/9bq+RUWHU3i
	a7xuT3ggPXkdgySJ+FUNFiDqhGgK/M8+xTZUmngXb/IIQvc/7xSlCE5sXrrej/UdHMa0/wQUHx/
	Q1Ur109Z8y4wlbm3aKUxGDSWGCirXJYg1Kv/jT8XHJ9L9lDNwMNyCiSI7xuVIDmg1UyIdTwVliH
	62lCkevsLRjOSbQm/d3A2G8s/EdtfuM7CIcmMuuS7oZFPo661Rt0XGAa5lbEF7+JdNo4hRGN2OM
	RBZImFYLabGQQTe0bEV7KP55XsbMGDgVy++n59ZMiW8KArYhR20WxiWfyO/ULi9dy849x2NLZvD
	pDja4AB8dEmuI7Bk4+m03Bp/ONXRunfZofc+dr6fNFTayo+7JlRDrawabG6Q==
X-Received: by 2002:a05:620a:294f:b0:8eb:41de:fb43 with SMTP id af79cd13be357-911cca9b97amr3243513785a.10.1779224867891;
        Tue, 19 May 2026 14:07:47 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f814:1e::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm1964749085a.28.2026.05.19.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:07:47 -0700 (PDT)
Date: Tue, 19 May 2026 14:07:43 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, sdf@fomichev.me, sdf.kernel@gmail.com,
	kaiyuanz@google.com, almasrymina@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned size or SG length
Message-ID: <agzRH1CdGV4dvkGh@devvm29614.prn0.facebook.com>
References: <20260519203530.66310-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519203530.66310-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289612-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 8B50B584FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:35:30PM +0100, David Carlier wrote:
> net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> PAGE_SIZE multiples without checking:
> 
>   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
>     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
>     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =
>     N*PAGE_SIZE + r (1 <= r < PAGE_SIZE), sendmsg() at iov_base =
>     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.
> 
>   - owner->area.num_niovs = len / PAGE_SIZE while gen_pool_add_owner()
>     covers the full byte len, so a non-page-multiple non-final sg
>     desyncs num_niovs from the gen_pool region for every later sg, on
>     both RX and TX.
> 
> dma-buf does not require page-aligned sizes, so the bind path has to
> enforce what its own indexing assumes. Reject both with -EINVAL.
> 
> The size check is TX-only (only tx_vec is sized off dmabuf->size); the
> SG-length check covers both directions.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> Changes in v2:
>   - Reframe commit message around the kernel-side OOB instead of
>     "real exporters already page-align", which read as the OOB being
>     unreachable and undercut Cc: stable (Stanislav Fomichev).
>   - Hoist the SG-length check out of the if (TX) branch so it covers
>     RX too; RX has the same num_niovs / gen_pool desync on a
>     contract-violating exporter, just without an OOB. Keep the
>     size-multiple check TX-only (Stanislav Fomichev).
>   - Drop bool todevice; compare direction == DMA_TO_DEVICE inline to
>     match the existing call site at the tx_vec[] assignment
>     (Bobby Eshleman).
> 
>  net/core/devmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 468344739db2..4f71de44c0fb 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	}
>  
>  	if (direction == DMA_TO_DEVICE) {
> +		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
> +			goto err_unmap;
> +		}
>  		binding->tx_vec = kvmalloc_objs(struct net_iov *,
>  						dmabuf->size / PAGE_SIZE);
>  		if (!binding->tx_vec) {
> @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		size_t len = sg_dma_len(sg);
>  		struct net_iov *niov;
>  
> +		if (!IS_ALIGNED(len, PAGE_SIZE)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
> +			goto err_free_chunks;
> +		}
> +
>  		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
>  				     dev_to_node(&dev->dev));
>  		if (!owner) {
> -- 
> 2.53.0

LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

