Return-Path: <netdev+bounces-196703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F348AD6000
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3390D1E07C4
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431FA1DE4CD;
	Wed, 11 Jun 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQS7VZg3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27713A3F2
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673402; cv=none; b=kyN88S1+nZkIPsKJc0HxkE8+fQ5UCdfCOvvDYct49KF/paeWOZHceae7anSNebBHdB+oL2h4dU79TTZhqv7fze+ITSOFP/lg7okZ2RXqFQAzv22g7ksGfY9eHGDYGvDYaBZ0ziZc/zTEyNwh9ypViQ16wY/8mxy8FBQskxtpEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673402; c=relaxed/simple;
	bh=TSJ0xzSdWNrXSW/KgRMtrp6xLfO1Nug0/yg93GgtDU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDLu1z5/Ju360hLiaBcMYkl2ioWBeXqlVxq9H89koZe0srhujMcO1TjvNy/05fTajj6zgb8T/dMAJnBBh/aGau0pVLju0gb0SkpDSPWk8mL4wpsFAiD/mACidauXvcAF7GGKLaaJ8pH1zvvwFnaxzM2nmlo9Ii3TlQ9EFl9EQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQS7VZg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40619C4CEE3;
	Wed, 11 Jun 2025 20:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749673401;
	bh=TSJ0xzSdWNrXSW/KgRMtrp6xLfO1Nug0/yg93GgtDU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQS7VZg3WfP+TvBaKbMMQFSKSyoGxMUoepdwSov+790PYQHwiyFcv/He6m1haBEab
	 TZjn6K4y+mlmyIFpMuE3RFsX7QSJtpDxbT9BsquQhPTfcORXzuf6rHCZxLBVZyQ4ow
	 Nw4yQzyzWxED7tIGIxX5HmYHXE7Bad9Nh+ox4bSi152iUjCHP7f0qyJp6lagP6bZip
	 QEhpaWnVeT3sY7hdeMb92DKpx0tTm9urwyPPidYdS1jjvGwK8LMJk5P4n4HBNH8LhK
	 kGzIVC/Aq+a37DU00RU60YqGu9fAb2MMuRXeW5Mnx0uZd0E00qol7LhmZkSwPSXhcE
	 yVkDjhKagfrsw==
Date: Wed, 11 Jun 2025 13:23:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David Ahern"
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>, Kuniyuki Iwashima
 <kuniyu@google.com>
Subject: Re: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing
 locally-generated MC packets
Message-ID: <20250611132320.53c5bebc@kernel.org>
In-Reply-To: <87o6uui6f7.fsf@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
	<20250610055856.5ca1558a@kernel.org>
	<87wm9jeo3n.fsf@nvidia.com>
	<87o6uui6f7.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 17:30:15 +0200 Petr Machata wrote:
> Could it actually have been caused by another test? The howto page
> mentions that the CI is running the tests one at a time, so I don't
> suppose that's a possibility.
> 
> I'll try to run a more fuller suite tomorrow and star at the code a bit
> to see if I might be missing an error branch or something.

We also hit a crash in ipv6 fcnal.sh, too. Looks like this is either a
kmemleak false positive or possibly related to the rtnl changes in ipv6.
Either way I it's not related to you changes, sorry about that! :(

[ 2900.792890] BUG: kernel NULL pointer dereference, address: 0000000000000108
[ 2900.792961] #PF: supervisor read access in kernel mode
[ 2900.793017] #PF: error_code(0x0000) - not-present page
[ 2900.793053] PGD 8fd6067 P4D 8fd6067 PUD 6402067 PMD 0 
[ 2900.793097] Oops: Oops: 0000 [#1] SMP NOPTI
[ 2900.793127] CPU: 0 UID: 0 PID: 15652 Comm: nettest Not tainted 6.15.0-virtme #1 PREEMPT(voluntary) 
[ 2900.793200] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 2900.793245] RIP: 0010:ip6_pol_route+0x286/0x4a0
[ 2900.793290] Code: 0c 24 0f 85 fb 01 00 00 09 ca 0f 88 2f 01 00 00 e8 cf 11 43 ff 83 cb 08 48 8d 7c 24 18 e8 32 7b ff ff 0f b7 cb ba ff ff ff ff <4c> 8b 80 08 01 00 00 48 89 c6 49 89 c7 49 8d b8 80 06 00 00 4c 89
[ 2900.793422] RSP: 0018:ffffc08a0932f480 EFLAGS: 00010246
[ 2900.793460] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
[ 2900.793521] RDX: 00000000ffffffff RSI: ffffc08a0932f740 RDI: ffff9adac8c8f1a8
[ 2900.793580] RBP: ffff9adac87458c0 R08: 0000000000000000 R09: 0000000000000000
[ 2900.793635] R10: 0000000000000000 R11: 0000000000000040 R12: ffff9adac82e362c
[ 2900.793692] R13: ffff9adac82e3600 R14: 0000000000000080 R15: 0000000000000000
[ 2900.793752] FS:  00007f3418913740(0000) GS:ffff9adb7373a000(0000) knlGS:0000000000000000
[ 2900.793816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2900.793864] CR2: 0000000000000108 CR3: 0000000008007004 CR4: 0000000000772ef0
[ 2900.793920] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2900.793977] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2900.794031] PKRU: 55555554
[ 2900.794050] Call Trace:
[ 2900.794070]  <TASK>
[ 2900.794090]  ? __pfx_ip6_pol_route_output+0x10/0x10
[ 2900.794131]  fib6_rule_action+0xe3/0x310
[ 2900.794166]  fib_rules_lookup+0x1b2/0x2b0
[ 2900.794200]  ? __pfx_ip6_pol_route_output+0x10/0x10
[ 2900.794241]  fib6_rule_lookup+0xa9/0x270
[ 2900.794271]  ? __pfx_ip6_pol_route_output+0x10/0x10
[ 2900.794310]  ip6_route_output_flags+0xab/0x180
[ 2900.794353]  ip6_dst_lookup_tail.constprop.0+0x282/0x340
[ 2900.794394]  ip6_dst_lookup_flow+0x46/0xc0
[ 2900.794422]  vrf_xmit+0x100/0x4a0
[ 2900.794459]  dev_hard_start_xmit+0x8d/0x1c0

https://netdev-3.bots.linux.dev/vmksft-net/results/160541/vm-crash-thr0-0

