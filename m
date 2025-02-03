Return-Path: <netdev+bounces-162224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1824A26415
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126951668A8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF056209F22;
	Mon,  3 Feb 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY2xBCd+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801001D47AD;
	Mon,  3 Feb 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612399; cv=none; b=pzDA9NUEBgIw4p5zP1W2thF9jd+GQBDvOcebmDT1RT6hjpE+ewtOQXZjQ1BmHdEBozKYVwL8ktp2zy9DtvyuFlTdZWnt2Lxbec2IHHrB6SkI2SpvXc0agXKHYFsFl+u8RRa4S39+0bJ2i5cc6ZTu8ZN1kiRw5L0k7d6F6RCfDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612399; c=relaxed/simple;
	bh=txxsPm2nXmynDqW7wkBqaMmMRBITIsKevGT/NX9df0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REF0n8gRu/zs0f+fSqGVsBMqmSIWJ10n5bz9/kQNtPvHo3YVMIH0sd1cidesDiSPD0ge4pgGeSeuaZphJtqmvFRV7o2kcnYnLKWwMXjiw/IqC6kv/DmoVY1pKCO+rn1SW8dpxYbHbvQ6w8zfry5WkdsCPcpQMaL7R3GJN6hWStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY2xBCd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD45C4CED2;
	Mon,  3 Feb 2025 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738612397;
	bh=txxsPm2nXmynDqW7wkBqaMmMRBITIsKevGT/NX9df0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IY2xBCd+gBh411tPAi9ArCrwUIjzfc3+b2I/L0iyGE9JvvxKmcYVO6Nowcoa84fER
	 0Sd5z3G3DHv6zd3fv6WTl696hudKy4clON6BrW03tElItiT/07MnqquWH3U6zwc/Bj
	 99FN0Au1UqvuoEahKqLG1jugExYFcEj6+2HCLHz38KUii0FUuuR7zjQERdd1zYf8tt
	 OMVlckfy1aIbwIuXeK84WIkNvAu7BBU8UZQuK7oaO325UVbAY0SofX5McnK1xjKqho
	 nO3Qwzyg7ZvAhns3+tity636aVOlCepQH4Jg/hNNQEof0voEUmCS5acWo3Lh4pBP6/
	 MHb22j8+TtD5w==
Date: Mon, 3 Feb 2025 20:53:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre Ferrieux
 <alexandre.ferrieux@gmail.com>, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250203205312.74339d30@foz.lan>
In-Reply-To: <20250203205039.15964b2f@foz.lan>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
	<874j1bt6mv.fsf@trenco.lwn.net>
	<20250203205039.15964b2f@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 3 Feb 2025 20:50:39 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

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
> > > +unless there is a demonstrable reason for them, usually performance
> > > +related. Rather, it is preferred to omit the inline keyword and allow the
> > > +compiler to inline them as it sees fit.
> 
> You should probably point to chapter (12) of Documentation/process/coding-style.rst
> where it mentions that inline for function prototypes and as a way to
> replace macros are OK.

Heh, I hit enter too quickly...

I mean:
	"inline for function prototypes and as a way to replace macros on
	 header files (*.h) are OK."

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
> 
> Regards,
> 
> Thanks,
> Mauro



Thanks,
Mauro

