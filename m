Return-Path: <netdev+bounces-258009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML8DNaqHimk1LgAAu9opvQ
	(envelope-from <netdev+bounces-258009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:19:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DF115F36
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 039CE300A75B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 01:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557923EA87;
	Tue, 10 Feb 2026 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnvDiHUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A617B418
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686375; cv=pass; b=RbmFTpb4yfVrXFZ1+VO6Soz19NcFZ+hX7+B9dxJfxuVplk1XwSgMgjBva7/DOWpPXsdihHRUebma1uugyl0l/L1IcXn+IkQg45WACs02OWooZ/0sGw9L40u6draB3eYzLgKrRqSj7BZuD8yfCt9L8AGTqw+8OXU9yhNLQXWTk0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686375; c=relaxed/simple;
	bh=M/xjaQ6usPof+auHUm3FeiVUCsdGjUqeSjPcTpKz7CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUoOd6/UYomUNnrKwm0RD1QUJuqDwEAJX64MmencBnQ2USFm0teG8knglGkdeo2uZ02720GefN+dx8ZHCVJEHqJSAEpVytiZS3vJThCPc+pxKMdAqq93nN+XVWiICA19ZLcokgX3/n6HUTYHKJi5m9l9qts5rZ3hASan7XbqL/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnvDiHUG; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124899ee9d3so3391232c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 17:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770686373; cv=none;
        d=google.com; s=arc-20240605;
        b=cw7N6NOJNxQVW1jsLz1dFJaJidomON+LzKnwLsJMcyiWr67XLcPasUKk6sLfyyY0tu
         fX/cfd38EwdVv6dSLS3EAw23SR7yw4Dwkqb+cY2M0hoL8fS8SCoHZa097h7+ADLAVAYp
         xdb+psApu5gvOI87aeY5f/isGJaibpxevTVfA7V6SSft9ree9MTUTEc8RcQbO1o5HhfY
         CVn9VMlWDf3aNJjTNNnZ86b3VOsYu9Vnn64f+KT0c31LbilqEEOF2thpLuRfqmssQtTG
         wb5OlgfkPGdjdq9+grBh5CjrkOepl7gnEQxIVZHaQft+5lCjmcFslOtVTykTrDtRaQwY
         PEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMJkgYkbFLkRcuf35gty1YVid2onGGqHzqxh822jpMQ=;
        fh=FNPDf1Qxzh+oSIiKZQLtr2kpn8Cl/y3G5UKg4yFpOUc=;
        b=BwQxdi17lEzGSHqqfmdo0YKoNH7dWv0/TMxR0GCP7xQUPp9IQQUdW5nJumvxc9acn8
         6tcAQQ7kz1PX3Yp7kMjxGKm4aFfZj6p6SaLhlcF80bG9YlPgtcDUdMXQTNS6EWJYGQ3K
         XwWzrzsM85QAts9ntUYtFpgRjht9vo4NjsK05ndE2h57+MfEDm/3zwjucd2RD+06uLJI
         bts4oyD8fzArsRTysAWnp9u7rZvHbivS5wiPN6LTCuxKp0shMiDUsyToDqaE8S2PeKA4
         GHMFazJSOAOS6kslRDy/tejMVM/kr0jsRtv3L1yfw22epBF7lUOm/wCrNPNqVZz4Nk3b
         Gk3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770686373; x=1771291173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMJkgYkbFLkRcuf35gty1YVid2onGGqHzqxh822jpMQ=;
        b=EnvDiHUGIba0mD37PhWZz6SjAt0K6t/jx3LSgxomzAFxzmNJvRsSPYHl87K0AjWZZL
         WZ2kmwknDv1vO04q8Ce3tAhAgpn5lfohaw09OVWqVA12Qrenv+I/GVvbvilG42Fms+kb
         X2HYE+I2hxRwa/DvI28b7jxD3VFJzIsKPO7svJwfDxZUfbzd4elYx5DONajlMj6tXOkp
         xxaWU7lUJsW1gN9DP2de7jZ4+upQ54irbL4xVluhxk8Ef0wFuI1wi+i0DcbnwGL3Picy
         pZDYc1wlt3OwCguv2Y45qZbcZI+aUal6Ujmek+S65QKCqy2ITxr/XPf6znJejzpICESj
         GpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770686373; x=1771291173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMJkgYkbFLkRcuf35gty1YVid2onGGqHzqxh822jpMQ=;
        b=PLw+6tct/a5zzZVhu6c/lUzRvsqnAwP18n1EoNxrT0HiB2VWl5bOzxBXYav2b+uM/g
         hOhrCT8160I2oh3LcrkRmd1C/hUcY9hB3maK4YOglGcAsxdtU+5W6R0bp9HD9zzqxxO2
         xq7kRr8WXP/XcRn9JP1qXb6NKdpW3N4aENIKK7Dt9Mj37PpJGqAn9IhkI55WGaOpehD2
         XCxteYbzvOa3U4RXR7Cpgv1XxPAwUZr9x92L1vHrv1bO5LckXsnZoZuE7ib7XM8bS0UP
         O4InC1/YMu76W+w3jj/O2LJkqahGbnrXVTMzmNWUJgYY5EDKe497knI7qLAVc10YQyi9
         bc4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBzAJIO+5iMgUDYa2/NC+LcmHg2ldWoeQcHkRzHtDVRf5793okIG488BvikQn83gJM+btdlg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwtctbc3sGW7o7cy+jo8F7GQPGATK5aePyRHW15O9q+974VrKZ
	Jys8h6aMEiveGQ2jrp4mIqMX0Fo7rqZ/6vg1oCNCJVM9neRXeJmySGfo6X8Kan2S6F/o1+69oBG
	peofH5plrISkSk3nsFxM3MqvJZvbjbdqQJcZqMLdQ
X-Gm-Gg: AZuq6aIGth4cDV8EN8MBFn3aoa4nOO1onjVJse9rwkqh5Or6WAT3zzlzmBghU8XIsEm
	5MdOVdNY6OLueqePFDrktV83dIZZYvo6x7V5EJN6eyzRAz3cM950aOOfrmHMWNgYoaA6586f79M
	oX1s2LTR0m+H/8BLHoS3Xhmt9DMQbu37Nkoc9VzsGSmZHzq2N7QQtxFC405OZePDq5rlsuigRhW
	bb+uIaocNE3M1FZeA/pITzZNP1jZZPSxtf09FAD93xLnHvsKfn/QhCy0s4vaZuXJJ0gZ7p0HCnB
	KGQ9B/ToULZToJh0eJi4nr0R14xYYeKrHX4h+LoJuXzV3TgLsFWWwjiXegVM3Pnrc/3CTc9T
X-Received: by 2002:a05:7022:4585:b0:127:fa:7758 with SMTP id
 a92af1059eb24-12723ea9f97mr308681c88.9.1770686372889; Mon, 09 Feb 2026
 17:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
In-Reply-To: <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 9 Feb 2026 17:19:21 -0800
X-Gm-Features: AZwV_QgLHU9qq-VTNodmxFHxhk_GHudR0gC0151o-atRLaJy99qtZNSTJExKFRA
Message-ID: <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258009-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,rbox.co,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E1DF115F36
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > bpf_skc_to_unix_sock(). [0]
> >
> > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > but there are many functions where bpf prog can access the field
> > locklessly via fentry/fexit.
> >
> > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > the last refcnt of the peer sk while a bpf prog is accessing it,
> > resulting in use-after-free.
> >
> > Another problematic scenario is that unix_sk(sk)->peer could
> > go away while being passed to bpf_setsockopt() in bpf iter.
> >
> > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > by marking the pointer with PTR_UNTRUSTED.
> >
> > If needed, we could add a new helper later that uses unix_peer_get()
> > and requires bpf_sk_release().
> >
> > [0]:
> > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > Call Trace:
> >  dump_stack_lvl+0x5d/0x80
> >  print_report+0x170/0x4f3
> >  kasan_report+0xe1/0x180
> >  bpf_skc_to_unix_sock+0xa4/0xb0
> >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> >  bpf_trampoline_6442564662+0x47/0xab
> >  unix_shutdown+0x9/0x880
> >  __sys_shutdown+0xe1/0x160
> >  __x64_sys_shutdown+0x52/0x90
> >  do_syscall_64+0x6b/0x3a0
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > Reported-by: Michal Luczaj <mhal@rbox.co>
> > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6cae=
0@rbox.co/
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3135643d5695..b328a1640c82 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *ma=
p, int off, int size, u64 *val,
> >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_=
or_null)
> >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
> >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_=
trusted_or_null)
> > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untrus=
ted)
> >
> >  /*
> >   * Allow list few fields as RCU trusted or full trusted.
> > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_str=
uct) {
> >         struct file *vm_file;
> >  };
> >
> > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > +       struct sock *peer;
> > +};
> > +
>
> That's just one out of many. It's not really a fix,
> but a bandaid for one case.

Right, this is only one example where a pointer lifetime
does not match with bpf prog.

> We discussed it in the past and the only way forward is to make
> helpers only accept trusted args.
> Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> We should do the same for helpers.

What about just reading an untrusted pointer ?

I used bpf_skc_to_unix_sock() in selftest in case compiler
could optimise out branches that always return 0.

Currently, this passes the verifier and can trigger UAF.

u =3D bpf_skc_to_unix_sock(sock->sk);
if (!u || !u->peer)
    return 0;
if (u->peer->__sk_common.skc_family) # unsafe access
    return 0;

Thanks

