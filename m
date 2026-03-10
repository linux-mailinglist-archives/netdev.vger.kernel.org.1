Return-Path: <netdev+bounces-265984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOreHA/zr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:31:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2091249688
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 825B630CAD52
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1652370D4F;
	Tue, 10 Mar 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7BhwY9u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F492D24B7
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138700; cv=none; b=L3pPZxJGUOsAF8fJQHFKF8bq5tR2bGiLGB1jRCjW/MX6izfTSL06Ey4F8Hl3JhjbWVbFvBeuvPDW9kxdkr4FGhkcOWNnxwc7DY8tfcv0xmiNNRWRiUDTC+ug3LmUkEuNZS1E5xT4fkdC8FVVPYykHT5jwqygL7f5EVsQ0eAO1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138700; c=relaxed/simple;
	bh=XV6Oz7u1T/2j5qrwX1qOo6PhgGykz9lb2mI/7CFF2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcYHDeI1MhPbl75jfGpKQnhGQ7hWXvzpwnAg0hiCq9Yy+2DORpFzXKODszLZI5Nik+arQ9Wh9wmuY+bsHgEJyYGofWywbN1nK97OzsU5voRpSG/H/kkPnmKsPriWWdsxruBQhlUlsnt6uD46MEJoL7ttjmTDzR38KVqTcZ/1Tgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7BhwY9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA7EC2BC86;
	Tue, 10 Mar 2026 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773138699;
	bh=XV6Oz7u1T/2j5qrwX1qOo6PhgGykz9lb2mI/7CFF2fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7BhwY9uyy91JdjHBR1chYrF3ua9YmjHCcbiDwfjDAy5StcIhp7zQ2Px7ASx2npae
	 iwD4ScVocQKHlZuv2zimrQELGMBInrabajLwcfmbKx65lHyu7ZPV+Au92uByXrlTA3
	 fArfVRK3guJG7hoM0VSHBbgIvsARWarUrARri4j7NsPaiWtp8mxiS4a1Ad4TrmQ6Kx
	 aRHl78ak4rB4J/BRstxo6+46tH3dmikFY7mg7myrWRFxFcz86iDvmVeLO687riaxnA
	 65Vteysyk+q5F7n8cZNcRIaMfbvLHLC2dTn7/0n/jp2vYGPF5B6j4t6ZSK+b/TcyxZ
	 I7iEmgIAXfwag==
Date: Tue, 10 Mar 2026 12:31:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <20260310103135.GB12611@unreal>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
X-Rspamd-Queue-Id: C2091249688
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265984-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:32:34AM +0100, Sabrina Dubroca wrote:
> In all callers, x is not an __rcu pointer. We can drop the annotation to
> avoid sparse warnings:
> 
> net/xfrm/xfrm_state.c:58:39: warning: incorrect type in argument 1 (different address spaces)
> net/xfrm/xfrm_state.c:58:39:    expected struct refcount_struct [usertype] *r
> net/xfrm/xfrm_state.c:58:39:    got struct refcount_struct [noderef] __rcu *
> net/xfrm/xfrm_state.c:1166:42: warning: incorrect type in argument 1 (different address spaces)
> net/xfrm/xfrm_state.c:1166:42:    expected struct xfrm_state [noderef] __rcu *x
> net/xfrm/xfrm_state.c:1166:42:    got struct xfrm_state *[assigned] x
> (repeated for each caller)
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 98b362d51836..7a68c594ce37 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -53,7 +53,7 @@ static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
>  static HLIST_HEAD(xfrm_state_gc_list);
>  static HLIST_HEAD(xfrm_state_dev_gc_list);
>  
> -static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
> +static inline bool xfrm_state_hold_rcu(struct xfrm_state *x)
>  {
>  	return refcount_inc_not_zero(&x->refcnt);
>  }

This change makes me wonder why we need both xfrm_state_hold_rcu() and
xfrm_state_hold().

    932 static inline void xfrm_state_hold(struct xfrm_state *x)
    933 {
    934         refcount_inc(&x->refcnt);
    935 }

The function signatures differ, of course, but it still seems worth
considering whether they could be unified.

Thanks

> -- 
> 2.51.2
> 
> 

