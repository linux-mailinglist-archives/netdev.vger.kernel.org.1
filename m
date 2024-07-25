Return-Path: <netdev+bounces-113016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CC93C3EA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34267B21B2C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CA19CCF5;
	Thu, 25 Jul 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hP9mc1za"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264A3FB3B;
	Thu, 25 Jul 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917105; cv=none; b=Gz04zZDpbyW55eazj0m99LZ9OAs1erK900ZfDx8n4JAC6b3yN56JrWrmQf3i83gS3rpAaMcBDPH42mEjy/MEJa+noYuRtTaASrRIae6hhk6QS7XaH3VTT/Qkv/AanWiAotU9Nuor9vF83jkEU07o9oi+lOiES+DiVJAB2QJ45d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917105; c=relaxed/simple;
	bh=ygDnth1C28xLAe3h8ElguVvzIpLxChuKUvV5W0V4ulk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOwf5iLkrYJnIxBiGiNsUAwJc/jD1pC9a/KOiVMAJ9RHBqWlvF4OqyETaxpuv8+gUewHptjvOpINKGsLWg9+YZ39USOVk9PV9/jZaDqr5gWRML08ycGv1vIzfJcenuZYbF9gjXD4VSpcOprMhKRxKMdMPw+pzoZuJHv3zbCPGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hP9mc1za; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=IhE5GEFyRJBbsPlOyYM3ajXD3ZfpIhn5ydfRA/yrrKc=; b=hP9mc1zaqq3kHqnz
	gfpnUUGwHfv03WegqUrk9kCPaRMQtJNRj+JsANQZ/DASsCM/R5e8+SLQjNi0PNLAd+ELhoPcF2yck
	UIbJQdliDQgKuAPLJmhICFC2d9qUh6PZ7/RK6ewflWmSWjPAIutkgmZzjfZbIVJo2UGg/FDmmbqcM
	LwegCYh8u1BX2M3bjH7lz8xWOTXEdeEIc9SCulDpCvvHizNERWOVkpcZT28TYrITtlDF+r8jlqhDS
	hZXcpsGfLdy+iOdvmc5Hk8t55mHeb6+c378ol/nQeBMSfGjVKmgUzmWrsfkJIqmWa7Fug0YdLtzN7
	ZAvj2LYrF+P3uQwkMg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sWzIP-00DCtU-2c;
	Thu, 25 Jul 2024 14:18:17 +0000
Date: Thu, 25 Jul 2024 14:18:17 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, edumazet@google.com,
	dsahern@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kennetkl@ifi.uio.no
Subject: Re: [PATCH] net/tcp: Expand goo.gl link
Message-ID: <ZqJeqWO7xVjA88Zd@gallifrey>
References: <20240724172508.73466-1-linux@treblig.org>
 <20240724191215.GJ97837@kernel.org>
 <b399e0bf-07fd-4da6-9ab4-19cd1ceaa456@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b399e0bf-07fd-4da6-9ab4-19cd1ceaa456@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:17:58 up 78 days,  1:32,  1 user,  load average: 0.11, 0.04, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Paolo Abeni (pabeni@redhat.com) wrote:
> 
> 
> On 7/24/24 21:12, Simon Horman wrote:
> > On Wed, Jul 24, 2024 at 06:25:08PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > The goo.gl URL shortener is deprecated and is due to stop
> > > expanding existing links in 2025.
> > > 
> > > Expand the link in Kconfig.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Both the motivation and updated link look correct to me.
> > I also checked that there is no other usage of goo.gl in this file.
> > 
> > Not sure if this should be for net or net-next.
> 
> I also think this should go via net-next.
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.11 and therefore net-next is closed for new
> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
> 
> Please repost when net-next reopens after July 29th.

OK, I'll repost next week.

Dave

> RFC patches sent for review only are obviously welcome at any time.
> 
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> -- 
> pw-bot: defer
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

