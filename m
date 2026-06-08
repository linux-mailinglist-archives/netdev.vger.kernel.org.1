Return-Path: <netdev+bounces-296735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nAMSLLg1J2pitQIAu9opvQ
	(envelope-from <netdev+bounces-296735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5E65AB17
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uo2OUVbR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296735-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296735-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 778ED30055F6
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5823AEF22;
	Mon,  8 Jun 2026 21:35:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2639E9D5
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:35:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954541; cv=pass; b=ozA8ymnrzaP51D7G6cTJ05uXcezzQxZeTsHQCj1MOFmQxjKnvEt90aftCFOoFZLbbMftfaqytkfEXfixmx13z8QdY5Cr2r9ZlsqY8q77W2bQKH4k/vMUNbo/21U46p1yesq+gd7tu/GZ5ic3K9y5m6O8NYEsxy+sMmk7H3y5D68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954541; c=relaxed/simple;
	bh=1A5zKEqAscmhGqROJUPu7ZRqKa1REMrRG6hrstD7bCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKIveQXpenZ4oLlQ3th/yAYYteJI0xSD43xX7HldrPHkqfvn06IMGyh02zd4DAPLOXAgnRSqWlG8EGM/BDzqx7wVF55H1oOBR/vcQeU9nYNI1zhAfPZ7Gha8SMe0EbVxdGycmsEKPqCSATS5moG48DnrhyLe+uBfyIN2JBHARt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uo2OUVbR; arc=pass smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13817614cd3so1478628c88.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 14:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780954539; cv=none;
        d=google.com; s=arc-20240605;
        b=QS8O6w+G0AQ8g97YZi1TwVFL57FUKkgL0gGBM40PacVmBvcOu9WbuZkc0/OqqmuAa5
         Xmqek97Ni+VhbGlAuwnitkcbuutJgz6NG51Uq1yoAmwx8J0Ed6ChEl/NVPSid1Sd9ji4
         rENOzAAn7g6Ht447SaK3xQRmQxDzha/RqX4negGGR9/eg9f5GwmAUy4BWWRgBSDDGqAF
         nV5wPB7z5QFDz4VYelwgr+sOnfAJSrrblIZ0U/JDXXY2KhPtZjg22Y6NfDUfmU8mEUXa
         rEx6dr2ehc9vU+8UsI/CaNAgSXr7y/8wTy4ySXaCgIIwN+Iqc62Jn1DHJYQ72IhBXtRP
         ok5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfEI3p6vfYRJLFYBKXtD1V6ydUrj2yea5C4lNu0JJ2A=;
        fh=OjffW8p5H2XEIeRev/ThBkClUgFf7tlRYSJj6+8BnkY=;
        b=e0+8GiBBhdrHEiFCUJ2P8uUbRHv+f9VHzZdF+su0WY5xO2WrcGITWvFNE7/mEHYhzG
         ruWCgo4mGoCkFOJrV9qBqe9Pt+QEaq5f81vf9bPm7OxvgEd3OS/A1485siIjWxq+pOe8
         kvSV5uBLv1ns1Qtkcfva9tXGsGOVVGQ1HbQlYLUWrsHnauaY++jPfv7ggWdw592FNOrg
         6nElkdwcDFv+th5ZtkIQzxSpd/BBDg/fE1hteuuvPD8UJGj0A0GnSV1YHXdGW6/ExSI8
         mBBnZ0Vim6Jt+m3VYTfOfkE3UKcZ0hXG46AktiHw0yiqyozktFxXX6SmgQnMSJ7Patp0
         c7/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780954539; x=1781559339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfEI3p6vfYRJLFYBKXtD1V6ydUrj2yea5C4lNu0JJ2A=;
        b=uo2OUVbRa39U0wC/EJUyZ70AuVfZ4D5qWOO2Jx0vUNXm1mfnhx1yYx3KDRhv/2aYI6
         F+0vATXhlu+ZEenNggghGhACfDSEh4azmVb3o4lWBECZhaDDjqrusmk1ToCFJo1VqK0s
         wnaGRd9/XnEE789JK6TTDah6qKHGr5ApOV1DWp6AJX+cFzmmkN6jLaZ2dFXQXREL8Xmt
         iovp1VAtUmVrZXe69ZZbsSj0jSDFfS9xXcsilB2TlHTQGcOxJIvraR+A3CzU2jxYAEch
         w0rayS+pgRH0M+35kI4+lSsMFlAk7BXYhTqt2Q9drGcOLLjkkzhvIjEQc/ZxXWDl8aMf
         zceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954539; x=1781559339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfEI3p6vfYRJLFYBKXtD1V6ydUrj2yea5C4lNu0JJ2A=;
        b=UIJGnMot6EW19aROkdCTecTQPFABJw2ZzQlH+mcD9ExCpU2KJA4ybAVBw4bLsrNFPe
         /FRhRFCxSYyH3se0HiQHT/B9n+ClAd1Y3EWcOV3JLwVsSqL6P8ecsLUnie4q53N1f97M
         t1u6loOJWnI99ZqtU5TLfIHLUXIQqX61B30Ih0GBth/UdwVuneyWYsjQdQU5g2NN7Ymw
         kACftXGQkNCqtiYzV6ODBJS5khcRZbXyOkgbEHsHzkhxcGrGjy5wk191mwqre+1zR/vP
         zd4NOJruxlKntoIqW6e8CUuXf01B21kR3iBOh4GMhdC1oYXafPnzDgcpgqC4k2XB+8le
         pirg==
X-Forwarded-Encrypted: i=1; AFNElJ/YPy9m/eNXlOw0OB17GIIkinA/cuBBqfp+spwwetjWRt8TXyZdBjIuOR0Ybw/rb3GBe30eytA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5IpkMNzPPzDF3mE2yGIznTqgMW7WcI4uAmyt4CK/3h/2BH6Y
	A/O+YWU1ynO00oVgAkHMpeNz9k4XDMQtSdfNeehE1PW1wIzRNrwAwXbRzSN3MSCekMKW2UVtpjf
	WNCSRpnJruPLgpZAZaO+PHDf9V7x55taKCA1uirfT
X-Gm-Gg: Acq92OFhbZrmnrX37F+ia7UecEZ691OBuImGttYuqU6O/p+be9oY+0Adm36aF2LSBSd
	+RqR1or5LvvF2vMFmwt8wv/dMptQ8FlJxxSljRVGnIouJr/9Lu1bdwWYfXs5gVtZWUPkB0gaUqj
	cACy7bgc5YuGrZrecRva/CzKaAk3coJ7ifsw1wNI2ulXXwJxY4aoEu8mIvZ4Guanlg4IZVLTqi5
	m7ul9+FRphYALxE6PUAH4ApvbmRKxWZeE7uzrRXuYV94SP3kpvC8QWrcZnZtzlUGim/SeLVqede
	mYyxrkSaux6bIyil4KvQjBpjhkKLXr+Nf8+WkFfRCH4+r1dDwpyDZ+7BlU4X+YXvqzws9Yobh/m
	5d4kwQKquwtm+55yb4F2M3TDNpvwr9f6wxWEsVBvxU7Km4H4fFO20diHvoO9S
X-Received: by 2002:a05:7022:503:b0:137:f0d8:4ffe with SMTP id
 a92af1059eb24-13806764206mr8627440c88.36.1780954538395; Mon, 08 Jun 2026
 14:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
In-Reply-To: <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 14:35:26 -0700
X-Gm-Features: AVVi8CfNPnu_11Y9w6rUPwUMj9tXfuWG5h97XU5lB3N-O0DJfMa4Mh5VgPAmWag
Message-ID: <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296735-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,iogearbox.net,wand.net.nz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1F5E65AB17

On Mon, Jun 8, 2026 at 2:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 1:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Mon, Jun 8, 2026 at 1:02=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> > > > On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@l=
inux.dev> wrote:
> > > >>
> > > >> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> > > >> causing a panic when the skb enters the wrong L4 receive path [1].
> > > >> An initial attempt tried to fix this in the BPF helper by checking
> > > >> iph->protocol, but Sashiko [2] revealed that BPF programs can bypa=
ss
> > > >> this check via a TOCTOU attack by modifying iph->protocol around t=
he
> > > >> call:
> > > >>
> > > >>     iph->protocol =3D IPPROTO_TCP;
> > > >>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> > > >>     iph->protocol =3D IPPROTO_UDP;
> > > >>
> > > >> Furthermore, bpf_sk_assign() has had the same class of vulnerabili=
ty
> > > >> since its introduction =E2=80=94 it can assign any socket type to =
any skb
> > > >> without protocol validation.  Since the BPF helper check alone can=
not
> > > >> prevent a malicious BPF program from crashing the kernel, add prot=
ocol
> > > >
> > > > I'm curious about the BPF maintainers' stance on this kind of "bug"
> > > > where admin tries to shoot oneself in the foot.
> > > >
> > > > I saw Alexei said this recently, and I guess it applies here as wel=
l ?
> > > > https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPC=
WHDQu2OWQx27_w@mail.gmail.com/
> > > >
> > > > ---8<---
> > > > Not every "bug" needs a fix.
> > > > If a malicious bpf user wants to crash the kernel they will
> > > > find a way to do so. Especially with agents.
> > > > We cannot realistically close all of the holes.
> > > > Right now the priority is to fix the issues that normal
> > > > users can hit and not bots.
> > > > ---8<---
> > >
> > > In addition to that I have to add that skb_steal_sock() is performanc=
e
> > > critical path of networking stack. Adding runtime overheard there
> > > because bots can find a way to abuse the interfaces is not a good tra=
de off.
> > > If there is no simple way to fix it completely on the bpf side
> > > then we have to flag this issue as "won't fix" and move on.
> >
> > I asked if we could fix this in the verifier but it seems difficult. [0=
]
> > Since this is triggered only by BPF misuse, treating it as "won't fix"
> > makes more sense to me.
> >
> > [0]: https://lore.kernel.org/all/202648182730.i4ki.martin.lau@linux.dev=
/
>
> btw is earlier sashiko TOCTOU concern real?

Yes, the selftest in patch 2 should reproduce null-ptr-deref.
(I tested one in a prior version)


> iph->protocol =3D IPPROTO_TCP;
> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> iph->protocol =3D IPPROTO_UDP;
>
> as far as I can tell past bpf_sk_assign_tcp_reqsk()
> the networking stack only looks at skb->protocol,
> so modifying iph->protocol will only mess up
> things on the wire (if this packet goes out).

ip_rcv_finish_core() uses iph->protocol for early demux
and ip_local_deliver_finish() also uses it for demux.

