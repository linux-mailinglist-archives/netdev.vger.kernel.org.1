Return-Path: <netdev+bounces-174556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36571A5F3BE
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149A0188405C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB09266B4B;
	Thu, 13 Mar 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="bbMH24F2"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794921E51EB
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867524; cv=none; b=s1DkZft8qeDMRF+JuQ9z3DVyMcc5XJX7ZDkSM5e+ttl/gVTIp0AH09IleZGuMM9riP1Odvt6PFJctOhKF9Q+F1TyEK4k5XDv/D1GTRi/bzlK0ncltiAdb10pATSWLoWqQYJTQ8aPnybKPk6VGZeEZ/bI6KYuqxLAHcNU/xT87II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867524; c=relaxed/simple;
	bh=IisSk6sdU50PE88ipM/73T8L2szFc+CMyMn21ZkLocI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpsWn5KYLcFkE631cS9P7YAG5E1+ihA+yrUSa1fOhUxjwInpSMiXgr6w9hBPKhWj1QOmueUy1qsxrRhk8M2YcGkSoijxnu+CDjdRxhXSBguxc8BWXTEB25gg6tje5VVRuDTwA3MmpnUK0N9uaK39Iw1/8+B54AmMgpwYo7hB5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=bbMH24F2; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2nykwEq1TezVw7TCQTw4mUXRBUmVLbTmeYp6q4RM81U=; b=bbMH24F20GYtEi1O8qZKKYBKHe
	G/KsC9cMcPjbi30Q3PfeNHTh8sNv+iWP8D4Tyrd3hqxQhEVH6r/H4DOjo5C5KQEZgTpBNnNI1XI7p
	U3WEAiOMWnwLdrqPVgCuMBT4BzfJKWKmlQ6VFFw6jflB3n0TbqWnDfSevpyPpGe+Kt2sn5xpZjJkG
	iV7vw4/vKfHXOgeNsUfo1Rte/rY/zIGph/InuNv5aqUv4yLKRo/efI+ooGQTKzCO/VkQhb0AqFjGY
	sF8QOef6uczcu60RXeJgP0sfgu1mWHnbNB3Xb6FmAjKpsTCZ625EaXjvgkPrBXK9p6rvdME/rG+HK
	Sb1Qsh+A==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tshJP-0000000072X-0OEf;
	Thu, 13 Mar 2025 13:05:19 +0100
Date: Thu, 13 Mar 2025 13:05:19 +0100
From: Phil Sutter <phil@nwl.cc>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH iproute2-next v2] color: default to dark color theme
Message-ID: <Z9LJ_zDqy8iKpX7y@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Matteo Croce <technoboy85@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
References: <20250310203609.4341-1-technoboy85@gmail.com>
 <20250310141216.5cdfd133@hermes.local>
 <Z9LBZsdh3PsjuB28@orbyte.nwl.cc>
 <CAFnufp0e-GNCsjXw-KUjnTx+A4TP_gQTW4-HK2T8kYxH-PMxkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp0e-GNCsjXw-KUjnTx+A4TP_gQTW4-HK2T8kYxH-PMxkg@mail.gmail.com>

On Thu, Mar 13, 2025 at 12:41:54PM +0100, Matteo Croce wrote:
> Il giorno gio 13 mar 2025 alle ore 12:28 Phil Sutter <phil@nwl.cc> ha scritto:
> >
> > On Mon, Mar 10, 2025 at 02:12:16PM -0700, Stephen Hemminger wrote:
> > > On Mon, 10 Mar 2025 21:36:09 +0100
> > > Matteo Croce <technoboy85@gmail.com> wrote:
> > >
> > > > From: Matteo Croce <teknoraver@meta.com>
> > > >
> > > > The majority of Linux terminals are using a dark background.
> > > > iproute2 tries to detect the color theme via the `COLORFGBG` environment
> > > > variable, and defaults to light background if not set.
> > > >
> > >
> > > This is not true. The default gnome terminal color palette is not dark.
> >
> > ACK. Ever since that famous movie I stick to the real(TM) programmer
> > colors of green on black[1], but about half of all the blue pill takers
> > probably don't.
> >
> > > > Change the default behaviour to dark background, and while at it change
> > > > the current logic which assumes that the color code is a single digit.
> > > >
> > > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > >
> > > The code was added to follow the conventions of other Linux packages.
> > > Probably best to do something smarter (like util-linux) or more exactly
> > > follow what systemd or vim are doing.
> >
> > I can't recall a single system on which I didn't have to 'set bg=dark'
> > in .vimrc explicitly, so this makes me curious: Could you name a
> > concrete example of working auto color adjustment to given terminal
> > background?
> >
> > Looking at vim-9.1.0794 source code, I see:
> >
> > |     char_u *
> > | term_bg_default(void)
> > | {
> > | #if defined(MSWIN)
> > |     // DOS console is nearly always black
> > |     return (char_u *)"dark";
> > | #else
> > |     char_u      *p;
> > |
> > |     if (STRCMP(T_NAME, "linux") == 0
> > |             || STRCMP(T_NAME, "screen.linux") == 0
> > |             || STRNCMP(T_NAME, "cygwin", 6) == 0
> > |             || STRNCMP(T_NAME, "putty", 5) == 0
> > |             || ((p = mch_getenv((char_u *)"COLORFGBG")) != NULL
> > |                 && (p = vim_strrchr(p, ';')) != NULL
> > |                 && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
> > |                 && p[2] == NUL))
> > |         return (char_u *)"dark";
> > |     return (char_u *)"light";
> > | #endif
> > | }
> >
> > So apart from a little guesswork based on terminal names, this does the
> > same as iproute currently (in his commit 54eab4c79a608 implementing
> > set_color_palette(), Petr Vorel even admitted where he had copied the
> > code from). No hidden gems to be found in vim sources, at least!
> >
> > Cheers, Phil
> >
> > [1] And have the screen rotated 90 degrees to make it more realistic,
> >     but that's off topic.
> 
> I think that we could use the OSC command 11 to query the color:
> 
> # black background
> $ echo -ne '\e]11;?\a'
> 11;rgb:0000/0000/0000
> 
> # white background
> $ echo -ne '\e]11;?\a'
> 11;rgb:ffff/ffff/ffff

Maybe a better technique than checking $COLORFGBG. Note that:

- This may return rgba and a transparency value
- In 'xterm -bg green', it returns '11;rgb:0000/ffff/0000'

So the value may not be as clear as in the above cases.

Cheers, Phil

