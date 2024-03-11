Return-Path: <netdev+bounces-79163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B227878127
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8825BB228FC
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120C3EA64;
	Mon, 11 Mar 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1/KWglk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72F33CCD
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165648; cv=none; b=s1xNSnUXpLjdlkQDYuwIiVMHolh3i05U01ysTWKjiNhpH8B3dbwuOAe6htZt9pA1sHDZU5m/8iTtKYtsld5Lgf+YzXPon+eyp7f/61W0ahNRZ40QO3h0HfHkDk9UuZz6EhvyJoaz5BAc8OkXmYgW2BfqWY4KsyePESsWh7Fs09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165648; c=relaxed/simple;
	bh=a77vKe2Aka5qPyD8uXzkGtzsWGEZYvAWS9bZXcEefKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkeUK04MvjDxCSyQ/k+TJunKIWwi9n3q0R65xXb4RvA1Q3S+Dx4kbaQKMxlizaFxT2RGVKTbsAXgk5hqnIyG4ZHW5JgaT+37zmw61M58kA6annfwrWaEs9iyGaZ9RwPbpWbuamtUsTEBk68owmT8wgjLms45BCi/oMa2WO3PqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1/KWglk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93787C433C7;
	Mon, 11 Mar 2024 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710165647;
	bh=a77vKe2Aka5qPyD8uXzkGtzsWGEZYvAWS9bZXcEefKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1/KWglkR3rn1w7LWbK31TTzOLMMVE+mqcFWReMWq/FYdx22KtMjfbDs4cqky751z
	 1qLumJeDj99qbdo4kxIzJLZUU5gV/FGfUQfMRGIEgTamuTer5b/Tgyp8JEY4WNnl9m
	 FHQJrwJ79AhPHH8EKioG2j5J1BBkoc4qdvC7dh2yu+UOCeReZZR8c0yOJmMIs8QWm2
	 nJNv8WcMZ9ZgkCZAjdoGzvdjaTHPRC+I160Dzaa+kVqr2a4rbdm6y9vejpSR2ZKQoK
	 +E8o9XU/ZgAfEZjX9/eX542EDy5xb2sc4mF7sA/VtosWnp3uPfpXFoQu3iPIqMKhGy
	 w9kD13N1BOc+A==
Date: Mon, 11 Mar 2024 14:00:43 +0000
From: Lee Jones <lee@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, netdev <netdev@vger.kernel.org>,
	cve@kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Is CVE-2024-26624 a valid issue?
Message-ID: <20240311140043.GR86322@google.com>
References: <95eb2777e6e6815b50242abb356cfc12557c6260.camel@decadent.org.uk>
 <CANn89iKnQZWNw3NS0uGCWSejKxaUh8iL=UwZ+9+Lhmfth-LTxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKnQZWNw3NS0uGCWSejKxaUh8iL=UwZ+9+Lhmfth-LTxQ@mail.gmail.com>

On Mon, 11 Mar 2024, Eric Dumazet wrote:

> Hi Ben
> 
> Yes, my understanding of the issue is that it is a false positive.
> 
> Some kernels might crash whenever LOCKDEP triggers, as for any WARNing.

Exactly.  So is it possible to trip this, false positive or otherwise?
Being able to crash the kernel, even under false pretences, is
definitely something we usually provide CVE allocations for.

> > I noted that CVE-2024-26624 was assigned by the kernel CVE authority to
> > the issue fixed by commit 4d322dce82a1 "af_unix: fix lockdep positive
> > in sk_diag_dump_icons()".  By my understanding, this does not fix any
> > locking bug, but only a false positive report from lockdep.  Do you
> > consider this a security issue?
> >
> > Ben.
> >
> > --
> > Ben Hutchings
> > Time is nature's way of making sure that
> > everything doesn't happen at once.
> >
> 

-- 
Lee Jones [李琼斯]

