Return-Path: <netdev+bounces-118078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B295073F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5E1C22933
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA719D07A;
	Tue, 13 Aug 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYDv3oDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF819D078
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558337; cv=none; b=h/hrTMQYpcgEDWijdZMY5ZD8SxT3mjzlx8vjK47kz8kJzhzqqv09sfhfkzXVEY+kOB2GkxwRYbbcDDVonsaUVBhASsEyKif5fCRCWZOqbT6uJ1nBNOhf+RErC8vdaJ5FiPNDSqRCNqrT4G0BVvlEacLALSV3l0k9WuO5evZ5zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558337; c=relaxed/simple;
	bh=Ge9cfIaF/ah5rnosOu8KP/Yh9bhPhAOwhBXK5mJHTj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkerOoFv40KZuqg4jnw+JDytLOc3LQFki7HTHMciyx7w7ru2CkHxJWghOMYhr5CE5Kv1H1y2hwEpxOSdTrUMkP7p2V4mIDCgJd5cV8rE+84LK3ILYh7MxruJCSY9m80kZZOXsxCYcXEhU/8595QKAqRorPVK7Fy7ojVJljEExCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYDv3oDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235EAC4AF09;
	Tue, 13 Aug 2024 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558336;
	bh=Ge9cfIaF/ah5rnosOu8KP/Yh9bhPhAOwhBXK5mJHTj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EYDv3oDUyvrHc2onbAUdrq5hPgI0A6ANTlZYg9jsadZx+F5sBLdXf1ZdQcdQkD/I6
	 j8wM6aXgIqgeRgZtGFPmtsMfyIqWbfh+P4iMUzRKebdhd+YqhPLVskMiXdWEOPSz43
	 eeovCEm/trfgNNsX1pJFJ0DtX9/zuy8FFUDl4WF6aQpQo6aep+w36szsiwoY9d+dhr
	 +VKK/iqFLQO44yBB8OM5fBoyiqYzxWCvZKf+ZtcXTm5EaiUolrDh/z/c76AodSFvq0
	 yVzgBifMsIbgWP2xSGtqo3WCm4F4nsybXhIShdh/Ir5mtKOR+Tnrrb2sDO1qL4umiN
	 Es4fdB3yRvT+g==
Date: Tue, 13 Aug 2024 07:12:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240813071214.5724e81b@kernel.org>
In-Reply-To: <ZrrxZnsTRw2WPEsU@nanopsycho.orion>
References: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
	<20240812082544.277b594d@kernel.org>
	<Zro9PhW7SmveJ2mv@nanopsycho.orion>
	<20240812104221.22bc0cca@kernel.org>
	<ZrrxZnsTRw2WPEsU@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 07:38:46 +0200 Jiri Pirko wrote:
> >Parent / child is completely confusing. Let's not.
> >
> >User will classify traffic based on 'leaf' attributes.
> >Therefore in my mind traffic enters the tree at the "leaves", 
> >and travels towards the root (whether or not that's how HW 
> >evaluates the hierarchy).
> >
> >This is opposite to how trees as an data structure are normally
> >traversed. Hence I find the tree analogy to be imperfect.  
> 
> Normally?

Yes, normally, in sort and/or lookup algorithms the owner of the tree
has a pointer to root, and walks from root.

> Tree as a datastructure could be traversed freely, why it
> can't?

I didn't say it can't.

> In this case, it is traversed from leaf to root. It's still a
> tree. Why the tree analogy is imperfect. From what I see, it fits 100%.
> 
> >But yes, root and leaf are definitely better than parent / child.  
> 
> Node has 0-n children and 0-1 parents. In case it has 0 children, it's a
> leaf, in case it has 0 parents, it's a root.
> This is the common tree terminology, isn't it?

You're using tree terminology and then you're asking if it's the tree
terminology. What are you trying to prove?

To me using input / output is more intuitive, as it matches direction
of traffic flow. I'm fine with root / leaf tho, as I said.

> >> subtree_set() ?  
> >
> >The operation is grouping inputs and creating a scheduler node.  
> 
> Creating a node inside a tree, isn't it? Therefore subtree.

All nodes are inside the tree.

> But it could be unified to node_set() as Paolo suggested. That would
> work for any node, including leaf, tree, non-existent internal node.

A "set" operation which creates a node. 

