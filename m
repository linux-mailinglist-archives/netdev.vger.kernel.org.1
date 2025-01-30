Return-Path: <netdev+bounces-161681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC8A23398
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE33C1882463
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3C1F03FF;
	Thu, 30 Jan 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxyAr8qq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682551F03F5;
	Thu, 30 Jan 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260839; cv=none; b=lZB9owtLRcK7QmoYxB88REb3sXF+hyIpwNu/tEDlLAN5N6px0aFLztlXEI9VwS70wTA2z1KeO4hCqmimX8WozyulBOVQyOXkbM/Gu9gNGl3mnVWOzfp1ZKWSLgoJAn/cmldejm0903CfLv4QDkwWQupNlxmdwWwMLyEexCNHzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260839; c=relaxed/simple;
	bh=CFvylmkfpQXyjutHCowdCstPU+btHiGDqHnk7+frJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kevu12JPugeUSxU0vMV3tCRnnY1x9b/A/Xb7hk0JrUNWZCVPIUXKbn4xOY4mvNMxPjvus04CSCfnTi5HK9rln0W0GhE5/M6zBqry2TafHf24Dvwlogrcxdd6BNZAgPp4lk6G6vL1R3sxXT+qZEQxAlAhWA90VB6ITMJ1C0RU6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxyAr8qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE019C4CED2;
	Thu, 30 Jan 2025 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738260838;
	bh=CFvylmkfpQXyjutHCowdCstPU+btHiGDqHnk7+frJLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GxyAr8qqnbwq+CTzOc79v4Pudb4m4RDGKCQTvg869TF2vZvH39Trryvh3IV6lDuAz
	 lz1/gmeH9zd+H8MdtRm0nGZBg3ni5Zf3JW2vSjKn7FbXX9qdyEfQVzQcxKXO4ZJUJk
	 QSAO1u9Nho4P6mAxRG6KXZzKobqM6CGQbVQo/LpGTQchT6Zwf9YyPCKmSpJvOLkhWh
	 GecBovPQivSthivhwoNzuyyIAlsKPpgfP9Ke20MFIuf+YRq8XtmhDqus9NXk7Exhf3
	 BPvrHn4dlIjfJt+s6evyODrkeiPc1LnFwHU9APz3bmrMSS3tam31dAuxzCh04Ndayr
	 r/MJz4kAgVsVw==
Date: Thu, 30 Jan 2025 10:13:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Amritha Nambiar
 <amritha.nambiar@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, Daniel
 Jurgens <danielj@nvidia.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] netdev-genl: Add an XSK attribute to queues
Message-ID: <20250130101357.2cd1bbc5@kernel.org>
In-Reply-To: <Z5u_t7Rw77X6VAEs@LQ3V64L9R2>
References: <20250129172431.65773-1-jdamato@fastly.com>
	<20250129172431.65773-2-jdamato@fastly.com>
	<20250129175224.1613aac1@kernel.org>
	<Z5u_t7Rw77X6VAEs@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 13:06:47 -0500 Joe Damato wrote:
> On Wed, Jan 29, 2025 at 05:52:24PM -0800, Jakub Kicinski wrote:
> > On Wed, 29 Jan 2025 17:24:24 +0000 Joe Damato wrote:  
> > > Expose a new per-queue attribute, xsk, which indicates that a queue is
> > > being used for AF_XDP. Update the documentation to more explicitly state
> > > which queue types are linked.  
> > 
> > Let's do the same thing we did for io_uring queues? An empty nest:
> > https://lore.kernel.org/all/20250116231704.2402455-6-dw@davidwei.uk/
> > 
> > At the protocol level nest is both smaller and more flexible.
> > It's just 4B with zero length and a "this is a nest" flag.
> > We can add attributes to it as we think of things to express.  
> 
> I got a thing working locally, but just to make sure I'm
> following... you are saying that the attribute will exist (but have
> nothing in it) when the queue has a pool, and when !q->pool the
> attribute will not exist?
> 
> For example:
> 
> [{'id': 0, 'ifindex': 5, 'napi-id': 8266, 'type': 'rx', 'xsk': {}},
>  {'id': 1, 'ifindex': 5, 'napi-id': 8267, 'type': 'rx'},
>  ...
> 
> Is that what you are thinking?

Yup! That's it.

> Completely fine with me as I haven't read enough of the xsk code to
> really have a good sense of what attributes might be helpful to
> expose at this point.

