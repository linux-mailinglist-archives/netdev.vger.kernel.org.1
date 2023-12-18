Return-Path: <netdev+bounces-58670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A9817CA5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 22:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F61C22C2E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC0740A2;
	Mon, 18 Dec 2023 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKI38e3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842473465
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 21:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9286DC433C8;
	Mon, 18 Dec 2023 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702935201;
	bh=viIrjkpxCQsWojqf+L/giT1tkiNy8AuoGtrntUG6hfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nKI38e3bD9+jAuj404JQ1Kd2UFhbcWPDT27UaKAnp5mh4upUrTjxeWexHSc0CbdPT
	 0fms9NDXUWfdhoA14cwf1KuGZ+XKzBW1+UG2VzNVuMykx/VX17eWzFl7mAEzcPB7fb
	 vtH180qrvwZXamE4pn31h0ZigRpW4BFxwjp8nZEIdv78TY9d32R44eW+6ZzS/+gOLu
	 XW4w02hGawA6jqORtEZHJeGAnDxV8wymqVMOvqUQ7qXkWVQGjTeTP+DhWsif3zOQgS
	 xz9t8dj83wSQGi8sdHLSgKb4Fv/GyJZy80WnS9a/iJoCOYC2xutsvLda20JCYf4SlB
	 rkeSVXvxvX8nw==
Date: Mon, 18 Dec 2023 13:33:19 -0800
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
Message-ID: <20231218133319.3eef8931@kernel.org>
In-Reply-To: <baa4bd4b3aa0639d29e5c396bd3da94e01cd8528.camel@redhat.com>
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
	<20231215144155.194a188e@kernel.org>
	<baa4bd4b3aa0639d29e5c396bd3da94e01cd8528.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 21:12:35 +0100 Paolo Abeni wrote:
> On Fri, 2023-12-15 at 14:41 -0800, Jakub Kicinski wrote:
> > I explained before (perhaps on the netdev call) - Qdiscs have two
> > different offload models. "local" and "switchdev", here we want "local"
> > AFAIU and TBF only has "switchdev" offload (take a look at the enqueue
> > method and which drivers support it today).  
> 
> I must admit the above is not yet clear to me.
> 
> I initially thought you meant that "local" offloads properly
> reconfigure the S/W datapath so that locally generated traffic would go
> through the expected processing (e.g. shaping) just once, while with
> "switchdev" offload locally generated traffic will see shaping done
> both by the S/W and the H/W[1].
> 
> Reading the above I now think you mean that local offloads has only
> effect for locally generated traffic but not on traffic forwarded via
> eswitch, and vice versa[2]. 
> 
> The drivers I looked at did not show any clue (to me).
> 
> FTR, I think that [1] is a bug worth fixing and [2] is evil ;)
> 
> Could you please clarify which is the difference exactly between them?

The practical difference which you can see in the code is that
"locally offloaded" qdiscs will act like a FIFO in the SW path (at least
to some extent). While "switchdev" offload qdiscs act exactly the same
regardless of the offload.

Neither is wrong, they are offloading different things. Qdisc offload
on a representor (switchdev) offloads from the switch perspective, i.e.
"ingress to host". Only fallback goes thru SW path, and should be
negligible.

"Local" offload can be implemented as admission control (and is
sometimes work conserving), it's on the "real" interface, it's egress,
and doesn't take part in forwarding.

> > I question whether something as basic as scheduling and ACLs should
> > follow the "offload SW constructs" mantra. You are exposed to more
> > diverse users so please don't hesitate to disagree, but AFAICT
> > the transparent offload (user installs SW constructs and if offload
> > is available - offload, otherwise use SW is good enough) has not
> > played out like we have hoped.
> > 
> > Let's figure out what is the abstract model of scheduling / shaping
> > within a NIC that we want to target. And then come up with a way of
> > representing it in SW. Not which uAPI we can shoehorn into the use
> > case.  
> 
> I thought the model was quite well defined since the initial submission
> from Intel, and is quite simple: expose TX shaping on per tx queue
> basis, with min rate, max rate (in bps) and burst (in bytes).

For some definition of a model, I guess. Given the confusion about
switchdev vs local (ingress vs egress) - I can't agree that the model
is well defined :(

What I mean is - given piece of functionality like "Tx queue shaping"
you can come up with a reasonable uAPI that you can hijack and it makes
sense to you. But someone else (switchdev ingress) can chose the same
API to implement a different offload. Not to mention that yet another
person will chose a different API to implement the same things as you :(

Off the top of my head we have at least:

 - Tx DMA admission control / scheduling (which Tx DMA queue will NIC 
   pull from)
 - Rx DMA scheduling (which Rx queue will NIC push to)

 - buffer/queue configuration (how to deal with buildup of packets in
   NIC SRAM, usually mostly for ingress)
 - NIC buffer configuration (how the SRAM is allocated to queues)

 - policers in the NIC forwarding logic


Let's extend this list so that it covers all reasonable NIC designs,
and them work on mapping how each of them is configured?

> I think that making it more complex (e.g. with nesting, pkt overhead,
> etc) we will still not cover every possible use case and will add
> considerable complexity.

