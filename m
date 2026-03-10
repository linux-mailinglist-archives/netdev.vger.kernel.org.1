Return-Path: <netdev+bounces-266372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lmZWAeOhsGl6lQIAu9opvQ
	(envelope-from <netdev+bounces-266372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:57:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D025919D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7280317750F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E738D693;
	Tue, 10 Mar 2026 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="COo7eqMr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oo01Fg1T"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A231960A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183455; cv=none; b=GaRGQ9B/gROar2bX6WdCaH7fSBNR+ho2utlzitHx+G5pAEZFmW22rKfma2+pxvTBTs6U8uGAddtelUuMXnEslYy4/KcEqDpPkbJjtij6LPrH0PtKik9dqMr7erRvqnbkMB7XOJZqeWScuGX/H5sRMDDY+B0dA3OEnoTRuw4QZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183455; c=relaxed/simple;
	bh=Uuah5pMUN2QYvsnEweXnd3gAbDNsL8rCIDq6RgNF0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReQRd7eSU3YpPZ+2FIhOIfz1yrlt2YdJ5TYh5Jd3wWCSJFOnEd4e7C7U0re9J/0M4ILygxOD4+zBzO20gEvoGBCcNKmkJLF6gIHqNbx0RV+x36HW1Ywwo85J48BMNJHjhq/W0bvSEZzGPHB6JCELri+b7ka8ExvjwtN5ohEZgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=COo7eqMr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oo01Fg1T; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6E0D7A020B;
	Tue, 10 Mar 2026 18:57:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 18:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773183451; x=
	1773269851; bh=ARsADLWiqEHkCon+akMXKpEPYDnBeiJg2xtrUprl64o=; b=C
	Oo7eqMrwb7/GG9umo9pzKWCNUWv/BEkX6DLL3Q7XsVVOORgf0hSBrPs+dqncL7Lh
	9UlRKVhtn/+B6Jax488UstMy8OSnZtZDljrXSXRWG8G/KoWQfAZUT+i+tmuEAOBf
	wkTPtCWEeXvXbT7mnGbdtaBRfPU7f3T9zxwb4HT5kxEzKKlIyfRqODdWCpx4rgbe
	dC9YN6nUeefzw+Ymki5EK+xKWdxAcz4oMh9RTWJsAm/4NvKDvwcCiipvCyrmejFB
	IuKJQz6mMdM9PeSvTZ0L9J3ocPPZntwHDj/jO3L0k+rH9yEVwyw9cpK/p3rcG2rq
	/LBFi+bw4Nkli8He467kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773183451; x=1773269851; bh=ARsADLWiqEHkCon+akMXKpEPYDnBeiJg2xt
	rUprl64o=; b=Oo01Fg1TJ3g4T4j/v2rrC0UpCI1hZ2hPv7BYEiZOsIb1RcGRHA4
	ZrE57mE+7zIFXnlZVhUfs/AtNNkC32BJgSVO8wry/8XqndfC5zxAqOupnoZT3VAc
	Kccl4XBy8KGYA78i/WPQ+m+vHvQuqNMIhHVyZFhJoUR7gZ4bL8VeMVKorLFJpfrf
	uA3mImhmD3/Ux2uKJY0HIydb1SXPDKlibLasqFpN/nvRYsgcxf/Nfu9RdqJg5w1z
	cXIbnxQE5Qz/e+KzSgJ2K6ILY4t7aLZBxQmiKxdZ4y3VTjmRg9hTrEpi7QwNXppY
	i31C84cqQ8rqsL0Cmyi9U3b9w8UVquX8kVA==
X-ME-Sender: <xms:2qGwaQAq4PWPhY-m6Gf53KG_CUY5ChqRQ8GFTZ4EHOIH2wPiHzFTYg>
    <xme:2qGwaYhZMKc0tvjIFhFybbYHUvMNQo3XmDiWBGyuvbnWAYLXnD-YMKhmI5wZ5FWuz
    lfhiFbtnQH0DcmyAGFBs1sp-v8G2nCUk9mJg-2pLBGZNHHFtRpBUow>
X-ME-Received: <xmr:2qGwaea3Jq1zH237aD7LmVOsTLBLpDHltM4U-wy1PEz67cA_NZF2ZuDFG9Sl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtghomh
    dprhgtphhtthhopegvhigrlhdrsghirhhgvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpth
    htohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphht
    thhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2qGwaZkBL0G_OVBt83FAaxevngt_dSa6RDO_FDIVRtpo01E0jeDFPQ>
    <xmx:2qGwaUjm-azZSY0WaVzRF_0fG1BAcq2NHRiMlGDUPfXivgwdEXmFvQ>
    <xmx:2qGwabRCJEhVmZsvlPjuZR7lr5RGfIdNru0a5BtdoT-y-oZk5eX0qA>
    <xmx:2qGwaVZinNiH9GzcaztFqbs-xrwL2UcrfTSNd6uPuBxrdQcyA_HwYA>
    <xmx:26GwaTsaoaXVJciViWUNP4naK5BuPRKtPpkFP_5CKjNRtA4NsaxK4jwr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 18:57:29 -0400 (EDT)
Date: Tue, 10 Mar 2026 23:57:28 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>, Eyal Birger <eyal.birger@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abCh2CgVS3Uw7W-_@krikkit>
References: <abBf_R81PYmafhWv@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abBf_R81PYmafhWv@v4bel>
X-Rspamd-Queue-Id: 210D025919D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Action: no action

Please also CC the author, and maybe additional contributors, of the
patch that introduced the problem you're fixing.

2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> After cancel_delayed_work_sync() is called from
> xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> states via __xfrm_state_delete(), which calls
> xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.

Eyal, I'm wondering why __xfrm_state_delete() calls
xfrm_nat_keepalive_state_updated(). At this point the state has been
removed from the walk list so nat_keepalive_work() won't do
anything. Am I missing something?

> The following is a simple race scenario:
> 
>            cpu0                             cpu1
> 
> cleanup_net() [Round 1]
>   ops_undo_list()
>     xfrm_net_exit()
>       xfrm_nat_keepalive_net_fini()
>         cancel_delayed_work_sync(nat_keepalive_work);
>       xfrm_state_fini()
>         xfrm_state_flush()
>           xfrm_state_delete(x)
>             __xfrm_state_delete(x)
>               xfrm_nat_keepalive_state_updated(x)
>                 schedule_delayed_work(nat_keepalive_work);
>   rcu_barrier();
>   net_complete_free();
>   net_passive_dec(net);
>     llist_add(&net->defer_free_list, &defer_free_list);
> 
> cleanup_net() [Round 2]
>   rcu_barrier();
>   net_complete_free()
>     kmem_cache_free(net_cachep, net);
>                                      nat_keepalive_work()
>                                        // on freed net
> 
> To prevent this, cancel_delayed_work_sync() is replaced with
> disable_delayed_work_sync().
> 
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/xfrm/xfrm_nat_keepalive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
> index ebf95d48e86c..1856beee0149 100644
> --- a/net/xfrm/xfrm_nat_keepalive.c
> +++ b/net/xfrm/xfrm_nat_keepalive.c
> @@ -261,7 +261,7 @@ int __net_init xfrm_nat_keepalive_net_init(struct net *net)
>  
>  int xfrm_nat_keepalive_net_fini(struct net *net)
>  {
> -	cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
> +	disable_delayed_work_sync(&net->xfrm.nat_keepalive_work);
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
> 

-- 
Sabrina

