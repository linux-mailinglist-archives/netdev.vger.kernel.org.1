Return-Path: <netdev+bounces-294606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54hwKtvVH2rwqgAAu9opvQ
	(envelope-from <netdev+bounces-294606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA13463524C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=WeIuVFDF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294606-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294606-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F1A33025FAC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1F30CDBC;
	Wed,  3 Jun 2026 07:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA92874F5
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:07:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470476; cv=none; b=idAUfPHZxbjTI5B5uT9y2uViUiir48u0K8lJ4DKcvsbAyNRTW+WdBcwb4qF80Odel5Rgxr/K3CEtUtiR+PV0mFU6jxA5dHAj0MueHyeXaxvOCj/GxM2AfUXXbR0XUVZ0ETcubtEhHFwGeBOIiqGVrC3FNKNFW3OUI62ImgEZwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470476; c=relaxed/simple;
	bh=NIqP3mpKkMl9tQO6dV0NJUEq2aGoT1j7zHKB4lafGVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=laZnzqIQVjBEVwNnTKKjJ6RyZO7S6xcFAabCIflELE0sX0rJ+1qb6rdZmMFsUKfX9fCkIXOfwlHMuP/jFafP3MCKAT0ty5N8978SOkIiEDC6w5WUO4ijXTOvtZ5p7F0HiFOdlqEQS3fFZbjKaV5KQj/dV/t+8FcRZOcnKn366fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WeIuVFDF; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o6AAJ92nuL/D04C2mqzdfWtr0DSTjGJMRQeczoYczwU=; b=WeIuVFDFrG6219CNlWXsINDPIr
	opkyyVs7XoZJUaGXM2uBYUwO4TVuKDC7jdW2t/O4c1yx/pCbH10QUIe/ksPade1Z+UDKyyhFkFJ0b
	5B35S538ZJUg3QLjGISYfaSLPs36VIA95TjaYZDDjuQnH9ioISuVOUeBIF+pfzIariLNygK/WfwbU
	DC9/xji5OqdxeFB0Zqrdic5TNb9AdF0s6lcHpsQN/oTmao0Lj7W1l2E9RF8i5dEixCCE1Jmzvg59r
	nnmHFEtsph9oM7CIYvHmptPEvVTj05aA0OTwH2Q8YMWX+7vBtvqslzRpGsPgBdCaAB/i/JGxFKWK+
	CfrLAJzQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUfhY-000LMM-1W;
	Wed, 03 Jun 2026 09:07:44 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUfhY-000Hbq-1N;
	Wed, 03 Jun 2026 09:07:43 +0200
Message-ID: <f3d7803f-0a3e-4429-8236-42ec5d946016@iogearbox.net>
Date: Wed, 3 Jun 2026 09:07:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: slab-out-of-bounds Write in mini_qdisc_pair_swap
 (net/sched/sch_generic.c) -- lifetime analysis and proposed fix
To: boz baba <bababoz943@gmail.com>
References: <CAAB7JC+WKtCUkTeJFhAR-d3A=DFa_31tK78-QoSu5-dXXypmnQ@mail.gmail.com>
 <db1dd6b5-47ff-436b-8bbc-c4abca87bb0e@iogearbox.net>
 <CAAB7JC+oMsTESKXMcP_Qhm2zSaU=yFqmA_MJxCd8wDVSnwTz0g@mail.gmail.com>
Content-Language: en-US
Cc: Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAAB7JC+oMsTESKXMcP_Qhm2zSaU=yFqmA_MJxCd8wDVSnwTz0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bababoz943@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294606-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,iogearbox.net:mid,iogearbox.net:dkim,iogearbox.net:from_mime,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA13463524C

Hi boz,

On 6/2/26 11:56 PM, boz baba wrote:
> Hi Daniel,
> 
> Thanks for the quick turnaround. Attaching both artifacts you asked for.
> 
> Syzbot reference:
> https://syzkaller.appspot.com/bug?extid=c5690f59dae698a60ee4
> 
> 1) KASAN splat
> -----------------------------------------------------------------------
> The splat below is taken directly from the syzbot report at the URL
> above (ci-upstream-kasan-gce-selinux-root, 2025-05-29). I have not
> yet reproduced it independently — my own reproducer (see section 2)
> has not reliably triggered the race in my environment. The syzbot
> crash is the authoritative record; I include it here for convenience.
> Trimmed for relevance:

Hm, that bug from syzbot reference has been fixed already via:

   a0671125d4f5 ("clsact: Fix use-after-free in init/destroy rollback asymmetry")

Also your report and the syzkaller one are not the same crash. What's more
your trace below has tcf_block_playback_keep_dst+0x1e1/0x320 net/sched/cls_api.c:1416.
There is no such function.. checking on the lists:

   https://lore.kernel.org/all/?q=tcf_block_playback_keep_dst

   (counter example: https://lore.kernel.org/all/?q=tcf_block_owner_netif_keep_dst)

This is not an upstream kernel ?

> ==================================================================
> BUG: KASAN: slab-use-after-free in mini_qdisc_pair_swap+0x1a4/0x220
> net/sched/sch_generic.c:1564
> Read of size 8 at addr ffff8881072a3018 by task syz-executor.0/4823
> 
> CPU: 2 PID: 4823 Comm: syz-executor.0 Not tainted 6.9.0-rc4 #1
> Call Trace:
> <TASK>
> dump_stack_lvl+0x82/0xd0 lib/dump_stack.c:117
> print_report+0xcf/0x650 mm/kasan/report.c:488
> kasan_report+0xb5/0xe0 mm/kasan/report.c:601
> mini_qdisc_pair_swap+0x1a4/0x220 net/sched/sch_generic.c:1564
> tcf_chain0_head_change.isra.0+0xb5/0x120 net/sched/cls_api.c:380
> tcf_chain_head_change_item net/sched/cls_api.c:402 [inline]
> tcf_block_playback_keep_dst+0x1e1/0x320 net/sched/cls_api.c:1416
> tcf_block_get_ext+0x4cd/0x9a0 net/sched/cls_api.c:1500
> clsact_init+0x10a/0x1c0 net/sched/sch_ingress.c:296
> qdisc_create+0x712/0x1170 net/sched/sch_api.c:1334
> tc_modify_qdisc+0x4f8/0x1a30 net/sched/sch_api.c:1714
> rtnetlink_rcv_msg+0x424/0xe30 net/core/rtnetlink.c:6594
> netlink_rcv_skb+0x16e/0x440 net/netlink/af_netlink.c:2543
> netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
> netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1367
> netlink_sendmsg+0x93b/0xe60 net/netlink/af_netlink.c:1908
> ____sys_sendmsg+0x71e/0x960 net/socket.c:2638
> ___sys_sendmsg+0x110/0x1b0 net/socket.c:2692
> __sys_sendmsg+0xfc/0x1e0 net/socket.c:2721
> do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Allocated by task 4821:
> kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
> __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:392
> qdisc_alloc+0xb0/0x8c0 net/sched/sch_generic.c:944
> qdisc_create_dflt+0x71/0x230 net/sched/sch_generic.c:991
> attach_default_qdiscs net/sched/sch_generic.c:1212 [inline]
> dev_activate+0x4c0/0x870 net/sched/sch_generic.c:1271
> 
> Freed by task 4823:
> kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
> kasan_save_free_info+0x40/0x60 mm/kasan/generic.c:579
> __kasan_slab_free+0x37/0x60 mm/kasan/common.c:240
> kfree+0x153/0x3b0 mm/slub.c:4435
> qdisc_free+0x97/0xf0 net/sched/sch_generic.c:1063
> qdisc_destroy+0x10f/0x180 net/sched/sch_generic.c:1080
> qdisc_put+0xc9/0xe0 net/sched/sch_generic.c:1098
> dev_shutdown+0x1ae/0x340 net/sched/sch_generic.c:1493
> 
> The buggy address belongs to the object at ffff8881072a3000
> which belongs to the cache kmalloc-1k of size 1024
> ==================================================================
> 
> Race window is between the qdisc_put() path in dev_shutdown() on the
> parent netns teardown and the clsact_init() that runs when a second
> task installs clsact on a sibling device whose miniq pair was just
> freed but not yet detached from the chain0 head-change list. Frees the
> qdisc, then mini_qdisc_pair_swap() dereferences miniqp->p_miniq.
> 
> 2) Standalone C reproducer
> -----------------------------------------------------------------------
> Attached as repro_v2.c (also pasted below). Build with:
> 
> gcc -O2 -static -o repro repro_v2.c
> 
> Run as a normal user — it sets up its own user+net namespace via
> unshare(CLONE_NEWUSER | CLONE_NEWNET) and does not need CAP_NET_ADMIN
> on the host. It spins a producer thread creating veth pairs + clsact
> and a consumer thread creating/destroying dummy interfaces to force
> kmalloc-1k reuse. The repro tails /dev/kmsg looking for "KASAN" and
> exits 1 on first hit. Note: I have not yet reliably triggered the
> crash with this reproducer — the heap layout needed is specific and
> the race window is narrow. It is provided as a starting point; you
> may need to adjust thread counts or scheduling to hit the window.
> 
> Caveats:
> - Needs unprivileged user namespaces enabled
> (kernel.unprivileged_userns_clone=1 / sysctl
> user.max_user_namespaces > 0). syzbot's image has both.
> - Needs CONFIG_VETH, CONFIG_DUMMY, CONFIG_NET_SCH_INGRESS,
> CONFIG_NET_CLS_ACT.
> - Single-CPU VMs widen the race significantly if you pin both
> threads to the same CPU; taskset -c 0 ./repro is the fastest
> trigger I found.
> 
> Happy to test any candidate fix you have in mind — my guess is the
> chain0 head-change list needs to be drained under the same lock that
> swaps miniqp->p_miniq, but you know that subsystem better than I do.
> 
> Thanks,
> boz
> 
> On Wed, Jun 3, 2026 at 12:13 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Hi boz,
>>
>> On 6/2/26 9:47 PM, boz baba wrote:
>>> Hello netdev maintainers,
>>>
>>> I would like to report a slab-out-of-bounds write reachable through
>>> mini_qdisc_pair_swap() during clsact/ingress qdisc teardown, and to
>>> propose a fix grounded in an analysis of the actual object lifetimes
>>> involved. A first cut at this report suggested a check of the form
>>> "miniq_old == &miniqp->miniq1 || miniq_old == &miniqp->miniq2" inside
>>> mini_qdisc_pair_swap(); on closer reading of the code that check is
>>> incorrect, and the fix belongs in the teardown path instead. Details
>>> below.
>>>
>>> Bug
>>> ---
>>> KASAN: slab-out-of-bounds Write in mini_qdisc_pair_swap
>>>
>>> File:     net/sched/sch_generic.c
>>> Function: mini_qdisc_pair_swap()
>> [...]
>>
>> Do you have the actual KASAN splat + a standalone C reproducer I can
>> try myself that triggers the former?
>>
>> Thanks,
>> Daniel


