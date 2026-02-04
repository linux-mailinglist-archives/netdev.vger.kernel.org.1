Return-Path: <netdev+bounces-256882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP+6G6LWg2lbuwMAu9opvQ
	(envelope-from <netdev+bounces-256882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:30:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A1ED473
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F6F3046524
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1039E6DE;
	Wed,  4 Feb 2026 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iiTlPlAf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63242AA9;
	Wed,  4 Feb 2026 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247566; cv=none; b=ebdUXhvAnjz34TyAUud6GOCcUHxjK+nhr8V75lTMYCX5QcQ/7kAuDstpQJ4H2VbV1SkQxHqlPsF8a+WPrzLWWodIbWto3x0bfSVkbzJg/kV2KhobBq+ygD6WEwQ0MW8tVcmw7fINDuhhRmngn2GBS5M1iYhnjVx+CtAzF1e2MGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247566; c=relaxed/simple;
	bh=23SS+XtT7lCt1kn5I7DiJKgm3ihSY8Qpfz4e1qL4HGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUNSnh22CUpYay01QUXnhC9kQh9WwO2V+PgA5mzLuDoCDRhOnUANDNBP0kmAm1lwrFCBOTm+mrpF6Ce1RnR14yMaIcTrIe0QQuLK+3k8+3d8CX064E2cYZA8QnYaeLJZRzV6EIRF2ib2+MzwYvFvyeoTH3sVV3E/4tVQdSVH+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iiTlPlAf; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vnmFr-002wHc-Pz; Thu, 05 Feb 2026 00:25:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=tjwzzeP9KZHnpW8GEpbcDG3lqJQmyCrrTFz9XMbkVeY=; b=iiTlPlAf5cIAY0JSJZ7K6+iZQn
	Ncrinc+MGsoB/P9YemVfVfyAry/WMimsC68YKMWs/aLpGf7qMRxdaq89fOh4WmaPFkHYxLI5FzB/t
	iA7RMuPJ7QJcslw/mO8BcC1FzIuu1D0KipsDsMQb/DLbU73U/BfzWZPK+rjOk0gHXSh8C6mLvyflA
	Awp6mkZQFCgBOd3sNoLm2PpwJsxIX4GDSKlvs/LpfB2Fl/vTTncfovFdum9il0uf8fxl7+ncirYIg
	i6R9ByRXbIgkdBroN63Uh44IlmqsZlKpQDG0zV5khz1q5Vg//93KXB8fQvYuJvlO0QhTt+NkDOu0Z
	g6YH2h9Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vnmFq-0003kJ-Qk; Thu, 05 Feb 2026 00:25:50 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vnmFg-003ETh-S0; Thu, 05 Feb 2026 00:25:41 +0100
Message-ID: <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
Date: Thu, 5 Feb 2026 00:25:39 +0100
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
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
 <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
 <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:mid,rbox.co:dkim]
X-Rspamd-Queue-Id: 1B7A1ED473
X-Rspamd-Action: no action

On 2/4/26 20:34, Martin KaFai Lau wrote:
>> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
>> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
>> right, we can crash at many fentries.
>>
>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
>> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
>> Call Trace:
>>   dump_stack_lvl+0x5d/0x80
>>   print_report+0x170/0x4f3
>>   kasan_report+0xe1/0x180
>>   bpf_skc_to_unix_sock+0xa4/0xb0
>>   bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>>   bpf_trampoline_6442564662+0x47/0xab
>>   unix_shutdown+0x9/0x880
>>   __sys_shutdown+0xe1/0x160
>>   __x64_sys_shutdown+0x52/0x90
>>   do_syscall_64+0x6b/0x3a0
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This probably is the first case where reading a sk pointer requires a 
> lock. I think it will need to be marked as PTR_UNTRUSTED in the verifier 
> for the unix->peer access, so that it cannot be passed to a helper. 
> There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted one now.

What about 'fexit/sk_common_release' that does 'bpf_skc_to_unix_sock(sk)'.
Is this something the verifies is supposed to handle?

$ python -c 'from socket import *; socket(AF_INET, SOCK_DGRAM)'

BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
Read of size 1 at addr ffff888128312112 by task python/4076
Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_report+0x170/0x4f3
 kasan_report+0xe1/0x180
 bpf_skc_to_unix_sock+0x95/0xb0
 bpf_prog_70a8d38bd5dbf399_release_exit+0x87/0x8b
 bpf_trampoline_6442556594+0x64/0xd3
 inet_release+0x104/0x230
 __sock_release+0xb0/0x270
 sock_close+0x18/0x20
 __fput+0x36e/0xac0
 fput_close_sync+0xe5/0x1a0
 __x64_sys_close+0x7d/0xd0
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e


