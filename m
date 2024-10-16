Return-Path: <netdev+bounces-136203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF239A0FFF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBD9B242F6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EC1FDF99;
	Wed, 16 Oct 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7hZj20c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4814F135;
	Wed, 16 Oct 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097113; cv=none; b=n5qhxttU5QOQua4Bu3m/c/1LJELeLiz7CK5d9LFM5NFVwQ8gAZYs3NIZHPxGqbn+cX3UA07INkdYZ4FKCtR4VdiFXsslF5xFDtEEQIPyea3v5sud2xupwit59D0eOMlbQcT4M08hfZmq6Bcq72ExRidK8U77YBmTdztJhrhQy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097113; c=relaxed/simple;
	bh=b7jQbTfdPgYF17RIjC8T8bC2V9vm7YjfPfB5RbvZTww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERb/lKVLiaXGnHH6NZaUyCu3Rcx2rPt4j2d0wQvfUouiMYtMMuFOEwLOJRHbmEwDzn3B3wAZH32XIT67PuRfNBTTGwBCl4ztCEddN6ypiz4lE+OqxfvWwOugY7q2w904fZuKNB99krKLslnRzXuEjywLPjbsUUwMNQgUNOc+71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7hZj20c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7CEC4CEC5;
	Wed, 16 Oct 2024 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729097112;
	bh=b7jQbTfdPgYF17RIjC8T8bC2V9vm7YjfPfB5RbvZTww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7hZj20c0E0ImYQi2QKj2kgbO7VGdePmMpk1MagJqh32pF1vAu8lxdAFnDHRQggQL
	 9KiCfhDyFdEes48BYCsQHr3XHU7aQXDhzpiuBpNJkTL+5Go8gKil/sefU8YcZnR5LH
	 GaRDXFcMXVKsXW/hHDilNPPF2zFPkjFb9CEf7RSrpDlu9kUlSaA7GjFascYlYHKmNa
	 2DtQr7i7OBrMVARoNC+CLgWjkNyg65PfIdIaSptLUzQUJbPn8ZLvBoLNf6nHH+W59w
	 fLT+UKENU6YkgF8iGjDlUlbQFcB1nEK9tISrQ9uMOepFxfqkEoSW2pPTSlLRd/mUs/
	 AD0ywkGqJDtlA==
Date: Wed, 16 Oct 2024 09:45:09 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Johannes Berg <johannes@sipsolutions.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202410160942.000495E@keescook>
References: <cover.1729037131.git.gustavoars@kernel.org>
 <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
 <ac2ea738-09fb-4d03-b91c-d54bcfb893c6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2ea738-09fb-4d03-b91c-d54bcfb893c6@lunn.ch>

On Wed, Oct 16, 2024 at 02:30:02PM +0200, Andrew Lunn wrote:
> On Tue, Oct 15, 2024 at 06:32:43PM -0600, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> > 
> > Address the following warnings by changing the type of the middle struct
> > members in a couple of composite structs, which are currently causing
> > trouble, from `struct sockaddr` to `struct sockaddr_legacy`. Note that
> > the latter struct doesn't contain a flexible-array member.
> > 
> > include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Also, update some related code, accordingly.
> > 
> > No binary differences are present after these changes.
> 
> These are clearly UAPI files. It would be good to state in the commit
> message why this is a safe change, at the source level.

I think we can avoid complicating UAPI by doing something like this in
include/uapi/linux/socket.h:

#ifdef __KERNEL__
#define __kernel_sockaddr_legacy        sockaddr_legacy
#else
#define __kernel_sockaddr_legacy        sockaddr
#endif

And then the UAPI changes can use __kernel_sockaddr_legacy and userspace
will resolve to sockaddr (unchanged), and the kernel internals will
resolve to sockaddr_legacy (fixing the warnings).

-Kees

-- 
Kees Cook

