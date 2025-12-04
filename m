Return-Path: <netdev+bounces-243658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF9CA4D3C
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AF13308D9F1
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE4355815;
	Thu,  4 Dec 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ikrN5p44"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC511355025
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870222; cv=none; b=ILS2j9UrfeYhM22i1kn8b0JLDKANhCtINqHo/gckUT+V4mHnKXKFDOdm8Ruh9BVxilWDg0fCxPdhrQQbhiaA2Unx9k44HVg230R/q7SxE4bd2oZbl7Pkj9zz6wOqILlKdmIj1x1HVWFNMmG6f547yEZx7zvpif2h1ytqVvV9RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870222; c=relaxed/simple;
	bh=ANlhuk4F3lUdjCZFBfh8kiFAm52IlbP73ApvPkWPb+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9vc+S28B96+3Rz70ZAa31W9VMPEN1my5LgJdUAkc6wQ26RZ53mnhTH1uXeTGeNHbWhpe4KHBlFWzs1EyHjGWuuLUjeOJZ4my6bWdvmfjLf2SZryEoeI0rN5/KZPIAtWsOSXWfUL8uns/QeHjsKNj/pQNhfI3USm/ic+CsawqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ikrN5p44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE29C4CEFB;
	Thu,  4 Dec 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ikrN5p44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764870220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNeKPv2bF7fxHXZ+Xnn5wy8NxZtaaS11huwudqwThfg=;
	b=ikrN5p44XW9f/c0dv95U688Q8LePaGbwzF9Nany7Y86YRJqAdpwk5nffmQJplonlN/YlQ8
	XUeyNlSFt+kGEPsv0C40SOmcFQADWJ7lJqB5icD8yZUy1jG0YnZAAvzhBvJzV8z8A8rAW/
	4dLLqTMxwHs+0e7Z9l5ubtmTRgX0cbc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 91fdf0fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Dec 2025 17:43:39 +0000 (UTC)
Date: Thu, 4 Dec 2025 12:43:31 -0500
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 00/11] wireguard updates for 6.19
Message-ID: <aTHIQ2ZuuQutREXf@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
 <20251201150729.521a927d@kernel.org>
 <aS5av6CuCukeFO3G@zx2c4.com>
 <20251201203713.58118d7e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201203713.58118d7e@kernel.org>

Hi Jakub,

On Mon, Dec 01, 2025 at 08:37:13PM -0800, Jakub Kicinski wrote:
> FWIW we do still ask for patches to be posted to the list. But some
> folks like to do _both_ that and include a branch/signed tag in the
> cover letter to pull.

You manage a zillion patches from a million people, and so your process
of doing things takes precedent over whatever hairbrained ideas I have,
obviously. But I thought I'd ask about this anyway (and if it's too
annoying for you to even respond to, don't worry, and I'll continue
doing things as normal, happily, without even a grumble).

Here is how things work for submissions to Linus:
1. People post things to the list (myself included). They get discussed.
   Revisions get posted. Eventually things settle down and Reviewed-by
   lines come in.
2. I queue up the settled patches in one of my trees.
3. Eventually, I send a PULL to Linus for said tree.
4. Result: the patches originally posted on the list wind up in Linus'
   tree, and on Lore, there is one single thread that the patch came from.

Here is how things work for submissions to netdev:
1. People post things to the list (myself included). They get discussed.
   Revisions get posted. Eventually things settle down and Reviewed-by
   lines come in.
2. I queue up the settled patches in one of my trees.
3. Eventually, I send the patches back out to you, and then you queue
   them up in net[-next].
4. Result: the patches originally posted on the list wind up in your
   tree, and on Lore, there are now two threads for each patch -- the
   original where it was discussed, and this new process-generated one,
   and they're identical.

The idea of sending a pull instead of step 3 would be to avoid the
duplication. But it sounds like if I did a pull, you'd want
pull+patches, continuing the duplication? What if, instead, the pull
request just had the global diff of the whole pull? So it wouldn't be a
total duplicate, but there'd still be some extra confirmation for you
(which is I assume what the duplication is all about).

Or... I just keep doing things in the normal way that they've been done
for years, which clearly works and doesn't present a real issue for
anybody. :) I don't want to change a process that clearly works for you.
This always just struck me as a peculiarity, so I thought this was an
occasion to mention it.

Jason

