Return-Path: <netdev+bounces-288189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODzdITi4BmocnQIAu9opvQ
	(envelope-from <netdev+bounces-288189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB144549DA8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFA9B300E614
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2D378830;
	Fri, 15 May 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgkUg8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143D377543
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825266; cv=none; b=TgCpsLLlPE6SwZL5UxSvpygbOj1btqfMVhxZo1iMXZmeEyXVHhgADFqVwOSoQh7VvdNXhqpBacCXWMcUz02UnfRx2sPWfXm5EF5JvoAnClssyFlljM8UD7Ujh6qX63C7k+hUlMtjepmQbBGKgs6wurhcpQ8FWAohM4zopgii9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825266; c=relaxed/simple;
	bh=+os5diGbM0rQuQsh1pnR7VysuCSPjKqRUmyB+QHMOog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVdZLFmN3ySzo97dFTEQO+ZQYPddhl21Rm6Wh35WnvY3IgBySk3N7kVfjOX7AoXGjFvr8eKB53ffPmcfiaeoP3JrhVyOLOE9mm8jcKccE+sDAM7P2/77dE5EhVXNnzbAqcwcmQKAEyfc/aFIvSlPsj5VKMGa9OzrXEWOk80KyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgkUg8B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c827313dac0so274184a12.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778825263; x=1779430063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itu1od+G5dozoGgTbnQ0j5SYYRoj4kQeiJIPcCU4pOI=;
        b=NGgkUg8BI2nv/Ork8CXqzSiHg01ryrpFNil7mDOZ9nPRVSpPp9iY5rA6c7KokxRBCR
         a274nHse3H9vi+SVuo/GkFQn96sCNdvuQzvPMfBn3m4NLbxzhRGsPBSjRQsJIpzGPHId
         dN7SdG3lprgsntNbqEijvJs7NvBkyRcSq2nTFzXXljYKYMzkPKOJbBh/X2Gqk+Ka3UL0
         94fk4CWwi70u6yTNgJocaR977sNcaaDvJtna6QLkwk4v/WFavjZLr9lEUlyB09leZq7R
         uKX1KxWA1V6Xw674tt3w87O4He2HEKiI2O4Jt7JdUTDwis7KZx+55TLZIrLzb6ALAFIO
         xYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778825263; x=1779430063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itu1od+G5dozoGgTbnQ0j5SYYRoj4kQeiJIPcCU4pOI=;
        b=lRizZF7Mpdq2RbXNy/aa/JFN7jOcI8YlVX4msCPF4nWq+Ca+RzoEi8MMNMvBB7hz/j
         rPBGEL0PQohZKb/xDhhvxsOiDC/cNCnAu8VdVcOjnZKmkyymIKwBHevozTkC7Yj5anY9
         JuTEhGQ7smIP0Tg2VUBF34C4nGK2bQF0DNsneLQjbgvsTiU0A5eKjcFe66Bz+n3Ist1y
         CEORPJCvt+OKZMYHVI2FUGP5AGsinB2nQbfB43LwwY05CbHyiQBn3jshXNYdaOLWMsTN
         E1bxXv+UZF3AWje1JmYdi+xlFEjgVfbyn7AcMDhl6wCIAq7ZmtGNRNL+86eNb5RdKP9v
         BrCQ==
X-Gm-Message-State: AOJu0Yy7jBduyxNh0+zKvwZo4GbT189aWpdoVTZdwEo3n3muC1HYZuHo
	MPVfsJTylrJJavFEumkJ1iscoBWjBl3K2m6zsxdJeHEuPnsYBvujYi+m
X-Gm-Gg: Acq92OHJNlRqtLeQdOtcsW8rOOYa+F+aMjYqBdseDYHicBsl31odexXXB2JCzOYFAh9
	NAu2wMDPvxnM9mA3vSpDbSK1d0+4rIbyNjCMbq2/tQ2UDNteS0mXI+OI1kNe3LFhvaDWZf+h7FD
	V34JY1ea/9j3S+WQ4BC9dBUgrmyz24P5PM1izErO3aoyrRHcD8YvfD5ubflMPbKb3J1mpWFtJAm
	ogJKLkU63BVxUs164+Gm7vrfsX8J/rAVL3xK/DDKUni5KJOzmBJtLZTmVeoyQM9pje3KgqaBwDI
	bZZ9UDx0LE9p6ShZsqG5xe1vgDbO5H6INGPBUnv7Gi7IObAfoJjVTYA9QRWqss4Nndn1NdLba6d
	sUyK/UZy1nJYo9fd7/MxazC63K03aY4/0tcBFwu+PsV2rXaQtTeM6v5W1LcyLeUiYbVJ/5+Ttz3
	W8eZFtgoUeua8SsVmY72Wkef8JzzoIZJNTQ1Yi+lb2YOw=
X-Received: by 2002:a17:902:ef08:b0:2bd:8a97:14fc with SMTP id d9443c01a7336-2bd8a9716d9mr10354565ad.1.1778825263036;
        Thu, 14 May 2026 23:07:43 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d23044csm44639995ad.78.2026.05.14.23.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:07:42 -0700 (PDT)
Date: Fri, 15 May 2026 15:07:37 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, sd@queasysnail.net, malin89@huawei.com,
	tanjingguo@huawei.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <aga4KZtvaRQAMv6B@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aga1VyHpHaUhnGZa@v4bel>
X-Rspamd-Queue-Id: EB144549DA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288189-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,queasysnail.net,huawei.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kerneltoast.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:55:35PM +0900, Hyunwoo Kim wrote:
> Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
> to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
> moving frags from source to destination.  __pskb_copy_fclone() defers
> the rest of the shinfo metadata to skb_copy_header() after copying
> frag descriptors, but that helper only carries over gso_{size,segs,
> type} and never touches skb_shinfo()->flags; skb_shift() moves frag
> descriptors directly and leaves flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> The former moves the incoming skb's frag descriptors into the
> accumulator's last sub-skb via two paths (a direct frag-move loop and
> the head_frag + memcpy path); the latter chains the incoming skb whole
> onto p's frag_list.  Downstream skb_segment() reads only
> skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> shinfo as the nskb -- both p and lp must carry the marker.
> 
> The same omission also exists in tcp_clone_payload(), which builds an
> MTU probe skb by moving frag descriptors from skbs on sk_write_queue
> into a freshly allocated nskb.  The helper falls into the same family
> and warrants the same fix for consistency; no TCP TX-side in-place
> writer is currently known to reach a user page through this gap, but
> a future consumer depending on the marker would regress silently.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>

Since they are asking for credit, I will add them:

Suggested-by: Lin Ma <malin89@huawei.com>
Suggested-by: Jingguo Tan <tanjingguo@huawei.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v4:
> - Include the tcp_clone_payload() propagation suggested by Sabrina.
> - Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
> - v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/
> 
> Changes in v3:
> - Include the skb_gro_receive() audit patch suggested by Sultan
> - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> 
> Changes in v2:
> - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> ---
>  net/core/gro.c        | 4 ++++
>  net/core/skbuff.c     | 3 +++
>  net/ipv4/tcp_output.c | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a..9f8960789b2c 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -213,10 +213,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  	p->data_len += len;
>  	p->truesize += delta_truesize;
>  	p->len += len;
> +	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>  	if (lp != p) {
>  		lp->data_len += len;
>  		lp->truesize += delta_truesize;
>  		lp->len += len;
> +		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>  	}
>  	NAPI_GRO_CB(skb)->same_flow = 1;
>  	return 0;
> @@ -244,6 +246,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  	p->truesize += skb->truesize;
>  	p->len += skb->len;
>  
> +	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>  	NAPI_GRO_CB(skb)->same_flow = 1;
>  
>  	return 0;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9c4e8d331d6d..7cd388504297 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
>  			skb_frag_ref(skb, i);
>  		}
>  		skb_shinfo(n)->nr_frags = i;
> +		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>  	}
>  
>  	if (skb_has_frag_list(skb)) {
> @@ -4349,6 +4350,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>  	tgt->ip_summed = CHECKSUM_PARTIAL;
>  	skb->ip_summed = CHECKSUM_PARTIAL;
>  
> +	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>  	skb_len_add(skb, -shiftlen);
>  	skb_len_add(tgt, shiftlen);
>  
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f9d8755705f7..6e4bb411dc04 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
>  			todo = min_t(int, skb_frag_size(fragfrom),
>  				     probe_size - len);
>  			len += todo;
> +			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>  			if (lastfrag &&
>  			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
>  			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
> -- 
> 2.43.0
> 

