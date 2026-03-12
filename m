Return-Path: <netdev+bounces-267127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMquDkbdsmmtQQAAu9opvQ
	(envelope-from <netdev+bounces-267127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:35:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F927497E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1BEF31C8B8D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2E3C8723;
	Thu, 12 Mar 2026 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DI4qhVFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4338657D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329415; cv=pass; b=CweZvK+LRK4yY4Tt95WuPYRVxRyG+De/cdfaaICs2RRyN49kmRVQ4y6iJNqacf0uQuYzcOyEuVGFGWD+i8/DWwJQPGnurqpljHG3hnHhTTsmx5H+blnpA1DZBjtvJDy+tX5KIIH0t54akUXAetSe0xaLtBDRxmboPbVw0EakbWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329415; c=relaxed/simple;
	bh=4FFIjaXlX6+bQYLzBy6OE5Cc0eCGpALweVNKve2VDLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmMr6UeJAVA5ilNg01dO0M1eONypdnXUAM3dJl/Tednvn5ylqouMX8XTFV/HzMTUin7SicE/eu/u+WtdpOIIYdrWve+SUgJbYFHLEOBNd0CtI+H2gl4vAuJwWziN7HA0RCJVi7gXDOm4EwwMOuOkW48q58bUT2CS7s3XJK7Ls+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DI4qhVFD; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79860421382so10798187b3.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329413; cv=none;
        d=google.com; s=arc-20240605;
        b=SjRtVOLusvUiBQmAFtlQeQgltsWF2XJfmpiYJKyPHpFjygsHSPWzf+sG+qaf+PxpSw
         HFIs1PU3xln9heTMZGfRHbFvuJq9Y52E/btWHtLsxManxE6EOLoPYSQ4SeUwGsuOOCF6
         E1HCA1U7dm89DjyyXxw02iG2CRAF6x33n6skr28U1Hg65OuNSpuYef4tyDd4+F5jLouK
         AU302e9DGkAuV85AwGPNHpwwy0VdoixlfR8aAhhYl1QO0m42U/QALSHM5mTiIxMadX/d
         DD741zTsRJUxWrhNScv5BC0szYyp8WDrXGFV5fcTc6MJORWHRjvb35fd3TqI9v2pdrmv
         /hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GIvvx4vblV9mlkVR80fqtOluWeOvaTz7lKEtkM21LxA=;
        fh=ONBY+cUF/hTKyZHokz5Rl6ehGnzPMPVV5YIqtvbx4O4=;
        b=dPChT5HBUkC026mjNAIZrJcCMPQFpRD/sxL+hMrMNGmt++PThuhgFBoNJ2CpGZn59K
         GdFEIY+QL4KTj9CYxJ4bWMGVia2YM8/FwHc2+wRHraIFLObB1n9Ew5EXsb6kjlc35Tbv
         4Rako/b3P865bNq1f9WQLEtutIxRnMsNKL0ycHnYj59/Ur6IG6HWJ0oBHMzN6rUIAgTy
         /s9NwruxPa318tmX+Trd1IG8G6UBCPJ5aBlCtXbtUGq66oUv9zMl07Wd8b7WG1BnBDyv
         1QZ6YU4ZQ380UdvWZ26AwkrQpCucysDereJq08TkPJ3LXg4LxQCHSMqDprrmKLxPSpgN
         o+DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773329413; x=1773934213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIvvx4vblV9mlkVR80fqtOluWeOvaTz7lKEtkM21LxA=;
        b=DI4qhVFDp0EpZV0Ob3JQgbEWTpBu2cjVn0BV96YlOcl2/fBgkF8k9XXBiHZbjCahXW
         pAA8z3MvkSsB4PggBG9Ncv4dD1bPNlGPK4IlN0ZFzhon63+62e+NAKJys5DJ6jYy3MP5
         w8PPfQB2PJiprqx/5JxspRlm+KEnt9gfidvXfEJCRhthhOXP19e4lgvYpJ+HOgFX/4lV
         aoWT9rXXHmBX8A1Oq8c97RfCOzSLVj1CL4WpuZjUNZFfOJJdEQqERf77Ajpu1K/lbS+w
         RBFQQcW7cIfCrpOR2XNCP0YsrYX6IPldlXnth2GOVWO6Doku2EVqjikdkqACX89drEtW
         NtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329413; x=1773934213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIvvx4vblV9mlkVR80fqtOluWeOvaTz7lKEtkM21LxA=;
        b=kIa/V4cMq2/4VwlUqaTSIcOxjnfUzQ0livtSo2kUVKTmhfh1GYRkKfN5zSAKMsiazP
         RFU5EA1NLlEj9OYenJb0h8gtynxtQlCWiiuauWxoaFPiSjeGzLHk4fLbOKFVg6f2Cr8F
         zI3qEYe05zCXTTnMqGRPoL3qYsImSdPvEIfngt67isIlY3Ow+WF8QgalWeUTQw2SdvuP
         KkuTFnMhqNbs2Gzzh5TcJMbsmr5ohxNHHSyVHgpHIlf6U1fFX3AYmiw5fdlGvjeXusJw
         E/xZAFDpvXr/egv5sW1ZsYBuhxpM+YXlj5dQVyv7d55qRpDnQJcoduoJSI+LaLe5zZra
         Rnww==
X-Forwarded-Encrypted: i=1; AJvYcCXddmVUgPJJyjuooPp7FkoGyELqvKg2zAKpS7agi7HukkPUXWyTQHFfUp6ZkWB0zeO6TdOg27o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQbM5QMXELj7zaH3Ko06ewPnJUy+15aa6lSa00c1QYEfO8DxO
	gmcx+x6LJR6elG/4ZpksiCx1Jp11WL4Xbz/tntr7YMk22ZWoiooHm8VE9FH0O+a9XO1SxZoKD+T
	rW0ZTzUW/545kY3NGTis8FB9CrrygwVj+M31gocMG
X-Gm-Gg: ATEYQzyx2ZCeqxOiSYa/2e+0uR+hxluAobrkYkkJ/IaLeOXrpWHSi06K3vw0R1kJa5d
	Ay3agcgxRKdINt99vBg7QDt6RsjZ4ICjhFaQ6HIvn17Lr1FTCaFA30Z30GWOOx8SZD7EAS8G/E/
	7+Z02Jd+NqVJS/VClRWyQr6UP+YAhjpQS/K+9Nv7bRoH/v9ujbS5f6EiNEbQyUtbKwovwQUnggB
	Z0XNEqEPFKKzEqemlyQyAL2LDmWkJGCuffvnICOH4k71GsRmRBYtFrrycb7LRJWI4ExXKoIB8yg
	yErJW1sNDk1MtgQbQG0=
X-Received: by 2002:a05:690c:64c9:b0:796:3787:39b2 with SMTP id
 00721157ae682-79917f73800mr58932447b3.30.1773329412298; Thu, 12 Mar 2026
 08:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69b2db28.a00a0220.94e15.0025.GAE@google.com>
In-Reply-To: <69b2db28.a00a0220.94e15.0025.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 16:30:00 +0100
X-Gm-Features: AaiRm51fGABsfDdY5quTkhqtp5-dPMxuhEOC90Ic-0GrhJjV69j62kAYNbgwkgc
Message-ID: <CANn89iJLC9p+N=Rqtuj7ZuPRdpSGCATCtZdz1Vi9mbzf3ATekQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] KCSAN: data-race in pfifo_fast_dequeue /
 pfifo_fast_enqueue (6)
To: syzbot <syzbot+b44f2bbe286b9355c563@syzkaller.appspotmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: davem@davemloft.net, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ec543385a37b9f17];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267127-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,googlegroups.com:email,mail.gmail.com:mid,appspotmail.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,b44f2bbe286b9355c563];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 8C8F927497E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 4:26=E2=80=AFPM syzbot
<syzbot+b44f2bbe286b9355c563@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1244fa5258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dec543385a37b9=
f17
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db44f2bbe286b935=
5c563
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5c78f22cfb6c/dis=
k-37a93dd5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/77c2f419bced/vmlinu=
x-37a93dd5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5640d838c887/b=
zImage-37a93dd5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b44f2bbe286b9355c563@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue
>
> write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
>  __ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
>  __ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
>  __ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
>  __skb_array_consume include/linux/skb_array.h:98 [inline]
>  pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
>  dequeue_skb net/sched/sch_generic.c:297 [inline]
>  qdisc_restart net/sched/sch_generic.c:402 [inline]
>  __qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
>  qdisc_run include/net/pkt_sched.h:120 [inline]
>  net_tx_action+0x379/0x590 net/core/dev.c:5793
>  handle_softirqs+0xb9/0x280 kernel/softirq.c:622
>  do_softirq+0x45/0x60 kernel/softirq.c:523
>  __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
>  bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
>  bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
>  __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
>  __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
>  __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
>  x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:=
322
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
>  __ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
>  ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
>  skb_array_produce include/linux/skb_array.h:44 [inline]
>  pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
>  dev_qdisc_enqueue net/core/dev.c:4144 [inline]
>  __dev_xmit_skb net/core/dev.c:4188 [inline]
>  __dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
>  dev_queue_xmit include/linux/netdevice.h:3384 [inline]
>  __bpf_tx_skb net/core/filter.c:2153 [inline]
>  __bpf_redirect_common net/core/filter.c:2197 [inline]
>  __bpf_redirect+0x862/0x990 net/core/filter.c:2204
>  ____bpf_clone_redirect net/core/filter.c:2487 [inline]
>  bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
>  bpf_prog_53f18857bc887b09+0x22/0x2a
>  bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
>  __bpf_prog_run include/linux/filter.h:723 [inline]
>  bpf_prog_run include/linux/filter.h:730 [inline]
>  bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
>  bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
>  bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
>  __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
>  __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
>  __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
>  x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:=
322
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff888104a93a00 -> 0x0000000000000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G        W           s=
yzkaller #0 PREEMPT(full)
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/24/2026
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

CC Michael for this KCSAN report.

I suggested

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 534531807d95d0d2a9aa1afea918bfce49a67b32..21b49c55cfcf82ddfcb5df98e32=
4dd12c47f9a9d
100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -103,7 +103,7 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-       if (unlikely(!r->size) || r->queue[r->producer])
+       if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
                return -ENOSPC;

        /* Make sure the pointer we are storing points to a valid data. */
@@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
 static inline bool __ptr_ring_empty(struct ptr_ring *r)
 {
        if (likely(r->size))
-               return !r->queue[READ_ONCE(r->consumer_head)];
+               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
        return true;
 }

@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
ptr_ring *r, int consumer_head)
         * besides the first one until we write out all entries.
         */
        while (likely(head > r->consumer_tail))
-               r->queue[--head] =3D NULL;
+               WRITE_ONCE(r->queue[--head], NULL);

        r->consumer_tail =3D consumer_head;
 }

