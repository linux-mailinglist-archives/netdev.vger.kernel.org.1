Return-Path: <netdev+bounces-57629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71576813A8E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31A51C20ED4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C717692A4;
	Thu, 14 Dec 2023 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oefJu8x0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F76692A0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA2DC433C7;
	Thu, 14 Dec 2023 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702581423;
	bh=ujFf03ATnpjvcwr0gwnAClynzbpEdP8qyPsk+Dn7Iws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oefJu8x05/HT6ScLbIsfO0OwVzcEwg60Hv/t/TWrLPQbF9IDLFyOt+xbccnZv+Vzb
	 Vl92aouERm/SrAX6HdEYF09t7SZr2JwDQOW2V5yoK9JNXRB/F3ZFJt4tjVVLBQODR7
	 u6luejyHfsNVa6wZlecElLytmuiFeIl/drlCx99PV9rO93dhVTE7Mv+g5qA/iEU41+
	 aAwLYU8gF2G4AgF7AeU5AFFcnlq4LiO8k7e5gKe9zU93/5KI/XctLBGzZ6DgWKkRFN
	 CLwiyV3viWI6euxtaHnT2ogEP9YkNsdK4wHwlHh2milm7yCzUCRoypWnnUUxAAgLGg
	 DTiahN6uWFkxg==
Date: Thu, 14 Dec 2023 11:17:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 0/3] add YAML spec for team
Message-ID: <20231214111701.51668f06@kernel.org>
In-Reply-To: <ZXqBSyBt7xiv7YyA@Laptop-X1>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
	<20231213083642.1872702f@kernel.org>
	<ZXqBSyBt7xiv7YyA@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 12:15:07 +0800 Hangbin Liu wrote:
> > > 3. Do we have to hard code the string max-len? Is there a way to use
> > >    the name in definitions? e.g.
> > >    name: name
> > >    type: string
> > >    checks:
> > >      max-len: string-max-len  
> > 
> > Yes, that's the intention, if codegen doesn't support that today it
> > should be improved.  
> 
> I can try improve this. But may a little late (should go next year).
> If you have time you can improve this directly.

Noted on my todo list but no ETA, let's see who gets to it first.. :)

> > > 4. The doc will be generate to rst file in future, so there will not have
> > >    other comments in the _nl.c or _nl.h files, right?  
> > 
> > It already generates ReST:
> > https://docs.kernel.org/next/networking/netlink_spec/
> > We do still generate kdoc in the uAPI header, tho.  
> 
> How to generate the doc in uAPI header?

The doc strings for enum types should appear in uAPI.
Other docs in uAPI usually describe nesting.. which the YAML spec
makes a bit obsolete / possible to generate automatically.
If there's more that we need we can extend the codegen..

