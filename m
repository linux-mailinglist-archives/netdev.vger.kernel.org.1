Return-Path: <netdev+bounces-253548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AgTOtedd2kCjQEAu9opvQ
	(envelope-from <netdev+bounces-253548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 720708B37E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC95D30842F1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5D346FC3;
	Mon, 26 Jan 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Nwno+SZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C12FE595
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446630; cv=pass; b=X78eF7XQB+VRmxlz0nFiJqMFtMlisP8g04gUu6q0igbWd651HmN3KpTJGvF0ZjD3mu5zt0pV8BVQvPzCWBDLt446MahMpuAnwaBpMAK7fi7ME+qt8y/gE0fnsQWMYc3jcyxlf1EcQs2cgmNmPsuvZuZtO+uSoOkfH1VCVSu3Fj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446630; c=relaxed/simple;
	bh=480kSECEzkNcs0+A+LlDEG/Wcem9oTwFlQh4ca14HFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG5YsTQyrIyVVcw3KqqCyMMrQR3giL57lH7eAR1tWvEdB44g9eZv2Ey097ONweuINP1VPcqJACEAsZA2n/mCv3xmXkIij/NZz74ua1SI455J4z3KuKvxv7hTigFYfdALJFmm87RSPyxe0z4lZkhEM5gZFUhPcLZA7/K4yrLbCpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Nwno+SZK; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-382fa663249so43398941fa.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:57:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769446627; cv=none;
        d=google.com; s=arc-20240605;
        b=akElkxMPAUl/2aRBOQCTTo1Zyac09eQ44LjuIEl1OzdS2j6svWI14LBxoCsIwsInMp
         bmo+AGtcRLDVS9E8gV7qhafujvPziRBpq+GsJsKqbyG4O0m6EC1XBoeCqxgHuty1PrpM
         08OqEe4DEzeR5n1W1JskqtY9K6SauWnnMzsfv3mYGIoS3H8l8OeunYoJB8p5gkaLodg0
         /clKE27BYtKn9yVC30yq0BXeTcq56SMg7O8trsWXD2V8Wt65yf+m3BLk1gCcNFBZLwX8
         I6JuzCK6fAdVy4tf47mT/VIvJADe/iPBK3drmCwb+jdaunO855E5OzgEDE2le1ol83Eq
         G44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GEJMc99u4iSRQsJNb7yqLP7KfZHzCOG6z+xzNYntaE4=;
        fh=4e98keLYiYBfHfasOYsDKXBdmodiQ51aY6uAsekr1kE=;
        b=k8Eu0pTMBzF49/CR54m1OorDdpcMZkcwVNeg0j5IcrXoypxlF5sxIyiuySwiroTYF9
         LreiYY7Lik7BRPtaAklwJOIapE2m6ez7SMLA5M7feVS2lZSFjlQzmwzDIwFEfoklerIh
         g71t0XcqYvaLjAUaSdJvkJRZ9rJ7Ccvs8VaVET0WC7x1C4dj7mJ4SuVtsrUHJIuC7anC
         YwOI1Ou2G9hUZx5UfQC/VL1hpEtORBWd+kZ+3vwzsRhIewDnXEfwBjtxDIMvRMqVVHcC
         qUbxepsRAu0RblkL/YpbO2COIRNihJBMjJOHqWTYWt9xEeMPUXkJPIgjIgP+K9HfBmqF
         s1Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769446627; x=1770051427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEJMc99u4iSRQsJNb7yqLP7KfZHzCOG6z+xzNYntaE4=;
        b=Nwno+SZK012vZsOICT8LQ+BNF2ZwflqOe6/AYaWO/ZrYewSnAApaZA2N+ICT1w2RJ0
         v8cEhJLnmzxKUMTszrSmYumoBG3pTUu9HY1bw7PNaG7iOvPoMzX60PSHeev7CNLJSv1n
         95ziUwK4ramBBfEIdobw3xVVbSmqLnT19P4PBdRlycYAO2f9V+19ibVGcVGXiyFjg7kH
         X+tG4PYqCdMdr0ViFCfxyVxvywYXrK4rY5WBORPYxdoP683v/+h+n/9Mz6z1qhNjMBwZ
         8BthRnIWCdt4ZcqWz0m3CS30AOHfuKXjjqFjYi9k1Y0vGCoblSo9RcERgX0ASP+8b6V0
         CwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446627; x=1770051427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GEJMc99u4iSRQsJNb7yqLP7KfZHzCOG6z+xzNYntaE4=;
        b=V6u/cLT1601R6wwkXqBnj8YWKueTEmylArlCiU/HOvzxORpBnbZ7kmdTvoyhEPF7xT
         s3pTq8/LDahe01c3ruh8EOvb0/87i8Bb4KqfZYS8EuRaTfWmj3hIJfjf5CjH8kcl8S9h
         LYQUPgpRpwEwLupl0JkzIckdhQO8430yGcVoFRSYgGPqGEnjV7zKBqiJCWhWpKGxOZLw
         fADkX5ZslmDsLaRZlq5C0VSl80XR7w2fLZr+yK02TfjmNrUbx6aqns6cFlILSfBWdwxK
         jL9VoKwyXmOaa2QSsMpiMUNy0hTJPbR515B1zEjGUQ8GMXjk+Ai0m7dfANbJRS7ytEo2
         Ofog==
X-Forwarded-Encrypted: i=1; AJvYcCUR4kmJmBNsqKVxtQmP28dKyW+eZFiEBNohP5y4/Vq7RXOJrHKz0TjPNOX3l0M92XjXwuDMJvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLEed52udVHxW0BGgHkcuwYCUm/emAWKwzVYdTHqJue4k7eir
	MWxmLEI6M6tOsXL7oe06KrRzHw/k+31pf9vwaGla9wNhq94s3k4r4zKfEDxc4bDA8QCMixo9DXA
	8cVSj5NrfN+BIQUjFS9u+xiRKI74Dk3yM391lDlBpkWrFiQz+PwyPRQ==
X-Gm-Gg: AZuq6aKS0XDAFp5Z6e0piJ0C7Z43JtKhqn4AlkvaQd1VvHjAQI0Z3KqgxIAHGgKpCwu
	k8Sd/7LvXEz8M6keDfarVgrYnf5n/fXEHIuHOQcaM56hQ5sb+MrGmQ3neKiARd+nic6XkCULGxf
	+ZH7jOqfQrPQPH31HKIU9xPALpcD3uOdORIh0vcSRvMkeTuyorqzglzCPXc7Fix/bygHjy/Kejv
	sZ1OZZQgEM/okKOkC0LiPYsAVye4sC8/jXQV2nKT4nNyKUBQ1AekUNFEcymodioUXeYk2noTn2l
	luvBYpbVtSAww+lTIj2ZQcQprRDW+BK1LvuAk57insxfXtaIX4VLj8zsd4s=
X-Received: by 2002:a05:651c:41c7:b0:385:c21f:37f4 with SMTP id
 38308e7fff4ca-385f9f034f1mr16222541fa.16.1769446626527; Mon, 26 Jan 2026
 08:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121214925.112604-1-tom@herbertland.com> <20260121214925.112604-7-tom@herbertland.com>
 <5dca897a-700f-41da-afa4-37a497346f97@gmail.com>
In-Reply-To: <5dca897a-700f-41da-afa4-37a497346f97@gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 26 Jan 2026 08:56:55 -0800
X-Gm-Features: AZwV_Qh2yXq5ZBRlVSR6Em1I6kN7byMmpmLtFv1KalohgeWBiY1qN1DIVRgsn8U
Message-ID: <CALx6S37q84Ou+iD7y4fXjBbKabeJYJaU8iQs_fzLMTD8zwJkEg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] ipv6: Enforce Extension Header ordering
To: Justin Iurman <justin.iurman@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253548-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[herbertland.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,ietf.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 720708B37E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:35=E2=80=AFPM Justin Iurman <justin.iurman@gmail.=
com> wrote:
>
> On 1/21/26 22:49, Tom Herbert wrote:
> > RFC8200 highly recommends that different Extension Headers be send in
> > a prescibed order and all Extension Header types occur at most once
> > in a packet with the expection of Destination Options that may
> > occur twice. This patch enforces the ordering be folowed in received
> > packets. It also disregrards Destination Options before the Routing
> > Header as those are unused in deployment asnd there is a proposal
> > to deprecate them in draft-herbert-deprecate-destops-before-rh.
>
> I'll have to pushback on this specifically, at least as long as
> draft-herbert-deprecate-destops-before-rh is not adopted and published
> (to be clear, I'm not against it, just that it's still an individual
> draft right now and there is no consensus). We're already at the edge of
> remaining compliant with RFC8200 with this series (which is fine
> considering its security gaps), so let's not rush by removing the
> DestOps before the Routing header. It can be done later, this series
> already mitigates DoS attacks quite well.

Justin,

If we need to wait for permission from IETF then pretty much most of
this patch set isn't viable. For instance
draft-iurman-6man-eh-occurrences is also not adopted and published
either, and if we enforce the number of occurrences in implementation
then we are non-conformant with RFC8200. But I think it is justified
to protect users from an obvious DoS attack.

As for Destination Options before the Routing header, _no_one_ is
using this. There is no deployment of that. The only routing header
being deployed is SRv6 and the header has its own options, no routers
support Destination Options before the Routing Header. But, if by some
miracle someone is using them in their network, then they can simply
set the sysctl to not enforce EH ordering. IMO, this approach is
better than adding additional complexity to the stack just to detect a
case that nobody cares about and a code path that is never exercised.

Tom

>
> FWIW, the rest of this patch makes sense.
>
> > The allowed order of Extension Headers is:
> >
> >      IPv6 header
> >      Hop-by-Hop Options header
> >      Routing header
> >      Fragment header
> >      Authentication header
> >      Encapsulating Security Payload header
> >      Destination Options header
> >      Upper-Layer header
> >
> > Each Extension Header may be present only once in a packet.
> >
> > net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> > enforcement of xtension Header order. If it is set to zero then
> > Extension Header order and number of occurences is not checked
> > in receive processeing (except for Hop-by-Hop Options that
> > must be the first Extension Header and can only occur once in
> > a packet.
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
> > ---
> >   include/net/netns/ipv6.h   |  1 +
> >   include/net/protocol.h     | 16 ++++++++++++++++
> >   net/ipv6/af_inet6.c        |  1 +
> >   net/ipv6/exthdrs.c         |  2 ++
> >   net/ipv6/ip6_input.c       | 14 ++++++++++++++
> >   net/ipv6/reassembly.c      |  1 +
> >   net/ipv6/sysctl_net_ipv6.c |  7 +++++++
> >   net/ipv6/xfrm6_protocol.c  |  2 ++
> >   8 files changed, 44 insertions(+)
> >
> > diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> > index 34bdb1308e8f..2db56718ea60 100644
> > --- a/include/net/netns/ipv6.h
> > +++ b/include/net/netns/ipv6.h
> > @@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
> >       u8 fib_notify_on_flag_change;
> >       u8 icmpv6_error_anycast_as_unicast;
> >       u8 icmpv6_errors_extension_mask;
> > +     u8 enforce_ext_hdr_order;
> >   };
> >
> >   struct netns_ipv6 {
> > diff --git a/include/net/protocol.h b/include/net/protocol.h
> > index b2499f88f8f8..70cc2d0fdc0c 100644
> > --- a/include/net/protocol.h
> > +++ b/include/net/protocol.h
> > @@ -50,6 +50,21 @@ struct net_protocol {
> >   };
> >
> >   #if IS_ENABLED(CONFIG_IPV6)
> > +
> > +/* Order of extension headers as prescribed in RFC8200. The ordering a=
nd
> > + * number of extension headers in a packet can be enforced in IPv6 rec=
eive
> > + * processing. Destination Options before the Routing Header is not in=
cluded
> > + * in the list as they are unused in deployment and it has been propos=
ed that
> > + * they be deprecated. See:
> > + * www.ietf.org/archive/id/draft-herbert-deprecate-destops-before-rh-0=
1.txt
> > + */
> > +#define IPV6_EXT_HDR_ORDER_HOP               BIT(0)
> > +#define IPV6_EXT_HDR_ORDER_ROUTING   BIT(1)
> > +#define IPV6_EXT_HDR_ORDER_FRAGMENT  BIT(2)
> > +#define IPV6_EXT_HDR_ORDER_AUTH              BIT(3)
> > +#define IPV6_EXT_HDR_ORDER_ESP               BIT(4)
> > +#define IPV6_EXT_HDR_ORDER_DEST              BIT(5)
> > +
> >   struct inet6_protocol {
> >       int     (*handler)(struct sk_buff *skb);
> >
> > @@ -61,6 +76,7 @@ struct inet6_protocol {
> >
> >       unsigned int    flags;  /* INET6_PROTO_xxx */
> >       u32             secret;
> > +     u32             ext_hdr_order;
> >   };
> >
> >   #define INET6_PROTO_NOPOLICY        0x1
> > diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> > index bd29840659f3..43097360ce64 100644
> > --- a/net/ipv6/af_inet6.c
> > +++ b/net/ipv6/af_inet6.c
> > @@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *ne=
t)
> >       net->ipv6.sysctl.max_dst_opts_len =3D IP6_DEFAULT_MAX_DST_OPTS_LE=
N;
> >       net->ipv6.sysctl.max_hbh_opts_len =3D IP6_DEFAULT_MAX_HBH_OPTS_LE=
N;
> >       net->ipv6.sysctl.fib_notify_on_flag_change =3D 0;
> > +     net->ipv6.sysctl.enforce_ext_hdr_order =3D 1;
> >       atomic_set(&net->ipv6.fib6_sernum, 1);
> >
> >       net->ipv6.sysctl.ioam6_id =3D IOAM6_DEFAULT_ID;
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index 394e3397e4d4..2af16694db46 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
> >   static const struct inet6_protocol rthdr_protocol =3D {
> >       .handler        =3D       ipv6_rthdr_rcv,
> >       .flags          =3D       INET6_PROTO_NOPOLICY,
> > +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_ROUTING,
> >   };
> >
> >   static const struct inet6_protocol destopt_protocol =3D {
> >       .handler        =3D       ipv6_destopt_rcv,
> >       .flags          =3D       INET6_PROTO_NOPOLICY,
> > +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_DEST,
> >   };
> >
> >   static const struct inet6_protocol nodata_protocol =3D {
> > diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> > index 168ec07e31cc..5254ead5c226 100644
> > --- a/net/ipv6/ip6_input.c
> > +++ b/net/ipv6/ip6_input.c
> > @@ -366,6 +366,7 @@ void ip6_protocol_deliver_rcu(struct net *net, stru=
ct sk_buff *skb, int nexthdr,
> >       const struct inet6_protocol *ipprot;
> >       struct inet6_dev *idev;
> >       unsigned int nhoff;
> > +     u32 ext_hdrs =3D 0;
> >       SKB_DR(reason);
> >       bool raw;
> >
> > @@ -427,6 +428,19 @@ void ip6_protocol_deliver_rcu(struct net *net, str=
uct sk_buff *skb, int nexthdr,
> >                               goto discard;
> >                       }
> >               }
> > +
> > +             if (ipprot->ext_hdr_order &&
> > +                 READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) {
> > +                     /* The protocol is an extension header and EH ord=
ering
> > +                      * is being enforced. Discard packet if we've alr=
eady
> > +                      * seen this EH or one that is lower in the order=
 list
> > +                      */
> > +                     if (ipprot->ext_hdr_order <=3D ext_hdrs)
> > +                             goto discard;
> > +
> > +                     ext_hdrs |=3D ipprot->ext_hdr_order;
> > +             }
> > +
> >               if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
> >                       if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb=
)) {
> >                               SKB_DR_SET(reason, XFRM_POLICY);
> > diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> > index 25ec8001898d..91dba72c5a3c 100644
> > --- a/net/ipv6/reassembly.c
> > +++ b/net/ipv6/reassembly.c
> > @@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
> >   static const struct inet6_protocol frag_protocol =3D {
> >       .handler        =3D       ipv6_frag_rcv,
> >       .flags          =3D       INET6_PROTO_NOPOLICY,
> > +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_FRAGMENT,
> >   };
> >
> >   #ifdef CONFIG_SYSCTL
> > diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> > index d2cd33e2698d..543b6acdb11d 100644
> > --- a/net/ipv6/sysctl_net_ipv6.c
> > +++ b/net/ipv6/sysctl_net_ipv6.c
> > @@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] =3D =
{
> >               .proc_handler   =3D proc_doulongvec_minmax,
> >               .extra2         =3D &ioam6_id_wide_max,
> >       },
> > +     {
> > +             .procname       =3D "enforce_ext_hdr_order",
> > +             .data           =3D &init_net.ipv6.sysctl.enforce_ext_hdr=
_order,
> > +             .maxlen         =3D sizeof(u8),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dou8vec_minmax,
> > +     },
> >   };
> >
> >   static struct ctl_table ipv6_rotable[] =3D {
> > diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
> > index ea2f805d3b01..5826edf67f64 100644
> > --- a/net/ipv6/xfrm6_protocol.c
> > +++ b/net/ipv6/xfrm6_protocol.c
> > @@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protocol =
=3D {
> >       .handler        =3D       xfrm6_esp_rcv,
> >       .err_handler    =3D       xfrm6_esp_err,
> >       .flags          =3D       INET6_PROTO_NOPOLICY,
> > +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_ESP,
> >   };
> >
> >   static const struct inet6_protocol ah6_protocol =3D {
> >       .handler        =3D       xfrm6_ah_rcv,
> >       .err_handler    =3D       xfrm6_ah_err,
> >       .flags          =3D       INET6_PROTO_NOPOLICY,
> > +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_AUTH
> >   };
> >
> >   static const struct inet6_protocol ipcomp6_protocol =3D {
>

