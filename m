Return-Path: <netdev+bounces-147307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661679D9080
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 03:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B14216720E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544F2940D;
	Tue, 26 Nov 2024 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MHrdP9t3"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0656282FB
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589693; cv=none; b=Ly0I7XYZE6zB0+ihLMoh5rCObIr9APRxhxhjK4jAtFVs70uAnyZwyQtzsZQtcMJDMeX4dtg6MYjUCUhj0nWy7tMfi3ihHTXedqH8p3Md145QM5xGPw8CU2xYvv4H4hbq/V1vjwB8O6uUzaeZ1JkjEixok4QYKg3GjXwgwelMtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589693; c=relaxed/simple;
	bh=jFDl11le/9lQfYq3Bf4A1XVCCSFhmtpE+N6oDUSEZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQEUF+i16eJvQ9jlb2IRIhhATttP9t2DKn7X2VcOT7rk8juI8ckGbQn2JCer3E1a2qnkzuFABYTJvARiP3tV9dfvn3B/VnTNfHrtGJEREX4HYh2V5KEogS+cf0QwlRLP9t4JhYWS60N6tUqUVuG6WTtblQwfa7MNskstARErTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MHrdP9t3; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hdet5G+5mP5JbJxbjTtzemHnE1NvV8IRzyVtcTwHIpE=; b=MHrdP9t3Yaz23tRrIKaMebMMTE
	8k4h4wyuSg2zfza2RKhTuYLIEQq7IHvyd7dZARSLE292YmU7/iSqvcxihOC9HWq2/lYRpBnMplRUS
	7JH4R9u3Iodoq2mdmXh8LaFNA5ey47EKTuCuWzt5cTOq58JzRY2h+ycJISe5FT2zKrafNOcPuYE/t
	mGXzRxsfx3tkKh1hzQlnepHIjB7o7DzAzS1PII0r/pJMJCi/OaExkWWbOjd5GmKdnLBe0d8HwvMqb
	29GkdzaOtdyxd7mUki9NG9AYFlRlQ//JjrM0qLm+RkfZjMRrsa5XJEcdLYJVwjc0am8JEs4P+pSh1
	Z4fMHDvw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFlin-001gNm-1T;
	Tue, 26 Nov 2024 10:54:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 26 Nov 2024 10:54:37 +0800
Date: Tue, 26 Nov 2024 10:54:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>

On Mon, Nov 25, 2024 at 07:38:57PM -0500, Kent Overstreet wrote:
>
> Networking and storage people seem to have quite different perspectives
> on these issues; in filesystem and storage land in general, randomly
> failing is flatly unacceptable.
> 
> We do need these issues fixed.
> 
> I don't think the -EBUSY is being taken seriously enough either,
> especially given that the default hash is jhash. I've seen jhash produce
> bad statistical behaviour before, and while rehashing with a different seen
> may make jhash acceptable, I'm not an all confident that we won't ever
> see -EBUSY show up in production.
> 
> That's the sort of issue that won't ever show up in testing, but it will
> show up in production as users start coming up with all sorts of weird
> workloads - and good luck debugging those...

I actually added a knob to disable EBUSY but it was removed
without my review:

commit ccd57b1bd32460d27bbb9c599e795628a3c66983
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Mar 24 00:50:28 2015 +1100

    rhashtable: Add immediate rehash during insertion

commit 5f8ddeab10ce45d3d3de8ae7ea8811512845c497
Author: Florian Westphal <fw@strlen.de>
Date:   Sun Apr 16 02:55:09 2017 +0200

    rhashtable: remove insecure_elasticity

I could reintroduce this knob.  It should obviously also disable
the last-ditch hash table resize that should make ENOMEM impossible
to hit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

