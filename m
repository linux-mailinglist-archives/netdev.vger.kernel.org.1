Return-Path: <netdev+bounces-307430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zWVPMlcaVmrgzAAAu9opvQ
	(envelope-from <netdev+bounces-307430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B8753CF2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:15:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=egkuiVe3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307430-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68613070D24
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12037F8B3;
	Tue, 14 Jul 2026 11:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9F37DE98
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:13:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027626; cv=none; b=VCNrAgKPUK6IyDpuN5KvK366OedZ9zHX2EokIH1G2beAJRNQpm8qwOtutRcVamjflcNtjJVEkxoADK/21fbWyH4Qg/zmN1gGoJOnabPA93hcCvNAdA6kaaQkGHBwLHWfiJbC4YTjANu/idv/iZ8HXLRJaTaDM1qPF7/QWf7J3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027626; c=relaxed/simple;
	bh=gFmm8OhmJgg+3uRmLjOxHc2kjU1UK7NWYxJrINbn7+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxQ+NeSdlV84tlglNbAWH5NWAvYE9Ynvt6XpSa6H98AMJkIVGGrvqUsyENVI7DKLsT0+VuY9POu++s/HDSTsM4pzn39LwxWbN18Jk6Zb+oPKvXJzgwTCzNW9jvczPRlJtcRu5QktkX4ZsGODSp1GQsFjGH65dJwkambWKs494Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=egkuiVe3; arc=none smtp.client-ip=91.218.175.188
Message-ID: <29dc5f0e-1ddc-4655-99a7-756a5e020495@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784027613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79zXcDEPlxrNcOqS0crvZ4z9J9iujdc4lV84ElCi0oE=;
	b=egkuiVe3UUyFoCDgYvEZPngKvvlzzorZkUxsiaufMqUMWWb/h4P/OOo9nh/dNSH3/I172/
	cutwSAOVgNTq8eTtdCGM+EqecxQQXqZGpEtbUL4d5iNqtk6u+UZFxq1c3a/XWhcxJYoB0H
	0ovp7mj3cI7nh0uSX6CG4mU9Tn7yOYw=
Date: Tue, 14 Jul 2026 19:13:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: hsr: clean up the slave VLAN filters when
 deleting a port
To: Felix Maurer <fmaurer@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Hangbin Liu <liuhangbin@gmail.com>, Jakub Acs <acsjakub@amazon.de>,
 Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
 MD Danish Anwar <danishanwar@ti.com>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org
References: <20260714080640.149654-1-jiayuan.chen@linux.dev>
 <alYYhIPZBbMo5qMe@thinkpad>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <alYYhIPZBbMo5qMe@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmaurer@redhat.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:lukma@nabladev.com,m:fmancera@suse.de,m:liuhangbin@gmail.com,m:acsjakub@amazon.de,m:xiaoliang.yang_1@nxp.com,m:danishanwar@ti.com,m:m-karicheri2@ti.com,m:jiri@resnulli.us,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,nabladev.com,suse.de,gmail.com,amazon.de,nxp.com,ti.com,resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F8B8753CF2


On 7/14/26 7:07 PM, Felix Maurer wrote:
> On Tue, Jul 14, 2026 at 04:06:36PM +0800, Jiayuan Chen wrote:
>> Our internal syzkaller reported this warning:
>>
>>    netdevsim netdevsim10 eth0: entered promiscuous mode
>>    netdevsim netdevsim10 eth1: entered promiscuous mode
>>    netdevsim netdevsim10 eth1 (unregistering): left promiscuous mode
>>    ------------[ cut here ]------------
>>    WARNING: drivers/net/netdevsim/netdev.c:1208 at nsim_destroy+0x276/0x6e0, CPU#3: 1/46
>>    Modules linked in:
>>    CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:1 Not tainted 7.2.0-rc2+ #286 PREEMPT
>>    Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>    Workqueue: netns cleanup_net
>>    RIP: 0010:nsim_destroy (drivers/net/netdevsim/netdev.c:1031 drivers/net/netdevsim/netdev.c:1201)
>>    RSP: 0018:ffffc90000337898 EFLAGS: 00010293
>>    RAX: 0000000000000001 RBX: ffff8881036c8b00 RCX: 0000000000000000
>>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>    RBP: ffffc900003378f0 R08: 0000000000000000 R09: 0000000000000000
>>    R10: ffffffffad4186a8 R11: ffffffffad41c3db R12: ffff8881036c9268
>>    R13: dffffc0000000000 R14: ffffed10206d9164 R15: 0000000000000001
>>    FS:  0000000000000000(0000) GS:ffff888160866000(0000) knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: 000055bcf1a2e0c4 CR3: 0000000105376003 CR4: 0000000000770ef0
>>    PKRU: 55555554
>>    Call Trace:
>>    <TASK>
>>    __nsim_dev_port_del (drivers/net/netdevsim/dev.c:1547)
>>    nsim_dev_reload_destroy (drivers/net/netdevsim/dev.c:1561 drivers/net/netdevsim/dev.c:1785)
>>    nsim_dev_reload_down (drivers/net/netdevsim/dev.c:1038)
>>    devlink_reload (net/devlink/dev.c:462)
>>    devlink_pernet_pre_exit (net/devlink/core.c:578)
>>    ops_undo_list (net/core/net_namespace.c:161 net/core/net_namespace.c:235)
>>    cleanup_net (net/core/net_namespace.c:706)
>>    process_one_work (kernel/workqueue.c:3322)
>>    worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>>    kthread (kernel/kthread.c:436)
>>    ret_from_fork (arch/x86/kernel/process.c:158)
>>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>>    </TASK>
>>    ---[ end trace 0000000000000000 ]---
>>    netdevsim netdevsim10 eth0 (unregistering): left promiscuous mode
>>
>> vlan_vids_add_by_dev() is what passes the VID filter info down to the real
>> device. A virtual device does no filtering itself, so it has to push the
>> VIDs down to its slaves. HSR already does this correctly on the add side:
>> hsr_ndo_vlan_rx_add_vid() calls vlan_vid_add() on each slave.
>>
>> We just never clean the slaves up on delete. hsr_del_port() drops the port
>> and leaves the VIDs sitting on the slave, so the filter entries leak.
>> netdevsim keeps a bitmap of the VIDs it was told to filter and checks that
>> it is empty when the netdev goes away, which is what trips the warning
>> above.
>>
>> So do the cleanup in hsr_del_port(). We follow hsr_ndo_vlan_rx_add_vid()
>> here: it only pushes the VIDs to HSR_PT_SLAVE_A and HSR_PT_SLAVE_B, so the
>> del side only touches those two as well.
>>
>> Reproducer:
>> ip netns add ns0
>> ip netns exec ns0 sh -c 'echo "10 2" > /sys/bus/netdevsim/new_device'
>> ip netns exec ns0 ip link add hsr0 type hsr slave1 eth0 slave2 eth1
>> ip netns exec ns0 ip link add link hsr0 name hsr0.1 type vlan id 1
>> ip netns del ns0
> Thank you for your patch! The explanation and the patch look very
> similar to a fix that Eric posted a week ago [1]. Can you check if
> Eric's patch also fixes you reproducer? And if it does, please add your
> Tested-by and/or Reviewed-by to the thread?
>
> Thanks,
>     Felix
>
>
> [1]: https://lore.kernel.org/netdev/20260707082327.3238690-1-edumazet@google.com/


Thanks, It seems my patch is duplicated.


