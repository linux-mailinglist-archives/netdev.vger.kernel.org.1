Return-Path: <netdev+bounces-300592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4OzeAhvANGqkgAYAu9opvQ
	(envelope-from <netdev+bounces-300592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49B6A3B8A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:05:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=cUqJlXk0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300592-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBFFE3038174
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 04:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F60322B72;
	Fri, 19 Jun 2026 04:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCC27703
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 04:05:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841944; cv=pass; b=QDWQ/iUvfpfXmlp4iKpNTHsZ7XmLZlapVfkFRKd3Arvvh+zLCJmzkd2FRy+rR4rsIY+nBw5VDrTYSEygutmYxPlvsw8xxsv4o53j6Bj/m+RhqAnLnYju5jKVfwC4iFCg/H9IcrbYcIkMm/8X6cOxZIzm/p6iIedy/XO6Ak7TUqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841944; c=relaxed/simple;
	bh=jbSq64Vi52fZqiuN8kvOeNTthOcGyRvN6ml18ZftJNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBz/BYfBqp/MXZOSGNLEFceov7PimGEvNkcwLm1W2yNITksvvB5RlxGPDp9ggw4RB5PN67lPHcOmh2xvAJ3h+qnals/o9jy7SsMMjixQUxJtZDcM7GUBjun6T7/UDB8zaWb8t6dQ72kDhF3DRD8PE6Lfa6aRHpY3o4+pAGSIFp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cUqJlXk0; arc=pass smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso1343051a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 21:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781841942; cv=none;
        d=google.com; s=arc-20240605;
        b=AQmJ9zKwsOinUu2chcNNuUzxmvAsKa3n3eIpHF096g6mfp4k0vluqOvyaDVuoxScIX
         zU4wphd/cmQ59F34B4sbHrB6feS+cHVRgFsapkOdoZ2cO6r6QB6m4eyTs8em3tMHgbJ/
         B+1uUvYPPd0JceT+s/T3XZcObyExSxu+3P8nn0gib2BvCdYtC3vXohQkwrNk1OfObWZO
         PN/DTazwHaw50JuN+kYSEdfSMN1ZUtMwshzT6wUtbixC1J4OSgBUs1VfvCJ07SUt9qeH
         OsHMqc/ZhWL+w47k8i0hXB/Dlj0De+ibTwb5iuzl81OSm0Oxnzt2xHbOhYiX5S/REkuA
         crzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYgSMaslaawwgoLNJYxgNcWJks9TqzbAmPvCOQdSraY=;
        fh=VWCUNOwi1fDdRDzz1OrfTT/j2AtwTtwsaxket2TG8Os=;
        b=Z6ngYd0/N4V86HB38CHGb0i5q2SnOiyx3zrWsvIJcU638OSBrdte8jENmreDkW7vfy
         D3wnkkL0lBRg7P5iKkGnt/sfGQab7SxrQiqjiA5BwyV8/JMSk6D/FdOSRk5wagbcBy16
         xu9aLzkgAkt8T+DqpsVex6glwp/Tb6MSoOH1EHr5jmiXhzuX+wh9Z6sM5b9m4I04IUud
         hXHeV8qBeeAVFGvQiUR4H9WraOVnwf91Hd0ZY9uZzJa1ECwKwJwZvcuByOyQ1xEiIxHq
         VqtZCzQwMxB1hIMcjrpAh7ToNVgmAV2VGuE8S3UnrFjhbaLIGnkDIQc+JgK3aJoL+IvW
         75wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781841942; x=1782446742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYgSMaslaawwgoLNJYxgNcWJks9TqzbAmPvCOQdSraY=;
        b=cUqJlXk06aloFhJlEx72dRRAHJ5/YZq73S05iDuPiszRVgzTU55UNblyVIlAYpqtvg
         yUb4IME5uflBPMpiH7TI9teXOOMta6OjbUftdnF12wWL4zztGcbCfopgAduTReGHIfwY
         8RrMrKzGtTmy92uor4fudBFubVTOuvcmsz8VtL0ymymAbRtQ/xyrrs6cQuJCBRMF9/5w
         pb3YbYqHILu4zivVHrU51O4iNcR7S21mG5fcn9GAcO7uEbPsf30JFpOjM3fORWcBu3DF
         ssTOamFUMHRhu/xdJMNESicl42WD7GQF8b6nQQPr0W286C+4Vnp1Yw3uA4jTh7odz6vC
         bJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781841942; x=1782446742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYgSMaslaawwgoLNJYxgNcWJks9TqzbAmPvCOQdSraY=;
        b=is+i4loEGHOXA0Nm7XxEfgkNj5mb/jEQoFtOIaEtAE87KxTjkRIOeLxPh/ISPFkpE+
         6szFUFn9YLvkps/+H0fX6Ea6AqieAM987+XO5y6QoU65Ro6hIdUYCkjOgQiUX5nAjyMy
         TJxUnNN6dA6ATlRWpiqo/kDg42cpRFlcA29MiFcqMr8PlGeHBKOyEGuBPHtMBmyCCFL2
         nPYvRjBFmAGAF06rKgbzBVIjVapH/pZcfNgKTKxmXlF/B9p81rdQqJszaX+cghu9NIZC
         NR+rKcG/SE0XFVAeaBtDC/Vsqv0IG6hu4o6WipA1nvGEujGmdsFStKZSq5k6C/969lGU
         PCLA==
X-Forwarded-Encrypted: i=1; AFNElJ/OHLgTcPI/c0ULMmrnKvTIByFXx8viF/6z3FSLWmgcshjPLhpeC7eah9eMDa/2ROC+TdApmm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVOmrJ4rVi1uy+CtwC9sCmOB3cjeZbgDSlKZfg4Kzz6FfGYmr
	tDb3N13jN4CGjoQmJ16jxbhiSYUr1t6JUqL4q6mPBsdg5f9pRs/n3FaYvRyr3Y1WcbFTQrc2fMT
	nMFg6fgUpiiiuvCZbqr4zmK0os4W6G03dnVRVukZ3
X-Gm-Gg: AfdE7cmMcnb2t4Dn41eReWaDSJ0ulAunuNGUDGsvdaacimUFzGMzedQpUfONXyAsFtP
	7b0xZZ9fNN7qwCTwgczV2GHhR/TLsmHZWJ0GXmE8l2bN1k4bYPUbyVJ+aNlR0gmkWMKZqUBxrWD
	K9g7wPJZC7Nr9luLxoUKveYLexl3KOW7f0AlG53M7YAoomDIVLt1RRB/BZRXCGGvuAasW/0IuUM
	HSmI5PZWUN0HMb6spw/aYG5mX1J109kMAYga1JOzLywzl+K5LLS8SZBdaXhtpBOB5cqu8ix
X-Received: by 2002:a17:90b:55c6:b0:36a:fcf5:64bd with SMTP id
 98e67ed59e1d1-37d1e82f06dmr1024015a91.2.1781841942088; Thu, 18 Jun 2026
 21:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617065512.2529757-2-bestswngs@gmail.com> <e8ace4ba-31cb-40d7-b288-eeb411f8d0ef@linux.dev>
 <DJBD6SGYRIHX.1IHLCVG9YYTNJ@gmail.com> <efea4e44-e9cd-444d-a648-8831f408acbf@linux.dev>
In-Reply-To: <efea4e44-e9cd-444d-a648-8831f408acbf@linux.dev>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 18 Jun 2026 21:05:31 -0700
X-Gm-Features: AVVi8CcT-bWpQ4PiH704BLqZ6BiIxPWAQH95fqGVDfh43a-ZzbGaB-koNYeRmRE
Message-ID: <CAPpSM+Qa-FySsuV4T3e1oMdOLaYn1A6uUdwGXjppL4D8dn7NWg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Weiming Shi <bestswngs@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bestswngs@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,qemu.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F49B6A3B8A

On Wed, Jun 17, 2026 at 9:09=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 6/17/26 9:38 PM, Weiming Shi wrote:
> > On Wed Jun 17, 2026 at 4:32 PM CST, Jiayuan Chen wrote:
> >> On 6/17/26 2:55 PM, Weiming Shi wrote:
> >>> accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev=
)
> >>> and dereferences idev->cnf.accept_untracked_na without a NULL check,
> >>
> >> Does ipv6_rpl_srh_rcv have same problem?
> > Hi,
> >
> > Yes, ipv6_rpl_srh_rcv() has the same missing check. It reads
> > idev->cnf.rpl_seg_enabled right after __in6_dev_get(skb->dev) with no
> > NULL check, while seg6 and ioam6 in the same file both check it.
> >
> > But I tried to trigger it and couldn't. With a guard added as an instru=
ment,
> > idev never came back NULL over tens of millions of RPL packets while
> > flapping the MTU, so I can't say it's actually reachable.
>
>
> Can you need to add mdelay to enlarge the race window to reproduce it?
>
The delay works; we insert one at

@@ -1078,6 +1079,7 @@ static enum skb_drop_reason ndisc_recv_na(struct
sk_buff *skb)
         */
        new_state =3D msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STAL=
E;
        if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
+               mdelay(100); /* AI-POC: widen race window vs
concurrent addrconf_ifdown() NULLing dev->ip6_ptr */
                if (accept_untracked_na(dev, saddr)) {
                        neigh =3D neigh_create(&nd_tbl, &msg->target, dev);
                        new_state =3D NUD_STALE;

And our poc triggers:
```
[    0.887292] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000068: 0000 [#1] SMP KASAN NOPTI
[    0.887791] KASAN: null-ptr-deref in range
[0x0000000000000340-0x0000000000000347]
[    0.888101] CPU: 1 UID: 0 PID: 146 Comm: exploit Not tainted 7.1.0+
#9 PREEMPTLAZY
[    0.888419] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/4
[    0.888880] RIP: 0010:ndisc_recv_na+0x67b/0xf30
[    0.889072] Code: 03 80 3c 02 00 0f 85 5f 07 00 00 49 8b af c0 00
00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 40 03 00 00 e
[    0.889829] RSP: 0018:ffff8881029084f8 EFLAGS: 00010202
[    0.890043] RAX: dffffc0000000000 RBX: 1ffff110205210a8 RCX: 00000000000=
00001
[    0.890340] RDX: 0000000000000068 RSI: 0000000000004d9a RDI: 00000000000=
00340
[    0.890633] RBP: 0000000000000000 R08: 0000000000000004 R09: ffff8881029=
08570
[    0.890921] R10: ffff88800ee7f792 R11: ffff888102908580 R12: ffff88800ee=
7f780
[    0.891207] R13: ffff88800ee7f778 R14: ffff88800ee7f792 R15: ffff88800f2=
d6000
[    0.891511] FS:  00007b8516aec6c0(0000) GS:ffff888177d3d000(0000)
knlGS:0000000000000000
[    0.891853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.892094] CR2: 00007b8516aebb30 CR3: 000000000f164006 CR4: 00000000007=
72ef0
[    0.892402] PKRU: 55555554
[    0.892517] Call Trace:
[    0.892627]  <IRQ>
[    0.892718]  ? stack_trace_save+0x93/0xd0
[    0.892895]  ? __pfx_ndisc_recv_na+0x10/0x10
[    0.893087]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[    0.893295]  ? stack_depot_save_flags+0x488/0x810
[    0.893506]  ? fib6_rule_lookup+0x40a/0x5a0
[    0.893689]  ? __napi_poll+0xa1/0x560
[    0.893852]  ? net_rx_action+0x401/0xd80
[    0.894025]  icmpv6_rcv+0x10a4/0x14e0
[    0.894181]  ip6_protocol_deliver_rcu+0xbd4/0x1340
[    0.894391]  ip6_input_finish+0x1d1/0x3a0
[    0.894559]  ip6_input+0x195/0x1d0
[    0.894709]  ? __pfx_ip6_input+0x10/0x10
[    0.894873]  ? __asan_memset+0x23/0x50
[    0.895034]  ip6_mc_input+0x26c/0x3a0
[    0.895188]  ipv6_rcv+0x31b/0x390
[    0.895340]  ? __pfx_ipv6_rcv+0x10/0x10
[    0.895501]  ? get_stack_info+0x2f/0x90
[    0.895665]  ? stack_access_ok+0xde/0x200
[    0.895833]  ? get_stack_info_noinstr+0x18/0x110
[    0.896036]  __netif_receive_skb_core.constprop.0+0xd78/0x2f00
[    0.896286]  ? common_startup_64+0x13e/0x151
[    0.896475]  ? common_startup_64+0x13e/0x151
[    0.896655]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[    0.896875]  ? arch_stack_walk+0x99/0x100
[    0.897049]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[    0.897310]  ? common_startup_64+0x13e/0x151
[    0.897498]  ? stack_trace_save+0x93/0xd0
[    0.897668]  ? __pfx_stack_trace_save+0x10/0x10
[    0.897855]  ? stack_depot_save_flags+0x29/0x810
[    0.898046]  ? kasan_save_stack+0x33/0x60
[    0.898213]  ? kasan_save_track+0x14/0x30
[    0.898389]  ? kasan_save_free_info+0x3b/0x60
...
```

Weiming's patch works with a delay. The poc doesn't crash the kernel.
I noticed that you mentioned ipv6_rpl_srh_rcv. We actually have sent
one, but we later found that someone (Andrea Mayer) had sent the issue
earlier, so we just let them fix it:

https://lore.kernel.org/all/20260521200859.816b8923b5f27bba6124461e@uniroma=
2.it/

Xiang
> I believe we need more precise traffic and timing control, instead of
> aggressively ramping up traffic and load in an attempt to reproduce the
> issue.
>

