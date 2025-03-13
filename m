Return-Path: <netdev+bounces-174554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9278CA5F375
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C855175FCD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBF26560B;
	Thu, 13 Mar 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="jQMJNpEA"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163726658F
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866742; cv=none; b=SiqRtlHaDi5x+nKS+SajqaCOupGPKS/XMhHgdRWHZFbEV69FFObA9B4k+xCRzpL8yZUboPm+kmFretXLx2BqfMOuIdIDnOlgJXI6zYAc0NyvnMeNZd3JcmdBWc27gv2IkpknuettyrKrGl7u4PTTUDeqr2rwhGOXPcrrd67ULdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866742; c=relaxed/simple;
	bh=hvhONuS1Va4aXa4gexiTlMB9pMUi68he2/K9g5leyVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzIFMHA5X8mcKMt0QAEZtsJRRGge0RsGDRHb70Dh4SvXuRf1WtAV1YGwhKSgqUVI7UG+c0cQB7k8bqRrUs1AG37Ror8j7YDUqEbZgrgMMZLKi4jEBWgnXgzUahcfGizbgtOFCSNGeDfZAtfHHeZwQpOoK92S2YOn0Td49K2nIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=jQMJNpEA; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ViwQmQRnI/xG0YiBwrcfVedfKN8UHZeYrhdukRSyi/A=; b=jQMJNpEAeETeirigfByVTis7rA
	MZ3sNKJdWxEerTDffJoM6O9+DvVTVP3PmtBLPdYNVZIhMXc57NHGMAHVdKW5y1X2mHBR3MmvxgKwK
	RJf+GlKHTvlouNmbvw+rORVXvfgaJiSOx8tRyTKJ8IE5Z1BZ7MK1LqITpE8Wk/RvRYuYa3umqjFst
	a8T9HoF22GBTvPoaErVlt4L1IXhfIuuL8kDtXmyCx7Z494kijVlVe31xBg6RQm7aVljrbCnAPUn2l
	Rx27hZln7aRuOxSvOYMas0KuYkFLi7uNSvI0DmvBrWypNysIAQvecslg7jR20uDvMwVUJcXKndiog
	aCmfr4Rw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tsgju-000000006Xv-1bR2;
	Thu, 13 Mar 2025 12:28:38 +0100
Date: Thu, 13 Mar 2025 12:28:38 +0100
From: Phil Sutter <phil@nwl.cc>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Matteo Croce <technoboy85@gmail.com>, netdev@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH iproute2-next v2] color: default to dark color theme
Message-ID: <Z9LBZsdh3PsjuB28@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Matteo Croce <technoboy85@gmail.com>, netdev@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
References: <20250310203609.4341-1-technoboy85@gmail.com>
 <20250310141216.5cdfd133@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310141216.5cdfd133@hermes.local>

On Mon, Mar 10, 2025 at 02:12:16PM -0700, Stephen Hemminger wrote:
> On Mon, 10 Mar 2025 21:36:09 +0100
> Matteo Croce <technoboy85@gmail.com> wrote:
> 
> > From: Matteo Croce <teknoraver@meta.com>
> > 
> > The majority of Linux terminals are using a dark background.
> > iproute2 tries to detect the color theme via the `COLORFGBG` environment
> > variable, and defaults to light background if not set.
> >
> 
> This is not true. The default gnome terminal color palette is not dark.

ACK. Ever since that famous movie I stick to the real(TM) programmer
colors of green on black[1], but about half of all the blue pill takers
probably don't.

> > Change the default behaviour to dark background, and while at it change
> > the current logic which assumes that the color code is a single digit.
> > 
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> 
> The code was added to follow the conventions of other Linux packages.
> Probably best to do something smarter (like util-linux) or more exactly
> follow what systemd or vim are doing.

I can't recall a single system on which I didn't have to 'set bg=dark'
in .vimrc explicitly, so this makes me curious: Could you name a
concrete example of working auto color adjustment to given terminal
background?

Looking at vim-9.1.0794 source code, I see:

|     char_u *
| term_bg_default(void)
| {
| #if defined(MSWIN)
|     // DOS console is nearly always black
|     return (char_u *)"dark";
| #else
|     char_u      *p;
| 
|     if (STRCMP(T_NAME, "linux") == 0
|             || STRCMP(T_NAME, "screen.linux") == 0
|             || STRNCMP(T_NAME, "cygwin", 6) == 0
|             || STRNCMP(T_NAME, "putty", 5) == 0
|             || ((p = mch_getenv((char_u *)"COLORFGBG")) != NULL
|                 && (p = vim_strrchr(p, ';')) != NULL
|                 && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
|                 && p[2] == NUL))
|         return (char_u *)"dark";
|     return (char_u *)"light";
| #endif
| }

So apart from a little guesswork based on terminal names, this does the
same as iproute currently (in his commit 54eab4c79a608 implementing
set_color_palette(), Petr Vorel even admitted where he had copied the
code from). No hidden gems to be found in vim sources, at least!

Cheers, Phil

[1] And have the screen rotated 90 degrees to make it more realistic,
    but that's off topic.

