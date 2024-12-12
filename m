Return-Path: <netdev+bounces-151273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7739EDDA3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9044F188369D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569E13C67C;
	Thu, 12 Dec 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1lN/NV/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8096257D;
	Thu, 12 Dec 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970495; cv=none; b=KeD7zFnBJL7vNXG5i7j2yLETzGipzjkqfFZ3G3XhAKqIYt5r1tB9WGm9ndEKxlo+l8DyG2isxEq+xg4lNIFLSrjlXwiPlw68nyc0kZYSMCxXmL+B7oCJEmwh3oq8BMVgmoXnWgo0GjPqGqNiBjXLklz6d6S4CvtsekVvMk2SmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970495; c=relaxed/simple;
	bh=XsiEYnxh+hvzn/XFOkHqruCHasjAtgFcOsO/3Lg/otk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnX6ISpnUqVPrnM5C5S916cKZrRz1YkITRCeZX6T8ARX6b1gHRVtJm/HkYFrpxBtF+Su/fzkJLwi82fzbSLSnSewBofyBxeGvQPy6tlD31ldSdrfC5iZOOk3o34IpHx6NDp2C354RFtcabCi1e2TYdg3ud3u4okP3ANuUgMQIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1lN/NV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD2EC4CED2;
	Thu, 12 Dec 2024 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733970495;
	bh=XsiEYnxh+hvzn/XFOkHqruCHasjAtgFcOsO/3Lg/otk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N1lN/NV/HzLYJ59eTU2CTXKk1IRG0uF9xQPIBL9qPWPt4qbQk3Z+mAHN1HtR/goYO
	 30UGr57Ge4SWphzeROlqd4KrN2ZWf7hOImC8FUHdgI/mOEhghjORThfo8tLc8Gy+Je
	 Jij0LBX/iQM3yMOW3ueXouAFoMIkL3O9JKNfz0bEMlzQdbVv7bsO2/ePA1Y0UDJoDN
	 VW7FgR2vXXNYJaIgu/qmkurJSbwqnjj+bRlS5fnu90suQmqX03FJH2+nl5Ed7aWRdn
	 +PhvBooPZI5q9Wo7oZAk4YbL5LMgghxPypt7ZKZHyG0mTZnfFqzX2vudSxa9yjeEJX
	 JAHnXyV8zPBoQ==
Date: Wed, 11 Dec 2024 18:28:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v3 5/5] net: Document memory provider driver
 support
Message-ID: <20241211182813.789616ce@kernel.org>
In-Reply-To: <CAHS8izOHfWPGaAF0Ri6sN5SVbvD9k_u2-_WmHJHcwu4HDEXj-Q@mail.gmail.com>
References: <20241209172308.1212819-1-almasrymina@google.com>
	<20241209172308.1212819-6-almasrymina@google.com>
	<20241210195513.116337b9@kernel.org>
	<CAHS8izOHfWPGaAF0Ri6sN5SVbvD9k_u2-_WmHJHcwu4HDEXj-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 09:53:36 -0800 Mina Almasry wrote:
> Drivers doing their own recycling is not currently supported, AFAICT.
> Adding support for it in the future and maintaining it is doable, but
> a headache. I also noticed with IDPF you're nacking drivers doing
> their own recycling anyway, so I thought why not just declare all such
> use cases as not supported to make the whole thing much simpler.
> Drivers can deprecate their recycling while adding support for netmem
> which brings them in line with what you're enforcing for new drivers
> anyway.

IIRC IDPF was doing recycling based on the old page ref tricks,
without any use of page pool at all. But without using page pool
the driver will never acquire a netmem_ref in the first place.

> The specific reason: currently drivers will get_page pp pages to hold
> on to them to do their own recycling, right? We don't even have a
> get_netmem equivalent. We could add one (and for the TX path, which is
> coming along, I do add one), but even then, the pp needs to detect
> elevated references on net_iovs to exclude them from pp recycling. The
> mp also needs to understand/keep track of elevated refcounts and make
> sure the page is returned to it when the elevated refcounts from the
> driver are dropped.

No? It should all just work. The page may get split / fragmented by 
the driver or page_pool_alloc_netmem() which you're adding in this
series. A fragmented net_iov will have an elevated refcount in exactly
the same way as if the driver was stashing one ref to release later.

