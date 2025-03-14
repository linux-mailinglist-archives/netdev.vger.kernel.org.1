Return-Path: <netdev+bounces-174935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C02A61729
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204151B60C83
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3120409D;
	Fri, 14 Mar 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="lvYwnnR2"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3D1FDA7A
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972369; cv=none; b=mAdmgA7TMw7L40l7iEZm7tXpybX/r0a9/DxnYH7b4z8p73uW3BVcEG805hbtrFK1e53wI3loLLGAJRYX46vzIGc+8F/VcTWNRmDU+8YTx3hY/gT0f/63Max5V9DB2+RBeT5//UU2qw7RkKJ5bBj2AFRk0mHhhcxMRYPJacLxwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972369; c=relaxed/simple;
	bh=+2bAPxpEgLNbLfmOzPnSbEOmjjT26GRGlcHUskm9ptU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji1VgHGPHlI5A8BXiUVGOURz2kR1ygv4lTgLoM9kOfbGdqCW38p7WAh7ykpvPf6Vh6v4uZ4MKZ0kigx0dYNrlFbQLtAij+fw95vccB9wFxpjkmVX++h68SsrBBdglswxEI0sc9m32Va8iYyBLt8FMJfUyrVDKdRVpW/tQPMeesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=lvYwnnR2; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/NTzv4DttY45rMbVG44ASdHnEHFJkKf67vqSh/R036k=; b=lvYwnnR2corAQH/gcoLA34F6kr
	oF96kM/vAj9EPB1eWpRvKg5p1G40gzrpYlDOFNbT8QUQXRjtqQbwJ7wSS5z9BIhBhTi5eyPdG/HtY
	t2kw46qjUZDfBpuaR7jcbb7pJbP3Uqsx1W1ws4FX/Sefbl3XxomIl5Sd4THRP9St+cWiLBb7ncV5z
	aobeEXGRY43rx8G6LyA3c4SqAoehhbvio75af0TMxijUPUtLG1rQMoSq34hxvyu1rmm8Fx9HFj1HP
	eCW+FUi9aCsv+HjrY79iuRN9ygXmkkQvQ3u2FMhJhcXGT7jlXjaydbt8K/2m8BqFfAC1KvQsVOA9q
	r4fTiggg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tt8aL-000000002kf-2wpd;
	Fri, 14 Mar 2025 18:12:37 +0100
Date: Fri, 14 Mar 2025 18:12:37 +0100
From: Phil Sutter <phil@nwl.cc>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Matteo Croce <technoboy85@gmail.com>, netdev@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH iproute2-next v2] color: default to dark color theme
Message-ID: <Z9RjhTfXi86Jo7SL@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Matteo Croce <technoboy85@gmail.com>, netdev@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
References: <20250310203609.4341-1-technoboy85@gmail.com>
 <20250310141216.5cdfd133@hermes.local>
 <Z9LBZsdh3PsjuB28@orbyte.nwl.cc>
 <CAFnufp0e-GNCsjXw-KUjnTx+A4TP_gQTW4-HK2T8kYxH-PMxkg@mail.gmail.com>
 <Z9LJ_zDqy8iKpX7y@orbyte.nwl.cc>
 <20250313093035.18848cf0@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313093035.18848cf0@hermes.local>

On Thu, Mar 13, 2025 at 09:30:35AM -0700, Stephen Hemminger wrote:
> On Thu, 13 Mar 2025 13:05:19 +0100
> Phil Sutter <phil@nwl.cc> wrote:
> 
> > On Thu, Mar 13, 2025 at 12:41:54PM +0100, Matteo Croce wrote:
> > > Il giorno gio 13 mar 2025 alle ore 12:28 Phil Sutter <phil@nwl.cc> ha scritto:  
> > > >
> > > > On Mon, Mar 10, 2025 at 02:12:16PM -0700, Stephen Hemminger wrote:  
> > > > > On Mon, 10 Mar 2025 21:36:09 +0100
> > > > > Matteo Croce <technoboy85@gmail.com> wrote:
> > > > >  
> > > > > > From: Matteo Croce <teknoraver@meta.com>
> > > > > >
> > > > > > The majority of Linux terminals are using a dark background.
> > > > > > iproute2 tries to detect the color theme via the `COLORFGBG` environment
> > > > > > variable, and defaults to light background if not set.
> > > > > >  
> > > > >
> > > > > This is not true. The default gnome terminal color palette is not dark.  
> > > >
> > > > ACK. Ever since that famous movie I stick to the real(TM) programmer
> > > > colors of green on black[1], but about half of all the blue pill takers
> > > > probably don't.
> > > >  
> > > > > > Change the default behaviour to dark background, and while at it change
> > > > > > the current logic which assumes that the color code is a single digit.
> > > > > >
> > > > > > Signed-off-by: Matteo Croce <teknoraver@meta.com>  
> > > > >
> > > > > The code was added to follow the conventions of other Linux packages.
> > > > > Probably best to do something smarter (like util-linux) or more exactly
> > > > > follow what systemd or vim are doing.  
> > > >
> > > > I can't recall a single system on which I didn't have to 'set bg=dark'
> > > > in .vimrc explicitly, so this makes me curious: Could you name a
> > > > concrete example of working auto color adjustment to given terminal
> > > > background?
> > > >
> > > > Looking at vim-9.1.0794 source code, I see:
> > > >
> > > > |     char_u *
> > > > | term_bg_default(void)
> > > > | {
> > > > | #if defined(MSWIN)
> > > > |     // DOS console is nearly always black
> > > > |     return (char_u *)"dark";
> > > > | #else
> > > > |     char_u      *p;
> > > > |
> > > > |     if (STRCMP(T_NAME, "linux") == 0
> > > > |             || STRCMP(T_NAME, "screen.linux") == 0
> > > > |             || STRNCMP(T_NAME, "cygwin", 6) == 0
> > > > |             || STRNCMP(T_NAME, "putty", 5) == 0
> > > > |             || ((p = mch_getenv((char_u *)"COLORFGBG")) != NULL
> > > > |                 && (p = vim_strrchr(p, ';')) != NULL
> > > > |                 && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
> > > > |                 && p[2] == NUL))
> > > > |         return (char_u *)"dark";
> > > > |     return (char_u *)"light";
> > > > | #endif
> > > > | }
> > > >
> > > > So apart from a little guesswork based on terminal names, this does the
> > > > same as iproute currently (in his commit 54eab4c79a608 implementing
> > > > set_color_palette(), Petr Vorel even admitted where he had copied the
> > > > code from). No hidden gems to be found in vim sources, at least!
> > > >
> > > > Cheers, Phil
> > > >
> > > > [1] And have the screen rotated 90 degrees to make it more realistic,
> > > >     but that's off topic.  
> > > 
> > > I think that we could use the OSC command 11 to query the color:
> > > 
> > > # black background
> > > $ echo -ne '\e]11;?\a'
> > > 11;rgb:0000/0000/0000
> > > 
> > > # white background
> > > $ echo -ne '\e]11;?\a'
> > > 11;rgb:ffff/ffff/ffff  
> > 
> > Maybe a better technique than checking $COLORFGBG. Note that:
> > 
> > - This may return rgba and a transparency value
> > - In 'xterm -bg green', it returns '11;rgb:0000/ffff/0000'
> > 
> > So the value may not be as clear as in the above cases.
> > 
> > Cheers, Phil
> 
> Rather than hard coding color palettes it would be better to use some
> form of environment or config file to allow user to choose.

I think we have that already. Quoting from ip(8):

 -c[color][={always|auto|never}
    [...]
    Used color palette can be influenced by COLORFGBG environment
    variable (see ENVIRONMENT).
 [...]
 ENVIRONMENT
    COLORFGBG
      If set, it’s value is used for detection whether background is
      dark or light and use contrast colors for it.

      COLORFGBG  environment  variable  usually contains either two or
      three values separated by semicolons; we want the last value in
      either case. If this value is 0-6 or 8, chose colors suitable for
      dark background:

      COLORFGBG=";0" ip -c a

Cheers, Phil

