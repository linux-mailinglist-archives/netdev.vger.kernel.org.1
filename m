Return-Path: <netdev+bounces-118741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BD9529AC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9AA1F212C6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCA17920A;
	Thu, 15 Aug 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vDP945ET"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266851EB31;
	Thu, 15 Aug 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706073; cv=none; b=ObUt1ygyIK3qG25dRi7QpWDiiRI1p2CkHpolRsN24RQCACjRbdFgRYlW559Agni3av2myzuZU7Vq5eVEMg1RDo1MvzPrhdqGzf6Uyo0XRDVW9m4SHO6OwxCCH93bSor92US1GbFoeTmClHI+coHDXsiGxVV34a08yktldfXCD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706073; c=relaxed/simple;
	bh=Jrjcm6+EhcaXEJi1rFzH1jGC5K6EkwBZ3kV70fPa7t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejaKwYo7btNjIwZfYW9enIWlYarFEemR3ISzWdVFyz7q5G9Myd6Ltja6o/LcUndSQifTMixxfYTiWfFbzZMQcC+0R43yMJeaU7q60t7hT9yfN57IQPWDhEMK4BP6ns7pSqR1IixASSZrkC/JWWfusivMASxgHXq9TJKPQ9XCYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vDP945ET; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=9qxoS+3oeTjP70ryzrOdH6IaU/FJ7BJBCt3EOY6TtFk=;
	t=1723706072; x=1724138072; b=vDP945ETztl0XzPCLUkZEkthJF1Pz7cC97vowEZUnyXVplh
	5IOpnEDMe7FedeNw93/vPAAduNsTiAumSBvnEs35lsbF2BkVgTzMk0KBIO3WnGLf9tQ6pZothMwp8
	oYrQ0i/LF5HDUxKcGAF6gz93ouCsXGNxZSrrVF0M4Cci4vpKxIEvCVWBW1UC2EPSCMbhtOo5UMZVq
	sxTecF69WmM0CEi06GccHu6T5BLcR8G+GxFKIxyaK+U4WW7iSPWfs+Zotyw3w60v9cW5lbrIUoWQb
	/qQnFG1CmH35TrBdeiKahqn5rmbeLJ+b/z+tsmz8j9mGG7Sjr2K8nm2e5svNTFeQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1seUgm-0003lm-Bo; Thu, 15 Aug 2024 09:14:28 +0200
Message-ID: <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
Date: Thu, 15 Aug 2024 09:14:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723706072;233a5b5e;
X-HE-SMSGID: 1seUgm-0003lm-Bo

[side note: the message I have been replying to at least when downloaded
from lore has two message-ids, one of them identical two a older
message, which is why this looks odd in the lore archives:
https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]

On 14.08.24 08:59, Michael S. Tsirkin wrote:
> Note: Xuan Zhuo, if you have a better idea, pls post an alternative
> patch.
> 
> Note2: untested, posting for Darren to help with testing.
> 
> Turns out unconditionally enabling premapped 
> virtio-net leads to a regression on VM with no ACCESS_PLATFORM, and with
> sysctl net.core.high_order_alloc_disable=1
> 
> where crashes and scp failures were reported (scp a file 100M in size to VM):
> [...]

TWIMC, there is a regression report on lore and I wonder if this might
be related or the same problem, as it also mentioned a "get_swap_device:
Bad swap file entry" error:
https://bugzilla.kernel.org/show_bug.cgi?id=219154

To quote:

"""
Hello,

I've encountered repeated crashes or freezes when a KVM VM receives
large amounts of data over the network while the system is under memory
load and performing I/O operations. The crashes sometimes occur in the
filesystem code (ext4 and btrfs, at least), but they also happen in
other locations.

This issue occurs on my custom builds using kernel versions v6.10 to
v6.11-rc2, with virtio network and disk drivers, and either Ubuntu 22.04
or Debian 12 user space.

The same kernel build did not crash on an Azure VM, which does not use
the virtio network driver. Since this issue only appears when receiving
data, I suspect there could be an issue related to the virtio interface
or receive buffer handling.

This issue did not occur on the Debian backport kernel 6.9.7-1~bpo12+1
amd64.

Steps to Reproduce:
1. Setup a small VM on a KVM host.
   I tested this on an x86_64 KVM VM with 1 CPU, 512 MB RAM, 2 GB SWAP
(the smallest configuration from Vultr), using a Debian 12 user space,
virtio disk, and virtio net.
2. Induce high memory and I/O load. Run the following command:
   stress --vm 2 --hdd 1
   (Adjust --vm to to occupy all the RAM)
   This slows down the system but does not cause a crash.
3. Send large data to the VM.
   I used `iperf3 -s` on the VM and sent data using `iperf3 -c` from
another host. The system crashes within a few seconds to a few minutes.
(The reverse direction `iperf3 -c -R` did not cause a crash.)


The OOPS messages are mostly general protection faults, but sometimes I
see "Bad pagetable" or other errors, such as:
Oops: general protection fault, probably for non-canonical address
0x2f9b7fa5e2bde696: 0000 [#1] PREEMPT SMP PTI
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
Oops: Bad pagetable: 000d [#1] PREEMPT SMP PTI

In some cases, dmesg contains something like:
UBSAN: shift-out-of-bounds in lib/xarray.c:158:34

When the system freezes without crash, I sometimes found BUGON messages
in some cases, such as:
get_swap_device: Bad swap file entry 3403b0f5b2584992
BUG: Bad page map in process stress  pte:c42f93fac0299e1d pmd:0d9b2047
BUG: Bad rss-counter-state mm:000000004df3dd9a type:MM_ANONPAGES val:2
BUG: Bad rss-counter-state mm:000000004df3dd9a type:MM_SWAPENTS val:-1

Thanks.
"""

Ciao, Thorsten

