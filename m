Return-Path: <netdev+bounces-222742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90DB55A58
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 01:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B970168079
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C142882D6;
	Fri, 12 Sep 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqbKahbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB17288538
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719913; cv=none; b=W8onIACUsBgTQo49XtCMg3VFAOVkBRUCHnt14sOY4yRe9nsLIvjqLr6MHcWxkdZaN56sVUHTGrVgTzcKn9uxUAkD3rK4xap0AMEpW9Nv4N61zxnwAHSubPX5qaYmdTwxMel7e/PEUg917WLxTm77UrVh3Z72hn7AE9NHxAy/F+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719913; c=relaxed/simple;
	bh=cRd7P9UTZ8A9jnxWj8Ho3aSGFYMopkm1MSyUL47MBPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8Ag9A9ltf1xasIg1UnCh6k8xuwR0ElPS4GKAZdmKzJyhUpo0wM4jbJlsmvC8OmFx0ZFz+Gc9BO7Ips19UwTmuOJ2jesLeEtW0h3XKWmJJmBBfGS5XAcfr8NStg0JpE2qlsoNIs47kZ6pBWJvHdFW9nPjf1N1aNTDjcbmBgakGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqbKahbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8360EC4CEF1;
	Fri, 12 Sep 2025 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757719912;
	bh=cRd7P9UTZ8A9jnxWj8Ho3aSGFYMopkm1MSyUL47MBPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqbKahbzAwHd0qQTc82skH7pLK5ZlSmOXVTlJeFks6u/aw1tzdwbmScCZ7EOpN4FM
	 3ETcFj8gbcRX+xC6kDMLipK8FN6N1OYk+OUDy/o/Itfm5xDTxMYJL8/rx/ccgBjwv3
	 6iEUcN5JRmgTzxiRx5P/2Pw3gHusD0ez3zT+MVXU5Whx1M3BI6JD/krLeWCf6J77RN
	 uBZZyxQQoPL/WuyW8+/Ifj6Zuowkb22CXtaX3GTFqdBO1vULOCACPoBmHCg40ORJZB
	 ogeA9UZFT442zHY2WcLAmcZQNPozXdtRoEJdUf655BOi4dAsRptNjEjfL0OvmcjKXK
	 xp6NpUTgiKwsw==
Date: Fri, 12 Sep 2025 16:31:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] net: phy: print warning if usage of
 deprecated array-style fixed-link binding is detected
Message-ID: <20250912163151.36bcee29@kernel.org>
In-Reply-To: <c651373d-374b-4a67-9526-1555a11cb8b5@gmail.com>
References: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
	<c651373d-374b-4a67-9526-1555a11cb8b5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 07:31:19 +0200 Heiner Kallweit wrote:
> On 9/11/2025 9:18 PM, Heiner Kallweit wrote:
> > The array-style fixed-link binding has been marked deprecated for more
> > than 10 yrs, but still there's a number of users. Print a warning when
> > usage of the deprecated binding is detected.
> > 
> > v2:
> > - use dedicated printk specifiers
> > 
> > Heiner Kallweit (2):
> >   of: mdio: warn if deprecated fixed-link binding is used
> >   net: phylink: warn if deprecated array-style fixed-link binding is
> >     used
> > 
> >  drivers/net/mdio/of_mdio.c | 2 ++
> >  drivers/net/phy/phylink.c  | 3 +++
> >  2 files changed, 5 insertions(+)
> >   
> --
> pw-bot: cr

This was already discarded from PW by the time you send this. 
Please note:

Quoting documentation:

  Updating patch status
  ~~~~~~~~~~~~~~~~~~~~~
  [...] 
  The use of the bot is entirely optional, if in doubt ignore its existence
  completely. Maintainers will classify and update the state of the patches
  themselves. No email should ever be sent to the list with the main purpose
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  of communicating with the bot, the bot commands should be seen as metadata.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  [...]
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status

