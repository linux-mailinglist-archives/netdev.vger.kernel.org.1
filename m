Return-Path: <netdev+bounces-162221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA140A26405
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17C318834EF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D41DACB1;
	Mon,  3 Feb 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKy03jQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A41D47AD;
	Mon,  3 Feb 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612245; cv=none; b=rzN6ylXgNo8e/2wD9FN3OIPXblXzmsQyQ+veFIoJbqbQF7vqeIN3ZToRKBinzCkZ8DdaVg0pA3SiT+fUX8siqLfgGKhfw9hqDUlS1TZu1HLD0BWVazrf1PafuaBjhJixPVMYRNiT7wDeoPX/2L/Opmc1vlwTDcmpv/f3vghJOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612245; c=relaxed/simple;
	bh=MJrx9uVTcVkOLBd3RaCKPYEE0+j9fIK//E/nrWrG6SE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxvt1J605m2K+17+OiLCeOTgrJIl9TSSFN5h1TTP5j1TSk2bDo3nxO7YNh5R/4s4fzm+98/7nPf6XgxNUh9w5yICds+3HqNi6fxX9KbxP+R+FmGFqKQgdypGGxYkGN46cRnCUaRfV0BTYuhnT1sC4t/YEF3CFuVmQtk8MSrHuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKy03jQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9959DC4CED2;
	Mon,  3 Feb 2025 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738612244;
	bh=MJrx9uVTcVkOLBd3RaCKPYEE0+j9fIK//E/nrWrG6SE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WKy03jQsC8BgN3JGxKIz0b884E/gV7TxOp/8Fqb2zwHiDSu+5dJXTtASjGq4CDxfi
	 TjQIUkHLnfwjBRWhYnKd+p84fuUQTtnSn9ZfIqHJ31NJ7NspHv8h+f8iq5NeJ94slS
	 zuLh+LmOg/BA3D3y7a7mnwO/eaCqHzXAg0Tc2duQCnkKaa4q/CL988ZiPm2igrEY1D
	 dN6t0k6aOJb8TRpQsbGv38ox+wK3bfbAJsOqyh46fEjZw1+ug/ecaCK+DG3skO5i9p
	 uqCC2jLACGCi6l4PBi59GKNZiLylsgoEJZXaapnqgN57rE9ViLHZO75as4M48ufXQU
	 hhM+wbQFT4KIw==
Date: Mon, 3 Feb 2025 20:50:39 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre Ferrieux
 <alexandre.ferrieux@gmail.com>, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250203205039.15964b2f@foz.lan>
In-Reply-To: <874j1bt6mv.fsf@trenco.lwn.net>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
	<874j1bt6mv.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 03 Feb 2025 08:00:56 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Simon Horman <horms@kernel.org> writes:
> 
> > Document preference for non inline functions in .c files.
> > This has been the preference for as long as I can recall
> > and I was recently surprised to discover that it is undocumented.
> >
> > Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> > Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  Documentation/process/maintainer-netdev.rst | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> > index e497729525d5..1fbb8178b8cd 100644
> > --- a/Documentation/process/maintainer-netdev.rst
> > +++ b/Documentation/process/maintainer-netdev.rst
> > @@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
> >  
> >  Conversely, spelling and grammar fixes are not discouraged.
> >  
> > +Inline functions
> > +----------------
> > +
> > +The use of static inline functions in .c file is strongly discouraged
> > +unless there is a demonstrable reason for them, usually performance
> > +related. Rather, it is preferred to omit the inline keyword and allow the
> > +compiler to inline them as it sees fit.

You should probably point to chapter (12) of Documentation/process/coding-style.rst
where it mentions that inline for function prototypes and as a way to
replace macros are OK.

> > +
> > +This is a stricter requirement than that of the general Linux Kernel
> > +:ref:`Coding Style<codingstyle>`  
> 
> I have no objection to this change, but I do wonder if it does indeed
> belong in the central coding-style document.  I don't think anybody
> encourages use of "inline" these days...?

Indeed IMO this belongs to the coding style. I would place it close
to chapter (12) at Documentation/process/coding-style.rst.

Regards,

Thanks,
Mauro

