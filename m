Return-Path: <netdev+bounces-96970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC6C8C87AD
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FB282C3B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67C757887;
	Fri, 17 May 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVuMU4Li"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C656B7E;
	Fri, 17 May 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954544; cv=none; b=gEdpSTYLVE9VMVT/U37TXMCnfe5HmHVl3DnmA0qPqEpfR0X3lw8ig9Q8oYrtlVbJ+nwdPpfEtQGhcMc4IWXY1OWBI9PQkcQjos7Z9QWNJwJlfEyjDMdNbs48IyM/Ibr7Xc/RJrPMNjPkamKh3dNTMQtAaVUuF5BARDp8lqo6i3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954544; c=relaxed/simple;
	bh=UTtL8QWSktOUWKUuiu6LfF5ZJtgBaPgKmC19fY4+mWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBKyZONM2UyHOqIuH/cfHQ7DotClTIJEOCiWyTy/gMK0gk+1WfhNs9jHUGRfKjGDVZnPU3I8DlQtS7agMumLd/L/7fwK5enr/cYwWqRbmZLV5bj9xIp5CjFhxeBhUAwgMqb2kIMCk1LcRg3FFdn47iYNuS5on6bggyXE34AXrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVuMU4Li; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715954542; x=1747490542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTtL8QWSktOUWKUuiu6LfF5ZJtgBaPgKmC19fY4+mWQ=;
  b=HVuMU4LiOtNfrqrUUY/IWixTU7DKYfV1cJQVCQGMEP6l2QLTXUwqxF68
   oE5bejxAV/5I1/X6IJA9reIXgcbGyA3I7EU4DJnlRkjWmgBICs5VQwfUm
   hK3bg88bE5zgBZZ0FTPYR/xj5zGtqjOz5zxz0GOZFkkJZKq5ERy10xpwA
   F81GBAMPpLRIizeCOCvtYI/ohi0Ka36pTmVn4W49A20ukwUJClO+F+fN+
   AHVZE0zhkoXY6Wgphl2TfqQ5O+bfaNMWNCnzW9Q/5obBde7FLccsdIaH8
   Lu1A104ZwdXbB+JJoUGnwJb2W9FDkZkNQJR1MatSQim4f4snw6HL4KFMj
   A==;
X-CSE-ConnectionGUID: xGf9XNULTnqXPC7jXB9mmQ==
X-CSE-MsgGUID: LruWkTePQ/eqHK91FR/+cQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="15920954"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15920954"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:02:21 -0700
X-CSE-ConnectionGUID: PZoF6Sz8S2Goh8d+pI1eQg==
X-CSE-MsgGUID: 9ox2vB6YRCSV7596nXDNyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31817391"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:02:20 -0700
Date: Fri, 17 May 2024 16:01:24 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 00/21] ice: add PFCP filter
 support
Message-ID: <ZkdjNGlxU6hAp9cc@mev-dev>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <ZkSivjg7uZsA20ft@nataraja>
 <ZkXjfeLhB9T5MLfX@mev-dev>
 <ZkZ62F_iCCOf4nmM@nataraja>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkZ62F_iCCOf4nmM@nataraja>

On Thu, May 16, 2024 at 11:30:00PM +0200, Harald Welte wrote:
> Hi Michal,
> 
> thanks for your response.
> 
> On Thu, May 16, 2024 at 12:44:13PM +0200, Michal Swiatkowski wrote:
> 
> > > I'm curious to understand why are *pfcp* packets hardware offloaded?
> > > PFCP is just the control plane, similar to you can consider netlink the
> > > control plane by which userspace programs control the data plane.
> > > 
> > > I can fully understand that GTP-U packets are offloaded to kernel space or
> > > hardware, and that then some control plane mechanism like PFCP is needed
> > > to control that data plane.  But offloading packets of that control
> > > protocol?
> > 
> > It is hard for me to answer your concerns, because oposite to you, I
> > don't have any experience with telco implementations. We had client that
> > want to add offload rule for PFCP in the same way as for GTP. 
> 
> I've meanwhile done some reading and it seems there are indeed some
> papers suggesting that in specific implementations of control/data plane
> splits, the transaction rate between control and data plane (to set up /
> tear down / modify tunnels) is to low.  As a work-around, the entire
> PFCP parsing is then off-loaded into (e.g. P4 capable) hardware.
> 
> So it seems at least there appears to be equipment where PFCP offloading
> is useful to significantly incresae performance.
> 
> For those curious, https://faculty.iiitd.ac.in/~rinku/resources/slides/2022-sosr-accelupf-slides.pdf
> seems to cover one such configuration where offloading processing the
> control-plane protocol into the P4 hardware switch has massively
> improved the previously poor PFCP processing rate.

Thanks for the interesting link.

> 
> > Intel
> > hardware support matching on specific PFCP packet parts. We spent some
> > time looking at possible implementations. As you said, it is a little
> > odd to follow the same scheme for GTP and PFCP, but it look for me like
> > reasonable solution.
> 
> Based on what I understand, I am not sure I would agree with the
> "reasonable solution" part.  But then of course, it is a subjective
> point of view.
> 
> I understand and appreciate the high-level goal of giving the user some
> way to configure a specific feature of an intel NIC.
> 
> However, I really don't think that this should come at the expense of
> introducing tunnel devices (or other net-devs) for things that are not
> tunnels, and by calling things PFCP whcih are not an implementation of
> PFCP.
> 
> Tou are introducing something called "pfcp" into the kernel,
> whcih is not pfcp.  What if somebody else at some point wanted to
> introduce some actual PFCP support in some form?  How should they call
> their sub-systems / Kconfigs / etc?  They could no longer call it simply
> "pfcp" as you already used this very generic term for (from the
> perspective of PFCP) a specific niche use case of configuring a NIC to
> handle all of PFCP.

What about changing the name and the description to better reflect what
this new device is for? I don't have any idea for good fitting name.

> 
> > Do you have better idea for that?
> 
> I am not familiar with the use cases and the intel NICs and what kind of
> tooling or third party software might be out there wanting to configure
> it.  It's really not my domain of expertise and as such I have no
> specific proposal, sorry.
> 
> It just seems mind-boggling to me that we would introduce
> * a net-device for sometthing that's not a net-device
> * a tunnel for something that does no tunneling whatsoeer
> * code mentioning "PFCP encapsulated traffic" when in fact it is
>   impossible to encapsulate any traffic in PFCP, and the code does
>   not - to the best of my understanding - do any such encapsulation
>   or even configure hardware to perform any such non-existant PFCP
>   encapsulation
> 
> [and possibly more] *just* so that a user can use 'tc' to configure a
> hardware offloading feature in their NIC.
> 
> IMHO, there must be a better way.

Yeah, let's say we didn't find the better way. I agree with you that it
isn't the best solution. The problem is that we couldn't have found the
better.

In short, if I remember correctly (because we sent first RFC more than
one year ago), to be sure that the packet is PFCP and has PFCP specific
fields to match, the UDP port needs to be checked. Currently any matching
for UDP port in flower kernel code is to match tunnel. Because of that
we treated it as a tunnel, only for simplification of this matching.

Why we need specific net-device is because of this simplification. All
tunnels have their net-devices, so in tc code the decision if specific
fields from the protocol can be matched is done based on net-device
type. If PFCP will have specific ip proto (as example) ther won't be any
problem, but as specific is only UDP port we end up in this messy
solution.

> 
> > > I also see the following in the patch:
> > > 
> > > > +MODULE_DESCRIPTION("Interface driver for PFCP encapsulated traffic");
> > > 
> > > PFCP is not an encapsulation protocol for user plane traffic.  It is not
> > > a tunneling protocol.  GTP-U is the tunneling protocol, whose
> > > implementations (typically UPFs) are remote-controlled by PFCP.
> > > 
> > 
> > Agree, it is done like that to simplify implementation and reuse kernel
> > software stack.
> 
> My comment was about the module description.  It claims something that
> makes no sense and that it does not actually implement.  Unless I'm not
> understanding what the code does, it is outright wrong and misleading.
> 
> Likewise is the comment on top of the drivers/net/pfcp.c file says:
> 
> > * PFCP according to 3GPP TS 29.244
> 
> While the code is in fact *not* implementing any part of TS 29.244.  The
> code is using the udp_tunnel infrastructure for something that's not a
> tunnel.  From what i can tell it is creating an in-kernel UDP socket
> (whcih can be done without any relation to udp_tunnel) and it is
> configuring hardware offload features in a NIC.  The fact that the
> payload of those UDP packets may be PFCP is circumstancial - nothing in
> the code actually implements even the tiniest bit of PFCP protocol
> parsing.
> 

Like I said it is only for tc to allow matching on the PFCP specific
fields.

> > This is the way to allow user to steer PFCP packet based on specific
> > opts (type and seid) using tc flower. If you have better solution for
> > that I will probably agree with you and will be willing to help you
> > with better implementation.
> 
> sadly, neither tc nor intel NIC hardware offload capabilities are my
> domain of expertise, so I am unable to propose detials of a better
> solution.
> 
> > I assume the biggest problem here is with treating PFCP as a tunnel
> > (done for simplification and reuse) and lack of any functionality of
> > PFCP device
> 
> I don't think the kernel should introduce a net-device (here
> specifically a tunnel device) for something that is not a tunnel.  This
> device [nor the hardware accelerator it controls] will never encapsulate
> or decapsulate any PFCP packet, as PFCP is not a tunnel / encapsulation
> protocol.
> 

Good point, I hope to treate PFCP as only one exception and even remove
it when we have better solution for allowing tc to match PFCP packets.

> > (moving the PFCP specification implementation into kernel
> > probably isn't good idea and may never be accepted).
> 
> I would agree, but that is a completely separate discussion.  Even if
> one ignores this, the hypothetical kernel PFCP implementation would not
> be a tunnel, and not be a net-device at all.  It would simply be some
> kind of in-kernel UDP socket parsing and responding to packets, similar
> to the in-kernel nfs daemon or whatever other in-kernel UDP users exist.
> 
> Also: The fact that you or we think an actual PFCP implementation would
> not be accepted in the kernel should *not* be an argument in favor of
> accepting something else into the kernel, call it PFCP and create tunnel
> devices for things that are not tunnels :)
> 
> > Offloading doesn't sound like problematic. If there is a user that want
> > to use that (to offload for better performance, or even to steer between
> > VFs based on PFCP specific parts) why not allow to do that?
> 
> The papers I read convinced me that there is a use case.  I very much
> believe the use case is a work-around for a different problem (the
> inefficiency of the control->data plance protocol in this case), but
> my opinion on that doesn't matter here.  I do agree with you that there
> are apparently people who would want to make use of such a feature, and
> that there is nothing wrong with provoding them means to do this.
> 
> However, the *how* is what I strongly object to.  Once again, I may miss
> some part of your architecture, and I am happy to be proven otherwise.
> 

It will be hard. As you said it is done "just to configure hardware
offloading". Can't it be an argument here?

> But if all of this is *just* to configure hardware offloading in a nic,
> I don't think there should be net-devices or tunnels that never
> encap/decap a single packet or for protocols / use cases that clearly do
> not encap or decap packets.
> 
> I also think this sets very bad precedent.  What about other prootocols
> in the future?  Will we see new tunnels in the kernel for things that
> are not tunnels at all, every time there is some new protocol that gains
> hardware offloading capability in some NIC? Surely this kind of
> proliferation is not the kind of software architecture we want to have?
> 
> Once again, I do apologize for raising my concerns at such a late stage.
> I am not a kernel developer anymore these days, and I do not follow any
> of the related mailing lists.  It was pure coincidence that the net-next
> merge of some GTP improvements I was involved in specifying also
> contained the PFCP code and I started digging what this was all about.
> 

No problem, sorry for no CCing you during all this revision of this
changes.

Probably I can't convince you. We agree that the solution with
additional netdev and treating PFCP as a tunnel is ugly solution. It is
done only to allow tc flower matching (in hardware with fallback to
software). Currently I don't have any idea for more suitable solution.

I willing to work on better idea if anybody have any.

> Regards,
> 	Harald
> 

Thanks,
Michal

> -- 
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)

