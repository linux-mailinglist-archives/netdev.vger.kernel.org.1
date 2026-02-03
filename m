Return-Path: <netdev+bounces-256226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fo1OVLHgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:00:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00FD73B0
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 388A83063F61
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC547395DB7;
	Tue,  3 Feb 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="M7R7wWMr"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45988312805;
	Tue,  3 Feb 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112685; cv=none; b=VdrQrp5PoLmwpci9fA7ejMQKhgziTe8tAA9K+bG18N4OC9BhDMx/JENu46hWQRwiiHLucTI4i1cIhCUaf4R5b4HfjdLupX/e1RTfYJhaJ3sHaIp0R4Ljp1B/VMt6MRi9WkHoa8jL9yjZBebSnWZ1hwmzTfAvN9SQX88Hvu4Kt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112685; c=relaxed/simple;
	bh=qG5WW1NRpxJBrmekKQ9D5nzRgBn/+vBoWOrdgIPVTwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTNpHVUFbBIobaVmn+0Vig+iJEb/tR1y4xgShHRWNfgZDvqXH3ZqutqB3GJboeZ+9p6atjbopshe+Y1HCJJThL86F8zMQK2ZvbNYuReg41OTLLqR4v1UodeQc0GbzRpf8Hl+ueyNFk4g3UAmUTJpVY5Y5bHV7MNGKwQSFtcs8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=M7R7wWMr; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vnDAR-00EX1u-Dt; Tue, 03 Feb 2026 10:57:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=iMfpMkidXJnlb6QlaNpWnVaPHLTtMwpknzZdeH49YR8=; b=M7R7wWMrYcZ7ZgsHV1TuA/Iebu
	wtd+weKCj4FMW6zJNZENhaYwFqrNRvXGB1CHbmcpEr6ARbNYhRFe+d4yjXeylczwnhkaJTb+dcngk
	lsF/aro5CuYCWKItTKnjTAIExp1vprEo37Ze9dJh4MRlb/YSM0YatKgiWax1rQBe/uxH1CUoeOQ5Q
	xNCmBxfgSGkRlKbIhb31xXRePaeUnYbCVQ92CfHdMCMjW3apNR9BwjBrRexVhnn/Z1DmjTgobwV4m
	X56mK9q38Q2ZXYKg+SMofpA22t1dqTr4YF+V9LCvDr7Dz5UuWGT7q+tH1TrcggQ6bsBkXT/tKaraB
	uKRf57GQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vnDAQ-00013V-D9; Tue, 03 Feb 2026 10:57:54 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vnDAJ-00G0EU-NP; Tue, 03 Feb 2026 10:57:47 +0100
Message-ID: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
Date: Tue, 3 Feb 2026 10:57:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
 <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
 <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
 <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
 <b98a40e8-1be2-47f0-8238-92dee8f5a204@rbox.co>
 <6de6f1bf-c8ee-4dfb-9b8c-f89185946630@linux.dev>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <6de6f1bf-c8ee-4dfb-9b8c-f89185946630@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256226-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:mid,rbox.co:dkim]
X-Rspamd-Queue-Id: CE00FD73B0
X-Rspamd-Action: no action

On 2/3/26 04:53, Martin KaFai Lau wrote:
> On 2/2/26 7:10 AM, Michal Luczaj wrote:
>> In related news, looks like bpf_iter_unix_seq_show() is missing
>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
>> bpf iterator can grab unix_sock::peer as it is being released.
> 
> If the concern is the bpf iterator prog may use a released unix_peer(sk) 
> pointer, it should be fine. The unix_peer(sk) pointer is not a trusted 
> pointer to the bpf prog, so nothing bad will happen other than 
> potentially reading incorrect values.

But if the prog passes a released peer pointer to a bpf helper:

BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
Read of size 1 at addr ffff888110654c92 by task test_progs/1936
Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_report+0x170/0x4f3
 kasan_report+0xe1/0x180
 bpf_skc_to_unix_sock+0x95/0xb0
 bpf_prog_382743e45576abd5_dump_unix+0x4a0/0x576
 bpf_iter_run_prog+0x5b9/0xb00
 bpf_iter_unix_seq_show+0x1f7/0x2e0
 bpf_seq_read+0x42c/0x10d0
 vfs_read+0x171/0xb20
 ksys_read+0xff/0x200
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Allocated by task 1941:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x63/0x80
 kmem_cache_alloc_noprof+0x1f7/0x6f0
 sk_prot_alloc+0x59/0x210
 sk_alloc+0x34/0x470
 unix_create1+0x86/0x8a0
 unix_create+0xd4/0x2d0
 __sock_create+0x243/0x5a0
 __sys_socket+0x119/0x1d0
 __x64_sys_socket+0x72/0xd0
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 1941:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x70
 __kasan_slab_free+0x47/0x70
 kmem_cache_free+0x12c/0x5d0
 __sk_destruct+0x432/0x6e0
 unix_release_sock+0x9b3/0xf60
 unix_release_sock+0x99f/0xf60
 unix_release+0x8a/0xf0
 __sock_release+0xb0/0x270
 sock_close+0x18/0x20
 __fput+0x36e/0xac0
 fput_close_sync+0xe5/0x1a0
 __x64_sys_close+0x7d/0xd0
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e


