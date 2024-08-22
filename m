Return-Path: <netdev+bounces-121135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 454D995BEAA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA571F243FD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6D1CDFD4;
	Thu, 22 Aug 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6C1ZL/I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858B76025
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353942; cv=none; b=m+pObOXA2VDS0F2ZhgTAnj+rxZbcgdQ5ogprOqOiJmKGCgNER/d3rF3nVzKBAAoQt6DsEr0PumbuaBK6rNu+tzZ8tlWnEvcZqM6wE3KPuBTStA1rHKWL7EqLhRmhfNrq9o3USI7j94u8rH/Nsf5bIeSqP+4uFDIF8eGkffKDkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353942; c=relaxed/simple;
	bh=SYFBu3L9wxq3E0TgJjyVaWRYygin63Hxaiw5xe47nqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqURCkLFosJdFauZmJZ2/RQJL2RW71Vnq4SJQMCLZGdle5UNG6v04w2ZkQg2iGDdXIzB6QJlYFWdSwkM2F7l7L6BaornTo+PwxEHTxgzy9UE4mF2mPtBkpPayUAe7HsTq+KpO3PKV+JRm0EYOmHzwAoDtaFVH2G1FhQ36gOJGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6C1ZL/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF76C32782;
	Thu, 22 Aug 2024 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724353942;
	bh=SYFBu3L9wxq3E0TgJjyVaWRYygin63Hxaiw5xe47nqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6C1ZL/I1wzlTeqNSj1Cmw7MVs8AezTj5hL7yut+5+J9ZevxoifnuUfNnbB7cn5KO
	 95yteLwFEd/0MFeRivowQ6VZ9/VKLu0HcNvwuIstVLFs5N/aTXVkFVMzRv0OigY0qX
	 es60wDpaNTzv4crXWSZTjNhvrlaUPsqON+2cO4IAs0wWV6zMFpFD05oEAR+VS6PVuc
	 Vre+zkbM4YfDKQAny2sqRy9YSK+XK/Q7Vy/gbpnKXnkUIuczxvp5YijU3hYIqBiwzc
	 lcYdPjVW6VbA2LUiIqL8qTH0CHFNxfbxvy3TDACZ4bkcfzXjtvBoITFIvW+kl+8hh3
	 CMtU9Om0AVP1g==
Date: Thu, 22 Aug 2024 20:12:17 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>,
	Chas Williams <3chas3@gmail.com>,
	Guo-Fu Tseng <cooldavid@cooldavid.org>,
	Moon Yeounsu <yyyynoom@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] MAINTAINERS: Add limited globs for Networking
 headers
Message-ID: <20240822191217.GR2164@kernel.org>
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
 <20240821-net-mnt-v2-3-59a5af38e69d@kernel.org>
 <5ecac29d-251a-4db8-abf4-e73c4e1eca55@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecac29d-251a-4db8-abf4-e73c4e1eca55@redhat.com>

On Thu, Aug 22, 2024 at 03:37:06PM +0200, Paolo Abeni wrote:
> On 8/21/24 10:46, Simon Horman wrote:
> > This aims to add limited globs to improve the coverage of header files
> > in the NETWORKING DRIVERS and NETWORKING [GENERAL] sections.
> > 
> > It is done so in a minimal way to exclude overlap with other sections.
> > And so as not to require "X" entries to exclude files otherwise
> > matched by these new globs.
> > 
> > While imperfect, due to it's limited nature, this does extend coverage
> > of header files by these sections. And aims to automatically cover
> > new files that seem very likely belong to these sections.
> > 
> > The include/linux/netdev* glob (both sections)
> > + Subsumes the entries for:
> >    - include/linux/netdevice.h
> > + Extends the sections to cover
> >    - include/linux/netdevice_xmit.h
> >    - include/linux/netdev_features.h
> > 
> > The include/uapi/linux/netdev* globs: (both sections)
> > + Subsumes the entries for:
> >    - include/linux/netdevice.h
> > + Extends the sections to cover
> >    - include/linux/netdev.h
> > 
> > The include/linux/skbuff* glob (NETWORKING [GENERAL] section only):
> > + Subsumes the entry for:
> >    - include/linux/skbuff.h
> > + Extends the section to cover
> >    - include/linux/skbuff_ref.h
> > 
> > A include/uapi/linux/net_* glob was not added to the NETWORKING [GENERAL]
> > section. Although it would subsume the entry for
> > include/uapi/linux/net_namespace.h, which is fine, it would also extend
> > coverage to:
> > - include/uapi/linux/net_dropmon.h, which belongs to the
> >     NETWORK DROP MONITOR section
> > - include/uapi/linux/net_tstamp.h which, as per an earlier patch in this
> >    series, belongs to the SOCKET TIMESTAMPING section
> 
> I think both the above files should belong also to the generic networking
> section. If there is agreement, I think can be adjusted with an incremental
> patch, instead of re-spinning the whole series - that I'm applying now.

Thanks.

I'm quite fine with adding a include/uapi/linux/net_* entry as a follow-up.
The reason that I didn't add it is to avoid including files in multiple
sections. But if there is consensus around that being ok then I have no
objections.

