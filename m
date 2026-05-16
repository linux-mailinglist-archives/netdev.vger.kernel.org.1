Return-Path: <netdev+bounces-288599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8bW5LHswCGr1dQMAu9opvQ
	(envelope-from <netdev+bounces-288599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A055ACEB
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B197B300EFB4
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40C380FC2;
	Sat, 16 May 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oKCLUxIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C037DEAD;
	Sat, 16 May 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778921590; cv=none; b=H7F006K3VwnvEEE2Haafh5pbbpVY4eXnPrwjtPvBqPdY+EDuST5k56toZikBpmcOAN9D1KGxlKOaFRBABswI0NLn0SWMsiSE3WcGyHrhWg9Dy6lr+SoDwqL5SG/JEW24PPS4ZxgpLt1qwzzMi3L96FGQadgdfisUb1mQpY8yFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778921590; c=relaxed/simple;
	bh=5rD3qF/0URoSGc/S4qOsZgFyxzw2ke0ZDuk4ggu4mp8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm3998Vgtl9wiSpWdd3N36JX9+Qb3Zh+1JicX98JuZb32S9nt2Pgfu9PVhzBhc8nv+0zu8Mui5rsQYRFx/5pg5E1ndacliQSDwAb0YNDJ47y/HK7YoVMpEzqWPSCnLuh1lYABXGdj0B4dqyzr+tOQacl6hq4AM540kdFXnHGRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oKCLUxIZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 93370207B0;
	Sat, 16 May 2026 10:53:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vj6TwFqIuPxp; Sat, 16 May 2026 10:53:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CAD4420606;
	Sat, 16 May 2026 10:53:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CAD4420606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778921585;
	bh=EcD+5yK7EH8GbB+LfuKmwEhjxF6V86B8BBTVPdWg6Vw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=oKCLUxIZwlfYWwap2LaKGrP8ZGYXkea6Voc6U34ClnrA2FTvF39F+Q0ytM/vpadD2
	 r+VINNd5XfjdkaGXbmH7rqNavxA/KrOKqjRRNPaBvqHs69k5MBWoUQqSFicw19gbL1
	 Kg0M9wYccv87Xfq/EqlSOrhWiQDSfino+2QsbbjPIMwAqQoRq+C9dlYFL5QB9XX4Ec
	 cwb1sQMA3C8LAsebLP21E0XcynyyJh1uFA6s3h/3TQacZCYp6e5a0vScgdkLdgTdI8
	 dMpf/zJmhVJIzBaAilY6al0+ryKLwBKY9q6Znw3Fhu4y6Qt8wPno+XMLXpgEEqz95v
	 g6QU/zsaoTKiQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 10:53:05 +0200
Received: (nullmailer pid 544255 invoked by uid 1000);
	Sat, 16 May 2026 08:53:04 -0000
Date: Sat, 16 May 2026 10:53:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, e521588
	<alessandro.schino@sbb.ch>
Subject: Re: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Message-ID: <aggwcBleyHfFD4BL@secunet.com>
References: <20260514094212.32-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514094212.32-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 136A055ACEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:42:11AM +0200, Alessandro Schino wrote:
> From: e521588 <alessandro.schino@sbb.ch>
> 
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache. The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes.
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2. nr_frags is set to 1 and frag[0] is replaced with the new page
>   3. Second skb_to_sgvec() fails -> goto error_free
>   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
>   5. kfree_skb() only releases frag[0] (the new page), not the old ones
> 
> Fix this by calling esp_ssg_unref() before the goto error_free when the
> second skb_to_sgvec() fails. At this point, the source scatterlist in
> tmp is fully populated, so esp_ssg_unref() can properly release all old
> page frag references.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> 
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
> ---
>  net/ipv4/esp4.c | 4 +++-
>  net/ipv6/esp6.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 6a5febbdbee4..5c4b162c1bb5 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -569,8 +569,10 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
>  		err = skb_to_sgvec(skb, dsg,
>  			           (unsigned char *)esph - skb->data,
>  			           assoclen + ivlen + esp->clen + alen);
> -		if (unlikely(err < 0))
> +		if (unlikely(err < 0)) {
> +			esp_ssg_unref(x, tmp, skb);

Maybe we need some variant of esp_ssg_unref() that does not
check the src and dst of the crypto request as this is
initialized later in the function.


