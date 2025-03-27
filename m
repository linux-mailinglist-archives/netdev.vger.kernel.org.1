Return-Path: <netdev+bounces-178022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E95A74069
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C2170B5F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060A1CDA14;
	Thu, 27 Mar 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTRRCF18"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CF1991B8
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111972; cv=none; b=S250wAlrQbsQzTHb3BAMz0hnwNaD40u9Ct1nYXUWUJnp/9X+kON8l83cLXukBLJ81u/AUIiYB9aV1oL+43FPs4ORVGk6xS9j00wFJBWoyrCZOZW5RS74GraEzOWkV/61+EMy44o6x/n+kAEzMx+kvEMrqOqZBHZnJG3CjW8r8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111972; c=relaxed/simple;
	bh=0YvyZUkM6L2rI7PqlYuf9uqCN050hVAskshNSWAO1F0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGYEtCl3vnJj+mTqtu4pUHbW5dt5Am42BnVb0gu4VixHduhagNDL4AtLOus12Xg/VrcMZbr4nshM8hQsXQVHYo7MHyWpCemGOC3g0JwLkHRBUZHjB93pzKWg1GqBrTVK7clEm2mvHDY+PeBA6YaulpAKynNQ3SzXgqVCATg0VIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTRRCF18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291ECC4CEDD;
	Thu, 27 Mar 2025 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111970;
	bh=0YvyZUkM6L2rI7PqlYuf9uqCN050hVAskshNSWAO1F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTRRCF18TTJY7KeagVzjUe0fvxLdQNEQ+77H2l1Y2DXK5Ey5OdQlyahh4Wu8QYlNh
	 CEGkjWAw3PFSKy9kPfiPwC8OR+YIYUCZ5DLU/csI5vKwLx8CCAy0vD1C3Wj1l10dEO
	 f9VL9Fk2sVJ6GOvBypjwqkaCdKYd6gWnC0eIkVme/8sWQQjCTLa0/6Ru2MqUuLoOmU
	 XSihYWHG+EiyiteCsHn/8CGvMoUIY/d1PYLIVqa9EPaiAsw1Sdnb8WrjTUf2BUb1+f
	 0XgMwfsIRkQZPh044Iu3xmJjQ8aQG7xB6SB+KnAbHRCcUo47YLxDW5SMPARGacdM6K
	 xjGG3bLy6k9lA==
Date: Thu, 27 Mar 2025 14:46:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Message-ID: <20250327144609.647403fa@kernel.org>
In-Reply-To: <Z-W9Rkr07PbY3Qf4@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-7-sdf@fomichev.me>
	<20250327121203.69eb78d0@kernel.org>
	<Z-W9Rkr07PbY3Qf4@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 14:04:06 -0700 Stanislav Fomichev wrote:
> > Can we register empty notifiers in nsim (just to make sure it has 
> > a callback) but do the validation in rtnl_net_debug.c
> > I guess we'd need to transform rtnl_net_debug.c a little,
> > make it less rtnl specific, compile under DEBUG_NET and ifdef
> > out the small rtnl parts?  
> 
> s/rtnl_net_debug.c/notifiers_debug.c/ + DEBUG_NET? Or I can keep the
> name and only do the DEBUG_NET part. 

I was thinking lock or locking as in net/core/lock_debug.c
But yeah, it's locking in notifier locking, maybe
net/core/notifier_lock_debug.c then? No strong feelings.

> Not sure what needs to be ifdef-ed out,
> but will take a look (probably just enough to make it compile with
> !CONFIG_DEBUG_NET_SMALL_RTNL ?).

You're right, looking at the code we need all of it.
Somehow I thought its doing extra netns related stuff but it just
register a notifier in each ns. 
I guess we may not need any ifdef at all.

> That should work for the regular notifiers,
> but I think register_netdevice_notifier_dev_net needs a netdev?

Hm. Yes. Not sure if we need anything extra in the notifier for nsim 
or we just want to make make sure it registers one. If the latter
I guess we could export rtnl_net_debug_event (modulo rename) and
call it from netdevsim? I mean - we would probably have the same
exact asserts in both?

