Return-Path: <netdev+bounces-175850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071DA67AF6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273E23BDAA2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4D211A2C;
	Tue, 18 Mar 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6ag9zLK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D120B815;
	Tue, 18 Mar 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318749; cv=none; b=AdoeTWgFJEivxvwNo9urH34EqF/uDVGRw6tUDDLwiEqAsQf8ZKkwBRTdhnJeP69Z2Dcn5LuzcbdcxC5eTfE4Qk8AAFdDU2BXfsnv2hQtFdYc9qrLf32Rv2hAf4yO8NGOa6bsPZEC9RY2nNpRhHQNZKAPX21r/QzZKG61XcXvJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318749; c=relaxed/simple;
	bh=0Fnw90lEkWmqokPbY8n+Uhso57d22AS+Hjmxfs5cBlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN5tN1z5L3qWhjteundp257ZZCojiQmYKpqwc8meoqDCBhycqxixEAhWmrORwPIijURuhHRD6J60wOlmW8+arCl/oKxD0/+8w9XO8TYRkyvIFQOmuZ7L2G++q2ER0lLdsgj3WUkrMXpHZtnjp25TOf9VfJloSx7q5LP78hKS55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6ag9zLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5F2C4CEDD;
	Tue, 18 Mar 2025 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318749;
	bh=0Fnw90lEkWmqokPbY8n+Uhso57d22AS+Hjmxfs5cBlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6ag9zLKIgs4FEXqiEGNoAFX42zZmWNtdUW3wOL0AtQbk3UknorKHt2YBAf9jqxfv
	 JsIh+sNPRphrmBvQighVDmjoGq2/SB7nHEuH5sfGVarHo0XSZ0zBEptY9HIQPH82Cx
	 Nh74tyVAkdnKZWs85AWHMn0rgmywOKjz12Sh2J0LsAxm0iP138S+Ix29nOUsDHyYwq
	 Z4jVpdo+CtEYnRxS68J6tt2x/mi5OLjaGqOpGJ9u1/NQ5/2nc2rR7OOE71/mrpavVW
	 Ct60qPjbmBgq6Aq3bYzQvxOS+rtN2H60bZlgNHOsYUdlqeOUvNJjQt8bMjBoATnYT9
	 aoqyPoxqlYVxQ==
Date: Tue, 18 Mar 2025 17:25:45 +0000
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	aleksander.lobakin@intel.com,
	syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: vlan: don't propagate flags on open
Message-ID: <20250318172545.GR688833@kernel.org>
References: <20250313100657.2287455-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313100657.2287455-1-sdf@fomichev.me>

On Thu, Mar 13, 2025 at 03:06:57AM -0700, Stanislav Fomichev wrote:
> With the device instance lock, there is now a possibility of a deadlock:

...

> Device setup:
> 
>      netdevsim0 (down)
>      ^        ^
>   bond        netdevsim1.100@netdevsim1 allmulticast=on (down)
> 
> When we enslave the lower device (netdevsim0) which has a vlan, we
> propagate vlan's allmuti/promisc flags during ndo_open. This causes
> (re)locking on of the real_dev.
> 
> Propagate allmulti/promisc on flags change, not on the open. There
> is a slight semantics change that vlans that are down now propagate
> the flags, but this seems unlikely to result in the real issues.
> 
> Reproducer:
> 
>   echo 0 1 > /sys/bus/netdevsim/new_device
> 
>   dev_path=$(ls -d /sys/bus/netdevsim/devices/netdevsim0/net/*)
>   dev=$(echo $dev_path | rev | cut -d/ -f1 | rev)
> 
>   ip link set dev $dev name netdevsim0
>   ip link set dev netdevsim0 up
> 
>   ip link add link netdevsim0 name netdevsim0.100 type vlan id 100
>   ip link set dev netdevsim0.100 allmulticast on down
>   ip link add name bond1 type bond mode 802.3ad
>   ip link set dev netdevsim0 down
>   ip link set dev netdevsim0 master bond1
>   ip link set dev bond1 up
>   ip link show
> 
> Reported-by: syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/Z9CfXjLMKn6VLG5d@mini-arch/T/#m15ba130f53227c883e79fb969687d69d670337a0
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Simon Horman <horms@kernel.org>


