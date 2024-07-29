Return-Path: <netdev+bounces-113797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D616393FFD8
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BFD283E8D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBC188CD7;
	Mon, 29 Jul 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iG0v1o6I"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2783A19;
	Mon, 29 Jul 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286486; cv=none; b=dyo6jBDtOH+yjaGCDb6JtyYoaduwm1TnIsmjEZjs0MYFSls4t8bpeivyPHyJO0XnO3Pm3V5Ca87yT4zATRVQ7tNAbPcXh7BzCUmKBgnuu5I39Leyr+1nRd9EGEKlVn93L1hpx54IHgQ4v5TFPZDzpMxXd6aN+vt9EVCl+tV+AOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286486; c=relaxed/simple;
	bh=vMSC5mSJwofNe+SDXEoDV476/CgeV7I1vGfJNeOR4tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk3nqxwseA9V7yQafYo+pyQ+3Th6keGhimY1cPgN8gv3wtLWzHo6qOW7OEfPTB7x1QkT0ABiPP93fWkOjNY+6SCX4+/A4gl+47YwUxL2ADIHk/aVTlx9Roe+jimVIxQJzduC4pn3kp5FwnfjrHlbljMhxhMwL3uD4rKwxEicPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iG0v1o6I; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=NVCKukZsilXPQ2aJYNivXtgsqLnvhWzzpkUIDtz4BwE=; b=iG0v1o6IlSlw2y96
	0zzRkx2bzLAtEeHuHVphd7BaFlzrv0bEa3pg1ecEqa9BHMZBC+sJpPxDDy0G2o+Cee58mao9Heo6V
	atgjbAJre7ShJIivSxn48SoiGx7d5s6dryGPQK8aHqSUbQfyAxqQO2bccDkwzK6dDRZSJpSeZihYW
	di7rnldApxpau8P9wABjHDnOZflwcHVm7ZbSU4+3yS5Pi0/whR5zBqRNqHYYhCY1gqaylvWD6hAmn
	e9l27Viuux97w1aNQ4Ir73fTanLG3oFyBVdx7elMszhRlNP1Jh3nxxOIx3c5wAc6Ot9Zv7SliWxSG
	KMRkrKjLF5XUmHMNxQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sYXOB-00DsMU-0B;
	Mon, 29 Jul 2024 20:54:39 +0000
Date: Mon, 29 Jul 2024 20:54:39 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, edumazet@google.com,
	dsahern@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kennetkl@ifi.uio.no
Subject: Re: [PATCH] net/tcp: Expand goo.gl link
Message-ID: <ZqgBjxjxpclRhZ_T@gallifrey>
References: <20240724172508.73466-1-linux@treblig.org>
 <20240724191215.GJ97837@kernel.org>
 <b399e0bf-07fd-4da6-9ab4-19cd1ceaa456@redhat.com>
 <ZqJeqWO7xVjA88Zd@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZqJeqWO7xVjA88Zd@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:54:07 up 82 days,  8:08,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Paolo Abeni (pabeni@redhat.com) wrote:
> > 
> > 
> > On 7/24/24 21:12, Simon Horman wrote:
> > > On Wed, Jul 24, 2024 at 06:25:08PM +0100, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > The goo.gl URL shortener is deprecated and is due to stop
> > > > expanding existing links in 2025.
> > > > 
> > > > Expand the link in Kconfig.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > 
> > > Both the motivation and updated link look correct to me.
> > > I also checked that there is no other usage of goo.gl in this file.
> > > 
> > > Not sure if this should be for net or net-next.
> > 
> > I also think this should go via net-next.
> > 
> > ## Form letter - net-next-closed
> > 
> > The merge window for v6.11 and therefore net-next is closed for new
> > drivers, features, code refactoring and optimizations. We are currently
> > accepting bug fixes only.
> > 
> > Please repost when net-next reopens after July 29th.
> 
> OK, I'll repost next week.

As requested, reposted as
Message-id 20240729205337.48058-1-linux@treblig.org

Dave

> Dave
> 
> > RFC patches sent for review only are obviously welcome at any time.
> > 
> > See:
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> > -- 
> > pw-bot: defer
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

