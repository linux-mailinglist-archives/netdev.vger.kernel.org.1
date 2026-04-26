Return-Path: <netdev+bounces-281148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EwuKJzv7WmYpAAAu9opvQ
	(envelope-from <netdev+bounces-281148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C51469776
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DEB330137A2
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674B314A9E;
	Sun, 26 Apr 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1tZAW6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E834F24B
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201026; cv=pass; b=qWZzdUttV7sbl+pWN2RVZss65e0bK6Is8DQOB2ZtYoBaWeLwamZORhhL/17tz/TP5nppE3KC2Cb3mXSMJ5bwxGmnjQYui2NUKj/pw5nZEczjKYtnl8VkkELBTgBIZud8Uuvs4uLZZGLNI2op/vUlS77aAlfxEq9wBjB95lHXG9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201026; c=relaxed/simple;
	bh=X38cTerivhNHU1J9r4lUFXkdCuAqrMGRnWfCp7e1Rm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ4otj38ODG6IpfRCtevhCUvepY6VZ3a5c4gPazM9TPQO9V4eIsOA0Ww1uf/EMLKQHF0MBvVqf3VxdDtK0t4ORgtQCjE7ufF1DuH4Pti7zu+6Gng6yWcb0HSlNoY/oE5y8zL1fdHERAuVRIETI5uRc2zt24SYuLkuuLLYc1mL20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1tZAW6L; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6720c7968e4so6493300a12.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 03:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777201023; cv=none;
        d=google.com; s=arc-20240605;
        b=NwwJrI8YQZ4YJnyp+uzoTQkucivOgO5MRV1xZEDTViXCiMw+eXjjNUUxyoP7aB8j1M
         jsjRkfy6D7YdrGTxdPxDSjvrbuU1lqzf8cWXHv3PPKYHGt6+gk2R2LaCFM7Lrfax40j0
         XW5UaEXBtRCVKkhOuoXRxs4CXQHJFi4Jw6VJQa4DccHiy5JKI7y83T5Lb0rAJWtbQK8v
         ptANnk34lmXlcOrDjTF9cB1K4wEvdK5Gw70YUCWPdPie54LiCc5c5H0roCIoBZwtTZkj
         a+qWrZMlu1TW/Qjx8l++zp8J6fp4FRp2IN/WySqyKgxN6F9kisms1rHrlCe6UmN7e8ui
         aXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FAsbbL0BHO216A/DQubjOAaFJLCW1lvrbacZy8+D6FU=;
        fh=6a5yv+NmAX13BqViXXOV851Ls1DQwledRclEOR2007w=;
        b=PDVbSJ50QbwzEHzEYzJ9y8fkx8xwZAWk9qFZJK7e8aM/1VchdhQKTFFLXsjgZHaq7H
         apCuLG/z8dh4opRQIcq6OfEakmJPUcfi4gfJvDuDmtv+8BHa1Xr7jOgyOvkQ/swjHEAw
         QFBFBReSDIaOWh0+u2k3BPmjjSo1ih85UjQ1LjA6NmqO52PPhqGi4rQ4RzOlR2pcttvY
         Qsk+A8HhaepqFkKetzUG5mQ+dhDYuSyncVVqGRJGWXX4/XRQoNBGKjw1E+llyO3fApza
         IpIX9iHDo9a7uFqCmVv0HOCFQZiM7r0OrHPdu+auUp+0UBj8o6UX9t6BjvkbFbNt+sgs
         IkQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201023; x=1777805823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAsbbL0BHO216A/DQubjOAaFJLCW1lvrbacZy8+D6FU=;
        b=P1tZAW6LBUr2sEffaV7MGD5XcdQ2iLSHL3XPDDK4Pw5yR0rncHdPuqWtgiLdWWtbzw
         c4Flphm1M3X+9hvTB3iZyKwARZCQkxFtwa1FufzOzPnCVFk/G1jGtvJvbiwWwtZxuKij
         doa1rq1wO1J2F5TtpGuZSYXUK6TZjLeiegEc0AA1nyssZZ7yBVaLutQVA0pD/GjQR8xH
         w160RCDrEn8olxk+tGlBXGprxdMq/Euy64ylyBKMpXCbST4fvP+TxGbWdIgrfzR3IP1k
         0xGzRPosUGd0I7Uk/JC9EN4ycXUWz9p9C2B7N6EZKDvRhAQHmvvgrK8DfPE4aQhLlymv
         auVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201023; x=1777805823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAsbbL0BHO216A/DQubjOAaFJLCW1lvrbacZy8+D6FU=;
        b=qk27+vTmh5cyLMge2D/JWPc88locu9Jl2HFcuj2T+VERVrL0DVLTbSiXst1270HNm/
         AoMCGQDtTdMLual0gL/BYqfNDCioav2Yuw3WnRuojGxlM6WV6b0aWA8ooQU03Zc5XpGr
         nPJe+dZfM4XZG+yqHJFL/A6ClQbHPXsKk0EjcI+4fw6PzwZu5vQovSvO+EokXM8UYAxX
         9PoeCk3iYg6lTASb3/eTAIE9RZDSQruA/Zxu3A1Nc9Zzf42/Xj9agRN3xTL31SKR8C81
         TW3A0dahLMqJVhr2gu1YHYn2E5Bc6J+pAyuoEGjudxF2wDi0JPhpMv0MADhr/G79DUc7
         R/Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/CDTSgeDVCAGYIN6M+UFVZ1FqNAdrnEr1iSunJkty7wJVNjxHigOO9qYHVpOpJnaos1iq1tOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vN0HoPWeHchZYEvqxnBQ11kBJYXhfAxkmI+d9gWr/qYf48J3
	HjNOHxI1auOsNMI+jqg7Zr2gt/BIclwE0k2Z6/11fCvNyG3I5jPIi2YJCi70lC0BRgl77l1YZ1y
	9qk9PF3xvAoZ4GumltfvLROLJeVRAv1k=
X-Gm-Gg: AeBDieuTQ9nM27AqlMnzyhF+Not5sN6L0gMhffinldaZ/jUvzCY4YV6mzqRgj5eo6JV
	NSmnyYcOBb09e9sn8GCEAkG1l+j4JN9kE8m91d+jGdESaJOssxLt3DeiphT+X8XBces/9A2p0aX
	1UC4hrMmnWffhjtpt4fY/gRSRNgPLtUvFFvZtQlF5K+whEBBrF5V+zmNMS/MYSldegAK69KjWAT
	lPzSEkXV+Y7MBnTXRzdffT2rGaqzwR9t+j88Ky1/z3slTmwsolXRHwalRKJ2U/h1MrOCfmsyPje
	/IUFww==
X-Received: by 2002:a05:6402:24d7:b0:672:c664:38d8 with SMTP id
 4fb4d7f45d1cf-672c6643c80mr10597594a12.2.1777201022428; Sun, 26 Apr 2026
 03:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425075521.736328-1-daniel@iogearbox.net> <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
 <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
In-Reply-To: <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Sun, 26 Apr 2026 13:56:50 +0300
X-Gm-Features: AVHnY4JE3FI-RH8cFOZUZUhlgG6FGEpf5tEZ4C2LTLRePqAAsfcg1n2brxTBPL0
Message-ID: <CAHfVqdVmUf189n0vxZXmzBH0+Cum0m_xZP74Vkdx4OReGyNDBw@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Justin Iurman <justin.iurman@gmail.com>, kuba@kernel.org, edumazet@google.com, 
	dsahern@kernel.org, tom@herbertland.com, willemdebruijn.kernel@gmail.com, 
	idosch@nvidia.com, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 09C51469776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,herbertland.com,nvidia.com,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saeedbisharaos@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, Apr 26, 2026 at 1:38=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Justin,
>
> On 4/25/26 12:19 PM, Justin Iurman wrote:
> > On 4/25/26 09:55, Daniel Borkmann wrote:
> >> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> >> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> >> find a non-extension-header protocol or run out of packet data. The
> >> loops have no iteration counter, relying solely on the packet length
> >> to bound them. For a crafted packet with 8-byte extension headers
> >> filling a 64KB jumbogram, this means a worst case of up to ~8k
> >> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> >> for example, is used where it parses the inner quoted packet inside
> >> an incoming ICMPv6 error:
> >>
> >>    - icmpv6_rcv
> >>      - checksum validation
> >>      - case ICMPV6_DEST_UNREACH
> >>        - icmpv6_notify
> >>          - pskb_may_pull()       <- pull inner IPv6 header
> >>          - ipv6_skip_exthdr()    <- iterates here
> >>          - pskb_may_pull()
> >>          - ipprot->err_handler() <- sk lookup
> >>
> >> The per-iteration cost of ipv6_skip_exthdr itself is generally
> >> light, but skb_header_pointer becomes more costly on reassembled
> >> packets: the first ~1232 bytes of the inner packet are in the skb's
> >> linear area, but the remaining ~63KB are in the frag_list where
> >> skb_copy_bits is needed to read data.
> >>
> >> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
> >> (default 8, minimum 1). All four extension header walking functions
> >> are bound by this limit. The sysctl is in line with commit 47d3d7ac656=
a
> >> ("ipv6: Implement limits on Hop-by-Hop and Destination options").
> >> As documented, init_net is used to derive max_ext_hdrs_number to
> >> be consistent given a net cannot always reliably be retrieved.
> >>
> >> Note that the check in ip6_protocol_deliver_rcu() happens right
> >> before the goto resubmit, such that we don't have to have a test
> >> for ipv6_ext_hdr() in the fast-path.
> >>
> >> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> >> IPv6 extension headers ordering and occurrence. The latter also
> >> discusses security implications. As per RFC8200 section 4.1, the
> >> occurrence rules for extension headers provide a practical upper
> >> bound, thus 8 was used as the default.
> >>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   v1->v2:
> >>     - Set the default to 8 (Justin)
> >>     - Update IETF references (Justin)
> >>     - Add core path coverage as well (Justin)
> >>
> >>   Documentation/networking/ip-sysctl.rst |  7 +++++++
> >>   include/net/dropreason-core.h          |  6 ++++++
> >>   include/net/ipv6.h                     |  2 ++
> >>   include/net/netns/ipv6.h               |  1 +
> >>   net/ipv6/af_inet6.c                    |  1 +
> >>   net/ipv6/exthdrs_core.c                | 11 +++++++++++
> >>   net/ipv6/ip6_input.c                   |  6 ++++++
> >>   net/ipv6/ip6_tunnel.c                  |  5 +++++
> >>   net/ipv6/sysctl_net_ipv6.c             |  8 ++++++++
> >>   9 files changed, 47 insertions(+)
> >>
> >
> > [snip]
> >
> >> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> >> index 967b07aeb683..a5bbbc16e8d7 100644
> >> --- a/net/ipv6/ip6_input.c
> >> +++ b/net/ipv6/ip6_input.c
> >> @@ -403,8 +403,10 @@ INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct s=
k_buff *));
> >>   void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, =
int nexthdr,
> >>                     bool have_final)
> >>   {
> >> +    int exthdr_max =3D READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cn=
t);
> >>       const struct inet6_protocol *ipprot;
> >>       struct inet6_dev *idev;
> >> +    int exthdr_cnt =3D 0;
> >>       unsigned int nhoff;
> >>       SKB_DR(reason);
> >>       bool raw;
> >> @@ -487,6 +489,10 @@ void ip6_protocol_deliver_rcu(struct net *net, st=
ruct sk_buff *skb, int nexthdr,
> >>                   nexthdr =3D ret;
> >>                   goto resubmit_final;
> >>               } else {
> >> +                if (unlikely(exthdr_cnt++ >=3D exthdr_max)) {
from performance perspective, isn't it better to have single variable
that initialized to max_ext_hdrs_cnt then decremented until reaches
zero? that will take less cpu cycles and variables
> >> +                    SKB_DR_SET(reason, IPV6_TOO_MANY_EXTHDRS);
> >> +                    goto discard;
> >> +                }
> >>                   goto resubmit;
> >>               }
> >>           } else if (ret =3D=3D 0) {
> >
> > The hop-by-hop options header (if present) is not taken into account ba=
sed on the above. However, the max number of extension headers (implicitly =
7***, as per RFC 8200 Section 4.1) must include it. I suggest adding this a=
t the beginning of ip6_protocol_deliver_rcu():
> >
> > struct inet6_skb_parm *opt =3D IP6CB(skb);
> >
> > if (opt->flags & IP6SKB_HOPBYHOP)
> >      exthdr_cnt++;
> >
> > *** FYI, rounding to 8 is fine for this fix
>
> Ok, ack, I'll look into adding that in a v3.
>
> >> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> >> index d2cd33e2698d..93f865545a7c 100644
> >> --- a/net/ipv6/sysctl_net_ipv6.c
> >> +++ b/net/ipv6/sysctl_net_ipv6.c
> >> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] =3D=
 {
> >>           .extra1        =3D SYSCTL_ZERO,
> >>           .extra2        =3D &flowlabel_reflect_max,
> >>       },
> >> +    {
> >> +        .procname    =3D "max_ext_hdrs_number",
> >> +        .data        =3D &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
> >> +        .maxlen        =3D sizeof(int),
> >> +        .mode        =3D 0644,
> >> +        .proc_handler    =3D proc_dointvec_minmax,
> >> +        .extra1        =3D SYSCTL_ONE,
> >> +    },
> >>       {
> >>           .procname    =3D "max_dst_opts_number",
> >>           .data        =3D &init_net.ipv6.sysctl.max_dst_opts_cnt,
> >
> > I've given it a lot of thought. I came to the conclusion that we should=
 use a hard-coded value here as well (just like we did for 076b8cad77aa, wi=
th the same logic), not a sysctl. IMO, the main reason is that it provides =
as is a suitable security fix to be backported, i.e., the max value is the =
max number of EHs allowed by RFC 8200, Section 4.1. Also, we remain consist=
ent with draft-iurman-6man-eh-occurrences (I think Tom is about to send a r=
evision of the series soon for net-next). What this series does is not only=
 enforcing ordering, but also verifying the specific number of occurrences =
for each type of Extension Header. Which is totally compatible with what th=
is patch does, i.e., limiting the total number of Extension Headers (regard=
less of their types) to 8. I guess what I'm trying to say is that it seems =
like a good plan/compromise and that the aforementioned series would build =
perfectly on top of this fix.
>
>
> Initially, I had a hard-coded constant (when it was still 32), but Eric's=
 comment
> was to rather go with a sysctl, such that if someone unexpectedly complai=
ns, then
> there is still a chance for that person to fix it up via sysctl without h=
aving to
> rebuild the kernel. I'm okay either way, but presumably given we're now b=
eing more
> "aggressive" into lowering the default to 8 rather than 32 then having su=
ch a fall-
> back is probably better.
>
> Thanks,
> Daniel
>

