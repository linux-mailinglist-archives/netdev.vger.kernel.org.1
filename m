Return-Path: <netdev+bounces-188754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1B6AAE7C6
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8D91C283AC
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B391628C2C1;
	Wed,  7 May 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P5EfZ55l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14225D558
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638759; cv=none; b=KOQ0/jayOeh3Oc/huiGm+ihxBmjndDOd1kdipGlGDQZF1HhWtizgYB8HC1alTJoYaRaDaLGaxj1O9Rmrv5PZhf8dzJLP1rNB2ih4uKhkT6DMRiDsx/StvxqXV5faUp8jt+3fn6PMUw9zgyiWaHVJXy/d3XTbiqQ8cm9Kpm3JCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638759; c=relaxed/simple;
	bh=vZnaULol6oaApzumSiMGKENx5H45DVxNMqhnZhUFLY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3mEu2OSPxPgSKxbyTB7iAdm5hh0K1kGkFLDSPY27oFcNbBTqVc029xw4r3AqEE2WfUEuqXUnGQNQEpyOXjXjiknCyMv5mKWfOWdcRp2hapf+qrQliUTuKMmGJNJ4BtdDeOoNPs8YSWZU3O5hNu/VE312Grl9ubUMtwxq/aO1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P5EfZ55l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FNVyf8lzND6wE8M17+XQQ6Xa7mEDBP5WOaGtnUeDo58=; b=P5
	EfZ55lP0oKfy6g0lJfFeiAxRH7kBIcgjNNP39XbV+dE0C/lCkN1Oy9PtOg2yjLl86joNLvtPALjZF
	DMsQkX0bzlswX2Mqj+t8GFyrkIvl+no4CXnK2rC+jFwVUAo1/VIsYFz1iSvl4UEl+n+z3wHohzJYm
	yYy3BmghcohD1dE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCiWe-00Bucf-Tb; Wed, 07 May 2025 19:25:44 +0200
Date: Wed, 7 May 2025 19:25:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v8 05/15] net: homa: create homa_peer.h and
 homa_peer.c
Message-ID: <64b25d26-dbc1-4027-b04f-ecf5ad3b69b9@lunn.ch>
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-6-ouster@cs.stanford.edu>
 <4350bd09-9aad-491c-a38d-08249f082b6d@redhat.com>
 <CAGXJAmyN2XUjk7hp-7o0Em9b_6Y5S3iiS14KXQWSKUWJXnnOvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmyN2XUjk7hp-7o0Em9b_6Y5S3iiS14KXQWSKUWJXnnOvA@mail.gmail.com>

On Wed, May 07, 2025 at 09:11:01AM -0700, John Ousterhout wrote:
> On Mon, May 5, 2025 at 4:06 AM Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On 5/3/25 1:37 AM, John Ousterhout wrote:
> > [...]
> > > +{
> > > +     /* Note: when we return, the object must be initialized so it's
> > > +      * safe to call homa_peertab_destroy, even if this function returns
> > > +      * an error.
> > > +      */
> > > +     int i;
> > > +
> > > +     spin_lock_init(&peertab->write_lock);
> > > +     INIT_LIST_HEAD(&peertab->dead_dsts);
> > > +     peertab->buckets = vmalloc(HOMA_PEERTAB_BUCKETS *
> > > +                                sizeof(*peertab->buckets));
> >
> > This struct looks way too big to be allocated on per netns basis. You
> > should use a global table and include the netns in the lookup key.
> 
> Are there likely to be lots of netns's in a system? I thought I read
> someplace that a hardware NIC must belong exclusively to a single
> netns, so from that I assumed there couldn't be more than a few
> netns's.

You might want to read up about PF and VF, as part of SR-IOV

https://www.intel.com/content/www/us/en/developer/articles/technical/configure-sr-iov-network-virtual-functions-in-linux-kvm.html

https://doc.dpdk.org/guides/_images/single_port_nic.png

You can have one NIC support a number of Virtual Functions, each of
which is a PCIe device on the bus and gets its own linux
interface. You can move those interfaces between network names spaces,
or pass them through into virtual machines. Below these Virtual
Functions is an embedded switch, often called eswitch. That allows
traffic to flow between the VFs, for e.g. VM to VM, or out the media
to the link peer.

I've used some Intel NICs which support 32 VFs, but other Intel NICs
support 64 VFs.

	Andrew

