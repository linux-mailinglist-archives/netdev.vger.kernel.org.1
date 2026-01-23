Return-Path: <netdev+bounces-252868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CyOGfyTc2ktxQAAu9opvQ
	(envelope-from <netdev+bounces-252868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:30:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0020B77CD7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A703041386
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104A309F0B;
	Fri, 23 Jan 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="isGEbZD8"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7B17A31E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182148; cv=none; b=tg9AGF1gQXSZxFHk6V7cVQ3WYGPUA2Zl4QyC/7v0+FuQCHBTSoDh9X0YgaCyFuWTKGXCY6yi58lk5X6YtEekXv3tZ/SPkiGaKeprkFnQMcrIslpAdKr8V7O8MMt5OXgGQ2L2nU8QrJ9k4T3DV6X8ZPncUl46yea77pELxzH+Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182148; c=relaxed/simple;
	bh=QJdElbj+4EPRpm/w8zGO44PVEzORKvLlDWMin4dyiM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeBgdScDa0Pb2reznjwuu6grDDGUHRHYFH1u311xMTfPnNO9QUxhEmyJxO4ejCELyFLr5zLQd62K9imVK+44E2bItNLq5vN+HFPYqKl4XymlOeFRDzJ8SVXyGbFO8gKnq277jqHoc+U5k49KEq4l9mahkMMPz2/hq2zS30vatAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=isGEbZD8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ujqhCo4FyS5EG+60e5aGFRC1Y2LqrfPKhzmKSqz6n6k=; b=isGEbZD8eymRNMS2RUMazatjPL
	w5cnlGNBBp1gyVE0/Sh1KC3EyZbxZ0ZKoL4yFotY8WM0muH2qLonGiU5odS3O76faiziI0A094fTw
	fm2NqBtVMtYGjrQ1YKO5loOizP1M6p/SVxHfX/vxdne/t/jp5cKJOzZ7ZOe/7jDqi3eiaQ6cJtW0i
	DyrkL35qkCuNRem2Cg+6lZsoZRWPk97rDVmrtmM3fVA0bLlyRHbfT9xqgIgtmhvkfzwUZtfo7VkKt
	0IpohwWK77RVvVN11MzLq6QV7/ySPODQP6EQihtf4rMLuE89MZrPcKrtyMcXDMzC3GBKkbwZVqvRd
	wI7uebTA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vjJ5P-000DWC-0z;
	Fri, 23 Jan 2026 16:28:35 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vjJ5O-000Epp-1y;
	Fri, 23 Jan 2026 16:28:34 +0100
Message-ID: <28671453-10ad-4d50-a45d-d1124e7e5414@iogearbox.net>
Date: Fri, 23 Jan 2026 16:28:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: fix use-after-free due to enslave fail after
 slave array update
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen Zhen <chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>
References: <20260123120659.571187-1-razor@blackwall.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260123120659.571187-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27888/Thu Jan 22 08:25:13 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-252868-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid,blackwall.org:email]
X-Rspamd-Queue-Id: 0020B77CD7
X-Rspamd-Action: no action

On 1/23/26 1:06 PM, Nikolay Aleksandrov wrote:
> Fix a use-after-free which happens due to enslave failure after the new
> slave has been added to the array. Since the new slave can be used for Tx
> immediately, we can use it after it has been freed by the enslave error
> cleanup path which frees the allocated slave memory. Slave update array is
> supposed to be called last when further enslave failures are not expected.
> Move it after xdp setup to avoid any problems.
> 
> It is very easy to reproduce the problem with a simple xdp_pass prog:
>   ip l add bond1 type bond mode balance-xor
>   ip l set bond1 up
>   ip l set dev bond1 xdp object xdp_pass.o sec xdp_pass
>   ip l add dumdum type dummy
> 
> Then run in parallel:
>   while :; do ip l set dumdum master bond1 1>/dev/null 2>&1; done;
>   mausezahn bond1 -a own -b rand -A rand -B 1.1.1.1 -c 0 -t tcp "dp=1-1023, flags=syn"
> 
> The crash happens almost immediately:
>   [  605.602850] Oops: general protection fault, probably for non-canonical address 0xe0e6fc2460000137: 0000 [#1] SMP KASAN NOPTI
>   [  605.602916] KASAN: maybe wild-memory-access in range [0x07380123000009b8-0x07380123000009bf]
>   [  605.602946] CPU: 0 UID: 0 PID: 2445 Comm: mausezahn Kdump: loaded Tainted: G    B               6.19.0-rc6+ #21 PREEMPT(voluntary)
>   [  605.602979] Tainted: [B]=BAD_PAGE
>   [  605.602998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   [  605.603032] RIP: 0010:netdev_core_pick_tx+0xcd/0x210
>   [  605.603063] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3e 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 49 8d 7d 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 25 01 00 00 49 8b 45 30 4c 89 e2 48 89 ee 48 89
>   [  605.603111] RSP: 0018:ffff88817b9af348 EFLAGS: 00010213
>   [  605.603145] RAX: dffffc0000000000 RBX: ffff88817d28b420 RCX: 0000000000000000
>   [  605.603172] RDX: 00e7002460000137 RSI: 0000000000000008 RDI: 07380123000009be
>   [  605.603199] RBP: ffff88817b541a00 R08: 0000000000000001 R09: fffffbfff3ed8c0c
>   [  605.603226] R10: ffffffff9f6c6067 R11: 0000000000000001 R12: 0000000000000000
>   [  605.603253] R13: 073801230000098e R14: ffff88817d28b448 R15: ffff88817b541a84
>   [  605.603286] FS:  00007f6570ef67c0(0000) GS:ffff888221dfa000(0000) knlGS:0000000000000000
>   [  605.603319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  605.603343] CR2: 00007f65712fae40 CR3: 000000011371b000 CR4: 0000000000350ef0
>   [  605.603373] Call Trace:
>   [  605.603392]  <TASK>
>   [  605.603410]  __dev_queue_xmit+0x448/0x32a0
>   [  605.603434]  ? __pfx_vprintk_emit+0x10/0x10
>   [  605.603461]  ? __pfx_vprintk_emit+0x10/0x10
>   [  605.603484]  ? __pfx___dev_queue_xmit+0x10/0x10
>   [  605.603507]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
>   [  605.603546]  ? _printk+0xcb/0x100
>   [  605.603566]  ? __pfx__printk+0x10/0x10
>   [  605.603589]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
>   [  605.603627]  ? add_taint+0x5e/0x70
>   [  605.603648]  ? add_taint+0x2a/0x70
>   [  605.603670]  ? end_report.cold+0x51/0x75
>   [  605.603693]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
>   [  605.603731]  bond_start_xmit+0x623/0xc20 [bonding]
> 
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reported-by: Chen Zhen <chenzhen126@huawei.com>
> Closes: https://lore.kernel.org/netdev/fae17c21-4940-5605-85b2-1d5e17342358@huawei.com/
Thanks!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

