Return-Path: <netdev+bounces-160064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D14A1801E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C077A4BE1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD41F3FD1;
	Tue, 21 Jan 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGIn3Ng9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904761F1508;
	Tue, 21 Jan 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470375; cv=none; b=BGlkdOLyCZF/auQf7xUyuu2J5ggV3fvC/0RewYNqjd/yWi3bn1fmLYIoNTHCfQlSLUPcGsCCqns4UiWWq6j2rxpEuse3HgGaDXw2u2QoVWIkqfUAg0OUhPC0A6YzrloQuYHqYDe/becZ8RLAg2op7NbdY31TDEMhF6otE1JlTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470375; c=relaxed/simple;
	bh=4TEa7Lov74WvDD9VbiPQrlS9Dg8723r7IvA82a28054=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZlZ6DUN9ZwchugrlshOMcZqOOvXpCaO9zeyvBfPzDcNWj6PUlH3OUaQefGHwAybZAftLqFdZWtd8WPw1gpQGNbLV9Pkm9JsC1QILmVkqIMnNI647gL5I/ZKo4TkFyMAFdMFP+iLZj+bZsNVZMlE4BVPcDiIR2axUVLXb1foxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGIn3Ng9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737470374; x=1769006374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4TEa7Lov74WvDD9VbiPQrlS9Dg8723r7IvA82a28054=;
  b=nGIn3Ng9viFqQqEolX4VOJHLhhnqdSfTesd2ywkGpWqA3tz6YzPEEt3E
   uQZjyi3RiG6T2ArlUqdlwD3oVT4Kkd34e2uhcYQ7uLyz3K+hPHBt8H6b6
   U3YmxMUS7tBm3Vt5YTKbNvZ4PGyYaosKSWdAbazpD7t+QigkHAfl/jF1T
   KhH8pkGlBcGf/0pYeQ6fB1Bb7lMA08P5dNmdGx4FGbDLTmeoWJsMwysFO
   oIhLLevenLfSI9kKUsrhR8PbXQsWTpNU0GsrSH9XpeVaTmXiwULuXgAQZ
   nRk0yj8uaRYq7+g0Qf7s+bC8iw1fzhMiuRGreZZD7R3CsErchj+MzpIO7
   Q==;
X-CSE-ConnectionGUID: +80xK/itQa+cldqqVz/Vag==
X-CSE-MsgGUID: wnf6R6AQTlCOxZWnjtOocQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48878320"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="48878320"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 06:39:33 -0800
X-CSE-ConnectionGUID: g4gx3czdQDWba+a06Y3bDA==
X-CSE-MsgGUID: aO3yH/gcQAu+RD0sSwprCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111445223"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 06:39:30 -0800
Date: Tue, 21 Jan 2025 15:36:04 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Message-ID: <Z4+w1O/tS7nw0jlS@mev-dev.igk.intel.com>
References: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
 <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>
 <bb9cf9af-2f17-4af6-9d1c-3981cc8468c0@lunn.ch>
 <5d5cc80b20e878d01c3d7d739f0fc7e429a840ed.camel@alliedtelesis.co.nz>
 <17952bc5-31eb-452c-8fec-957260e9afd1@lunn.ch>
 <f8e90a949d08d3aba01a77f761efa41b44924345.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e90a949d08d3aba01a77f761efa41b44924345.camel@alliedtelesis.co.nz>

On Mon, Jan 20, 2025 at 09:36:57PM +0000, Aryan Srivastava wrote:
> On Mon, 2025-01-20 at 04:12 +0100, Andrew Lunn wrote:
> > > > This is not a very convincing description. What is your real use
> > > > case
> > > > for not offloading?
> > > > 
> > > The real use case for us is packet inspection. Due to the bridge
> > > ports
> > > being offloaded in hardware, we can no longer inspect the traffic
> > > on
> > > them, as the packets never hit the CPU.
> > 
> > So are you using libpcap to bring them into user space? Or are you
> > using eBPF?
> > 
> > What i'm thinking about is, should this actually be a devlink option,
> > or should it happen on its own because you have attached something
> > which cannot be offloaded to the hardware, so hardware offload should
> > be disabled by the kernel?
> Yes, so we use various in-kernel (eBPF) and some out of tree methods
> (netmap). To service both, I thought that a devlink config would be
> best.
> 
> Also aside from specific kernel feature use-cases the actual port we
> are trying to service is meant to be a dedicated NIC, whose
> implementation detail is that it is on a switch chip. By offloading
> aspects of its config, we end up with inconsistent behaviour across NIC
> ports on our devices. As the port is not meant to behave like a
> switchport, the fact it happens to be on the end of a switch should not
> force it to HW offload bridging. The HW bridging results in CPU bypass,
> where as SW bridging will be a more desirable method of bridging for
> this port. Therefore it is desirable to have a method to configure
> certain ports for SW bridging only, rather than the driver
> automatically choosing to do HW offload if capable.
> > 
> > > > net-next is closed for the merge window.
> > 
> > > I was unsure about uploading this right now (as you said net-next
> > > is
> > > closed), but the netdev docs page states that RFC patches are
> > > welcome
> > > anytime, please let me know if this is not case, and if so I
> > > apologize
> > > for my erroneous submission.
> > 
> > It would be good to say what you are requesting comments about.
> > 
> Ah yes, I understand. I will add the request in the cover letter next
> time, but essentially I just wanted comments about the best way to go
> about this. Specifically if there was already a method in kernel to
> prevent HW offload of certain features or if there are alternative
> methods to devlink to add specific switch config options on a per port
> basis.

For debug purpouse I am turning off HW bridge offload by setting aging to 0.
Don't know if it is appropriate in your case.

Thanks
Michal

> 
> 	Aryan
> 
> 
> 

