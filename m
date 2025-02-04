Return-Path: <netdev+bounces-162491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AEA270AC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1599F161CF8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A569320C496;
	Tue,  4 Feb 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQut86Yz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A420C47E;
	Tue,  4 Feb 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670056; cv=none; b=DW0vQY84SBsb+MuFBoIp99lp7PmVfPNQhMdUgjg0m5egyTvHi7JQ+fwnQpBnOzh3gms3ChN3gmyuMTYdqfQbxYVeZvqKzZFK9id+nSqyK6PhPG9qUenu+2pRn3quR3luuKCFRlXyGcxTrcvGdwjpHFn3/oRWwo4ezR/cmiP/OOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670056; c=relaxed/simple;
	bh=sNd7thjzXfTKLPNUT3NzEBRZyJcW6zglW4k6VC91zCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjJq8FxLEdY40OOFGQ/kDWsIHDvDxina3JTGRCPeVjOPV5Mo2XNo+InfYh58s3FyBsX87nbTujwTWW5kbvKf3Sp/otCuqTBFF6ho2qEfGcUKNIMqDu3jag+CAAgOG6f3tY/+kKe0r5k52WeENOP5KpXuD6Y8YV9OaX72D2hxhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQut86Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAA2C4CEDF;
	Tue,  4 Feb 2025 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738670054;
	bh=sNd7thjzXfTKLPNUT3NzEBRZyJcW6zglW4k6VC91zCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQut86YzTy2LgISG6kU+pGmUAmoLqnlMNc8uO2vAOpIgmNWcUQMGOv7x9+Tf1pHWD
	 bdpohqk2v8d73mie7ywCtiFvsfaMukHGl4BWAv8UuA9G9aFtkluhv3pTK9ZKWhkui/
	 JNs+9yfcJsG7V24NoMZONnmmkGT3ilaumU4/SN2eHq1pdvwpyOD48R+wFc52oz3W5C
	 lXa6XJO4GLgxakCW8H+9gWE/+GJYWLMuFWgGN+hsW5wMa7Fr3EP2B/Rr7070VzykaH
	 tdcVYn+k8+k/edNLmcpoKOO52B61T7fg/KPXD3IGXVWl1e1c5uuWZtWaORXl1Bsbxh
	 /xS3PjUNld9+w==
Date: Tue, 4 Feb 2025 11:54:10 +0000
From: Simon Horman <horms@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250204115410.GW234677@kernel.org>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
 <874j1bt6mv.fsf@trenco.lwn.net>
 <20250203205039.15964b2f@foz.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203205039.15964b2f@foz.lan>

On Mon, Feb 03, 2025 at 08:50:39PM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 03 Feb 2025 08:00:56 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > Simon Horman <horms@kernel.org> writes:
> > 
> > > Document preference for non inline functions in .c files.
> > > This has been the preference for as long as I can recall
> > > and I was recently surprised to discover that it is undocumented.
> > >
> > > Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> > > Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > ---
> > >  Documentation/process/maintainer-netdev.rst | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> > > index e497729525d5..1fbb8178b8cd 100644
> > > --- a/Documentation/process/maintainer-netdev.rst
> > > +++ b/Documentation/process/maintainer-netdev.rst
> > > @@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
> > >  
> > >  Conversely, spelling and grammar fixes are not discouraged.
> > >  
> > > +Inline functions
> > > +----------------
> > > +
> > > +The use of static inline functions in .c file is strongly discouraged

As suggested by Andrew Lunn elsewhere in this thread I will drop
"static" from the line above.

> > > +unless there is a demonstrable reason for them, usually performance
> > > +related. Rather, it is preferred to omit the inline keyword and allow the
> > > +compiler to inline them as it sees fit.
> 
> You should probably point to chapter (12) of Documentation/process/coding-style.rst
> where it mentions that inline for function prototypes and as a way to
>static  replace macros are OK.

Thanks, perhaps something like this would help:

  Using inline in .h files is fine and is encouraged in place of macros
  [reference section 12].

> 
> > > +
> > > +This is a stricter requirement than that of the general Linux Kernel
> > > +:ref:`Coding Style<codingstyle>`  
> > 
> > I have no objection to this change, but I do wonder if it does indeed
> > belong in the central coding-style document.  I don't think anybody
> > encourages use of "inline" these days...?
> 
> Indeed IMO this belongs to the coding style. I would place it close
> to chapter (12) at Documentation/process/coding-style.rst.

Sure, thanks to you and Jonathan for the positive feedback there.
I will prepare a revised patch that updates coding-style.rst instead.

