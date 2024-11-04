Return-Path: <netdev+bounces-141391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD209BAB88
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 04:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E021C20A04
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 03:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AC17ADE1;
	Mon,  4 Nov 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr7oUvqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3C6FC5;
	Mon,  4 Nov 2024 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691785; cv=none; b=FLgY2ECiwuiaOxblwWXE9zky8AvAb2GYPtq8YPR1x+5qKL6zmIyEYgiyf2NYib5NAHNa45t1uCVzfo96E/YsKl1CJoUDp13/jHvStJFn/W1QTOgYLveRWTAV3T21HkfKRj/dw+tsV3EnqAhekV7Gs/I6/Y3XJrVnShhW5UnEy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691785; c=relaxed/simple;
	bh=/7BH8bZDCwVicNSomUye4PFPwYtszdNZKfdTvy6wRr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6awHcDr8WvyiPGHMCnsBrA0lw87wLGx+paRImFq+dJ/cU093Nlrf6ZNDy2i5uKD1gCfKErCuWMqRbimKuQpjgy95SiBvT7qfKXGPCPfvRO3RK+UmeDvz3Khsa3yTa0FKqRkzZv0Iu0PLFqSShYueIGbcrSmfrujX8KPm1QyhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr7oUvqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0DDC4CED1;
	Mon,  4 Nov 2024 03:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730691784;
	bh=/7BH8bZDCwVicNSomUye4PFPwYtszdNZKfdTvy6wRr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lr7oUvqYaTt5upeVK8/1qzKzXchsiKZ59rQ8If6x7PWlSm5Hn6pFj6vkx6nS+ALPA
	 8Wtx2R0MR52HuGgXzAYmcSAa5vC5qun4YmrlOvGjxydUmxrYwe2El+47Q68wCyI/Fc
	 au/+J33ia/o6zpURGOzoVjrvr6stuz4CSevDXuhPN6j++jjy6iQ9qIosLMUyuFo4bx
	 TCp03XlFljBBUAyeMvq/ED6zmZxrjJSdrV9Wyp9/7a/6KhPRvuW7EUjdUE4nwjOjIs
	 +LcC/ugv2k2w3sKnCUPiwPKbwqeZK6Dqj/BAAJcV3Qjj12aoQDpX+EVj7MyY9VNz7X
	 kyjbkRsBcnmPw==
Date: Sun, 3 Nov 2024 19:43:01 -0800
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
Message-ID: <202411031920.BEF6CEBCD@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
 <20241031180145.01e14e38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031180145.01e14e38@kernel.org>

On Thu, Oct 31, 2024 at 06:01:45PM -0700, Jakub Kicinski wrote:
> On Thu, 24 Oct 2024 15:11:24 -0600 Gustavo A. R. Silva wrote:
> > + * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
> > + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
> > + * array in struct sockaddr") due to the fact that "One of the worst offenders
> > + * of "fake flexible arrays" is struct sockaddr". This means that the original
> > + * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
> > + * flexible-array member was introduced.
> 
> This isn't spelled out in the commit messages AFACT so let me ask..
> Why aren't we reverting b5f0de6df6dce, then?
> Feels like the best solution would be to have a separate type with
> the flex array to clearly annotate users who treat it as such.
> Is that not going to work?
> 
> My noob reading of b5f0de6df6dce is that it was a simpler workaround
> for the previous problem, avoided adding a new type (and the conversion
> churn). But now we are adding a type and another workaround on top.
> Sorry if I'm misunderstanding. No question that the struct is a mess,
> but I don't feel like this is helping the messiness...

This is a pretty reasonable position. I think sockaddr turns out to be a
really difficult problem, given its exposure to UAPI. Linux has been
trying to deal with it for a while (e.g. sockaddr_storage), and perhaps
b5f0de6df6dce wasn't the right solution. (It looked correct since it
looks like what we've done in many other tricky places, but perhaps
sockaddr should be dealt with differently yet.)

So, the rationale with b5f0de6df6dce was to change things as minimally
as possible. The goal is to stop lying to the compiler about object
sizes, with the big lie being "this object ends with a 14 byte array".

I think this results in two primary goals:
1- make sockaddr-like objects unambiguously sized
2- do not break userspace

For 2, we cannot change the existing (and externally defined) struct
sockaddr. It will stay the historical horrible thing that it is.

The specific UAPI sockaddr-related things we have that are _fixed_ sizes
are all fine. These can be seen with:
	git grep '^struct sockaddr_' -- include/uapi/

For 1, we cannot use (the externally defined) sockaddr as-is since we
run into size problems. (Basically anything casting from sockaddr,
anything copying out of sockaddr, etc.)

The storage problem for sockaddr has been attempted to be addressed with
the internally defined sockaddr_storage, but this doesn't capture the
"I don't know how big this object is yet" issues associated with taking
a buffer of arbitrary size from userspace that is initially defined
as sockaddr.

If we internally add struct sockaddr_unknown, or _bytes, or _unspec, or
_flex, or _array, or _raw, we can use that everywhere in the kernel, but
it is going to cause a lot of churn. This is why b5f0de6df6dce happened,
and why we went the direction of thinking sockaddr_legacy would be
workable: the kernel's view of sockaddr from userspace (sockaddr_legacy)
would be the only change needed.

Now, if we want to get to a place with the least ambiguity, we need to
abolish sockaddr from the kernel internally, and I think that might take
a while. I only think so because of what I went through just for doing a
portion of NFS in cf0d7e7f4520 ("NFS: Avoid memcpy() run-time warning
for struct sockaddr overflows").

But maybe it won't be as bad all that since we already do a lot of "what
is the family then cast to a fixed-size struct and carry on" stuff. But
the passing things between layers (usually "up" from a family into the
networking core) still depends on using sockaddr, and all of those APIs
would need to switch to sockaddr_unknown both in the core and in all
families. Maybe there is some Coccinelle magic that could be worked.

I think it's worth spending the time to try and figure out the size of
the effort needed to make that change.

-Kees

-- 
Kees Cook

