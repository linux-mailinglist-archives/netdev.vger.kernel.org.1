Return-Path: <netdev+bounces-151941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823769F1C04
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 02:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC59B188E98A
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 01:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351581401B;
	Sat, 14 Dec 2024 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulCpHdZ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB2125DF;
	Sat, 14 Dec 2024 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734141329; cv=none; b=mk9Z+h1m+K8YtEQjrEZzjwZZswd/0i00pUrGRt09TEpA45qhtxFKyySNdO4gQHh8fNRxc0SLM60xKc9h+Q5BVn0ZrZLOau2QbvuD6B/Xqu1atvVzTl5ue4BsNPp1C5Wen/83Ac/nB/WWUDJcnQYRPuIqYQVScgrONsO23b3jRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734141329; c=relaxed/simple;
	bh=+uyggo4BYVdNc7vEs80vAIpD7ah3JAvRIV4PVQrSpxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmGXvafwQj/DixGG/uy6HODZd7kvv3PjV+JXrSIuN7Z6T+OEB8rJF+qWtuoHDMoGfYiuzkGsPovGPGYahS7bWw8YN/k6HMgf2YjOIhGKhdeH4Ajx/VEV5jGYTntgGlOmfSYZKG0I3WFvk+tKF+V0bYw1RXh+LkHBerbm7FyHhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulCpHdZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB6EC4CED0;
	Sat, 14 Dec 2024 01:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734141328;
	bh=+uyggo4BYVdNc7vEs80vAIpD7ah3JAvRIV4PVQrSpxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulCpHdZ2s9XR5DSuELha8LSthUoibT/90sRDvdRAurH46Efs6H1/LtZFuvlO6DZmL
	 MoKwiLd9MmfH4BsIRpL6wl9vM8pylIoYb+RQkTZSn8mvLAN1wrCj2nb2Z4XfA48oSb
	 SCDBbpCjVz3G8SViAVZVlDrsDgJA97H0V5Emcaj2DdftwZpXVT9eV0tmX6Lzw+LNdc
	 T+l+DUelN5N11u559qrr09nVDp2FTZj0Lh3eQO9wXuRmDwEXi2Yk6WG8tmCmgaYu3F
	 Btdr3rcKU78ywLpV1MC4UWf7MyUTrdP80vRrGAOF2zDAvFvpMcYjIX0Hq9HcxAPoVx
	 XK33x7hJceklg==
Date: Fri, 13 Dec 2024 17:55:27 -0800
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
Message-ID: <20241213175527.01583db8@kernel.org>
In-Reply-To: <CAHS8izO0ELODoGJCz49q-9y1EF0fEauo2h7y177D_vL6x82VVA@mail.gmail.com>
References: <20241209172308.1212819-1-almasrymina@google.com>
	<20241209172308.1212819-6-almasrymina@google.com>
	<20241210195513.116337b9@kernel.org>
	<CAHS8izOHfWPGaAF0Ri6sN5SVbvD9k_u2-_WmHJHcwu4HDEXj-Q@mail.gmail.com>
	<20241211182813.789616ce@kernel.org>
	<CAHS8izO0ELODoGJCz49q-9y1EF0fEauo2h7y177D_vL6x82VVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 09:50:15 -0800 Mina Almasry wrote:
> > No? It should all just work. The page may get split / fragmented by
> > the driver or page_pool_alloc_netmem() which you're adding in this
> > series. A fragmented net_iov will have an elevated refcount in exactly
> > the same way as if the driver was stashing one ref to release later.  
> 
> Ah, I had not considered that the driver may recycle the page by
> holding onto a pp ref count, rather than a page refcount. The former
> should indeed just work, although I don't have a driver that does
> this, so test coverage may be a bit lacking.
> 
> But you mentioned you like the rule above. Do you want this removed
> from the docs entirely? Or clarified to something like "driver's can't
> perform their own recycling by holding onto page refs, but can hold
> onto page_pool refs"?

We can call it out, makes sense. I'm not sure how to clearly name 
the page ref vs page_pool ref. But yes, driver must not attempt to
hold onto struct page for recycling, as there is no struct page.

I'd add to that that recycling using page pool refs is also discouraged
as the circulation time for buffers is much longer than when data is
copied out during recvmsg().

