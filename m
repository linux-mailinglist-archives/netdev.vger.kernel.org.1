Return-Path: <netdev+bounces-267842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB8AM1S8tWlD4QAAu9opvQ
	(envelope-from <netdev+bounces-267842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:51:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6928EAAE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53128302C5CC
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F6137F727;
	Sat, 14 Mar 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="0dA9qYZE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01DD34D4D2;
	Sat, 14 Mar 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517867; cv=none; b=q45HithSZeB9EWXMj+M3+YtU34C2+AnYTpVl5AOHvWUgyJdUD/elhA/H60obAFz5QOz3i6avb8TBE9XIA2LOtzT1xWwuJnEmvGwfXjV/kvfXUI/ZBHeWLg9Ees+WaUfC+byxr1NMdYPKQOMoR5d0k3hPz6yXtz1IOBjf9nlgDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517867; c=relaxed/simple;
	bh=HblaUyaYxzw8a4QppLOIO5+vtEnJRZm9VsioiV//5w8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NgZErKalEMoWCB/02uTv4NtmE6X1HPQiR74rHpg7qEGug89wmdHdObdOG6GLXQITMIJAwJlJlzgXpwK/6q0KCFY/eJE2swQ8JDraj1LaSLBJaL3QqOtgsuLloUyPBk7Vlc7yIKDoTxH6nR5Oz4eOgXEfJ7SqxymwXTw98i4ukrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0dA9qYZE; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71853A000A;
	Sat, 14 Mar 2026 20:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773517863; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cz5Vr5ZAsQa8dld3HVw+tC0x2iZx+Eq1khAY01CCeG0=;
	b=0dA9qYZE/1jnYOTLDvQDqr2KbHhZwwtk5DtYvFh5pn8QNsmxpJ7iKqXeyjVDDGUIB/sYV4
	EyVOOksakhZPz3LncyBTttjbl4mGVfnMV9vn1m9qtgJj73D0GqqdwUYCaygXI8XEvbtHJ+
	fWU8cd+vQfa7Blhk7wZKmHodUwBKVGOnbgw9VliQHbYpGt/+VXz4DJ8feVVTDtbmhuOsGT
	IzMIJ2d8HuFIze2Mu2FpZ1jZHM1xhtQ540Ie7YF87PI676uHRJECPJxnuOdvCdiUTm/rz5
	jI2skbEMK0xRfokLwj4k7qJrIQaam74ew11vDfSafKIrVUgQtiGDORG/XVYNBQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Mar 2026 20:51:02 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Eric Biggers <ebiggers@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <mbloch@rooftopnetworks.de>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] net: bcmgenet: add XDP support
In-Reply-To: <f7e184fa-ba8c-4a95-9f08-626f81263669@broadcom.com>
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <f7e184fa-ba8c-4a95-9f08-626f81263669@broadcom.com>
Message-ID: <556be77d65dda294a191530a9ef66fe6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FA6928EAAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 14.3.2026 00:01, Florian Fainelli wrote:
> On 3/13/26 02:20, Nicolai Buchwitz wrote:
>> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
>> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
>> 
>> The first patch converts the RX path from the existing kmalloc-based
>> allocation to page_pool, which is a prerequisite for XDP. The 
>> remaining
>> patches incrementally add XDP functionality and per-action statistics.
>> 
>> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
>> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
>> - XDP_PASS latency: 0.164ms avg, 0% packet loss
>> - XDP_DROP: all inbound traffic blocked as expected
>> - XDP_TX: TX counter increments (packet reflection working)
>> - Link flap with XDP attached: no errors
>> - Program swap under iperf3 load: no errors
> 
> This is very nice, thanks for doing that work! If the network is 
> brought up and there is a background iperf3 client transmitting data, 
> and then you issue "reboot -f", you will see the following NPD:
> 
> [  176.531216] Unable to handle kernel NULL pointer dereference at 
> virtual address 0000000000000010
> [  176.540052] Mem abort info:
> [  176.542854]   ESR = 0x0000000096000004
> [  176.546614]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  176.551938]   SET = 0, FnV = 0
> [  176.555000]   EA = 0, S1PTW = 0
> [  176.558149]   FSC = 0x04: level 0 translation fault
> [  176.563037] Data abort info:
> [  176.565924]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  176.571421]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  176.576489]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  176.581813] user pgtable: 4k pages, 48-bit VAs, 
> pgdp=0000000044d02000
> [  176.588286] [0000000000000010] pgd=0000000000000000, 
> p4d=0000000000000000
> [  176.595101] Internal error: Oops: 0000000096000004 [#1]  SMP
> [  176.600774] Modules linked in: bdc udc_core
> [  176.604976] CPU: 3 UID: 0 PID: 1575 Comm: reboot Not tainted 
> 7.0.0-rc3-g08ac0b907060 #2 PREEMPTLAZY
> [  176.614124] Hardware name: BCM972180HB_V20 (DT)
> [  176.618662] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [  176.625636] pc : bcmgenet_free_rx_buffers+0x78/0x148
> [  176.630618] lr : bcmgenet_fini_dma+0x104/0x180
> [  176.635071] sp : ffff8000836d3910
> [  5]  95.00-96.00  sec  98.4 MB[  176.638390] x29: ffff8000836d3910 
> x28: 0000000000000000 x27: 0000000000000038
> ytes   826 Mbits/sec    0    819[  176.648318] x26: 0000000000000001 
> x25: 0000000000000010 x24: 00000000000003c0
>  KBytes
> [  176.658238] x23: ffffffffffffffff x22: ffff0000086b4a00 x21: 
> 0000000000000000
> [  176.666766] x20: ffff0000086b8600 x19: 0000000000000000 x18: 
> 0000000000000000
> [  176.673917] x17: 000000000000fe88 x16: 00000000000733f0 x15: 
> 00000000000005a8
> [  176.681067] x14: 000000291895b141 x13: 00000000000733f0 x12: 
> 0000000000000000
> [  176.688218] x11: 00000000000000c0 x10: 0000000000000910 x9 : 
> ffff8000809b4ecc
> [  176.695368] x8 : ffff0000058531f0 x7 : 0000000000000000 x6 : 
> 0000000000000000
> [  176.702518] x5 : 0000000000000000 x4 : ffffffff00000000 x3 : 
> 00000000fffe1db3
> [  176.709669] x2 : 0000000000000001 x1 : ffff80008103a108 x0 : 
> 0000000000000001
> [  176.716821] Call trace:
> [  176.719271]  bcmgenet_free_rx_buffers+0x78/0x148 (P)
> [  176.724247]  bcmgenet_fini_dma+0x104/0x180
> [  176.728353]  bcmgenet_netif_stop+0x1b4/0x1f8
> [  176.732633]  bcmgenet_close+0x38/0xd8
> [  176.736304]  __dev_close_many+0xd4/0x1f8
> [  176.740237]  netif_close_many+0x8c/0x140
> [  176.744169]  unregister_netdevice_many_notify+0x210/0x998
> [  176.749578]  unregister_netdevice_queue+0xa0/0xe8
> [  176.754291]  unregister_netdev+0x28/0x50
> [  176.758221]  bcmgenet_shutdown+0x24/0x48
> [  176.762153]  platform_shutdown+0x28/0x40
> [  176.766085]  device_shutdown+0x154/0x260
> [  176.770015]  kernel_restart+0x48/0xc8
> [  176.773688]  __do_sys_reboot+0x154/0x268
> [  176.777620]  __arm64_sys_reboot+0x28/0x38
> [  176.781638]  invoke_syscall+0x4c/0x118
> [  176.785397]  el0_svc_common.constprop.0+0x44/0xe8
> [  176.790110]  do_el0_svc+0x20/0x30
> [  176.793433]  el0_svc+0x18/0x68
> [  176.796495]  el0t_64_sync_handler+0x98/0xe0
> [  176.800689]  el0t_64_sync+0x154/0x158
> [  176.804362] Code: d280003a d503201f f94d2e93 9b3b4eb3 (f9400a61)
> [  176.810467] ---[ end trace 0000000000000000 ]---
> 
> That does not happen if you do:
> 
> ip link set eth0 down
> 
> while there is transmission in progress, FWIW.
> 

Thanks for testing!

Both the NPD and the stalled page_pool are the same
bug: bcmgenet_free_rx_buffers() used a wrong ring index (DESC_INDEX
remapping that doesn't match init_rx_queues). Already fixed in v2 WIP.

I will do some more testing (also with the xdp selftests Jakub 
mentioned)
and then send the v2.

> pw-bot: cr

Thanks,
Nicolai

