Return-Path: <netdev+bounces-188783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61193AAED17
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 22:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423A63AFD58
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B70F28F930;
	Wed,  7 May 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hIxAOst7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807D205ABB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649890; cv=none; b=XCXanz+kaa4DzAmGG5YJMrOxCKqoITT94VUH9reKqDFsr5zFwghOnAQHbvkpuBtEucvJPVWH9csm4TE2A45yDwP0C/8AyaWByQysJXg42KElKX53soTPu6HD1XNfm2vCc9sHwzevbiH2U+sFQ9qevED/7nLGHe+OiltwJOZ5ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649890; c=relaxed/simple;
	bh=K2+ro8KXG5KK7X3DjDvs1zWwAW6Yo9MEVaIqdgF5ysg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6fb8Gb2mF8hy72QHK/0SEDb8C/pW8EYGhBtp5elArG/sqlJp2CAWgXk1QnYTyUQpgZ9dPu/5zHnxDM5VXhRzlyc8QzdvNzVzZ1b46JGqHtGwofnEq3G3rPgCxZ4JWkCElNa0L5Gb0VXzf34qEwdBSe/D1AZGdYpYf8hoah5nCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hIxAOst7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=g/yEorNgjqZxqjjZCRjS2unOJ0chJrQIlXe8tiQPHSM=; b=hI
	xAOst7GfoeVjD8n8TPyzlhDaXrr4uz+inKPGlDXLTbopit8euQqDg7ns8ReYzj675r3hrEXGjupKy
	3j77snOdaluSlXCWFkksPNbHFNBmDqjg5J4zCoi55hKZi+C1t4hWJmiHIQf4Xkk99gUbofge6mPmO
	el8fo0TBbwqXu4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uClQI-00BvfO-5S; Wed, 07 May 2025 22:31:22 +0200
Date: Wed, 7 May 2025 22:31:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v8 08/15] net: homa: create homa_pacer.h and
 homa_pacer.c
Message-ID: <7e177e94-24cb-4090-81b9-d82b0c43a37d@lunn.ch>
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-9-ouster@cs.stanford.edu>
 <a6b82986-52df-4d51-b854-a2eb5842a574@redhat.com>
 <CAGXJAmxbtj7x78KYNBWoZaCHbOf39ekeHQUX2bMZsipXUCau_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmxbtj7x78KYNBWoZaCHbOf39ekeHQUX2bMZsipXUCau_Q@mail.gmail.com>

On Wed, May 07, 2025 at 11:55:23AM -0700, John Ousterhout wrote:
> In Tue, May 6, 2025 at 7:05 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 5/3/25 1:37 AM, John Ousterhout wrote:
> > > +     /**
> > > +      * @link_mbps: The raw bandwidth of the network uplink, in
> > > +      * units of 1e06 bits per second.  Set externally via sysctl.
> > > +      */
> > > +     int link_mbps;
> >
> > This is will be extremely problematic. In practice nobody will set this
> > correctly and in some cases the info is not even available (VM) or will
> > change dynamically due to policing/shaping.
> >
> > I think you need to build your own estimator of the available B/W. I'm
> > unsure/I don't think you can re-use bql info here.
> 
> I agree about the issues, but I'd like to defer addressing them. I
> have begun working on a new Homa-specific qdisc, which will improve
> performance when there is concurrent TCP and Homa traffic. It
> retrieves link speed from the net_device, which will eliminate the
> need for the link_mbps configuration option.

I would be sceptical of the link speed, if you mean to use ethtool
get_link_ksettings(). Not all switches have sufficient core bandwidth
to allow all their ports to operate at line rate at the same
time. There could be pause frames being sent back to slow the link
down. And there could be FEC reducing the actual bandwidth you can get
over the media. You also need to consider congestion on switch egress,
when multiple sources are sending to one sink etc.

BQL gives you a better idea of what the link is actually capable of,
over the last few seconds, to the first switch. But after that,
further hops across the network, it does not help.

	Andrew

