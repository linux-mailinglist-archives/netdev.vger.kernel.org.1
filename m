Return-Path: <netdev+bounces-125330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7228096CC04
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EF6B21827
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB204A1A;
	Thu,  5 Sep 2024 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyjXFFLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947EC8FE
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498212; cv=none; b=r5iY76BdycL/dR76MePyG6FPYWc/aeD231KdJSe4e9FPbZZDX+Nnm4pVLCLgqTuthTJOQaG3hguI5Fx1i/jhqE8GgNwTkCz081AnZJ1fTiEEAdwcbq6+cjHkqovB4gjFDYzs9xckAqSrLRnK0VUOy+cyEM/BRBI+gldW6FHKAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498212; c=relaxed/simple;
	bh=mBo1M+6e6dT1/Ok93GvGsN3bfzsU8Icz47GwhvHuvU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+DExb+qjfReCbXufW3hw0AqHMq88Y4oOC1F+SfBcjqNmNusqolqYUi3/Brcx9CCgxsZzzMDx0WIdmQJ9+hBxxp7hP9fehxUsXgWW3SiPnxfG+nQDOAklMM05e2fSrvT18WVk1P7lgr0MhahFyBJQTgLnpF5+r25LtsbySiYLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyjXFFLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2D2C4CEC9;
	Thu,  5 Sep 2024 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725498211;
	bh=mBo1M+6e6dT1/Ok93GvGsN3bfzsU8Icz47GwhvHuvU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HyjXFFLcxwLxMxQSpWyDJZuCU3rWXCn6VSOZhWX8fuGmKzor/qw7slbuia/oROApn
	 iOEe2JZ1VM7LJEyKTSyhEVe27jb0nPW/Yyw3vgfmQ8v9qld8Q2W13m2eyEqDdXI8ci
	 32jM68GNUoM74G2DpA0Tnut20KpocyxedHX8alyNwdbuoNIK8UXdvHeIAKHt55IVQp
	 qOuAQoGF2WiC5iIGoSVtPVflDgdKCpP1mKgsyPPxeaVewaeZQ7CzggmcoGvzFZKF5B
	 EQ6Z/6F0bvMCtFb2ylmkKwoO/gv2LfSvcPvpVKyzEKbtiNXOtF9do/WQwpoYNKJVJm
	 oBnUQYXduV89Q==
Date: Wed, 4 Sep 2024 18:03:30 -0700
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
Message-ID: <20240904180330.522b07c5@kernel.org>
In-Reply-To: <a0585e78f2da45b79e2220c98e4e478a5640798b.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<a0585e78f2da45b79e2220c98e4e478a5640798b.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 15:53:34 +0200 Paolo Abeni wrote:
> +doc: |
> +  Networking HW rate limiting configuration.
> +
> +  This API allows configuring HW shapers available on the network
> +  devices at different levels (queues, network device) and allows
> +  arbitrary manipulation of the scheduling tree of the involved
> +  shapers.
> +
> +  Each @shaper is identified within the given device, by an @handle,
> +  comprising both a @scope and an @id.
> +
> +  Depending on the @scope value, the shapers are attached to specific
> +  HW objects (queues, devices) or, for @node scope, represent a
> +  scheduling group, that can be placed in an arbitrary location of
> +  the scheduling tree.
> +
> +  Shapers can be created with two different operations: the @set
> +  operation, to create and update a single "attached" shaper, and
> +  the @group operation, to create and update a scheduling
> +  group. Only the @group operation can create @node scope shapers
> +
> +  Existing shapers can be deleted /reset via the @delete operation.

nit: space before the / ?

> +        name: bw-min
> +        type: uint
> +        doc: Minimum Guaranteed bandwidth for the given shaper.

I think I asked to remove "Minimum"? Both "guaranteed" and "minimum"
express the fact that we can't go lower, so it's a bit of a pleonasm.

> +      -
> +        name: node
> +        type: nest
> +        nested-attributes: node-info
> +        doc: |
> +           Describes the node shaper for a @group operation.
> +           Differently from @leaves and @shaper allow specifying
> +           the shaper parent handle, too.

Parent handle is inside node scope? Why are leaves outside and parent
inside? Both should be at the same scope, preferably main scope.

> +      -
> +        name: shaper
> +        type: nest
> +        nested-attributes: info
> +        doc: |
> +           Describes a single shaper for a @set operation.

Why does this level of nesting exist? With the exception of ifindex 
all attributes for SET are nested inside this..

