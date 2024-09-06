Return-Path: <netdev+bounces-125750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1196E6E5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AD4B23A27
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3CDDC3;
	Fri,  6 Sep 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSFgat6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647551401B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583139; cv=none; b=bBC/xzrIH7w8zRyvypbXO38cPPHx3e4JbvsIvxYn4MNP/SSZOF+kUx8WUZ+VkY63R8UWJTwJP0az/85UOUPNREzTkGYpgHoa+10Vumzhmv3C4nodf5E2gzs3daZ17Fv60e9vnHYmYvKnOUIeO4RW8BywHVep+mQ9uqA0i/GNCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583139; c=relaxed/simple;
	bh=BH+49kMVLlx3IWeDXgymiFy41FRYwFsqSDTA91+J6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaYRLoKogtBqbQAafEhLxJ4Ls8SAbU6BLYFAkuUCQSar3Yt2bA2CEWGftRwnYFd6wibfjxijV7TtXceEXEzdELCI1TY/W/b9ucKKYLR+/Ta49RT5xUQH0M7r6Z3vbXuufPP6LHAFoq/8LG5fVYvYxGt9kCz+zf68uy+zSk+Jnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSFgat6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7BAC4CEC5;
	Fri,  6 Sep 2024 00:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725583138;
	bh=BH+49kMVLlx3IWeDXgymiFy41FRYwFsqSDTA91+J6GQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSFgat6kKmFqfFTVXg82SnYYPBxVM7Hs1Rt+FMIrZOF0KnDWvtlkCrjQb+OkykltZ
	 XWh70txb/KkK8Cn4+/YvJmphR5ClhTb67UGjd56miR0+WB/74+N1JJ9Uldd55lY8r/
	 uVUjek7N3bzc7cQDhzZVrISKnEG0EF9DZjFwAYW6eiUIyp8UyfPEf/XRDIqFLglRcR
	 uSqUi3Z3YkMRU7oAt2oczMis68VHXyYK8IjVLRLG+Y9mNMt9IMPUv8RBQRz9cn+T8q
	 g72eEAn+tpYWWu0o2NIajGvervfJkJs4e+kQkg5NN/xO3htDss0IQDqx/uIHfypugk
	 FQhrtOsxe6A5Q==
Date: Thu, 5 Sep 2024 17:38:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 02/15] netlink: spec: add shaper YAML spec
Message-ID: <20240905173857.588f2578@kernel.org>
In-Reply-To: <46484afd-7b50-465d-b763-0ac60201bd3d@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<a0585e78f2da45b79e2220c98e4e478a5640798b.1725457317.git.pabeni@redhat.com>
	<20240904180330.522b07c5@kernel.org>
	<d4a8d497-7ec8-4e8b-835e-65cc8b8066b6@redhat.com>
	<20240905080502.3246e040@kernel.org>
	<46484afd-7b50-465d-b763-0ac60201bd3d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 18:17:42 +0200 Paolo Abeni wrote:
> > I don't see example uses in the cover letter or the test so there's
> > a good chance I'm missing something, but... why node_parent?
> > The only thing you need to know about the parent is its handle,
> > so just "parent", right?
> > 
> > Also why node_handle? Just "handle", and other attrs of the node can
> > live in the main scope.  
> 
> I added the 'node_' prefix in the list to stress that such attributes 
> belong to the node.
> 
> In the yaml/command line will be only 'handle', 'parent'.

And the scope inside parent is 'handle', not subset of 'net-shaper'?
Just to be 100% sure :)

> > Unless you have a strong reason to do this to simplify the code -
> > "from netlink perspective" it looks like unnecessary nesting.
> > The operation arguments describe the node, there's no need to nest
> > things in another layer.  
> 
> Ok, the code complexity should not change much. Side question: currently 
> the node() operation allows specifying all the b/w related attributes 
> for the 'node' shaper, should I keep them? (and move them in the main 
> yaml scope)

Up to you, I was surprised they were there (I expected @group to
be solely about creation of the RR node, and rate limit would have
to be set via a separate @set). But I don't expect providing rate 
limit params in @group to be problematic and user space may find it
convenient. So I'm neutral.

And yes, they should sit directly at the message level, not in any
nest.

