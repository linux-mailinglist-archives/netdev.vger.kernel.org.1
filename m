Return-Path: <netdev+bounces-285767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHwhNWfJ/WkpigAAu9opvQ
	(envelope-from <netdev+bounces-285767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AD4F5C7E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D2E53019457
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B13ACF0F;
	Fri,  8 May 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfxAoXh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A93ACA60
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239845; cv=pass; b=lR4JT93eoXAmX75WJMMelgUgeFhfkgr6s8nhcL+nrHufC0aSik0tq/Oq5l+cqUI5TsQnU3XV2w6iZdVi0LpKLAqFrIhGWcfxcstJj3xywcO+9JGy8tU18ts0R3z5jvWbxMNRKRR3zU4cF43UZbsOjPoI/3LaMTaGXygvfDSkTkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239845; c=relaxed/simple;
	bh=CBfD4iRTH3E14SN4QEqZr0RaBqNvQko8KctGms5BCcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF+rIW0GBgB0S2oGuhttHxp18YevTNgdwLcfRTgsB4yUHeULVWXFOyDwWOEg5TG0rRxPeK3//YTF4NP0cMPgaDI69MVq8prn3bS+vwZ35rtu9SaU7qIvZRv3X/6F1JsncVSELOx/uJ+ZDJmkL5fnDlKECBBiaKO1Dm0hmkGNIy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfxAoXh7; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-130b2295ed0so5574450c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 04:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778239843; cv=none;
        d=google.com; s=arc-20240605;
        b=Jq5uKMe32NSPdWtP3UVgRdjuRFzU7t6+XHIjpgRASmnivTaz7I/+PPkUXV45zoxWMB
         oS3hMF9/l6FrcuAsTML3D4NSGXS+BmwRx6I4dlVjR6sxWTymd3X7LHPPZh3AfpQcSjWq
         g+N5e6hznKuzIGt2zTbXr9A6htCOLiwBYYrfuXPr+NFa3WeDx7gXsJrqDs5nNVaov/QK
         AcgppUoRc6l1Wx5blUWVFldS5fSYL6HbmnQewoEbQmGuVkKoyE0XIERJCATv+d1xXzU3
         m/sk9l2UedMoicAC6YrhYWHUjLas0y6ymc6Vki2enPdyr9JgcEcrhCk5ZG8CGbJ4k933
         nSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kv/cN9JZtLINOz191VE4jyOuiPMT2DphC53i8RZ2MOk=;
        fh=Et4EP8VU9vC7SLrzBZikessMXdGvhX3oxMEtOGrBgjg=;
        b=kP0GkzspdV4Mr0RoDLNSiupKViBIrMyetrm5JLVi7O2N1sgStuXJvnpvytuSRVsKVf
         BsVpwem9giZCBIXtSSexJ+YB6rZh6m1QgewjrR2KPL6VXCY+sTl/ZPTJmVyhmrDaR5q0
         kyaJU3RhTPHLUoUiUZTX6/9hyH3p77ldTsswgnkX1SSOh9auT0CmJNTOONxft+k3SvJL
         koSM9+HCylLJCNn1zYUs0sK3FMKeRjL6megtHzmItQNnuiUF6H1fKLBtLJ1AyF29qT+Y
         /g8AffkXS1xaAD4VRIvmaKaOeYd0fwu0okdhXbW8Gzj4NoKIyCH97W4703X55VJWovPk
         YNuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778239843; x=1778844643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv/cN9JZtLINOz191VE4jyOuiPMT2DphC53i8RZ2MOk=;
        b=EfxAoXh7ZNOtZ6fsyUbKJw/95kCMKcIxREmjyJPpXIiq+mlMYp2pxPmOR6ZCo1HPRj
         mLsQWvTT0Gzw5M1SkoogzpkXAWuzy8suTdtJ6aCaJEhj7xQvtzuRImY88cpioQ78Rr4T
         Pfc2T3cBxktmn483+6lI+1mw895pJVD8ZCbF9KPCoQgr9EYPxNmpb+hRcZnnvz645EfF
         ROYyMDKOuouoTr7ULEjsx9MC7A9ZGtaIRiAu01eW7VVx1ut2F+dMSxJOielhAVNotbvg
         YfXOm40wyd4eX5SbBMjcpU3OV4m1kwp506glgSgxMmPTyUVW4golxWdHy16cvPt0/kAP
         4o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239843; x=1778844643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kv/cN9JZtLINOz191VE4jyOuiPMT2DphC53i8RZ2MOk=;
        b=PlMqHEbR6i6HW3ka4dqxqg5XuyH/pA5GgkZUoNpCVdEIHZ8/8SLcYqJad++Fhn6pjA
         4ocoPthLlWnxc+A69x3JEIvc2iRxjjCj7JiIsh0bPxG16fdZy3+da3tyHlTR61o3sF0O
         MwQRs9I/oyQHmWlcfq9ITtrT93m+Gh6myYaFOn6y5PxbipQEKCOwlKddoz4ebCFLzQDo
         2g+gyywUMl7Sy23TEvV8UU5hgWL5V0O88uTnsRBFDlXCVu0XJ5DSfzmv49AqAEuhS8iI
         bgm+AqNlvOHkMFsB0vB9m8hDkVy3KKUfNdpk8lE7nD4NFEhCiqlUpDtIabMvsZ13t4w9
         3xLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wvnRBNUFxKP0A3/1xCV6mv39zhIqBrnQntKtSfjaHqkluxxxNuV7VRdAq2LDPpg0i3cdYMCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60xIzLmJdaNELIXa5JVm37Mgw+eSUJiszFJgpPptT1HAl/wp6
	zvsyeV+ADEBHv9IpCTyqbOWANwypZUFwWumkBBhq8wWllnbqeVuKEEQzSZKrzoF4poNPc8MhKvz
	envWKYRr2GuZphX7trHOHxK+rcAhLhWSxgQ99oi0I
X-Gm-Gg: AeBDiesr2VBFZcHEqbtwYp8KkHimnxmcDWMq2/h4uBK4yjM8T1y3Qdkqs9YP1qd4qcf
	moGEWU6HYEtS8+CutpiBkwP0rxBKxrgultC7oNfr8QJRb9na5VaEzWKIOQiskGFxeVH5mhLx3O2
	qynFExRB9GczwQJJEoBYQKM0kVB9/glHs3DeO8C8RwdmwrPLZ4LZL/L4Z+iSuEcsFEQ+0HCa83z
	gaXYixEWEuq8vKamXtD342d1ax/qqXU8TwG6n1DhQ48T3hDzpzfMU2b5DmSXPUZ/ivVc7PsPTV9
	HQjXgk3HR6caiuBHGTsJmXnQo/Zuvaibcr9LDRzc/5miJ6ti0ERJkkM3EzESsNcoJRYlExCbm0X
	dOTVAMfWq5Oow4ejQvJ9be0vpimsYSuw=
X-Received: by 2002:a05:7022:ea24:b0:12c:87f1:f41a with SMTP id
 a92af1059eb24-1318e91771bmr6366203c88.21.1778239842029; Fri, 08 May 2026
 04:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-8-kuniyu@google.com>
 <21ee2d5d-fc8c-497e-aa98-e5e4e3fbecf8@linux.dev>
In-Reply-To: <21ee2d5d-fc8c-497e-aa98-e5e4e3fbecf8@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 04:30:30 -0700
X-Gm-Features: AVHnY4KkzSQ5bG2E11JHf5_h3yq1P29unHw-1nEvdIdkT055s-AbAypVF74WclI
Message-ID: <CAAVpQUBv0Uc4Xi-4wK2S63FqtXHHkLqJTotOxxDyhqFknoZG_Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4E2AD4F5C7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285767-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email,bpf_sock_ops.data:url]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 3:37=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 5/8/26 3:33 PM, Kuniyuki Iwashima wrote:
> > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > Let's invoke the BPF SOCK_OPS prog when
> >
> >    1. TCP stack enqueues skb to sk->sk_receive_queue
> >       -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> >
> >    2. TCP recvmsg() completes
> >       -> __tcp_cleanup_rbuf()
> >
> > This will allow the BPF prog to parse each skb and dynamically
> > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > until sufficient data (e.g., a full RPC frame) is available
> > in the receive queue.
> >
> > Note that the direct access to bpf_sock_ops.data is intentionally
> > disabled by passing 0 as end_offset.
> >
> > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > with bpf_sock_ops because payload is not in the linear area
> > with TCP header/data split on and skb may contain a RPC
> > descriptor in skb frag.  This also simplifies the BPF prog.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >   include/net/tcp.h       | 14 ++++++++++++++
> >   net/ipv4/tcp.c          |  2 ++
> >   net/ipv4/tcp_fastopen.c |  2 ++
> >   net/ipv4/tcp_input.c    | 10 ++++++++++
> >   4 files changed, 28 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4e9e634e276b..003e46c9b500 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_chec=
k(struct net *net, struct sock
> >   }
> >   #endif
> >
> > +#ifdef CONFIG_CGROUP_BPF
> > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_F=
LAG))
> > +             bpf_skops_rcvlowat(sk, skb);
> > +}
> > +#else
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +}
> > +#endif
> > +
> >   /* From net/ipv6/syncookies.c */
> >   int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr =
*th);
> >   struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 1d9e52fc454f..80144b97a87a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copi=
ed)
> >               tcp_mstamp_refresh(tp);
> >               tcp_send_ack(sk);
> >       }
> > +
> > +     tcp_bpf_rcvlowat(sk, NULL);
> >   }
> >
>
> tcp_read_skb (process frame 1 and __skb_unlink)
> =E2=94=94=E2=94=80 sk_psock_verdict_recv
>      =E2=94=94=E2=94=80 sk_psock_verdict_apply
>          =E2=94=94=E2=94=80 tcp_eat_skb
>              =E2=94=94=E2=94=80 tcp_cleanup_rbuf
>                  =E2=94=94=E2=94=80 __tcp_cleanup_rbuf
>                      =E2=94=94=E2=94=80 BPF RCVLOWAT_CB
>                          =E2=94=94=E2=94=80 bpf_sock_ops_tcp_set_rcvlowat=
 (wakeup=3Dtrue)
>                              =E2=94=94=E2=94=80 tcp_data_ready
>                                  =E2=94=94=E2=94=80 sk_psock_verdict_data=
_ready
>                                      =E2=94=94=E2=94=80 tcp_read_skb (fra=
me 2)
>                                          =E2=94=94=E2=94=80 ... =E2=86=92=
 tcp_read_skb (frame 3) ...
>
> For strparser it use read_sock instead of read_skb and it will become
> more complicated...

To be clear, this feature is NOT to use strparser/sockmap.

>
> I think this will cause stack overflow with amounts of skbs in receive
> queue or infinite call(not tested) for sockmap/kTLS/strparser.
>

BPF user is responsible for not doing silly things.

tcp_bpf_strp_read_sock() can have loop detection logic,
but it's only if really needed.

