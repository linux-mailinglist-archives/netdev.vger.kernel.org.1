Return-Path: <netdev+bounces-147300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13749D8F94
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 01:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636C7169F0A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6886FB0;
	Tue, 26 Nov 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VIrOvhvW"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CE33E1
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732581551; cv=none; b=EuIP+3EfuEq7lomT3Bc/jIVDxE1CKOGxM/GMywOGgyCCUB91f34+rYy9xZz6sqdqMy9TgF0MCdp/m2WD1lFQfPzuBWw0rQQF9q0q5emnbnCxJvfbItV61hCuk6xpL0dHsrSLh5SJI5qWmhe3/y5RPjACSRDYw9vGVHKT6/aP8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732581551; c=relaxed/simple;
	bh=AZ+jcImZHXAUheYWtiYxXgq8WEDXm96xYC/TrkXVxrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3Wd4EISWn7/2etPnfidaiCDXbyrxLnVFBgF0xZY/qe3J03duxuAq+jxZEqv+KhLaCPlDQ+mHQHHL36gw2BL86WYPb+SHHLx2oM0jBS74kTct6UQywcXl9WLdZsivBgGo6CAUQh/3EeFqkq7cpRHyWTNUVsBKQaYzVUx6DZuC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VIrOvhvW; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Nov 2024 19:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732581543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OE+MU5VeBHp6XGHAoDW6Nm241WPTBIzPkWxK2PqOcBE=;
	b=VIrOvhvWtIU6lqEz0/azJWJ01WCMsPYAlF/QZmYe/rkZQ0+k/24gHD/EFRgBVFlFD/3c8H
	vV19L5IXMDosU9vSMLccq75Vd1jZ0ExXytmSQQqBRBmEspCVI7ZxBxL0N1qEkrb8Rji8BU
	zdlLBewLUy9KES06CHNpKR//9o0v9Ko=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 26, 2024 at 10:38:10AM +1100, NeilBrown wrote:
> On Mon, 25 Nov 2024, Herbert Xu wrote:
> > On Mon, Nov 25, 2024 at 10:43:16AM +1100, NeilBrown wrote:
> > >
> > > So please turn it into a WARN_ON_ONCE and don't allow the code to return
> > > it.
> > 
> > You still have to handle ENOMEM, right?
> 
> I'd rather not.  Why is ENOMEM exposed to the caller?
> The rehash thread should *always* allocated the *whole* table before
> adding it to the chain and starting to rehash into it.  Until that
> allocation succeeds, just keeping inserting in the existing table.
> 
> rhashtables seems to have been written with an understanding that long
> hash chains are completely unacceptable and failure to insert is
> preferred.  I accept that in some circumstances that might be true, but
> in other circumstances failure to insert (except for -EEXIST) is
> anathema and long hash chains are simply unfortunate.
> 
> Now I could write an alternate resizable hashtable implementation which
> values predictable behaviour over short chains, but it would only be a
> tiny bit different from rhashtables so it seems to make more sense to
> add that option into rhashtables (which already has several options for
> different use cases).
> 
> So I don't ever want -E2BIG either.  Either -EEXIST or success should be
> the only possible results of "insert".

Networking and storage people seem to have quite different perspectives
on these issues; in filesystem and storage land in general, randomly
failing is flatly unacceptable.

We do need these issues fixed.

I don't think the -EBUSY is being taken seriously enough either,
especially given that the default hash is jhash. I've seen jhash produce
bad statistical behaviour before, and while rehashing with a different seen
may make jhash acceptable, I'm not an all confident that we won't ever
see -EBUSY show up in production.

That's the sort of issue that won't ever show up in testing, but it will
show up in production as users start coming up with all sorts of weird
workloads - and good luck debugging those...

