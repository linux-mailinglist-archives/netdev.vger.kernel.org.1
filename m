Return-Path: <netdev+bounces-75522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62486A64E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1782C28592D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B144400;
	Wed, 28 Feb 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR1oLvmT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC823BD
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085981; cv=none; b=td7872w2ddAAM8KfHbUfgsBtgUpvApOSr2E3oDdRz9lfVmN9e7uWCFUfQ+6eKqVUuUfqr8sCK17dKGQHYfG25EiLtIBbordFA0LHSntYg0U5/RFLc1n5dkGLU2DBaulITLRiAc1rdXoxQIsK+NX+yAk3q8Dgro3bQjjnzXuoGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085981; c=relaxed/simple;
	bh=dHDCKbGtb5A6TcofoQ6+toXMHlT+gODqpZCrSVTxQns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOMrOyKquBcDVkZhYHYRlhjwqnWZd5Pud6uTEvY2YdgUux0t4LZb9CT3SAMBYyz3PYQbckOxP5ElP/ZARpl5Un0xvMxbB/U7LLTA4g5+lfo/+BzgmNY+RL3Yg8zdNzgNsPpgCyQI4bt7DivbWyqRqMoj2opsW5CWlop+sPAtcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR1oLvmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48187C433C7;
	Wed, 28 Feb 2024 02:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709085981;
	bh=dHDCKbGtb5A6TcofoQ6+toXMHlT+gODqpZCrSVTxQns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cR1oLvmTzfCmPE3SVGKKgrqO6Bej7AKNI0GfGzp4PDrXXnA1/W9dmhC5ciXoFMhPj
	 7k/ywJ2ApcdujRqcHW1/PIGj/DGuUzk/9DOAE09jcWvBX9t61sGjT/BfKVAkR6lC3w
	 tm7XjsNiHmOmg7atnnAhoUD4FcOKUOETOAD1TeHJwLO4tLHoRQo8uv6apPk7tUid6K
	 /eKU5DrD2NWximyhzwdnxljq6d8yXfh5AOcxqM0EXJodzPsWIxLUAuYcNRt67ISmHP
	 /mzi2WtbdiZbN40pFavtpy6AmFEIBbf5RZO5dHNg6CuUz2yJsV2L8sCqAnugsOo2/4
	 MuGmYm5g6jyVQ==
Date: Tue, 27 Feb 2024 18:06:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tariq Toukan <ttoukan.linux@gmail.com>, Saeed
 Mahameed <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240227180619.7e908ac4@kernel.org>
In-Reply-To: <ZdhnGeYVB00pLIhO@nanopsycho>
References: <20240215030814.451812-1-saeed@kernel.org>
	<20240215030814.451812-16-saeed@kernel.org>
	<20240215212353.3d6d17c4@kernel.org>
	<f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
	<20240220173309.4abef5af@kernel.org>
	<2024022214-alkalize-magnetize-dbbc@gregkh>
	<20240222150030.68879f04@kernel.org>
	<de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
	<ZdhnGeYVB00pLIhO@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 10:36:25 +0100 Jiri Pirko wrote:
> >> It's really a special type of bonding of two netdevs. Like you'd bond
> >> two ports to get twice the bandwidth. With the twist that the balancing
> >> is done on NUMA proximity, rather than traffic hash.
> >> 
> >> Well, plus, the major twist that it's all done magically "for you"
> >> in the vendor driver, and the two "lower" devices are not visible.
> >> You only see the resulting bond.
> >> 
> >> I personally think that the magic hides as many problems as it
> >> introduces and we'd be better off creating two separate netdevs.
> >> And then a new type of "device bond" on top. Small win that
> >> the "new device bond on top" can be shared code across vendors.  
> >
> >Yes. We have been exploring a small extension to bonding driver to enable a
> >single numa-aware multi-threaded application to efficiently utilize multiple
> >NICs across numa nodes.  
> 
> Bonding was my immediate response when we discussed this internally for
> the first time. But I had to eventually admit it is probably not that
> suitable in this case, here's why:
> 1) there are no 2 physical ports, only one.

Right, sorry, number of PFs matches number of ports for each bus.
But it's not necessarily a deal breaker - it's similar to a multi-host
device. We also have multiple netdevs and PCIe links, they just go to
different host rather than different NUMA nodes on one host.

> 2) it is basically a matter of device layout/provisioning that this
>    feature should be enabled, not user configuration.

We can still auto-instantiate it, not a deal breaker.

I'm not sure you're right in that assumption, tho. At Meta, we support
container sizes ranging from few CPUs to multiple NUMA nodes. Each NUMA
node may have it's own NIC, and the orchestration needs to stitch and
un-stitch NICs depending on whether the cores were allocated to small
containers or a huge one.

So it would be _easier_ to deal with multiple netdevs. Orchestration
layer already understands netdev <> NUMA mapping, it does not understand
multi-NUMA netdevs, and how to match up queues to nodes.

> 3) other subsystems like RDMA would benefit the same feature, so this
>    int not netdev specific in general.

Yes, looks RDMA-centric. RDMA being infamously bonding-challenged.

Anyway, back to the initial question - from Greg's reply I'm guessing
there's no precedent for doing such things in the device model either.
So we're on our own.

