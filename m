Return-Path: <netdev+bounces-282991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ/6DxnD82mw6gEAu9opvQ
	(envelope-from <netdev+bounces-282991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F35664A7FA5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DB7230066B3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C3A37B40C;
	Thu, 30 Apr 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HU9w2p+W"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6129CE1;
	Thu, 30 Apr 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582871; cv=none; b=t+gnwwbIcd/mcBTV90bcQDRudn2m9GzQ10LOsnvGA7/nTcbmQ3QeL0cRBnGc6V4XMwk8pQEIeGumnzeaNaz2EEvY2mkHZh+cJAcIOeel+MmLcOlsGruc6nUGUqEspH485xV4TTg4C89XT7Q/EeeZaVrNGx9RtxEd1ok3naM1MHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582871; c=relaxed/simple;
	bh=+z9FQaVXJ2Okb/XwK9/H1gWDAQjlyC23w3vbqkdClS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqi+qfs6NxEkXUY6yIaM4A8BXzEARJ22C5zdcgJwuCYL6wJDK6rt3kehQ7lScsLSAeHhUz4pDY063FYIjrOm0aHDCIACAsEFl1C6tX4mdUsoG2fKT1DniJBkDO7Z0jGx4XtbMUBVs3hU4WnC9rTRoPNRBnERfK6WLGDhmKUvxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HU9w2p+W; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TsBQHE+KItiTEMUqUkDd6inEHQTMmXP6hOUnVC7fjzE=; b=HU9w2p+WM+2k+Ksv0+9rOHVzo5
	X9jfYuz3Bv8aVYa6SJOzqxTWU3F8bhch7qpIiGy1yxNcuhcw/V43iG6VcRbadlS3iR220EJKrBvY6
	OkMpp6jDevGwypRCRYp4sWyI6yAEdp7RmOErLnTtDrAwk08ue9xZSgWmiYmPyZtNMVcrzguGuLJ9e
	UNfHfdAU48OTpKP3MDeU4rz69wkCJGfvjq7dJlugaTk7BfgC57vt4IxIs25RTxapg3ADNsuJAYjrt
	lCUo7C29NqJ6H99vdpd+Ho7W7E4pv9d6V4lD95CGL/8Ge+wjH6aBCOQQ5+yzhsSGpLf12Lka0iaSj
	/42ic4Qg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wIYVH-00098H-2P;
	Thu, 30 Apr 2026 23:00:59 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wIYVH-000A2r-0e;
	Thu, 30 Apr 2026 23:00:58 +0200
Message-ID: <8570431a-38c0-49ab-8022-32ce59d5999b@iogearbox.net>
Date: Thu, 30 Apr 2026 23:00:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf 1/2] bpf: tcp: Fix type confusion in
 bpf_tcp_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Damiano Melotti <melotti@google.com>
References: <20260430184405.1227386-1-kuniyu@google.com>
 <20260430184405.1227386-2-kuniyu@google.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260430184405.1227386-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27987/Thu Apr 30 08:25:46 2026)
X-Rspamd-Queue-Id: F35664A7FA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,linux.dev,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/30/26 8:43 PM, Kuniyuki Iwashima wrote:
> bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
> but RAW socket can bypass it:
> 
>    socket(AF_INET, SOCK_RAW, IPPROTO_TCP)
> 
> Calling bpf_setsockopt() in SOCKOPT prog triggers out-of-bounds
> access to another slab object. [0]
> 
> Let's use sk_is_tcp().
> 
> [0]:
> BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt (net/core/filter.c:5519)
> Read of size 8 at addr ffff88801083d760 by task test_progs/1259
> 
> CPU: 1 UID: 0 PID: 1259 Comm: test_progs Tainted: G           OE       7.0.0-11175-gb5c111f4967b #1 PREEMPT(full)
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
>   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
>   kasan_report (mm/kasan/report.c:595)
>   sol_tcp_sockopt (net/core/filter.c:5519)
>   __bpf_getsockopt (net/core/filter.c:5633)
>   bpf_sk_getsockopt (net/core/filter.c:5654)
>   bpf_prog_629ba00a1601e9f2__setsockopt+0x86/0x22c
>   __cgroup_bpf_run_filter_setsockopt (./include/linux/bpf.h:1402 ./include/linux/filter.h:722 ./include/linux/filter.h:729 kernel/bpf/cgroup.c:81 kernel/bpf/cgroup.c:2026)
>   do_sock_setsockopt (net/socket.c:2363)
>   __x64_sys_setsockopt (net/socket.c:2406)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> RIP: 0033:0x7f85f82fe7de
> Code: 55 48 63 c9 48 63 ff 45 89 c9 48 89 e5 48 83 ec 08 6a 2c e8 34 69 f7 ff c9 c3 66 90 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 e1
> RSP: 002b:00007ffe59dcecd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f85f82fe7de
> RDX: 000000000000001c RSI: 0000000000000006 RDI: 000000000000000d
> RBP: 00007ffe59dcef20 R08: 000000000000003c R09: 0000000000000000
> R10: 00007ffe59dcef00 R11: 0000000000000202 R12: 00007ffe59dcf268
> R13: 0000000000000003 R14: 00007f85f9da5000 R15: 000055b2f3201400
>   </TASK>
> 
> The buggy address belongs to the object at ffff88801083d280
>   which belongs to the cache RAW of size 1792
> The buggy address is located 1248 bytes inside of
>   allocated 1792-byte region [ffff88801083d280, ffff88801083d980)
> 
> Fixes: 655a51e536c0 ("bpf: Add struct bpf_tcp_sock and BPF_FUNC_tcp_sock")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
First one lgtm:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks!

