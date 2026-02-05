Return-Path: <netdev+bounces-256974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z7m9NgsthGnx0QMAu9opvQ
	(envelope-from <netdev+bounces-256974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:39:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F032DEEC40
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 774B83004422
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD331ED75;
	Thu,  5 Feb 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL56avjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A81400C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269957; cv=pass; b=RaD9htITO/PCO+gJbmtkBKadeOVgl/jPz7i30sQsVY1jlyIbEZonmeapiEiY4GglECwAd9vUnkz84x40Xzp6RFzqWf+mGgM1itBRT/EMMck6hQtEt3M4ZBxCQA0NJV8b94Ssj3+mey2OWmQg0q95BKHcVxtuW74zBuzI59+6PYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269957; c=relaxed/simple;
	bh=EyqUe0+SutsI4NQnIIPjQmdDtSE0qjrbdBhLyEtfLfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw6jKWzG9PGjQOkcsxnVZUkOKtN48rK/quwN/yPlTK5p+AuwuoCQdCJ+zEfxUBJd5nIiYwTLT5Hc7twwoKdtMirm36ISUlNbIPQof4xU44ZHAoOugSQ+VCi9kGwSWEu/EY6sG/ytngE+sBk4vkli0YLGfdB+EZwokuRVgoB6nPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL56avjz; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794baacdefcso5200907b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:39:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770269956; cv=none;
        d=google.com; s=arc-20240605;
        b=F3WRBk+JQvxKy8xs48YiebQenWQbHtVgkMa4RWPayCcAISL7NxXFosayHS7bhLjWiE
         cP8aqP9huM1jV7MpUCMOiA1ZqMS+6cwpUmbn1kDkoXx9iuqpz7sWpfaJdnN6jYmWwDYS
         WQN798FSAkW8XRXs74vgqUqVmN5i01iGzkTgqeam/3da7Y7clSqWOvnaaMk1kfqxEeTN
         QsrTdHMiE18c/LyS4Wo1mj19c3f2C5kI3U1/sKPq9KZ0mI1a6GIp2zPXnamvfl5Pcoub
         bidLYLX93X6kJdclaoBJ+H8svGvA1nf5DvAle74JDmmjY0R4jVFYxCizZW87QcfAG5FY
         96og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PMsEOTaBBZEjoFKATr3E5W6cn/EGHtCQMDk79facobU=;
        fh=ZbPrz4v6QU7ukBej94gindlTZIYkFaQXYino5RmP7r4=;
        b=acawnkBH3znFUfUbp8GaL9bRBvUblTiKMhTVk+U0jwFEYTUKYpVXU+pgulk+zBoRbu
         E6VekxwqCfY4hxQ0s0MJo+fuxtBYCsHwYRsjJLDne/2TArztULOfpy87X6RE4cM/wObL
         cAQbcW7zIR9qBJlUCqEzrVj1WvjTIu4ouIlHrNl3HefKBPY/3/JDdZKvL9D3FQJFpPWh
         enWOU8yVSzbvDlqQ8h5e2UyFAF+1UHGOIruFk6G7F0j5GIE1rUTnUN65ngz59lsCuh+/
         PwEivTdles+/+vFqclM2hbtAm0a86NY+Osqu7N/VOAXyjlo45B4vwM2hU/S9xS6DTUAU
         pkBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770269956; x=1770874756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMsEOTaBBZEjoFKATr3E5W6cn/EGHtCQMDk79facobU=;
        b=GL56avjzVyz3Yx998OyjZSY6cQmrFMjsevVjIwY4Gu+/5QlK4KGcZKcnIwoAnI0zlp
         1Y9Vi2oTdjurwIlXgB9XtZUonPz7B/k2xzOj738wfdMNMG/zMHzTM+b8HfDyXt27MJae
         gdW7gQWtpCeWBPMxikLsAlIz3Ccd2k33EYNAeABXnmo48s+ZrzNPzUJ+OO7W8WDNyojH
         k+95XOD9rRTMl3cGYXqGMUR5EBnNFQiX5UYjTVy4fw6+/tG2iKmccEdob02U/yLBNz5M
         WJTeO2uqOQE1JxqpDZNXrLDNb94kmbXdbCkjcY15yRk1XMQwS9oq4B1IytrgjRuH3X8j
         NK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770269956; x=1770874756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMsEOTaBBZEjoFKATr3E5W6cn/EGHtCQMDk79facobU=;
        b=ER1dBG1ZNrTlWi0GCSn3IBLHnmJH0th3bd8RqWvEDxj2EpkkvgkUbZQapZKy/ZVB/u
         ZxZCrl/T5DSB1GIT/Omf7TzBryjt8SKI/u1FpKhaRQ40+kIk3tHoxGc9VqOevlR+SJhT
         Si5IOd33GYDzJHwHYssrPuAoJ9R+jvGwHEneLT5ijsY1UWWNmGBjARuWJlbl78o4xgUw
         IiwqBF2cgMnFxLzY6K2iWkinfokzTTTIvdaYcUkl67vyXJ8Ec2bqrWNaJzvVXyhtXjPw
         4f/E2bt4DkWW6t6DpIJXjOms9aDYqk9vczfCExnW+TN9IUu5k/PbEymidMwXNOseYeMc
         R/YA==
X-Forwarded-Encrypted: i=1; AJvYcCWtGlz+9RheoRwmIARysrV+JvhlJPGllgMSWr1pxHfcDNqJTVndJssYdNmPXFkAnZgcFudZkJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpEHNaFky6nRhVJlukZ33J3AUnVUgFcl/FVZQkiVndR3iu7DQ
	qJL62sIesUoE4TjCAlvp+yLNmLBd2hwx/1QTWkq8SbRY6jqrhytmEufxwdP2WjyaVXrrO5WK90N
	TGVlk6MdjYGNviSRU4qh762l0sa+o1oo=
X-Gm-Gg: AZuq6aLvowYpQgU8XnavRPUx6M+eCy20qo2iBbS3uApkYh/32qzsSjAoMLRH48jlVQt
	zW9howg48uiD7vZv8jM/dQ8im5LQ2azN1/CYd9U0oU/h/gSaGN4Yw7ocHaG0m32elup3ZGQuETw
	8SA/gG5TYtyaO63knkT5AHIR705DgvS8u3bH97kvinXYeojVyo8X0Na5BXIP4lGC/msc7ZQ8X4C
	ptpEQzmOhwgj+HJhfnj00IlOCzT70gV1CvctaIjFQo2Uo3ljM+W7+/Xt9Y/50EgIM9uovxSec/g
	5ZvZhdr+QPWvUCGu8hliYI1525IH
X-Received: by 2002:a05:690c:387:b0:794:e08a:9196 with SMTP id
 00721157ae682-794fe739166mr103469597b3.34.1770269956227; Wed, 04 Feb 2026
 21:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6982985a.a00a0220.37c87e.0018.GAE@google.com> <CAADnVQ+OujsQGaOcUxP3yGpn-e0KcQuO1SN0B_KKmfO1LtZf-A@mail.gmail.com>
 <aYMDEa87sU/7LXrD@mail.gmail.com>
In-Reply-To: <aYMDEa87sU/7LXrD@mail.gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Thu, 5 Feb 2026 06:39:03 +0100
X-Gm-Features: AZwV_Qj1jN728G2sXUrrkUesIphfgo1Eb5aGsIqmAFykZQ0PK8CP81wbgdjwdXs
Message-ID: <CAGn_ityekaJpFNnaYHS==PcfDdeXY87w50s9VmeiN4r4EyD__g@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256974-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,google.com,linux.dev,fomichev.me,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asprotopopov@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5a0f1995634f7c1dadbf];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: F032DEEC40
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:20=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 26/02/03 05:06PM, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 4:52=E2=80=AFPM syzbot
> > <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com> wrote:
> > >
> > > refcount_t: addition on 0; use-after-free.
> > > WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/r=
efcount.c:25, CPU#0: syz.1.44/6186
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 6186 Comm: syz.1.44 Not tainted syzkaller #0 PREEM=
PT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/24/2026
> > > RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> > > Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 2b 5b 23 fd 48 8d 3d 04 7d =
58 0b 67 48 0f b9 3a eb 4a e8 18 5b 23 fd 48 8d 3d 01 7d 58 0b <67> 48 0f b=
9 3a eb 37 e8 05 5b 23 fd 48 8d 3d fe 7c 58 0b 67 48 0f
> > > RSP: 0018:ffffc90003337380 EFLAGS: 00010293
> > > RAX: ffffffff84a11b58 RBX: 0000000000000002 RCX: ffff88802f648000
> > > RDX: 0000000000000000 RSI: ffffffff8ece7f00 RDI: ffffffff8ff99860
> > > RBP: 0000000000000000 R08: ffff88802f648000 R09: 0000000000000005
> > > R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880762d8854
> > > R13: 1ffff9200078f60c R14: ffff888079bc6258 R15: ffff888079bc6200
> > > FS:  00007fb9d62266c0(0000) GS:ffff8881256f8000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fb9d53e8600 CR3: 00000000329a6000 CR4: 00000000003526f0
> > > Call Trace:
> > >  <TASK>
> > >  __add_used_btf+0x152/0x2e0 kernel/bpf/verifier.c:21107
> > >  check_pseudo_btf_id+0x764/0xbb0 kernel/bpf/verifier.c:21238
> > >  resolve_pseudo_ldimm64+0x3f4/0xc90 kernel/bpf/verifier.c:21489
> > >  bpf_check+0x1d82/0x1ce00 kernel/bpf/verifier.c:25715
> > >  bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3081
> > >  __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6218
> > >  __do_sys_bpf kernel/bpf/syscall.c:6331 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:6329 [inline]
> > >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6329
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Anton,
> >
> > commit 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
> > looks buggy and I think syzbot spotted it correctly.
> >
> > This chunk of code:
> >         if (btf_fd) {
> >                 CLASS(fd, f)(btf_fd);
> >
> >                 btf =3D __btf_get_by_fd(f);
> >                 if (IS_ERR(btf)) {
> >                         verbose(env, "invalid module BTF object FD
> > specified.\n");
> >                         return -EINVAL;
> >                 }
> >         } else {
> >
> >
> > doesn't hold btf.
> > As soon as FD gets out of scope btf->refcnt can be zero.
> > Either btf_get_by_fd() is needed or CLASS(fd, f) needs to span
> > the whole function which is harder.
> >
> > Note add_fd_from_fd_array() is using __btf_get_by_fd() correctly.
>
> Thanks Alexei! I will send a fix.

#syz test: https://github.com/aspsk/bpf-next.git fix-btf-refcount

