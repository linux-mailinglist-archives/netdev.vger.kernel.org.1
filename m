Return-Path: <netdev+bounces-151368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9DE9EE6CD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B7D1658EC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C95212FB8;
	Thu, 12 Dec 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="igZ2toSo"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A252101BA;
	Thu, 12 Dec 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006843; cv=none; b=SXrq8L+MtXfylQYMm8Gb5/vihpFMyd/nCih60BTP1K99z3KuwktKrN9IG6p62OQYeXeuWe/Dcx+KwcGxRGgB/g6p7UyvRhbkxLWzD5R6IunY8RrvyJ5cK2iG7BoOYgRdu1vYDL/SzBV0BbP9qWUI5TBMbYdA6xNRFLthidQ0tWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006843; c=relaxed/simple;
	bh=kGaZbqNAhKdJHwiFqnBtTBeZf1uPGpqNgrYMqjt4IFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUngYCQ8cIY78yjgLhdrgXgBt+AOowt8zGp7GhDKHRBPtFQVyd/8fiE3ygS4n1wLI+aBvCK0JIvheabIdWRToz3Qa2LxkFlgyzzfr43QFPbbhFQCM6Hb33zLaFLGGFwFYwdAY5qcoDFqhaSZ8TLrt4wKP1QWoYRDVLfDabAQuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=igZ2toSo; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ys/o4lfTC5skxkRbXJEl4KNijT9jacifAZOahJOVLyk=; b=igZ2toSoIBHi82hrhv7bXUvYnO
	kLny625B16DC4o+al9sOVAyVTzc10sASbekIysvv1k4901XLnRcpyeopmdNi3agt0X34ajJq5Yywx
	bEikPl2O97FCG0tINf4h1CbDWUzmji3P9CfkQW5ZXL1R+lfGn2RJ4g+4yT6PSkf285eDCHlHduT61
	Ohue/TbYDrMjJZxvkw7jG88zdkGHQMLgHc8EONzKW45bc/5zbvmbPlDyn19Ao+hJEDM3OhMLPavA6
	M6MuQOK2+f28i50sJPYRn9C5LRttYABgFQ0mRa4vwg8wRVP41nzdSCQcHbewv6FiBnX2hVhaVPxav
	EDwiQLvg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tLiAt-00119c-0k;
	Thu, 12 Dec 2024 20:33:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Dec 2024 20:33:31 +0800
Date: Thu, 12 Dec 2024 20:33:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>

On Thu, Nov 28, 2024 at 04:16:25AM -0800, Breno Leitao wrote:
>
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6c902639728b767cc3ee42c61256d2e9618e6ce7..5a27ccd72db9a25d92d1ed2f8d519afcfc672afe 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -585,9 +585,6 @@ static struct bucket_table *rhashtable_insert_one(
>  	rht_assign_locked(bkt, obj);
>  
>  	atomic_inc(&ht->nelems);
> -	if (rht_grow_above_75(ht, tbl))
> -		schedule_work(&ht->run_work);
> -
>  	return NULL;
>  }
>  
> @@ -624,6 +621,9 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  				data = ERR_CAST(new_tbl);
>  
>  			rht_unlock(tbl, bkt, flags);
> +			if (rht_grow_above_75(ht, tbl))
> +				schedule_work(&ht->run_work);
> +

The growth check should stay with the atomic_inc.  Something like
this should work:

			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
				atomic_inc(&ht->nelems);
				if (rht_grow_above_75(ht, tbl))
					schedule_work(&ht->run_work);
				break;
			}

Could you please resend this via linux-crypto?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

