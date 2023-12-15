Return-Path: <netdev+bounces-58137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F68153DC
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B261C22FEB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F78013B120;
	Fri, 15 Dec 2023 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5uFAXav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434D48781
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 22:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F31C433C8;
	Fri, 15 Dec 2023 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702680116;
	bh=4FhBmd1T2ku6JY6B5uX89pPz+JgeRC0ORaKhXIJ6cNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i5uFAXavASJiGMIy0DpDCLcfBtx3azNgQX6lCjrU5wMlTZc4a6OrxsESVz4hLRWJp
	 r0W4YKbr67vbUL4E6Rd+ITrw1JsrJBvExc806/BBqm6a0VFsBzEV7dBXZUrJrsIifJ
	 bRtASM65TKcr4OjQtVnaW0RX+Ovvn6QBPNjbvjpUVtNgAlLl7WnYoGR/iX32MGppeO
	 bA5C0w3E5fM2MWUdV9qHa+AOkchh3/b+vFw+GuW5/mjpyRoIQ6yrjiSnagKM8/qpyd
	 InE0YosQup6PpLm+mHIqK0KJbmmPpBmiSU3jBmjgK/dfZYp8o2MUSUtYWhpwA72hgO
	 YRbZQfR/LWc2w==
Date: Fri, 15 Dec 2023 14:41:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 qi.z.zhang@intel.com, Wenjun Wu <wenjun1.wu@intel.com>,
 maxtram95@gmail.com, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Simon Horman
 <simon.horman@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <20231215144155.194a188e@kernel.org>
In-Reply-To: <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	<20230822034003.31628-1-wenjun1.wu@intel.com>
	<ZORRzEBcUDEjMniz@nanopsycho>
	<20230822081255.7a36fa4d@kernel.org>
	<ZOTVkXWCLY88YfjV@nanopsycho>
	<0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	<ZOcBEt59zHW9qHhT@nanopsycho>
	<5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	<bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
	<20231118084843.70c344d9@kernel.org>
	<3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
	<20231122192201.245a0797@kernel.org>
	<e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
	<20231127174329.6dffea07@kernel.org>
	<55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
	<20231214174604.1ca4c30d@kernel.org>
	<7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 12:06:52 +0100 Paolo Abeni wrote:
> > uAPI aside, why would we use ndo_setup_tc(TC_SETUP_QDISC_TBF)
> > to implement common basis?
> > 
> > Is it not cleaner to have a separate driver API, with its ops
> > and capabilities?  
> 
> We understand one of the end goal is consolidating the existing rate-
> related in kernel interfaces.  Adding a new one does not feel a good
> starting to reach that goal, see [1] & [2] ;)

ndo_setup_tc(TC_SETUP_QDISC_TBF) is a new API, too, very much so.
These attempts to build on top of existing interfaces with small
tweaks is leading us to a fragmented and incompatible driver landscape.

I explained before (perhaps on the netdev call) - Qdiscs have two
different offload models. "local" and "switchdev", here we want "local"
AFAIU and TBF only has "switchdev" offload (take a look at the enqueue
method and which drivers support it today).

"We'll extend TBF" is very much adding a new API. You'll have to add
"local offload" support in TBF and no NIC driver today supports it.
I'm not saying TBF is bad, but I disagree that it's any different
than a new NDO for all practical purposes.

> ndo_setup_tc() feels like the natural choice for H/W offload and TBF
> is the existing interface IMHO nearest to the requirements here.

I question whether something as basic as scheduling and ACLs should
follow the "offload SW constructs" mantra. You are exposed to more
diverse users so please don't hesitate to disagree, but AFAICT
the transparent offload (user installs SW constructs and if offload
is available - offload, otherwise use SW is good enough) has not
played out like we have hoped.

Let's figure out what is the abstract model of scheduling / shaping
within a NIC that we want to target. And then come up with a way of
representing it in SW. Not which uAPI we can shoehorn into the use
case.

