Return-Path: <netdev+bounces-203536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B91AF6526
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E571A1BC8104
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853F2475C2;
	Wed,  2 Jul 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lhZVTHxm"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E51EC014;
	Wed,  2 Jul 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495198; cv=none; b=NXmeSBjqlCg/bBSM6wn26Erxd/unKRFbE6yg84GPUmLYERBmZNxbDKZYq+OoODVDpYjXIAOXzdyDyH5zzIuwt/FHzx/h2KgSX1GqFxuzgrAtGCkZkJvlcgUa5luoac3b/eOx87znwufpw5GJFKtDUNmvxsOy9he7awaMeZleyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495198; c=relaxed/simple;
	bh=iEvqm8LEvOCppfJrHBWs4+zrkKzc5Z3mo3B9Tg6QiUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvPXPzXJcTubQ9lb/pmvzkmyelcV0gXNMzIHvqA/axGu5jSjedBIWOVA1NVRNQhnqa9a9AngsGkbPZNp9uDh7JYprkNDFzCA2saqURhcdd3W/1AfauPO2hAbqs4yCqIaCw/MFSVInmODZeD2YmpsZaQTfNA14UqhlYGQtXUbnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lhZVTHxm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pZYnQS6oVZM60NmqDWbhfi/8XUrw9dxSRfxYkTiS2dM=; b=lhZVTHxmoM5qQqnKr6jA8q6pR9
	lD9/f9R1LPlFjyCwVqFaswdrJAIYPoGOqQmoiBm0cCOjGijNE6r5f6gb6PoaNdAqkAIP8S6hSfcoW
	031uORY+ncpR13FdyCKdV6RKqYEWFQNhVPB1wQ8vElXFQ0Kag2bvyW554JcBG5tc/L+5uH7xOm70P
	ErHv31QuybfbBvlszA+wwbNWhdPrBP173b/bvXxtqMLairsgAzFTspM1vowTETrWp/uCEZLIJjpcf
	mhWHZkgocCZnVi3wtMaUnrbYVFkaC5GNqnkqJhAVeHA+Nx5Vw0Id3cCk4pXdkGcXUdsjLnkMQVzTX
	HjRPxtMQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX5uI-00000007a1D-2iyp;
	Wed, 02 Jul 2025 22:26:23 +0000
Message-ID: <53d8eaa7-6684-4596-ae98-69688068b84c@infradead.org>
Date: Wed, 2 Jul 2025 15:26:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: nicolas.dichtel@6wind.com, Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/2/25 3:05 AM, Nicolas Dichtel wrote:
> Le 02/07/2025 à 09:46, Gabriel Goller a écrit :
>> It is currently impossible to enable ipv6 forwarding on a per-interface
>> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
>> enable it on all interfaces and disable it on the other interfaces using
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>>
>> Introduce a new sysctl flag `force_forwarding`, which can be set on every
>> interface. The ip6_forwarding function will then check if the global
>> forwarding flag OR the force_forwarding flag is active and forward the
>> packet.
>>
>> To preserver backwards-compatibility reset the flag (on all interfaces)
>> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
>>
>> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>>
>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
>> ---


[snip]

>> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
>> +					    void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int *valp = ctl->data;
>> +	int ret;
>> +	int old, new;
>> +
>> +	// get extra params from table
> /* */ for comment
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n598

Hm, lots there from the BK to git transfer in 2005, with a few updates by Mauro, Jakub, and myself.


More recently (2016!), Linus said this:
  https://lore.kernel.org/lkml/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/

which seems to allow for "//" style commenting. But yeah, it hasn't been added to
coding-style.rst.

>> +	struct inet6_dev *idev = ctl->extra1;
>> +	struct net *net = ctl->extra2;
> Reverse x-mas tree for the variables declaration
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n368

Shouldn't maintainer-netdev.rst contain something about netdev-style comment blocks?
(not that I'm offering since I think it's ugly)

-- 
~Randy


