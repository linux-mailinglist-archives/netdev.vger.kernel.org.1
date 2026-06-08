Return-Path: <netdev+bounces-296733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jqOVJnQzJ2r/tAIAu9opvQ
	(envelope-from <netdev+bounces-296733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA165AAA1
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:26:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Fs1lWboY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296733-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92AB33021CBA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB73A874B;
	Mon,  8 Jun 2026 21:26:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1183A6B8E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:26:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953969; cv=pass; b=Bnmk5JHcj0XbNQ9Ca/gLH+gKLNcyNN6gOEfoLcSFBd1pDCVZHmJrsTtukU0xCsFMhTkORNhRVCzT+2OUIOT4KtGuMa3+U8WmKkRn+6x3N8PyHZ4CevUkvNSH5e85c1+Y5S7a/kQzj2Rn6TGPEYNAPi7rWKKqQ2SjAiitP1Nvzi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953969; c=relaxed/simple;
	bh=uf5HZTHJoAXInjP6F/jPwTZEqhmJlXS7G2mQJDPJKIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmfNQVxW0iUzvFG5Srjd9F0miIcYuElYMBxaYhbvEDa+0vkHCNaxPFp9uxQEdG0hMH/dtZYrjnI/152zH8k2XSUrAxkcahMCXSpAYxPIXL3/QGBP8XW1NFoqrpKVX64vr4WKPl29/qciX8VLtHtG24gN+cBMU8gdXBdtNiBGk0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs1lWboY; arc=pass smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2230123f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 14:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780953966; cv=none;
        d=google.com; s=arc-20240605;
        b=QCHPhPNIxklfRTEoEW6pSNJXm91E8KmAeE2eDtsSyNOgjCYSePmxXVaWfjtcbK5zoh
         5WSg79GnWdWDmebL5JLlVtS6baLX7yzPJpXKdBXDO9mI/kMd+5UtEwNxD9/9BupBcZlY
         uwpTlGwlODHP50vU9UyJHCxNI6NQWWo8nQk24cgYzl/PQRNwbdl5SGKy4tpLuD767qF4
         MzBuRMi/NuGLRAyYAwezUWHgF7G4i1XayI2j64NVwUSpz5Y3bDMymIFQ08mKE9FKZ77U
         ci3XnQVyN1+eR89ZMl2W/OaQfyeA+2Rl4wYVTIq3eLvumhh0QzNdJXLpU76zPSQDjADt
         fmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbOXCSw4UW03CiAnUGJEGMnbivoK/CLI2jGJHgllnPI=;
        fh=5ZTXmI4p1QDHHxXDfiTLZ4h8HOQE3COhjupqHTtFYw8=;
        b=ikgnEKwJ2zyioWlQNaexRBezsPSYHRetDjw8hIHi9u3wgkTFRwEPDYNAMpLmqA33eh
         u8OTg/DaFm2kpzCw6vAkcGtmkpz6zYRbNVFXt8Oab67YwVbnoPgYPa5rqvVgDJX3ARp4
         aktotEM+AarnTH7g5z1vfsdLkuBwlGyu40ssDxI2ujPnc0xl9NEa8H3PtWcIwMvnyH9c
         TwDaWZHgOpbmYv0M52Ezj6/RNWQZlLn3GO5nIhsyzK0e38gGFYTsLYHfgPYvtZY7isYO
         eiRmpBQtpqluT+O86IcMTWo5DygynSwdDHRuLEcZfJqheLSNeLQ2Q6RfG4S4tKbCmsLS
         7+lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780953966; x=1781558766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbOXCSw4UW03CiAnUGJEGMnbivoK/CLI2jGJHgllnPI=;
        b=Fs1lWboYpHyPc0zTxwQpATFDS1TinajwLgIiUffWox8eqbd2QrjpOMnpADipxnDdUE
         adeXpbwH6QBzGeN7YrZefeJW1rFRdHbXh9efhtlQZvn+kNi7vLe35plR0BsxeXDk/R3i
         bf5PMgGrZMmkt8h6wOTcgdYR+4D875AswUHBqia5yNFTuvgMQ+pP9Jsr61IuOufJLV2I
         dXm6VetciYYiByJodoMDm2QHuviWQyOSyHOrXCppQfLaZ+3r1A7L9FAvhiikNDfTW+SD
         fSRN64uq4f72FYkijaLhnhnuZeAARE+w3K3n4VDFVv2SUrBng844Gye1g4tKESHmEIJa
         BGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780953966; x=1781558766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bbOXCSw4UW03CiAnUGJEGMnbivoK/CLI2jGJHgllnPI=;
        b=J4DogJMW3dt+qpioAcaAYBHCFXuW1GVnXSdkNlENxma2VKwWawvGXeeeNNLPyiSIhZ
         nAa783tjvAh6niVQ/KArHQ97m8hIqub+zYYXTZOPPpSmQ3zl4i1QisnW8yeLb7xLca+B
         I6fnpr35rVMJK6oYsWkQj9LB9Utnt/T2gj4DQGRbLWhuZOB3E6zx3taN51/clPX1yO6R
         1pJKUrT9rvdySZt8soWtzaTXQUChPfW4JmxyRhiMNnqM45brDMJ7SfCRxJVUmWhIBZsW
         3kh+q6PNT04d8V4gEM9Fe6YDZR3qDPkaE4vi360m0MclAt+NHhg47izvzP337V0UZKXl
         PjJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CeSjjx8Sd/V9WVCfaJnNy7eThY6k8PjYWNYipOc7KXdDBYmBWNs6Xc/6jMC1p5XR02SJkzRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9c/L1yyYSdoKVto/O74J0myV2EodgxxWIxf2AjWPugoA8fVK/
	9CDnc2Jv2WFNm8lTvPjbXWD1exLtmTw8DktQgvMwLCm7oyDBrnvBsCK5Y4FsMthaNtGXse7ac9h
	7Hd5XxN6ritEuhgUyGp4j559FFLDnXbg=
X-Gm-Gg: Acq92OH4ryuqmw3XaniDhGuaQsl0ATU7gsQNjylzKznQfb7B9slV7CK6wtj2nvIkn0L
	0NxuzW471xAl10jXmIcoI87NEdUaWkDAi5e8acTLCAFKTXVi4JqdJYg/9fzzIETrGkpx1CMo19O
	4t50LQP3lR+C3s+ThrrM50kKN2RzYhoOJKLFhQzevXCtPW1s96UEQ1UVNW3KmKSkZsmhelOUq0b
	0FdObfTPNEJ0e+vROeiTFc/hbX3Y2RBZ7GpqjYXRLa60beAAo/sundv9D3DjivSEt1Mw/iEXTiN
	mx1a8LfQYisleQrNqRIaCNzZxYHzKP/ouDq2bpuLche+/ygR0UbA4jlhiWRBY0hcBZKxf3xlx9q
	wKkvEwAe9w2CpYHAza0G3rSOJ98SHhh8jXso=
X-Received: by 2002:a5d:5747:0:b0:45e:f266:f4c4 with SMTP id
 ffacd0b85a97d-4603061efd1mr20310565f8f.29.1780953966314; Mon, 08 Jun 2026
 14:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
In-Reply-To: <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jun 2026 14:25:53 -0700
X-Gm-Features: AVVi8CcgT8ycMVDBgmvoAGA-VFeJoLSpPQAJdB-dJg65JsknvnohoOnZrD5JvOE
Message-ID: <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Kuniyuki Iwashima <kuniyu@google.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296733-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,iogearbox.net,wand.net.nz];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34BA165AAA1

On Mon, Jun 8, 2026 at 1:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Mon, Jun 8, 2026 at 1:02=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> > > On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@lin=
ux.dev> wrote:
> > >>
> > >> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> > >> causing a panic when the skb enters the wrong L4 receive path [1].
> > >> An initial attempt tried to fix this in the BPF helper by checking
> > >> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
> > >> this check via a TOCTOU attack by modifying iph->protocol around the
> > >> call:
> > >>
> > >>     iph->protocol =3D IPPROTO_TCP;
> > >>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> > >>     iph->protocol =3D IPPROTO_UDP;
> > >>
> > >> Furthermore, bpf_sk_assign() has had the same class of vulnerability
> > >> since its introduction =E2=80=94 it can assign any socket type to an=
y skb
> > >> without protocol validation.  Since the BPF helper check alone canno=
t
> > >> prevent a malicious BPF program from crashing the kernel, add protoc=
ol
> > >
> > > I'm curious about the BPF maintainers' stance on this kind of "bug"
> > > where admin tries to shoot oneself in the foot.
> > >
> > > I saw Alexei said this recently, and I guess it applies here as well =
?
> > > https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWH=
DQu2OWQx27_w@mail.gmail.com/
> > >
> > > ---8<---
> > > Not every "bug" needs a fix.
> > > If a malicious bpf user wants to crash the kernel they will
> > > find a way to do so. Especially with agents.
> > > We cannot realistically close all of the holes.
> > > Right now the priority is to fix the issues that normal
> > > users can hit and not bots.
> > > ---8<---
> >
> > In addition to that I have to add that skb_steal_sock() is performance
> > critical path of networking stack. Adding runtime overheard there
> > because bots can find a way to abuse the interfaces is not a good trade=
 off.
> > If there is no simple way to fix it completely on the bpf side
> > then we have to flag this issue as "won't fix" and move on.
>
> I asked if we could fix this in the verifier but it seems difficult. [0]
> Since this is triggered only by BPF misuse, treating it as "won't fix"
> makes more sense to me.
>
> [0]: https://lore.kernel.org/all/202648182730.i4ki.martin.lau@linux.dev/

btw is earlier sashiko TOCTOU concern real?
iph->protocol =3D IPPROTO_TCP;
bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
iph->protocol =3D IPPROTO_UDP;

as far as I can tell past bpf_sk_assign_tcp_reqsk()
the networking stack only looks at skb->protocol,
so modifying iph->protocol will only mess up
things on the wire (if this packet goes out).

