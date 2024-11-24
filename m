Return-Path: <netdev+bounces-147093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2E9D789B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1FBB22A70
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817416CD35;
	Sun, 24 Nov 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qYd5NtKI"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88F16DEA9
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487717; cv=none; b=ZH0F+X00cVbb+5f22Gd4KE1lTmZW5FeHUaWzTU4A4YRcRU8cTgQQREW+n68gIGV7teFLF4iXeHrXo56gSQHNY7SRPGZpaN7VLgsKK0pSSQhbbx1/+YVrDkM0rJVgzbHnfOzjyX1q62wzkTrBz0uYhUbumX2JEsyKoQNFV4QrPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487717; c=relaxed/simple;
	bh=+63bjnIsOeFMdn4yEAyOL5y/C/KViU9tfYp9mWbrbuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYmj/LshvYSdGI5FBXKQa7AbOs5cSabJxGZsC8NNdmH8OpY2YG1yQk7ccCsN/9VBa9MYhgPUGShA4FvwhJVImS0xNx5OanJ5aGOwJCeJgygaSkcZmGyh+wYfDcdRSt0kG/l1997IlSdZTF8u4+3VMr+7spg1/+uJJDvOEedQCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qYd5NtKI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 24 Nov 2024 17:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732487711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbF/2XuWwb0zLoPtWkrJwXqUQhyzE0VudtO1VUsAAXg=;
	b=qYd5NtKIATXxtbRX5a6Ym/mydLYKcOYWGC9GHOaCWrRa7XhE7N0J/aP5f4zXBvmdzVUC6s
	/YlvAt+PyGLDzHJRg4rD6A4FYpDECV7kq3urOYD47A6M74aNWotdgFKqJMwaYJ2s1IECX8
	ZQDKvWOkAMefS4RCvTFj9dny/Kx3ry4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <lm4aynuzpvsnurr4kzkecwantceebugrija2hxjrwou4r4u7ea@xxtncggxnbk2>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 24, 2024 at 09:01:26PM +1100, NeilBrown wrote:
> On Sun, 24 Nov 2024, Herbert Xu wrote:
> > On Sun, Nov 24, 2024 at 08:25:38PM +1100, NeilBrown wrote:
> > >
> > > Failure should not just be extremely unlikely.  It should be
> > > mathematically impossible. 
> > 
> > Please define mathematically impossible.  If you mean zero then
> > it's pointless since modern computers are known to have non-zero
> > failure rates.
> 
> mathematically assuming perfect hardware.  i.e.  an analysis of the
> software would show there is no way for an error to be returned.
> 
> > 
> > If you have a definite value in mind, then we could certainly
> > tailor the maximum elasticity to achieve that goal.
> 
> I don't think there is any need to change the elasticity.  Rehashing
> whenever the longest chain reaches 16 seems reasonable - though some
> simple rate limiting to avoid a busy-loop with a bad hash function would
> not be unwelcome.
> 
> But I don't see any justification for refusing an insertion because we
> haven't achieved the short chains yet.  Certainly a WARN_ON_ONCE or a
> rate-limited WARN_ON might be appropriate.  Developers should be told
> when their hash function isn't good enough.
> But requiring developers to test for errors and to come up with some way
> to manage them (sleep and try again is all I can think of) doesn't help anyone.

Agreed, sleep until the rehash finishes seems like what we're after, and
that should be in the rhashtable code.

