Return-Path: <netdev+bounces-146933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A49D6C8D
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 04:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0FB210E5
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8721E4B0;
	Sun, 24 Nov 2024 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MFJn+Dr1"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92D1E53A
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732419056; cv=none; b=QkDHyKUcXHuxjigLYd4siymUyzqbVWV4vG3PpQzTQ84BZo82oxops7NegUSE2AfqW+PVacW6Vei22fO5aiWExkOqTG/ZRaEPciHdytx3l9g5CEga3y9dKPZmuQKr7xLGB0SP/qWWaWh5B+MupTrWp6VyUEeJV3uUxTcny/6WKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732419056; c=relaxed/simple;
	bh=br1Mv8ghjm8dMtWwE3Lps7qivUTW/dmFw8vWrZ2sCu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl+ytLMaDHcrTzQ3SKwXyqh1iFe9y5ITZsnGYy4b/qLkrOND03nW8P3bRx2zOny7PYuWYI+THxgwgH9AcXwnL9a76EawxGsosVhc569bvnI7q5U4zCFq4v/c9yCXFfQ+jwM5eNVQCeX2L6+DWf452hgO/P7mcCDeVQ0WN7eH+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MFJn+Dr1; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 22:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732419050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KUxK+oBD4N0QN5402p95hUnh/VtAcj5lXe9CKSx0pU=;
	b=MFJn+Dr1emjIn633nCVqqlDCmwzoMv7oQ7AvJu2aTXXQc04pijYdIZ/G4FlMa/YwrMSpV5
	1E2ZlwDTXsn5vSLrbSrmIMWB5moiTsylDTFBeny6syVVFucprFA1IXZooROWZAyAI16p5P
	NibL3jozIg91taxGlJcEo5kP/WYt2a4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org, 
	Neil Brown <neilb@suse.de>
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <3a2uv6dsl3xqw2bpeob7tq6e52ezjrpuvcqqvttb5goltdzpsd@dsj6fxwqi32g>
References: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>
 <Z0KaexOJM1phuJKS@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0KaexOJM1phuJKS@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 24, 2024 at 11:16:11AM +0800, Herbert Xu wrote:
> On Sat, Nov 23, 2024 at 12:21:21PM -0500, Kent Overstreet wrote:
> > I'm seeing an issue where rhashtable inserts sporadically return -EBUSY,
> > thrown from rhashtable_insert_rehash() when there's already a rehash in
> > progress, i.e. rehashes aren't keeping up.
> 
> EBUSY should never happen *if* you're using the hash table correctly.
> It is expected to happen if you insert multiple identical entries
> into the same hash table (the correct thing to do in that case is
> to use rhltable which is designed to accomodate multiple entries
> with the same key).

Well, reading the code that would appear to be -EEXIST, that's entirely
separate from the path you describe below.

We do indeed expect to hit the -EEXIST path in normal operation
(multiple threads racing to pull in the same inode).

> Now assuming that is not the case and you are using rhashtable
> correctly, this is when an EBUSY will occur during an insert:
> 
> 1) The hash table elasticity has been violated, meaning that
> more than 16 entries are in a single chain.
> 
> 2) The hash table is below 50% capacity (meaning that statistically
> we do not expect 1) to be true).
> 
> 3) An existing rehash is already taking place.

This appears to be the path we're hitting.

> The reason we have the EBUSY mechanism in place is to prevent
> the case where we are being actively attacked by a hostile
> actor, who has somehow compromised our hash function.
> 
> The first line of defence is to change our hash function and
> conduct a rehash.  This is what would have occured if 3) is
> false.
> 
> Once a rehash is in place, if we hit 1) + 2) again, then it
> means that our defence was futile and the hostile actor is
> still able to create arbitrarily long hash chains (possibly
> by compromising our RNG since we use that for the rehash),
> and as we do not have any defence mechanism for that, it is
> better to just fail.
> 
> Of course this is meant to be impossible to hit in practice.
> Whenever it has occurred in the past, it's always been because
> people were tring to insert identical keyed entries into the
> same table (Use rhltable instead).
> 
> Theoretically it is also possible to hit this if your hash
> table was immense (expected worst-case hash chain length is
> log N / log log N), but it has never been hit in the past
> with our default elasticity of 16.

Thanks for the background.

With the default hash function (jhash), I suspect this isn't so
impossible as you think - I had issues with jhash when doing cuckoo
hashing, and I had to switch to siphash there....

I'll see if switching to siphash solves it - and it sounds like some
tracepoints are in order, at least.

