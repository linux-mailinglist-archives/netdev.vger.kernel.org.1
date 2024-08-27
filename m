Return-Path: <netdev+bounces-122098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D095FE84
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E151D1C2121C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFBF747F;
	Tue, 27 Aug 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTNVYc9F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C279DDA8
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723457; cv=none; b=KPZf2/ZlmtQdzpDNQKU6HK07s0zV290T0zCr571pZQz5l+5f3/5fWAfK6inkWbeNKNxrzO/hy5RL+9pmsAPTqmXl6RY+OW8wWd2pJ4J1/vUeMXQK15hzm2N10YozNRtwcMpvz3ocLqg8sB96Z7wXQJ++VfvfkMVGUGFiTXMHeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723457; c=relaxed/simple;
	bh=3ay/yaeZf6IELKSmK+lqIhq5FgfvIFCO5XuuaCGwH1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlzPyIaYVULQXn/UJcHSxquUmi9WpF5wAsN7OToQUv7ZMUfyvT/xREKA30WBi1huTgDSxihhqQB42ek4xGnn6f9Chpa2PL/GKbN6kZQO0WamFmz6/nzCjF3/lXTWEiLlfxzzaIRCOiTmIj1ZJxkvMiU6HPTXPAG4xBfX96BBCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTNVYc9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1949C4DE0B;
	Tue, 27 Aug 2024 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724723457;
	bh=3ay/yaeZf6IELKSmK+lqIhq5FgfvIFCO5XuuaCGwH1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTNVYc9FxzZCc6CoFqsIIl7upvwxU8D4ALqdt7YOMNfA77kPh/iTKhzs+nAKFGobi
	 bGq2Omzi32YzBUwchDrj4A3+BHY6+TWBSgjsBqTHmwEuLgnOrRsTV9cXOzkxHapaWC
	 HcOZ38Mqs2qVXnXCgG5IlAcOwFWT/+F8kNFEC3PclGQb6Xyzj9CbplLw8C1hAy896o
	 eEje7rAdS9K6/ZXjplz7qcjIgtSjwWIPx5N23Vuu+HesKjdWyCsVR3ClE0kdqNa/x5
	 vTlwhK7Hd60ZByDj324jaTlZZYqlDbdrnbggUbKGFGdDJLHeOH8XnsldkBTZSOc4Z9
	 G0ghC4un8qQLw==
Date: Mon, 26 Aug 2024 18:50:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240826185055.38e1857f@kernel.org>
In-Reply-To: <ad5be943-2aa6-4f60-be90-929f889e6057@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
	<20240822184824.3f0c5a28@kernel.org>
	<ad5be943-2aa6-4f60-be90-929f889e6057@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 10:35:05 +0200 Paolo Abeni wrote:

> > deleted -> deleted / reset
> >   
> >> +  The user can query the running configuration via the @get operation.  
> > 
> > The distinction between "scoped" nodes which can be "set"
> > and "detached" "node"s which can only be created via "group" (AFAIU)
> > needs clearer explanation.  
> 
> How about re-phrasing the previous paragraph as:
> 
>    Each @shaper is identified within the given device, by an @handle,
>    comprising both a @scope and an @id.
> 
>    Depending on the @scope value, the shapers are attached to specific
>    HW objects (queues, devices) or, for @node scope, represent a
>    scheduling group that can be placed in an arbitrary location of
>    the scheduling tree.

s/that can be placed in an arbitrary location of/which is an inner node/

So:

    Depending on the @scope value, the shapers are attached to specific
    HW objects (queues, devices) or, for @node scope, represent a
    scheduling group which is an inner node the scheduling tree with 
    multiple inputs.

>    Shapers can be created with two different operations: the @set
>    operation, to create and update single "attached" shaper, and
>    the @group operation, to create and update a scheduling
>    group. Only the @group operation can create @node scope shapers.

> >> +    render-max: true
> >> +    entries:
> >> +      - name: unspec
> >> +        doc: The scope is not specified.
> >> +      -
> >> +        name: netdev
> >> +        doc: The main shaper for the given network device.
> >> +      -
> >> +        name: queue
> >> +        doc: The shaper is attached to the given device queue.
> >> +      -
> >> +        name: node
> >> +        doc: |
> >> +             The shaper allows grouping of queues or others
> >> +             node shapers, is not attached to any user-visible  
> > 
> > Saying it's not attached is confusing. Makes it sound like it exists
> > outside of the scope of a struct net_device.  
> 
> What about:
> 
>    Can be placed in any arbitrary location of
>    the scheduling tree, except leaves and root.

Oh, I was thinking along the same lines above.
Whether "except leaves or root" or "inner node" is clearer is up to you.

> >> +      -
> >> +        name: weight
> >> +        type: u32
> >> +        doc: |
> >> +          Weighted round robin weight for given shaper.  
> > 
> > Relative weight of the input into a round robin node.  
> 
> I would avoid mentioning 'input' unless we rolls back to the previous 
> naming scheme.

Okay, how about:

	Relative weight used by a parent round robin node.

> >> +           Differently from @leaves and @shaper allow specifying
> >> +           the shaper parent handle, too.  
> > 
> > Maybe this attr is better called "node", after all.  
> 
> Fine by me, but would that cause some confusion with the alias scope 
> value?

But to be clear, the "root" describes the node we're creating, right?
Alternatively maybe we should remove the level of nesting and let 
the attributes live at the command level?

