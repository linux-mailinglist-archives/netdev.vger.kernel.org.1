Return-Path: <netdev+bounces-265457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFUZCDqbrmkjGwIAu9opvQ
	(envelope-from <netdev+bounces-265457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:04:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C3236BB3
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB99E303A8C7
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C038B7CD;
	Mon,  9 Mar 2026 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+sG0PfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C838B7BC
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050635; cv=pass; b=Nr20IMclp3WR2u3OPXRqeTB71I0m5nfIy67fjr8R3Ho6hKRyz0o7nyYd9PBJ1HtGTKr2H2jKc7sqg3gRfM21WaOkHd9IuP2kq9c7gWZWloC0IprPldhrt1lPX1zgEXmn8i/GTo7IvNwqn1jiC6djyh7+Yl0hrgpjhcO9RESyeaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050635; c=relaxed/simple;
	bh=o3jaNkGDYBQTzgUWXmPXPeMrbrWzb0oNlGozzYke79U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2SqvTgp8ZUIfW6HO5bDGo/EU8bv+R2xDUhYWL1hHW0NGQBf+zzSajIgG75EQtXSnJ8c7wwocYBvahKPqguRnbFdUljPJVTtDlleWSq0dc8tUWHvKYWvBukTZBD5VD41HBs2hiCv17TTIT9JxwlbupngGdAlzy9/ibeFpyfBne4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+sG0PfG; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd7c372929so163708385a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 03:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050633; cv=none;
        d=google.com; s=arc-20240605;
        b=C1A6SdNJopGWAUPsDPFk3CMlEopigVhYoN8M41szgDR39jKcu+mNN7NV6jAEiyFWIL
         7NQDdNvy3n3WyWpyr3VOHpGuG1Z5+AYY+Ib27OyDu2x/d+YQ8Z2IB8GfS0jTpcdAbhn+
         7xTEGGpPkqdWbhsQisit5UmSFWyD9B5lDUiI0l/SMZrn4ZO5VgWWb2bxh+1Tcirt05sV
         6HMNZH6a5+DGzyI6VRLexY2L0ZweFh+6zEPK3JAfi/SAYOF5zZpyypUzTMkDs+Fkvhjg
         WDQq7KO8R0SrBjk5QCmXSI+685SwVyni7GJ0EqYNlwFVf8RDJdOGElA5c25DSa8cclIG
         pkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xSfqXtScotu5XTRky9yvHGfmaaQCdm2/cA82kCXoKvk=;
        fh=1sXoUbT8TE5r/mp6ip8L8fpo6P3EjOcO4D8N9Xk4tx4=;
        b=RIxzJz2CZm0k3zghnZ+1pBirzsFZYVS7asdNd58cd5cQvBtoTBFSl+e+cA6RDs38gc
         T/cjFYVJBrJTpU38BvN9o1Gz+ferbwxq8QwnXiHdHzSypudm5jrJmGZvZHJZ677bHfdn
         OH5bIkw5TwcKJTeUvH51HQz0dMEbuWhjw/GtLKKMhJutzgHFd75X1Ckt5KiIFch9/K8w
         0HlGh+6bWkAXjmCeDktQtHtlkOLNB+bikHwGR/eRuJBLrJ3ffIKali8fOZShxmhshUBA
         wvwiE4ailzpyWYVjWc8dWJ6vKdQeMPKPiOfMIacV2NYUWmRKGgAWXFBnZpGamqQq0K79
         WLnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050633; x=1773655433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSfqXtScotu5XTRky9yvHGfmaaQCdm2/cA82kCXoKvk=;
        b=3+sG0PfGTyUzCDwfs/kJwQ+GcjEKPuEyH5UMgH5M24tXRbvzoZcpTax6FvqrXhHZOS
         j935Kjock946dX76BZv5xOfU24Y1X/PkzDuViSOE6fU1ClF8mPpkus9PzCVjZzB8jhzy
         8ypI9a+g+VoeYH6b2NUu5h+kW+BXdzSp0nvLXSoE/+d1nUS2YSinoAekHcROOyLFthFX
         PjKBJuKRxhBKgQYaN/ycZjTeNR71M0TrsmBVZy64sbcgpsUmjMswb+XDz1zcUAlGDasq
         K0qUV98vSvk7l28G2SCeoQavfVLdkEc2M3Rc8NV5lb+3dmrwsJRjLVyUQ8BJA9Rc/8L8
         7UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050633; x=1773655433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSfqXtScotu5XTRky9yvHGfmaaQCdm2/cA82kCXoKvk=;
        b=oEFeOOE86631vjphJDw4RDyayX7zvDoSsGD6Lr9PaTjjMpywbrPz2r8VJfIB+buWwV
         T7FVJQ0zxssd7yCx9kCLXJ8GoSV/iAHD6JaPskcyvk85zeDlusBBrHwfjrMlPUFudII7
         GHU2u8Gbvggr3CjcXWfIMvxPGhBLEthsW47SPSZ1JWJ0R8tf0n7XsH/jw4IyQqv7iD7e
         0xp+bTmLW0FUz64nBPl4TvDsAb2AS499pQ3265BaVlSEYDHZY586ZtBHEOSJx7YnU+Wj
         7tbDiY42Ivy4Ltqpi1aPZ1JnSiukiOY1IyCTPiau5TL3Ahxu/BmsanXDrhl5yvvsPar1
         hJ/Q==
X-Gm-Message-State: AOJu0YyXxzoY6/GrH+GHmCG8OVm8xjmpowBbATxzOzrAIM1wXwg8AiiO
	XzjRosD5pLiLDmOThZpC7sgM6oEQXVyYntA3cyzlKAMO5foGThfuhujkUGelGlmC7Eol3jr1Lqv
	1X5bjEjCkRy3A6BkdJ3JZJmyn7AzzqfQDEg1keEU7V588YJ5l9Zc1UfSM
X-Gm-Gg: ATEYQzzlJhqADVQiPIFL4Qcqj4A+oeosaE7bJuSWA/e2LnuMHgcwDSPdEQ4f82kuI3h
	BXgTpV0T7JYhLRFuk94zpWIr12dCEHy2cNMvbrfNgumqQpeFd0F3Y8O6e11JA72q8O+SKtft3rH
	ylBrmA1NV5fr9RcuTOPHcTqxmQcjS4MMKfYzs45v4yKQNcYQ8fzRaCCGT6URS3HqReajk1fbgu7
	Gmvm/cN4BIY7TLeeGmP9S18SQMicbrEuPv6fHVZLB3jBNaLl8SBfW5NUvKcEVNI1KMMDKbq8mFP
	ldU8sdo=
X-Received: by 2002:a05:620a:1726:b0:8c6:ed3d:be60 with SMTP id
 af79cd13be357-8cd6d4a14ccmr1309367085a.71.1773050632954; Mon, 09 Mar 2026
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com> <903543b24e6e124ff970340e265185af176880f6@linux.dev>
In-Reply-To: <903543b24e6e124ff970340e265185af176880f6@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 11:03:41 +0100
X-Gm-Features: AaiRm51p8jwAE1iwbL1pN91qOyZJ3zxRXnsqElk9iOsk_BoOPc9YpeO-w-VwnW8
Message-ID: <CANn89i+k2i85Yn6gd_AxJtLD48XoZo366OGu1sLNRiU8ExOjmA@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] net,bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding and add selftest
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, jiayuan.chen@shopee.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 728C3236BB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265457-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,shopee.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,google.com,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,syzkaller.appspot.com:url,linux.dev:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 10:41=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> March 9, 2026 at 15:46, "Eric Dumazet" <edumazet@google.com mailto:edumaz=
et@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E > wro=
te:
>
>
> >
> > On Mon, Mar 9, 2026 at 4:07 AM Jiayuan Chen <jiayuan.chen@linux.dev> wr=
ote:
> >
> > >
> > > syzkaller reported a kernel panic [1] with the following crash stack:
> > >
> > >  Call Trace:
> > >  BUG: unable to handle page fault for address: ffff8ebd08580000
> > >  PF: supervisor write access in kernel mode
> > >  PF: error_code(0x0002) - not-present page
> > >  PGD 11f201067 P4D 11f201067 PUD 0
> > >  Oops: Oops: 0002 [#1] SMP PTI
> > >  CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PRE=
EMPT_RT
> > >  RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
> > >  RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
> > >  RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
> > >  RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
> > >  RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
> > >  R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
> > >  R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
> > >  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
> > >  PKRU: 55555554
> > >  Call Trace:
> > >  <TASK>
> > >  bond_xdp_get_xmit_slave+0xc0/0x240
> > >  xdp_master_redirect+0x74/0xc0
> > >  bpf_prog_run_generic_xdp+0x2f2/0x3f0
> > >  do_xdp_generic+0x1fd/0x3d0
> > >  __netif_receive_skb_core.constprop.0+0x30d/0x1220
> > >  __netif_receive_skb_list_core+0xfc/0x250
> > >  netif_receive_skb_list_internal+0x20c/0x3d0
> > >  ? eth_type_trans+0x137/0x160
> > >  netif_receive_skb_list+0x25/0x140
> > >  xdp_test_run_batch.constprop.0+0x65b/0x6e0
> > >  bpf_test_run_xdp_live+0x1ec/0x3b0
> > >  bpf_prog_test_run_xdp+0x49d/0x6e0
> > >  __sys_bpf+0x446/0x27b0
> > >  __x64_sys_bpf+0x1a/0x30
> > >  x64_sys_call+0x146c/0x26e0
> > >  do_syscall_64+0xd3/0x1510
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > Please, can you always provide symbols in such traces ?
> > You can use scripts/decode_stacktrace.sh to make the trace really
> > nice, instead of ugly.
> >
>
>
> Hi Eric,
>
> Thank you for the suggestion. I didn't include the fully decoded stack
> trace in the cover letter because the syzkaller report already contains
> the complete information. You can find it here if needed:
>
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15448952580000
> https://syzkaller.appspot.com/bug?extid=3D80e046b8da2820b6ba73

Exactly.

Either copy the syzbot stack traces when they have the symbols,
or do not copy them if they don't have them, a link to them is just good en=
ough.

