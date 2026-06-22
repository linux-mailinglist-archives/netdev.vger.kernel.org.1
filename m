Return-Path: <netdev+bounces-301096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gGd3DqIrOWqCnwcAu9opvQ
	(envelope-from <netdev+bounces-301096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 920426AF774
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZKbfXwqT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301096-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301096-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE4330071DD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1223A9DAB;
	Mon, 22 Jun 2026 12:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C23A75A3
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:33:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131602; cv=pass; b=GKYZsteAFayWilFUXeESQIdDkWj8aIa0fZkmL70AE8b+xNyo5K8m1J1y8Px7zguSaiyRFs5NuwoxQISGLedFQjVpgKeTtaVRj891xWaMAeJjsCzQV+zqIC/MS/7Ij0XvMlChbp8HGsLpar8gV9AFCdmPMlwUwKcbdMXA3afQhJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131602; c=relaxed/simple;
	bh=8vDes+e7/1V7VR8Nz218XUkz8Pq+TNyxUOlsiUiLAs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjJaUEsKf8zyS5hSEKoWB9JgtyD4+15JowT5iDYg1GSRAHEJdUoR5KwFN0zNl9dV+sOsz5/HpPHakJv/Gz1uBuZVTcAi2xXgOKmJB3N1kodMhequHfvLdNYEmdr01ynLeGd+Rvtx/4qKg8uOCy0B7DjulIy778+IqCgFSfwLGAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKbfXwqT; arc=pass smtp.client-ip=209.85.219.67
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8e066990ff9so21935036d6.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782131600; cv=none;
        d=google.com; s=arc-20240605;
        b=lpIGJKx4hlKBWqU+Fb5H+aCeDHdedhyTF9cE/lLPyC1hykqiU5g/S8S2KJAKKl0EP4
         WgVn/B3cm7AAWh40GOf902LCXY2xaCBXLqNtGTBesamfypfC/bQo6mw/Wr2Ydmalzr56
         IVcLUukRWGSaClliXRPrm2Hin7mmFBcQdgPPGvkzgQSS+4vVdGoiBo6cc8tBSAmTsKVr
         LG1lKNyEeyV+R8ncjtU7lnRRhKoXXxg6dLG6gvvX+uLvtez7RURhRaGkiwA55ZbK44PA
         qCLwIu0r5eCaPCvYvQF+zqgyYYPSVI+Pdsge+SwnAq95ksK0dRuTk4KpSQ3gTKNzSFCF
         yyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmRvukfSJvgUJLvig9hb0giMVedRKpfKlkMKmCdzG6E=;
        fh=s19bV8nnADrhwZlb8cY60mIIGLmAFKXkU60plN/9Q/0=;
        b=FcOm2gTSeWgmG3NRLVlTXbtFwp21KnH2j/vihy55rA8WLQ/EgQ1/JVOQOLWRAzQdou
         Y/jeq3DHTfa8WDljnc/qndAI5t8zf9Ba5evvJNnDXEvzgBMncU8G4JT3DNLn0QtLVmcd
         nJ5brjRSqTcdvrduwzeI0mhxX8N/BHWK50JeaUM2QXVxYOjlDYcIzLQeyap3P/vfMmKG
         YgGwkF7dAzuYt3tgYXsIGD7aQXM21CJYRC78ckss2aSam8wbsFlpceHJfmnw/V51NBsb
         ybSLALl0FZ/hW+9M4dfAsU27b0WEb6Pbce4rAaTRLbfVCwblSaI343T27JmeEImVK809
         +wew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782131600; x=1782736400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmRvukfSJvgUJLvig9hb0giMVedRKpfKlkMKmCdzG6E=;
        b=ZKbfXwqTfYWeJ4Dy3ATCTWY/wwV5z039Fhx6AehOHXE3JCsY2Y+mXtU8OG/bGeXJbc
         /5r7F1202BR/EY2sNMqOnza5QSmHubVQaLMd11gCon7Q6OlXUsm7n+YuLEWlOz0tvN5v
         HCte8XwVFAVBg2V+Gd3kjghUNDLnRoU9RNqmB4YyADlxXQ3OhWSiRSfWbxrMOHosnH1E
         fFnSyhk/tKTatNaYcRFbe3iiNbiL1cudV7ASV8oK++4YnktG0Y7jlwdg0H0KUvu7iPgp
         yUV8dSo9DxqcnZJoK+lp68y7MrHleEX6H43pIjUGjrgrYEYFoQgZE7TxD3YyKh5j+NgX
         4O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782131600; x=1782736400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmRvukfSJvgUJLvig9hb0giMVedRKpfKlkMKmCdzG6E=;
        b=IozIc8PyTDqSPuNZMpBfiRGvflSjCi8wsTkxEoPfPRhxZiIzfBFlhb1mI67LP/dUyQ
         00BJQPPTLA6+/BfgI72687f+0iGD6h6e9WzuRi+CORb8thw8iJmtjrN1Y2Q7DAMWmQs0
         yGUuvCrr7j4vYizsFUABpMHVM5p4KC3PfIoqpcG/dVHhRYNIgdkMZQCtFkhaPIzQni0n
         dcm0xvFj/xbVxVSEFxg5WUN4Nx01CTBw+vSsZiIaZbBxo588XluzeMUqdQHCbgtESpvh
         i2x/E9o2J5JXJyTxYfghJTZdYHWkvm9KoRrO2+Pi9oUYHCNp63hPvJyGc5TLNKsUDL5O
         hoLw==
X-Forwarded-Encrypted: i=1; AHgh+RpImV5Aa+AYS8j2/fTa2ayr8HfwpXGSvLLhD3b+8oeYhcvkeRle+8WPyrKw75/2b7Ge0fCtNW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3DhkDh6JU+/U5iR03ZjHmqcZ3h32w5ivJPUd5HSVhsxIG1bu
	8R/9m9B6N4iVnb9mck0+3YM8gybdZBsSyR3fGfy9x+QUooEYSl4vhRQshrRUmr8rxbj8sAz6Wbx
	Dxd9GAdDbK3063vSHwZh4znUMzFOBdzc=
X-Gm-Gg: AfdE7cmi84RNOhH60aCKWzLHeDa/H4o1q4Es1fbgJL4eIRd+3NOvY7iFuUk02l7JilW
	5y/gCk0Fh5xFzq8dqTBb1oLOGHpyTHrglJiNEhqWTcC2ZeiX052qDdkp9e/Xi0Ta0vQjXETCCDp
	73TmIkzabNw1lAA44oaMTWtYVxqMTjso7gBxrf+HJyDHw/4QoaLD8yyo6Oa2on7h8EiirphN8uo
	HVeUVMQBEcSU71itAZ2S/x3nqfD3R1sIPiKrTOs6OVcA/EnzJlqK3MdX/ZxnIlbikR0J77hoQ==
X-Received: by 2002:a05:6214:2306:b0:8ca:1e84:4e79 with SMTP id
 6a1803df08f44-8de499920a7mr168892476d6.4.1782131600408; Mon, 22 Jun 2026
 05:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmyfm4j0Vy--8rpYMEY1wOP-TgmnRWYd=7ragj1Z29=F7g@mail.gmail.com>
 <aih7PqPryonzP7cI@chamomile> <CAHPqNmxbS+YLQeOLOibm5rOBxA_nciMAVuEe5ERCOs3uE6+8+Q@mail.gmail.com>
 <d26c8934-6d4c-4171-9e6f-f58a249dd9ff@linux.dev>
In-Reply-To: <d26c8934-6d4c-4171-9e6f-f58a249dd9ff@linux.dev>
From: Longxing Li <coregee2000@gmail.com>
Date: Mon, 22 Jun 2026 20:33:09 +0800
X-Gm-Features: AVVi8Cc3g-9OGtbUN98eEDlvqip_g98UCHITOr6LdAmxjZsGiv90lF7uZn7ybfU
Message-ID: <CAHPqNmz32qs57+w4kLgJvDnKqMtwi+Ca-4OUcP1SYmC3No2dwg@mail.gmail.com>
Subject: Re: [Kernel Bug] INFO: task hung in xt_find_table
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, syzkaller@googlegroups.com, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:pablo@netfilter.org,m:syzkaller@googlegroups.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[coregee2000@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 920426AF774

Hi Jiayuan,
Thanks for explaining the situation. I will double check this problem.

Best regards,
Longxing Li

Jiayuan Chen <jiayuan.chen@linux.dev> =E4=BA=8E2026=E5=B9=B46=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=89 17:26=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 6/10/26 3:14 PM, Longxing Li wrote:
> > sorry for not containing report plain text in last email. the report
> > is as follows:
> >
> > INFO: task syz-executor.4:42949 blocked for more than 143 seconds.
> >        Not tainted 7.0.6 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:syz-executor.4  state:D stack:26456 pid:42949 tgid:42937
> > ppid:9759   task_flags:0x400140 flags:0x00080002
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5298 [inline]
> >   __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
> >   __schedule_loop kernel/sched/core.c:6993 [inline]
> >   schedule+0xe7/0x3a0 kernel/sched/core.c:7008
> >   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7065
> >   __mutex_lock_common kernel/locking/mutex.c:692 [inline]
> >   __mutex_lock+0xd9e/0x1df0 kernel/locking/mutex.c:776
> >   xt_find_table+0x59/0x1a0 net/netfilter/x_tables.c:1245
> >   ip6t_unregister_table_exit+0x22/0x50 net/ipv6/netfilter/ip6_tables.c:=
1808
> >   ops_exit_list net/core/net_namespace.c:199 [inline]
> >   ops_undo_list+0x2dd/0xa50 net/core/net_namespace.c:252
> >   setup_net+0x1f3/0x3a0 net/core/net_namespace.c:462
> >   copy_net_ns+0x351/0x7c0 net/core/net_namespace.c:579
> >   create_new_namespaces+0x3f6/0xac0 kernel/nsproxy.c:130
> >   copy_namespaces+0x45c/0x580 kernel/nsproxy.c:195
> >   copy_process+0x30cc/0x76d0 kernel/fork.c:2227
> >   kernel_clone+0xea/0x8f0 kernel/fork.c:2655
> >   __do_sys_clone+0xce/0x120 kernel/fork.c:2796
> >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >   do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x471ecd
> > RSP: 002b:00007f51f163e008 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> > RAX: ffffffffffffffda RBX: 000000000059bf80 RCX: 0000000000471ecd
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040080020
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000202 R12: 000000000059bf8c
> > R13: 000000000000000b R14: 000000000059bf80 R15: 00007f51f161e000
> >   </TASK>
>
>
>
> This is not a deadlock =E2=80=94 there's no lock cycle.
>
> The runner is simply under heavy pressure on all three axes: CPU (zswap
> compression) + memory (direct reclaim) + IO (swap).
>
> The hung task is just a victim. The actual holder is another task that
> took the mutex and then fell into direct reclaim.
>
> Likely stack of the holder:
> get_entries
>    xt_find_table_lock
>    copy_entries_to_user
>      alloc_counters
>         vzalloc  -> direct reclaim
>
> "INFO: task hung" reports of this kind are common on the official
> syzkaller dashboard https://syzkaller.appspot.com/upstream/
>
>

