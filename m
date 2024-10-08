Return-Path: <netdev+bounces-133258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A881599567D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ED8283351
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4A21265B;
	Tue,  8 Oct 2024 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw83NOHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640220ADFB;
	Tue,  8 Oct 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411929; cv=none; b=Y6mqVc4569N8Ik4vUa4WXJmeYxB+svJG/Q2E0RBh5HmC1Zgi7lkbdjYxnyywqdolWI/J8NnQntjpvL3rwvF6DR44mi2YqHXt/TTOmvS3+WHCOli1w5hwYeYrqHG48znen0ISRl+vlDFcDJFXK1S7UEbCruSulPh9gk2QCX6u5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411929; c=relaxed/simple;
	bh=6yO44GTruSBqyh+4TuT7xK5fItO/EwT/Yx8VFoAH+Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krg/3PWyE+xY8NAkOLhQ9RY/RDVFg0zZ5Y2eK20XljmB4+fDDEJFW0RBSyUooUKK0x279B1SHXiYXQJv3kusLZM9UazSFxT3+P4uPskkR9l49JGlxHfdeltQYBJUcSjSA+RETuEXzDuZv0eUwUBVsQTX0Fr7HZbo3KSC07wi+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw83NOHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D36C4CEC7;
	Tue,  8 Oct 2024 18:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411929;
	bh=6yO44GTruSBqyh+4TuT7xK5fItO/EwT/Yx8VFoAH+Hk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bw83NOHH/lU9hFEuBFZOoeLVb73SmNPn92SNob5YR1f/dQezMB82pJAK1ChtyRnZ0
	 RdQ7OLgdPd0D3CM2YOupQ+iAi7qpiLE8deIwF3AnnVN+awReA5exXQiCwqYp5Xhas8
	 nJKWvLsmrccfeqReS/x80xaCR6BATFbQDqgik4ru1FwJ4pjkAea+t1mwRyMqddldE8
	 pUaGN8Q9KsgvpyprPC2puQDfojj9a2Pv7EUuU3psydIzhIwXlN6hXRTcfOoXLMWMDd
	 rgZViOhUFIvaH7RjHwzG0t8uVbNCSoUOuuXTYWf+4gsTcQs2cmmaWkWTa55dBtEeTW
	 Nf1nDkoepdJFg==
Message-ID: <cea1458c-6445-45d0-bfa1-3c093384cc90@kernel.org>
Date: Tue, 8 Oct 2024 12:25:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Remove likely from
 l3mdev_master_ifindex_by_index
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel-team@meta.com, "open list:L3MDEV" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241008163205.3939629-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241008163205.3939629-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 10:32 AM, Breno Leitao wrote:
> The likely() annotation in l3mdev_master_ifindex_by_index() has been
> found to be incorrect 100% of the time in real-world workloads (e.g.,
> web servers).
> 
> Annotated branches shows the following in these servers:
> 
> 	correct incorrect  %        Function                  File              Line
> 	      0 169053813 100 l3mdev_master_ifindex_by_index l3mdev.h             81
> 
> This is happening because l3mdev_master_ifindex_by_index() is called
> from __inet_check_established(), which calls
> l3mdev_master_ifindex_by_index() passing the socked bounded interface.
> 
> 	l3mdev_master_ifindex_by_index(net, sk->sk_bound_dev_if);
> 
> Since most sockets are not going to be bound to a network device,
> the likely() is giving the wrong assumption.
> 
> Remove the likely() annotation to ensure more accurate branch
> prediction.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/l3mdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



