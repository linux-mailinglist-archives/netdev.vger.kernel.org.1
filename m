Return-Path: <netdev+bounces-162492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB3A270B6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B820D162039
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBE20CCE5;
	Tue,  4 Feb 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxVQVCKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0A20C496;
	Tue,  4 Feb 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670126; cv=none; b=m9voIVx3YWvubTaKYQ6tZmBxQmAxLyggcSfOWjG/ICfKW461eSQDiUJfksxuoBrpqjIVpFLxSD6FQq4ACIKM/UTp7DYz5eis6kQo+YhZ21lenctYKGBSetVcIUvBMsRUyd36EkkfT+Wxbha3gwS3HGrCLzqYQx8V97bEj0nwPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670126; c=relaxed/simple;
	bh=yeoRyJQsu/0KJCEG+5sYoTzht9tHhecwI2R/QIwy+5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHVIZU1rTQ7j3E+auX9GOWAvSOxr3BvvZ9BUwPmMSYEmvlc4mtH6SDYdaD+vYaM5a+hzJSHf8cnt6X9odxaCV2uo8Hb1CXtTzFZ9tm09in/El3N41ph5DzMpZHl1kBd0rqAGl7LL4dEj70WDtNcQ0ftyPIIWvQEshV6YeL/qT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxVQVCKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41438C4CEDF;
	Tue,  4 Feb 2025 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738670126;
	bh=yeoRyJQsu/0KJCEG+5sYoTzht9tHhecwI2R/QIwy+5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxVQVCKvvIoO8VT7XaURKFqoFhDaEAncG1y6/GOm51j5+xTWhLWdOc9lM7Zz263xA
	 rYp5t1/xESP3eIz7njlD9vmkmGA87X2/PC0vfLyk4Rp+A65Hs+NUw2cX7C2ZZlpPKr
	 DYJGdQ5YDyVSmlV9PgnPT4WcrQPJK5zIQGgrIhL8QtJELMXmC+pyjqBFqOqMobVsEa
	 2xqGXXfxbz8heqXaLObGrtf5Jo0DUsLpTVbMt7R55vW3p4cZDZ+FxtGW0sKJdhi6IB
	 KkFFwt3rfW1F3NgxEHKVfq2W1XX0RgLYfuml6NeyyE+/83S4YI05+MgV8ybAaB7EOq
	 MYsLK2DEInT8Q==
Date: Tue, 4 Feb 2025 11:55:22 +0000
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
Message-ID: <20250204115522.GX234677@kernel.org>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
 <874j1bt6mv.fsf@trenco.lwn.net>
 <20250203205039.15964b2f@foz.lan>
 <20250203205312.74339d30@foz.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203205312.74339d30@foz.lan>

On Mon, Feb 03, 2025 at 08:53:12PM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 3 Feb 2025 20:50:39 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > Em Mon, 03 Feb 2025 08:00:56 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> > 
> > > Simon Horman <horms@kernel.org> writes:
> > > 
> > > > Document preference for non inline functions in .c files.
> > > > This has been the preference for as long as I can recall
> > > > and I was recently surprised to discover that it is undocumented.
> > > >
> > > > Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> > > > Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
> > > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > > ---
> > > >  Documentation/process/maintainer-netdev.rst | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> > > > index e497729525d5..1fbb8178b8cd 100644
> > > > --- a/Documentation/process/maintainer-netdev.rst
> > > > +++ b/Documentation/process/maintainer-netdev.rst
> > > > @@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
> > > >  
> > > >  Conversely, spelling and grammar fixes are not discouraged.
> > > >  
> > > > +Inline functions
> > > > +----------------
> > > > +
> > > > +The use of static inline functions in .c file is strongly discouraged
> > > > +unless there is a demonstrable reason for them, usually performance
> > > > +related. Rather, it is preferred to omit the inline keyword and allow the
> > > > +compiler to inline them as it sees fit.
> > 
> > You should probably point to chapter (12) of Documentation/process/coding-style.rst
> > where it mentions that inline for function prototypes and as a way to
> > replace macros are OK.
> 
> Heh, I hit enter too quickly...
> 
> I mean:
> 	"inline for function prototypes and as a way to replace macros on
> 	 header files (*.h) are OK."

Likewise, I responded to your previous message too quickly.

Yes, I agree something like that would be good.

> 
> > 
> > > > +
> > > > +This is a stricter requirement than that of the general Linux Kernel
> > > > +:ref:`Coding Style<codingstyle>`  
> > > 
> > > I have no objection to this change, but I do wonder if it does indeed
> > > belong in the central coding-style document.  I don't think anybody
> > > encourages use of "inline" these days...?
> > 
> > Indeed IMO this belongs to the coding style. I would place it close
> > to chapter (12) at Documentation/process/coding-style.rst.
> > 
> > Regards,
> > 
> > Thanks,
> > Mauro
> 
> 
> 
> Thanks,
> Mauro
> 

