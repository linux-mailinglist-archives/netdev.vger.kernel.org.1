Return-Path: <netdev+bounces-128991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9E97CC74
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2961C21E94
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E64B1A2C0A;
	Thu, 19 Sep 2024 16:17:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C331A08A9
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762634; cv=none; b=HK99MyGZwmLbjed4q4D+D0k73JKkaTcppK1/D3gDGrSTcDpF8TxtJ4Id9s7scQzFXwM1PufeHkk66T/OprKyN0Azk2IypKT8XlhLlj2gyXg0sliWys5Hr403YVAS18AF6NUB3OPus7VNC/ti/BoU8cOXAdt22SBxBIsrjBDr6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762634; c=relaxed/simple;
	bh=KS4P8eS2lW5vydIMndE2gwmsRWilOEUA4j+0kpqNBgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T380K0OgHTu269UpKRAVxd05CHTPKu2VyzltpaJE8BH1L+JZjC3p1sHVl7EAFP+kr4/nJr8vZQJKZL64UCAtxE40A3mntkGld4b2DK5NN/PQDKbMqDIEfczjUTmn65p/ZP04Lek8aFm7SABUejdMWbUOAUdJzSpgCLybCcw+IS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1srJq9-00058c-1V; Thu, 19 Sep 2024 18:17:09 +0200
Date: Thu, 19 Sep 2024 18:17:09 +0200
From: Florian Westphal <fw@strlen.de>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: Dealing with bugzilla
Message-ID: <20240919161709.GA18875@breakpoint.cc>
References: <20240919091046.64cb49b6@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919091046.64cb49b6@hermes.local>
User-Agent: Mutt/1.10.1 (2018-07-13)

Stephen Hemminger <stephen@networkplumber.org> wrote:
> Up until now, I have been the volunteer screener of networking related bugzilla bugs.
> I would like to get out of doing that.

Understandable, thanks for doing all the prefiltering work all these
years!

> The alternatives are:
>    1. Change the bugzilla forwarding to netdev@vger.kernel.org (ie no screening)

"OH NEIN !!!11"

>    2. Get a new volunteer to screen

Even if someone would volunteer I don't think it would be good to have
this burden on one person alone.

>    3. Make a new mailing list target on vger (ie netdev-bugs@vger.kernel.org)

I'd go for 3) and see how that works out.

>    4. Find someone to make a bot to use get_maintainer somehow to forward

I'd say 3, then see if it can be refined somehow.
3) would also allow to get an impression on the volume, the signal/noise ratio etc.

>    5. Blackhole the bugzilla reports.
>    6. Bounce all the bugzilla reports somehow.

5 & 6 are worse than 7), which would be to close bugzilla
and keep it readonly archive.

