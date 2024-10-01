Return-Path: <netdev+bounces-130911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45CF98C029
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D91B2826FD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29301C6886;
	Tue,  1 Oct 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dOhgp3vB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF387282F7
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793356; cv=none; b=RoCwv47gh4BFSy9ciDncLQeBdRjzcUSGBEhPuXMHU8GOKJETNMT3pi1vyiDnirj9zl9Gt2aZftZ8KVP3R4ttQalUdjLhv2bsVzywh3ZGKNJQ0BGaKLKGoyvurifM0Aji6y7zakRIuZhuRamuYYY0uLG5W/IIVwjdXK10riFRO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793356; c=relaxed/simple;
	bh=4AGlYbSSELfa29XHCZVr/CA1F1gACOZd4DgP2Pm90b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ1lHoEKvncGETjIOq4iYoIXuXhgdQaPjtH83j5U8Yp9jkp+sWUDLHfH7HQHAdcaX2T1FbANdlE9dBOb1dWEGqN3lCJCQp+GTEnoDs72e348AiTIZLhzuIXfjrfAOxhBzb3BLdCjji9TJxfqSJH9GHfwvAXMzmARHuRkNhdDy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dOhgp3vB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EUlKdbp36TEzv6w89zOYmLbP2ZScClCwie1BzXX0jLk=; b=dOhgp3vBZTwUMmDOvsat2ekyYn
	p39qAiwgKBHlmAPiMBefQejBps481uw6nmdQ+e6iJnFCJyCfTndjRo4MFrCU3bQcQIdFpNe7iSKqy
	jF9zKrn+mrpPrYnoe8Ty8gB7CEOfIsZAYk/YbfE8FyMTnyXDa61LpENujXevbhC5vm20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svdyd-008k0S-Ks; Tue, 01 Oct 2024 16:35:47 +0200
Date: Tue, 1 Oct 2024 16:35:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: Advice on upstreaming Homa
Message-ID: <eea46d0f-4676-4393-940c-27d6fc984938@lunn.ch>
References: <CAGXJAmxbJ7tN-8c0sT6WC_OBmJRTvrt-xvAZyQoM0HoNJFYycQ@mail.gmail.com>
 <577c1d8b-1437-4ff2-b3d1-1261c4f73fec@intel.com>
 <CAGXJAmwMNfoRK42veVS5uFgr0dVZ2G=jj6bR-kn2xV2v+TGFww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmwMNfoRK42veVS5uFgr0dVZ2G=jj6bR-kn2xV2v+TGFww@mail.gmail.com>

> I think Homa is already pretty well known to the netdev community:
> I've given talks on it at multiple NetDev conferences and there are a
> couple of published papers describing both the overall protocol and
> the Linux implementation.There is also a Wiki with lots of links to
> topics related to Homa

I agree with that. Maybe cut/paste an executive summary into patch
0/X, and include some links.

> (https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview). Are
> you suggesting that Homa needs RFC standardization before uploading?

No. The kernel has plenty of experimental features. But you need to be
aware of the backwards compatibility issues you might be opening
yourself up to. Going forward, you cannot break running systems by
changing the protocol without maintaining backwards compatibility. So
make sure you have version fields where you need them, so you can in
the future negotiate between a stone age HOMA and a brand spanking new
version.

> There are a couple of Homa GitHub repos, and I suspect you may be
> looking at the one that is implemented in user space using DPDK. The
> kernel module I'd like to upstream is in this repo:
> https://github.com/PlatformLab/HomaModule. This is an in-kernel
> implementation that doesn't use DPDK.

Great. Kernel people will push back on anything which is not actual
needed for in the kernel.

> 
> > > Homa contains about 15 Klines of code. I have heard conflicting
> > > suggestions about how much to break it up for the upstreaming process,
> > > ranging from "just do it all in one patch set" to "it will need to be
> > > chopped up into chunks of a few hundred lines". The all-at-once
> > > approach is certainly easiest for me, and if it's broken up, the
> > > upstreamed code won't be functional until a significant fraction of it
> > > has been upstreamed. What's the recommended approach here?
> >
> > the split up into patches is to have it easiest to review, test
> > incrementally, and so on
> 
> I would be happy to have Homa reviewed, but is that likely, given its
> size? In any case, Homa has pretty extensive unit tests already.

It will get reviewed, but maybe what you might consider superficially
at first. Does it use the correct coding style? Does it re-invent
stuff which already exists in the kernel? Does its kAPI make sense,
does it abuse debugs or sysfs, etc. Also, do the unit tests fit in
nicely with other tests in tools/testing/selftests/net so they can be
run regularly. Until all that is dealt with, you might find that
nobody looks at the details of the protocols themselves.

> Most of these are already done; the ones that aren't (e.g., reverse
> Xmas-tree formatting, which I only recently discovered) will be done
> before I submit anything.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

ABIs tend to get the most scrutiny, since they are the most important
to get right, before they are fixed in stone. So try to make them easy
to find in the patchset.

	Andrew

