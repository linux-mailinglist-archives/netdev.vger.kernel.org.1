Return-Path: <netdev+bounces-256501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEGmFJWbgmlgWwMAu9opvQ
	(envelope-from <netdev+bounces-256501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:06:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3DE04A0
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6359F30186B2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90B1236435;
	Wed,  4 Feb 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsw7AjYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B91632E7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167185; cv=pass; b=IT18bSzGohZsq5WVzz9dnQRqBTS1nehv30At+x3YiHi/Bgbz+cQwbL3uSzioaL8cvtQzd9PdWmXmyIxV7pqWY48i2fkRRfLjYsj7JMP2TvDr0o6SuYrlFxpvWfgottfq7jD8vJJqT7UzYPYatWDbR48L3Nq8qCoowPYo80EVNZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167185; c=relaxed/simple;
	bh=i1udP5JdElmv9I0wfKbC5G03xGkgFOds89EiSJKHx7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/xyR1wj9HzA9O8LQZRIugKdg8Uwjrv4IVyUnlI8/9Lyk2ecZl2562pPZvDFLt6ehcu9yxesS2XQOdvgmvfwxfwquh5OnNbag7rgZ7L4No1F8z6mmExK6V4nyZV7fnQfKHj+qVZMaeLoD0jOCia6/8LazPdnAKoFu/jVqu9FCqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsw7AjYb; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso4840099f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 17:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167183; cv=none;
        d=google.com; s=arc-20240605;
        b=aShOsj/uzPppOrQio1zQja0KPy3olDZWB1jQGn7dDhyPtpJ7758bqYIm8yL3luuzC2
         6R3ATTI22CAzgMv0rx8h4usWPrKVNE2UZT3QX09ylQ+GAbb3mhr8Uim6F2WEfVDLpGvr
         8DVeVdPb+F5Vqhox/4LcJRn5ViMMNxJ/8K6BNt4n3sjFPJsBgmaMHJHjCJBkI4TfBsvM
         ev8ju+F5VT0rhbRQJcp6d9kVmr+Or1I68I4vpTUMqWaihMfAQUV1GwDDlZZpKFPoR4kn
         TH1W0gMdUy+hmdz/ZQ9ZzsRlFkd4zDK+lohwHctB4EdoTODqpccQEO2f3XB9NOrSg0Pm
         794g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXQDI+Kc9gYbK7/144RC/v7pTj3iItN3DkjMUdjCmbo=;
        fh=ssLFU4O4VZ+9WDvluu1/ggBRoT7BxUaMZZbarTfdFcY=;
        b=R7WX51ZJMGh9t0XhYWqHllagp3JuQGECWErerrJAAb2RKAtBpflYLstp8S7hgxDUNs
         8jVhhCBX4OrJ8cWjZmI8YDPjzispojBMcmGiZRfYXwO/W8aR8MEDm9Js1jZhTgRM6/fg
         4CRlezfkCiv5xMnUM8k/HgkCjjDmsm2fMxzdHln81MHYXtzwQ1sQz0r/ofP/Ms3VQVeE
         LSDNa8bpYpH4SqyWpiPoLpnllmK+9vUr4KLRqT/P3zORC1+4KR3Y48YoPRQsv0l1JgoV
         If6WAJTJTRReWTPvsIYQlbZK1bc7kkXBbrnPCK4r2DyIJlWqm2RmHuO9hp0vPi7wxDPU
         Jzjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167183; x=1770771983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXQDI+Kc9gYbK7/144RC/v7pTj3iItN3DkjMUdjCmbo=;
        b=Bsw7AjYb9Kl2IWzetOQOJEij1OXoxRFHBWvX81FCv9eXqZg2gMGCYKftFcX4bpfheM
         KDDtIMAMhdn4tLW5rlRq/Du0Fv6SEmtjTeTT9H8u2cZBZu1ySpH58h3JYTpiyZojSvMG
         SS/RD3LlyhKKbL0aBhLAgus3pN2m7SaJY4xdbqMmJlXqsMvr/IzxHzyQF2JNWjevosVr
         J4dSZLR5XVNQ+mCOWcpd8OZ5hXFPgWqsfAv1u4UOJDob9Q1NxD0CX005HPUhgm64lSBa
         rGfVJZKU7qD7pIcZYW6kbLDR8/23BRAUX3lgs144IVIVMV+zbBEZe6Putvtj8FQeFwVA
         W7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167183; x=1770771983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AXQDI+Kc9gYbK7/144RC/v7pTj3iItN3DkjMUdjCmbo=;
        b=osKiMuE6JHDF1871goa5YIldGDYKDLPdp49lJMuxMvEo43k8jrHYB2pjvUzAyH91h4
         YhzxR28u5pH60VW9uPvMQzznVKkve56LTyzq6HucqPLoq/LcF1WauToErsz95D3fV3CB
         pQsGsqTBVJbe6JUqIZiat7kRda9OE/B+r6SW4JPUkbURCprj7ihj8BlN3bbesWjfMzB8
         rpa0AI3g4HU72yL0MqFYim6VFvKIo2rtLVkKBYWCO4Rgg1GaQnGIMaZSi20fK3msRk4t
         gALtmK8Dw4qj4ZiHzoxuMpq0n5wuLqyAzIxeW8QLTy2OKvL6K4oAhiVu19wgpLUNdN5g
         i/3A==
X-Forwarded-Encrypted: i=1; AJvYcCWymwpBpallGwhrAse9NrNTMjrnaxAae4iqyQedIGUF8zl9Fyjjp6fSy77VAGjbi01eCGzJegA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXfTted1yM07FvnbWg+xQcmGoYmvycUPJjsQNrE/QP850460t
	K0RVh+QE64ySobqCHJEp0uStXuB30cP8jo4eLLqsJijIPqDIb+mD5EbqsEnt5lva6e/VNpGAYi0
	tbsK/Oy7PjokPsstXXwksGwKdsIlK18A=
X-Gm-Gg: AZuq6aJN6UyY57FVWMD8yq1UdA7Zpa4B2FgAYNHqVUhlGfiZ4wNIeaTYGUHTHGhKvbh
	QxYFQ9MVLuHtOAqV/m8ZAZ9b6ypu92NFfu3u7joO5pxGGtmbZA0KWgJzg/cWSLF8Qe0vJTfVh4z
	uEiUFA3aji77kMgVykOrsbkg2C92tDZfUve+vOuMyCecQw8iQZLGYKEFV5LM//GnTJtaK4oudRf
	muulMfQl04QuHHv1ia4C3045Js5shLZMZrn0ukgkVaXe6d0IF4FclI5aEkPxulNX+T8TosaB9Q9
	o90yGNY4ThZa6afK3LQv5HNjJd5XnhZKp/gG5EfDvby1y85m98ER5GLQLLtVhBAsr5q+2zHX71G
	b1SKq4Y2vO0giJg==
X-Received: by 2002:a05:6000:26cc:b0:435:e47b:e746 with SMTP id
 ffacd0b85a97d-436180572fcmr1755723f8f.36.1770167182529; Tue, 03 Feb 2026
 17:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6982985a.a00a0220.37c87e.0018.GAE@google.com>
In-Reply-To: <6982985a.a00a0220.37c87e.0018.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 17:06:11 -0800
X-Gm-Features: AZwV_Qh5EOQzcFaWo70rMUA9z7aqD3PQgiRqzc41wi1nY5QIFTdvX072wwWIiPs
Message-ID: <CAADnVQ+OujsQGaOcUxP3yGpn-e0KcQuO1SN0B_KKmfO1LtZf-A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
To: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256501-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,google.com,linux.dev,fomichev.me,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5a0f1995634f7c1dadbf];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 13D3DE04A0
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 4:52=E2=80=AFPM syzbot
<syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com> wrote:
>
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refco=
unt.c:25, CPU#0: syz.1.44/6186
> Modules linked in:
> CPU: 0 UID: 0 PID: 6186 Comm: syz.1.44 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/24/2026
> RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 2b 5b 23 fd 48 8d 3d 04 7d 58 0=
b 67 48 0f b9 3a eb 4a e8 18 5b 23 fd 48 8d 3d 01 7d 58 0b <67> 48 0f b9 3a=
 eb 37 e8 05 5b 23 fd 48 8d 3d fe 7c 58 0b 67 48 0f
> RSP: 0018:ffffc90003337380 EFLAGS: 00010293
> RAX: ffffffff84a11b58 RBX: 0000000000000002 RCX: ffff88802f648000
> RDX: 0000000000000000 RSI: ffffffff8ece7f00 RDI: ffffffff8ff99860
> RBP: 0000000000000000 R08: ffff88802f648000 R09: 0000000000000005
> R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880762d8854
> R13: 1ffff9200078f60c R14: ffff888079bc6258 R15: ffff888079bc6200
> FS:  00007fb9d62266c0(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9d53e8600 CR3: 00000000329a6000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __add_used_btf+0x152/0x2e0 kernel/bpf/verifier.c:21107
>  check_pseudo_btf_id+0x764/0xbb0 kernel/bpf/verifier.c:21238
>  resolve_pseudo_ldimm64+0x3f4/0xc90 kernel/bpf/verifier.c:21489
>  bpf_check+0x1d82/0x1ce00 kernel/bpf/verifier.c:25715
>  bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3081
>  __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6218
>  __do_sys_bpf kernel/bpf/syscall.c:6331 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6329 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6329
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Anton,

commit 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
looks buggy and I think syzbot spotted it correctly.

This chunk of code:
        if (btf_fd) {
                CLASS(fd, f)(btf_fd);

                btf =3D __btf_get_by_fd(f);
                if (IS_ERR(btf)) {
                        verbose(env, "invalid module BTF object FD
specified.\n");
                        return -EINVAL;
                }
        } else {


doesn't hold btf.
As soon as FD gets out of scope btf->refcnt can be zero.
Either btf_get_by_fd() is needed or CLASS(fd, f) needs to span
the whole function which is harder.

Note add_fd_from_fd_array() is using __btf_get_by_fd() correctly.

