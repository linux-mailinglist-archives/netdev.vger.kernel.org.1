Return-Path: <netdev+bounces-258190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFADFk4EjGkeewAAu9opvQ
	(envelope-from <netdev+bounces-258190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:23:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F01212A3
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D2C7303FFD7
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A0346E4A;
	Wed, 11 Feb 2026 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hew9ZV54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9234321C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783811; cv=pass; b=ZJ3RP2GI1mmufWuNKUJRsofjdTE0LE83YJkgeCU3BqsQ/ddVwWdllNaiKwDVcpWf/l40PxZkf1tfPEpDC/apxj+F31A1XrY3AyoE2VzwAa/OE+RugTkc+cPmMB5nt3XNbv5MfOk1ZeWyrOnNAze28L7b1Tw5DOdE1KkQrplnLpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783811; c=relaxed/simple;
	bh=5feqezYq4DtXKK86LxTBwiMMXMb/AYlWKlYvgZI8o5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICkDtzrz6Sxrq+luGAgWHo/0W2N/NWNSothJseOYW7/A/rADFo1rnIggzorypuR3tmB1Ur4DxsxypVbwqJuX4HoZOUUnw1JQSIat/ojRzZp1rUNvbpBOjJ9CEBAwM+/9yHa680O49R+Vs6/YwLABYN2yNGkdkhX/zUlfAUhcp98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hew9ZV54; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233b953bebso1596697c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770783808; cv=none;
        d=google.com; s=arc-20240605;
        b=h8I+YH4RrsXAUnalX2kvzXeA1KSlxqVO9IooWUN8jQ6c7IdsAkkUOWnIek2Ftd4H0a
         KGY9WpTRVa/6Yy6in0UUdFXyjSQPahhWeU5i7OCWrgGQl/l6ykjhPkKMKNXAh8rLuyCn
         eLh37XuVfZm6QnFg6jRp+D/Y0QlG4WiLhEKSGOxPTGM6gSdw5xcdPFqDFwf5/9tWqpYy
         m016n7qxAIPj5d41WD3cBQjDGa65bv8UsZH9oV/l4qXZ9srajHlItG1iFy+61WbKppMU
         bda7ixMiUBDyQ7Rqe+NOEYLRarDKP27bUKKTvXXktpJgIJNFdB1xTlVhHKSfiqE+JKBn
         Wq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=onR670WObIKN1WaDZsvnS8cFGX6eA30W7fb0qX5OToY=;
        fh=VISUWvidJjdKwaSW5XeQrt5ZIqI3IrWIaqOXirMfdxU=;
        b=H3UjN8VDi8sUzysDc6T2nEW0hX6syLrGVa/O5wijj7xf74a5omlGFJI6hQ+wTL9TmM
         ysSZpNMFkW0Q5PyHbbc0LL8AfBm3KptGSIJabWvn301C8lUqF+kpBgVbNflkdDxtk2lE
         w2ql9v70RiXuZ5xReUTNjSLJrZKM1P6CfCLvssILqoqVjHW8osXFj3CM713wjMgQ9nP7
         TV5eWi+v7uw6wKzkK1jQu3tnJ2zrelX2rDKRQ0Gs4JsD6mBj/MWIMaWq2X9Qx7cIrhX8
         ODZVgvw+qTMIxsS1KeoiA/iy5XretLSZSpcAYpXOhPe/6cQmDH91sJxm57u2oTtjdygr
         9pRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770783808; x=1771388608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onR670WObIKN1WaDZsvnS8cFGX6eA30W7fb0qX5OToY=;
        b=hew9ZV54DwhTTQVL+Wi45ZRDYJyD4EOMa03BqsooyU98LFfwmN+tkcX85lUGnD+u/0
         9ZtVpxZQdTCEeE3vuIu7kokLH3eVh3QIwJ7OCignzkGFMcOX+AfNIdYyz4H/pcMy5F/Z
         QToLWwakQVj5jEqBEv6o9rKGDA3f5/7dlGgvd2WE+irmd8aignrsNAVkTGPNGlEYZCcl
         uPx6kDwX45G6OcMhc+IrkWrkyho/DRJTuz24G2vd+/NBPpf6BAGjG0U+Md/aH8OosJAe
         0e6hRBg8dPL8O+mp+zIyQ+CZEKUFSJ5ESCxiPsIDkQTQM7KeduWqGJQnerJppIM5snAQ
         5JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783808; x=1771388608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onR670WObIKN1WaDZsvnS8cFGX6eA30W7fb0qX5OToY=;
        b=MMRHOIYKmK+MUMzJcjvsGijwnDO8XI7drOc0nZYxful/30/rrRGQGiYlLx/z7jhMWi
         rPBiftK4ZT4RsZgs3x/2uDIkvjRy+zKgbd3quo4h7jyrvYajWbSht63fotf6d6aR78mv
         XIeA2SfH97QGhwA58rgkSFogoA8Q3AMTWiNw8xuWPB9BEwYeOPxkyWaEZRSP7k6v2S9L
         2bxg7ZM9WrVTQZGOcu3CynsbgecuxlOHerXPPjMh3OWSNa76CNYW4JN5hLoTwe0XTH2U
         PUU05GtIHqtSei39Vk6e6LI7jKDaFxL020IKHBFwhGPPQe6KKNSjD35x8xJNlaO/ezEb
         EELw==
X-Forwarded-Encrypted: i=1; AJvYcCUq1VLca0vTuIVa5vjBMCpnBR9Wr3g750y0GVlf3qDiAIDcPcbf3lpwdF5cnDxs0HZuU5lxa5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaPy7WkFAsiTc0eNxmh61wtCxyL8W4h5hD/gjxUlRv3s8AHCN
	ksOImA9QJlo/5fR2+AuQyuurtTEHOznSzeRHh/LP98dMVgU/xhw7mQ/5WBS9sgHXaaskEyLblVI
	oTZzVN2oyMuZgaIpF+wkojqhiQAWNp8g0SuG0rjjd
X-Gm-Gg: AZuq6aKttMe8Af02iAeDGRJ9uaBbrnS/i/11lDDlE5o7d2JedTX9UNMMUa08sUNBUtD
	Tf8mqferdJOQs43H3i9jfdCUQGE7YXVHTFGVq6gh/JAsk9WKH4Z/f72n8Dg9VK5VAdyX9pMVfcA
	kDEG6aCes5IHHKVsY1s1uZr5AtCT9hpXRDA/lVuMCRIa8GH60FvGkLMj9aKyGxq45VbwFFgdVIt
	7/vHc85hinBugjXL6eiI4SdKGkU9+VuhH5LjOwYPEfmTmGlKWnm+0EV/OmvJRV7/Vh/YWtqawSO
	GdufyitfncpG1zFRcnIqoEENOWx98wWtkR9jNHbY74VIg8EgVSBPzo6OFN6Yrb9+Bim+9L/M
X-Received: by 2002:a05:7022:4597:b0:123:348b:979c with SMTP id
 a92af1059eb24-12703fe453emr7638450c88.6.1770783807886; Tue, 10 Feb 2026
 20:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
 <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com> <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
In-Reply-To: <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Feb 2026 20:23:15 -0800
X-Gm-Features: AZwV_Qj_Pvlk5Eij40X708nf6kEiOvBwwkZhZ9dI8ZMRlvtA6GhnVJcn0q8u5zo
Message-ID: <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258190-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B80F01212A3
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > > >
> > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > bpf_skc_to_unix_sock(). [0]
> > > >
> > > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > > > but there are many functions where bpf prog can access the field
> > > > locklessly via fentry/fexit.
> > > >
> > > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > > the last refcnt of the peer sk while a bpf prog is accessing it,
> > > > resulting in use-after-free.
> > > >
> > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > >
> > > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > > by marking the pointer with PTR_UNTRUSTED.
> > > >
> > > > If needed, we could add a new helper later that uses unix_peer_get(=
)
> > > > and requires bpf_sk_release().
> > > >
> > > > [0]:
> > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > > Call Trace:
> > > >  dump_stack_lvl+0x5d/0x80
> > > >  print_report+0x170/0x4f3
> > > >  kasan_report+0xe1/0x180
> > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > >  bpf_trampoline_6442564662+0x47/0xab
> > > >  unix_shutdown+0x9/0x880
> > > >  __sys_shutdown+0xe1/0x160
> > > >  __x64_sys_shutdown+0x52/0x90
> > > >  do_syscall_64+0x6b/0x3a0
> > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >
> > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef=
6cae0@rbox.co/
> > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++=
++++
> > > >  2 files changed, 43 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 3135643d5695..b328a1640c82 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map=
 *map, int off, int size, u64 *val,
> > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_=
rcu_or_null)
> > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trus=
ted)
> > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __s=
afe_trusted_or_null)
> > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_un=
trusted)
> > > >
> > > >  /*
> > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area=
_struct) {
> > > >         struct file *vm_file;
> > > >  };
> > > >
> > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > +       struct sock *peer;
> > > > +};
> > > > +
> > >
> > > That's just one out of many. It's not really a fix,
> > > but a bandaid for one case.
> >
> > Right, this is only one example where a pointer lifetime
> > does not match with bpf prog.
> >
> > > We discussed it in the past and the only way forward is to make
> > > helpers only accept trusted args.
> > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > We should do the same for helpers.
> >
> > What about just reading an untrusted pointer ?
>
> What do you mean 'untrusted' ?
> There are 3 types of ptr_to_btf_id:
> trusted, untrusted, legacy (without either trusted or untrusted flags).

Ah sorry, I used 'untrusted' since the pointer is not always
valid, but I think legacy is the one I meant in this case.


>
> kfuncs now accept only trusted, while helpers still accept
> trusted and legacy. The legacy should be disallowed.
> That might break some bpf programs, so it has to be done carefully.
>
> > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > could optimise out branches that always return 0.
> >
> > Currently, this passes the verifier and can trigger UAF.
> >
> > u =3D bpf_skc_to_unix_sock(sock->sk);
> > if (!u || !u->peer)
> >     return 0;
> > if (u->peer->__sk_common.skc_family) # unsafe access
> >     return 0;
>
> No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
> treatment. So above works and won't crash the kernel.
> It's effectively inlined probe_read_kernel.

Yes, it doesn't crash.

I was just unsure about the bpf expectation [0] like how we
should treat KASAN use-after-free report by bpf prog reading
a pointer whose lifetime is not guaranteed by bpf helper/verifier.

So, if this is WAI, I'm fine with that.

[0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBG=
qKcUT0iMA@mail.gmail.com/

