Return-Path: <netdev+bounces-256608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB5XAzMBg2keggMAu9opvQ
	(envelope-from <netdev+bounces-256608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:20:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9FE30AB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1221B3019199
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250339281A;
	Wed,  4 Feb 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdz+IMS1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE836AB53
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193200; cv=none; b=m8x2yoJaDJMkB5XNgHqaucPQQPz4XI4j3/apcAJVE7q2802VO8Kzom/ya15/Hqtq1mXn4j9yw3pxRpwjsSUdVpYgYFzeoukuXx9trONg0O7noZO7rzCtNQhAl6S7pbXBK+uVX1Bl6Zzx+SRV6TV8LzAVh3cuKI8ZuHNoFVjKNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193200; c=relaxed/simple;
	bh=2f+cDw9WFcPB67ns0Lrz0SDGKwepZq1q7rk/1aCbCq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjoGmgoyZzcty538yYBp/r2AnMjQJipmQDyJgU7oJQA+8HxK/LXMGOEjpybOc6LraU6yYEYoHB90ULNwvAkyX8XCAOeJlTOJe4KOp8zWpXX1ydTLXXx17+0Wjpkf/FoS3FusC0oCpGF6WX3e6Nc6nXsoC51PZqU7ZXFDLbpvFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdz+IMS1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso5922345e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770193198; x=1770797998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uUNU3oBkBlMo8bvj3Y46s6UrRiUTqgc5na1Yso+r9M=;
        b=Pdz+IMS1waHMZXTjgrs4lrgcPoaIQEXe1ngyNIC23ZskL6S2ZQUyusPAXRJsEwOoHp
         /OSrXAbuGg/hKc5HnIlboAeY2DH+UPys4AQrwJUrl4Qcr+jLYURRBNLhYHUufzgir1pT
         Hsv459qYXmlb/tN8DxNi8pZ/qiGDWpIDYVYU64bFC5FRV496RKkXGqC05QGwdabSjeJD
         v+iz4XzNtxTWDjzQyBzSsh6TqGJBKC8qsn2JKLVUeiyK8ExdZnYtQVnYJEZyUKZL2qXL
         3mlABXTo1EgBh/8R3JmBtUc5heeur8fZJHF0beZZZz00fkyVqzV+8z0aBVcZ98QAf62d
         WdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770193198; x=1770797998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uUNU3oBkBlMo8bvj3Y46s6UrRiUTqgc5na1Yso+r9M=;
        b=aaPIGiNF9F5iPbyOJU2O0ec3TxLLg+2EURNO9BSqiPLLGPmcWnLeb6IoStShmm9mID
         KBcKZNmvh1+mrbSidO/wJ2Wkz1Wfzsf59261XIaHPFKz1683g6aba246IhL+Kx+sXEDr
         c0R263CF0JmyQY1l1zlQCvZXUH00DONU+5APfaVVaNzHSYZ8k2UonfLMEs8+tdnqU1Pq
         ZgMX+OJJwTfw90oPFQO45DiLSq86I6hFg2b5du3MUBEH7TqRPD0K+d5KDFLQFfC1lsZa
         69c8bGT5Zq8ga+eGlRHxrV0iZrsrgU6f0EPgHDYebo70YBEdpXjrbmZdAfMqSx1BkZPa
         N6hA==
X-Forwarded-Encrypted: i=1; AJvYcCXH+AY4OOPK3W5fr1T+zJoaVMl374r7YTXP8l4wIMj/GXNExMpekROTl9CWPnmod8aaA+GEnRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57AHBwzptvR1n0rAZT+nhbnNgEiS1JBfilhczZWLeqZyrpwtp
	YxPnTH4Sby6FHN7TXC7IaVCaGfFvjTaSiKyFgoz9sInobHHLmS6Lpnmx
X-Gm-Gg: AZuq6aLk769C8CLNkFmJBlMgvQmjTKFUQ6xfNbCun6IYUKmye1wD6hN5lsasPyAhc5Y
	J+XHBOEn5ScQwtAlCeUQL5Q/F43BZHyNKnd1EmB/5Ed5Iql5fM1JEccBJ70m9AMaXZu497i04Xq
	b+7Q2zoF5ftJuXcUQd6i/a2EbmOEJJPjJDhgvn1Vep3JQ4rXGoVSd0koByFlP8k/yldpzUsk/oZ
	a2fiu/wLdr4kmV+Ui1tIbJfZYiAWid+QyjeKJ+gDJ/rWTqH/JRGDJCEb6ct7GKTRb21pWPEHbeH
	Sxnq099ldxgDHiB5/bryJIdfZK9qgceOtDJccU7OLEJVmTDT4n2awzXKf/S0Nn37IFv+kD429Ky
	f2VgSXVzvMFmjMHoGF9uyGvYqHSQkLaJLRf1YmfnfnC3J4UzLAqavAzFv8mzx+iRLj+1SQyzj+z
	09S+aGOrMzYZiIFJoHbV0V
X-Received: by 2002:a05:600c:314d:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-4830eb1cb70mr26063985e9.2.1770193197566;
        Wed, 04 Feb 2026 00:19:57 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fc0a3bbsm21236405e9.1.2026.02.04.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:19:57 -0800 (PST)
Date: Wed, 4 Feb 2026 08:28:01 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Network Development <netdev@vger.kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
Message-ID: <aYMDEa87sU/7LXrD@mail.gmail.com>
References: <6982985a.a00a0220.37c87e.0018.GAE@google.com>
 <CAADnVQ+OujsQGaOcUxP3yGpn-e0KcQuO1SN0B_KKmfO1LtZf-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+OujsQGaOcUxP3yGpn-e0KcQuO1SN0B_KKmfO1LtZf-A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,google.com,linux.dev,fomichev.me,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-256608-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[asprotopopov@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5a0f1995634f7c1dadbf];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 62E9FE30AB
X-Rspamd-Action: no action

On 26/02/03 05:06PM, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 4:52 PM syzbot
> <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com> wrote:
> >
> > refcount_t: addition on 0; use-after-free.
> > WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#0: syz.1.44/6186
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 6186 Comm: syz.1.44 Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> > RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> > Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 2b 5b 23 fd 48 8d 3d 04 7d 58 0b 67 48 0f b9 3a eb 4a e8 18 5b 23 fd 48 8d 3d 01 7d 58 0b <67> 48 0f b9 3a eb 37 e8 05 5b 23 fd 48 8d 3d fe 7c 58 0b 67 48 0f
> > RSP: 0018:ffffc90003337380 EFLAGS: 00010293
> > RAX: ffffffff84a11b58 RBX: 0000000000000002 RCX: ffff88802f648000
> > RDX: 0000000000000000 RSI: ffffffff8ece7f00 RDI: ffffffff8ff99860
> > RBP: 0000000000000000 R08: ffff88802f648000 R09: 0000000000000005
> > R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880762d8854
> > R13: 1ffff9200078f60c R14: ffff888079bc6258 R15: ffff888079bc6200
> > FS:  00007fb9d62266c0(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fb9d53e8600 CR3: 00000000329a6000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  __add_used_btf+0x152/0x2e0 kernel/bpf/verifier.c:21107
> >  check_pseudo_btf_id+0x764/0xbb0 kernel/bpf/verifier.c:21238
> >  resolve_pseudo_ldimm64+0x3f4/0xc90 kernel/bpf/verifier.c:21489
> >  bpf_check+0x1d82/0x1ce00 kernel/bpf/verifier.c:25715
> >  bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3081
> >  __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6218
> >  __do_sys_bpf kernel/bpf/syscall.c:6331 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:6329 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6329
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Anton,
> 
> commit 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
> looks buggy and I think syzbot spotted it correctly.
> 
> This chunk of code:
>         if (btf_fd) {
>                 CLASS(fd, f)(btf_fd);
> 
>                 btf = __btf_get_by_fd(f);
>                 if (IS_ERR(btf)) {
>                         verbose(env, "invalid module BTF object FD
> specified.\n");
>                         return -EINVAL;
>                 }
>         } else {
> 
> 
> doesn't hold btf.
> As soon as FD gets out of scope btf->refcnt can be zero.
> Either btf_get_by_fd() is needed or CLASS(fd, f) needs to span
> the whole function which is harder.
> 
> Note add_fd_from_fd_array() is using __btf_get_by_fd() correctly.

Thanks Alexei! I will send a fix.

