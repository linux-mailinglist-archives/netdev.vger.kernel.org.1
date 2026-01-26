Return-Path: <netdev+bounces-253577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHUfD7rCd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:38:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 463508CAA7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1C9C30046A6
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0941279DB4;
	Mon, 26 Jan 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ZESH1XWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C222A4E1
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456307; cv=pass; b=KXChSmTO0ODOKEix9uFeVKplf2n1gYaBwPn7quO7egRAnp78kn+Z0N2E00CaTHFqaL+NX9tuIvfJKq05FROnByfqwnHsyDK5pg5yKlr2/bGXXaXxO48sWHRSQZg/kAznxHBBVk21C2eXPhwHKQsYhoDAY+viBKMEZ9ZyTbyNjVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456307; c=relaxed/simple;
	bh=ImpYiDQhEGOUX6bJrKnpgnZgdSk+jNILVUTHaInq7yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbFEqaxy6Ofj5vRqYgWVCPl+UtuyE31iRSf3JC4h0yec+cMDt+aKETN0o/vopJdBnomXMV0UHHVn08CXC723KhhEE1ATIw6qPkQyKiKdyQHjht0BBaSXxMHXuc3bYbK2ZN1QKkV2CrIICcV8vjNOSGyiHxziyL2J99qtUxYv2dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ZESH1XWl; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59de66fdb53so3097061e87.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:38:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769456304; cv=none;
        d=google.com; s=arc-20240605;
        b=ifhgL/ZUlXUeZet5+0UYMJRmJ44KwkASl8ujHP7keUSJYrPltOG8V8aayWVQGDXu6F
         FB03wsZcB5qsakp2t9MOuIcpenNWNze1iVfumszdeoLcXCR3caTGCyCGXi2Do6BDlU2l
         cbi07KpxexhTJXLjw2fmyZwHK8wdz+hdl7KuyN9busPDA0yhAgB4+UL0gLGL+0iuhw94
         XsW+b1YXTUqasbHg0fGiR5itWVzB9LARKyasAC9S4Xf8REFyzIAGKTCODrNSqLCW+393
         StvocZtpky8R9g0/OElpIzz3XIFHfoY1X5T/7w2HQ0TMfFhyZG4ePUOAJKSmZxvxj+fC
         w91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QjVttQtPOWz33MXEvdSM28+x6i59B5B/BuyBDqiV2U0=;
        fh=s4Uz37phVJPGskCn4EumjZL5SgNAaZJBVsF/m0YPzoo=;
        b=QF+Vlm9gizYy4wMlo+uEfYyfLPa/Z8BCGMmRV/S4HgCLDCFh9fobrn2Ak/H7TzK3uc
         vI9TLPDK2FTRtHfYvp3ste6VNtChzjDpSZyzd3NaJt5xWMudd9JuHGwmyDZxbNZYOHnF
         TrxvT+YBRwpcocZSCaoUCgYPXrwRnTJBVYjC3S9yiDtMq9Cqzie7/xgZqa7DSxcPrKY8
         pYxCG6qeAxNpVhROhU1MW/CalYiUC3q1/089lQLNfitjRZYvy2Jh3VQAiyjslFYd3RLO
         D4lkFm+OF42Iip9du2nBDMvOQn0W6sFUV9xMIlaApyWq1qK1zfxE4IIdfVH8Huvw33mE
         oIsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456304; x=1770061104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjVttQtPOWz33MXEvdSM28+x6i59B5B/BuyBDqiV2U0=;
        b=ZESH1XWlkRAKL4QLq7MTREbNkbHBk5vMrgcHNtBBGI75OaGOxSejIFHHC7Tv7SySjs
         9WwDM/nMh6VbSRG081ogTBS9DUhTM1UE+HHKzz05q/YN8dJF1P7GrSkxJGVZYpYbwI5I
         tmr4DG6fJ/Y6jtrDh9yIrECgqFJ/FzziEd6oFkAaC+wKf3b21eDjitPSR2zE6XrhD8g2
         o8SedAAGENdVMrzza7DHtXLca77sf0c+DQpFYRI6c9QOS0W3dnmJf1m/F6V4k2utc3nJ
         NzqWdRQ7n/L4szZRSjly5QDPuNKrUOMt8yAYT7M/hlO4TUFkCYksFi/Hi1kM3ezl46Up
         4G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456304; x=1770061104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjVttQtPOWz33MXEvdSM28+x6i59B5B/BuyBDqiV2U0=;
        b=xKs37jaTzh/FdJnMZAXDI97EvZ/FzjB4Y2tjm3xdQr/da9YUutRZ5hElEieliZ3ijM
         Ge+PMsmQguDMHIy/9tV14VxFoGNVVkAnhvmoctLhqlZzW3jBsveoxN578tYUcKJMhXW4
         c+ISiCXiy18KAS57QSwpt7jrJUEFUaBUfMJGAamrFOhkU1Y8fI6E50Dn8S9feXDId01W
         fEkRXb3SHHQbIRPBZb4faeuCuLxixa0FSQn9fqKUNdJYICAOeImdOTgCKxkklHqST+pE
         BsAc7jKLFVX9H+BZgSBCcJGu3hyHE7cZs51VRGXEeCT9qGhcV2ygJXm/OJqjAJDCZoT/
         ZSgw==
X-Forwarded-Encrypted: i=1; AJvYcCWKLjqp3GVd78vXPJ1yTJ6SMQTWvVeWxbd0rbzfPbKmo0U4CK69pisApNlFLU8gj9Ek86WrR0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0lYlosDKto9m1IVkW8DsoLi2cRJVTij9vrE4KxfYU4TQz9ur
	Z6m/SVqJju3AQxa9+Tsp0psiJEROQhe5VQyT9ZPICIJYxE3e4PYpGrC4BpuUS1Tqfvb16P/LbxC
	zLjCvrMs+NBuI4gYegl0ONtwGHEVfg3/S98WWy49HahA6A3AGqMc=
X-Gm-Gg: AZuq6aKJQPNL/82uTV1LL9fWwMlzAgNUnrfkT2vffvgXo1i+FtnECti6DhWKFgQvCVs
	C3iVM223KkI1RxCVYo31zKUplKcVeAtW0D4tNVVNOt4VbWz1kOvwuABnuMK/yzhUL9RGFh9BOCB
	Ak6sNe5vF8CgbB8nA/w73zfuazCB3NBePveXUmTnS9PUF7Pp++jmth9Ijk94qcp4k7SwDwhINFN
	bR+rFoYsctgKNQ8W/lEsUVgCgyQMTOgMKMd3olxmnDNGH9qCJTitymS2IWysfeoNaIvIfLStgRY
	62dBkh59p8WlwesOJyG9nY7M+6+ZWCUfYPqif8WxIBA/QVfqhf1Twz6DeG4=
X-Received: by 2002:a05:6512:2256:b0:59b:6f90:4a2 with SMTP id
 2adb3069b0e04-59df36073c9mr1945283e87.16.1769456303721; Mon, 26 Jan 2026
 11:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121214925.112604-1-tom@herbertland.com> <20260121214925.112604-7-tom@herbertland.com>
 <5dca897a-700f-41da-afa4-37a497346f97@gmail.com> <CALx6S37q84Ou+iD7y4fXjBbKabeJYJaU8iQs_fzLMTD8zwJkEg@mail.gmail.com>
 <db979c8f-8ee9-4717-9cd3-c3125e33580b@gmail.com>
In-Reply-To: <db979c8f-8ee9-4717-9cd3-c3125e33580b@gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 26 Jan 2026 11:38:11 -0800
X-Gm-Features: AZwV_QiUT6KbABDti5EbHRnI4SkupSFih6tHbic02_04hUBRXuPrW3CaFaFI19I
Message-ID: <CALx6S37u+8b=QRGVfBFtbq7m-Ei3CvWaSmz_seRHZL5izd4ong@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253577-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 463508CAA7
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:23=E2=80=AFAM Justin Iurman <justin.iurman@gmail=
.com> wrote:
>
> On 1/26/26 17:56, Tom Herbert wrote:
> > On Fri, Jan 23, 2026 at 1:35=E2=80=AFPM Justin Iurman <justin.iurman@gm=
ail.com> wrote:
> >>
> >> On 1/21/26 22:49, Tom Herbert wrote:
> >>> RFC8200 highly recommends that different Extension Headers be send in
> >>> a prescibed order and all Extension Header types occur at most once
> >>> in a packet with the expection of Destination Options that may
> >>> occur twice. This patch enforces the ordering be folowed in received
> >>> packets. It also disregrards Destination Options before the Routing
> >>> Header as those are unused in deployment asnd there is a proposal
> >>> to deprecate them in draft-herbert-deprecate-destops-before-rh.
> >>
> >> I'll have to pushback on this specifically, at least as long as
> >> draft-herbert-deprecate-destops-before-rh is not adopted and published
> >> (to be clear, I'm not against it, just that it's still an individual
> >> draft right now and there is no consensus). We're already at the edge =
of
> >> remaining compliant with RFC8200 with this series (which is fine
> >> considering its security gaps), so let's not rush by removing the
> >> DestOps before the Routing header. It can be done later, this series
> >> already mitigates DoS attacks quite well.
> >
> > Justin,
> >
> > If we need to wait for permission from IETF then pretty much most of
> > this patch set isn't viable. For instance
> > draft-iurman-6man-eh-occurrences is also not adopted and published
> > either, and if we enforce the number of occurrences in implementation
> > then we are non-conformant with RFC8200. But I think it is justified
> > to protect users from an obvious DoS attack.
>
> Hi Tom,
>
> This is why I mentioned that, with this series, we're on the edge
> regarding RFC8200 compliance. However, the text in Sec. 4.6 is somewhat
> ambiguous and does not use normative language. Therefore, this series
> does not actually violate RFC8200 compliance.
>
> On the other hand, removing the DestOpt before RH would completely
> violate RFC8200 and, IMO, is not necessary at the moment (because this
> series already mitigates quite well DoS attacks).
>
> > As for Destination Options before the Routing header, _no_one_ is
> > using this. There is no deployment of that. The only routing header
> > being deployed is SRv6 and the header has its own options, no routers
> > support Destination Options before the Routing Header. But, if by some
> > miracle someone is using them in their network, then they can simply
> > set the sysctl to not enforce EH ordering. IMO, this approach is
> > better than adding additional complexity to the stack just to detect a
> > case that nobody cares about and a code path that is never exercised.
>
> What if I want to enforce EH ordering in my network *AND* use the
> DestOpt before RH? I don't think we should make it an exclusive
> condition. And, as discussed offline, draft-bonica-6man-crh-helper-opt
> defines a DestOpt before RH. Therefore, we have at least one use case
> (still a draft, though) in limited domains. Let's wait and see if this
> draft progresses, or if draft-herbert-deprecate-destops-before-rh gets
> consensus.

Okay, I'll submit a new patch set shortly.

Tom

>
> Justin
>
> > Tom
> >
> >>
> >> FWIW, the rest of this patch makes sense.
> >>
> >>> The allowed order of Extension Headers is:
> >>>
> >>>       IPv6 header
> >>>       Hop-by-Hop Options header
> >>>       Routing header
> >>>       Fragment header
> >>>       Authentication header
> >>>       Encapsulating Security Payload header
> >>>       Destination Options header
> >>>       Upper-Layer header
> >>>
> >>> Each Extension Header may be present only once in a packet.
> >>>
> >>> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> >>> enforcement of xtension Header order. If it is set to zero then
> >>> Extension Header order and number of occurences is not checked
> >>> in receive processeing (except for Hop-by-Hop Options that
> >>> must be the first Extension Header and can only occur once in
> >>> a packet.
> >>>
> >>> Signed-off-by: Tom Herbert <tom@herbertland.com>
> >>> ---
> >>>    include/net/netns/ipv6.h   |  1 +
> >>>    include/net/protocol.h     | 16 ++++++++++++++++
> >>>    net/ipv6/af_inet6.c        |  1 +
> >>>    net/ipv6/exthdrs.c         |  2 ++
> >>>    net/ipv6/ip6_input.c       | 14 ++++++++++++++
> >>>    net/ipv6/reassembly.c      |  1 +
> >>>    net/ipv6/sysctl_net_ipv6.c |  7 +++++++
> >>>    net/ipv6/xfrm6_protocol.c  |  2 ++
> >>>    8 files changed, 44 insertions(+)
> >>>
> >>> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> >>> index 34bdb1308e8f..2db56718ea60 100644
> >>> --- a/include/net/netns/ipv6.h
> >>> +++ b/include/net/netns/ipv6.h
> >>> @@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
> >>>        u8 fib_notify_on_flag_change;
> >>>        u8 icmpv6_error_anycast_as_unicast;
> >>>        u8 icmpv6_errors_extension_mask;
> >>> +     u8 enforce_ext_hdr_order;
> >>>    };
> >>>
> >>>    struct netns_ipv6 {
> >>> diff --git a/include/net/protocol.h b/include/net/protocol.h
> >>> index b2499f88f8f8..70cc2d0fdc0c 100644
> >>> --- a/include/net/protocol.h
> >>> +++ b/include/net/protocol.h
> >>> @@ -50,6 +50,21 @@ struct net_protocol {
> >>>    };
> >>>
> >>>    #if IS_ENABLED(CONFIG_IPV6)
> >>> +
> >>> +/* Order of extension headers as prescribed in RFC8200. The ordering=
 and
> >>> + * number of extension headers in a packet can be enforced in IPv6 r=
eceive
> >>> + * processing. Destination Options before the Routing Header is not =
included
> >>> + * in the list as they are unused in deployment and it has been prop=
osed that
> >>> + * they be deprecated. See:
> >>> + * www.ietf.org/archive/id/draft-herbert-deprecate-destops-before-rh=
-01.txt
> >>> + */
> >>> +#define IPV6_EXT_HDR_ORDER_HOP               BIT(0)
> >>> +#define IPV6_EXT_HDR_ORDER_ROUTING   BIT(1)
> >>> +#define IPV6_EXT_HDR_ORDER_FRAGMENT  BIT(2)
> >>> +#define IPV6_EXT_HDR_ORDER_AUTH              BIT(3)
> >>> +#define IPV6_EXT_HDR_ORDER_ESP               BIT(4)
> >>> +#define IPV6_EXT_HDR_ORDER_DEST              BIT(5)
> >>> +
> >>>    struct inet6_protocol {
> >>>        int     (*handler)(struct sk_buff *skb);
> >>>
> >>> @@ -61,6 +76,7 @@ struct inet6_protocol {
> >>>
> >>>        unsigned int    flags;  /* INET6_PROTO_xxx */
> >>>        u32             secret;
> >>> +     u32             ext_hdr_order;
> >>>    };
> >>>
> >>>    #define INET6_PROTO_NOPOLICY        0x1
> >>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> >>> index bd29840659f3..43097360ce64 100644
> >>> --- a/net/ipv6/af_inet6.c
> >>> +++ b/net/ipv6/af_inet6.c
> >>> @@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *=
net)
> >>>        net->ipv6.sysctl.max_dst_opts_len =3D IP6_DEFAULT_MAX_DST_OPTS=
_LEN;
> >>>        net->ipv6.sysctl.max_hbh_opts_len =3D IP6_DEFAULT_MAX_HBH_OPTS=
_LEN;
> >>>        net->ipv6.sysctl.fib_notify_on_flag_change =3D 0;
> >>> +     net->ipv6.sysctl.enforce_ext_hdr_order =3D 1;
> >>>        atomic_set(&net->ipv6.fib6_sernum, 1);
> >>>
> >>>        net->ipv6.sysctl.ioam6_id =3D IOAM6_DEFAULT_ID;
> >>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> >>> index 394e3397e4d4..2af16694db46 100644
> >>> --- a/net/ipv6/exthdrs.c
> >>> +++ b/net/ipv6/exthdrs.c
> >>> @@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
> >>>    static const struct inet6_protocol rthdr_protocol =3D {
> >>>        .handler        =3D       ipv6_rthdr_rcv,
> >>>        .flags          =3D       INET6_PROTO_NOPOLICY,
> >>> +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_ROUTING,
> >>>    };
> >>>
> >>>    static const struct inet6_protocol destopt_protocol =3D {
> >>>        .handler        =3D       ipv6_destopt_rcv,
> >>>        .flags          =3D       INET6_PROTO_NOPOLICY,
> >>> +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_DEST,
> >>>    };
> >>>
> >>>    static const struct inet6_protocol nodata_protocol =3D {
> >>> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> >>> index 168ec07e31cc..5254ead5c226 100644
> >>> --- a/net/ipv6/ip6_input.c
> >>> +++ b/net/ipv6/ip6_input.c
> >>> @@ -366,6 +366,7 @@ void ip6_protocol_deliver_rcu(struct net *net, st=
ruct sk_buff *skb, int nexthdr,
> >>>        const struct inet6_protocol *ipprot;
> >>>        struct inet6_dev *idev;
> >>>        unsigned int nhoff;
> >>> +     u32 ext_hdrs =3D 0;
> >>>        SKB_DR(reason);
> >>>        bool raw;
> >>>
> >>> @@ -427,6 +428,19 @@ void ip6_protocol_deliver_rcu(struct net *net, s=
truct sk_buff *skb, int nexthdr,
> >>>                                goto discard;
> >>>                        }
> >>>                }
> >>> +
> >>> +             if (ipprot->ext_hdr_order &&
> >>> +                 READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) =
{
> >>> +                     /* The protocol is an extension header and EH o=
rdering
> >>> +                      * is being enforced. Discard packet if we've a=
lready
> >>> +                      * seen this EH or one that is lower in the ord=
er list
> >>> +                      */
> >>> +                     if (ipprot->ext_hdr_order <=3D ext_hdrs)
> >>> +                             goto discard;
> >>> +
> >>> +                     ext_hdrs |=3D ipprot->ext_hdr_order;
> >>> +             }
> >>> +
> >>>                if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
> >>>                        if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, =
skb)) {
> >>>                                SKB_DR_SET(reason, XFRM_POLICY);
> >>> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> >>> index 25ec8001898d..91dba72c5a3c 100644
> >>> --- a/net/ipv6/reassembly.c
> >>> +++ b/net/ipv6/reassembly.c
> >>> @@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
> >>>    static const struct inet6_protocol frag_protocol =3D {
> >>>        .handler        =3D       ipv6_frag_rcv,
> >>>        .flags          =3D       INET6_PROTO_NOPOLICY,
> >>> +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_FRAGMENT,
> >>>    };
> >>>
> >>>    #ifdef CONFIG_SYSCTL
> >>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> >>> index d2cd33e2698d..543b6acdb11d 100644
> >>> --- a/net/ipv6/sysctl_net_ipv6.c
> >>> +++ b/net/ipv6/sysctl_net_ipv6.c
> >>> @@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] =
=3D {
> >>>                .proc_handler   =3D proc_doulongvec_minmax,
> >>>                .extra2         =3D &ioam6_id_wide_max,
> >>>        },
> >>> +     {
> >>> +             .procname       =3D "enforce_ext_hdr_order",
> >>> +             .data           =3D &init_net.ipv6.sysctl.enforce_ext_h=
dr_order,
> >>> +             .maxlen         =3D sizeof(u8),
> >>> +             .mode           =3D 0644,
> >>> +             .proc_handler   =3D proc_dou8vec_minmax,
> >>> +     },
> >>>    };
> >>>
> >>>    static struct ctl_table ipv6_rotable[] =3D {
> >>> diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
> >>> index ea2f805d3b01..5826edf67f64 100644
> >>> --- a/net/ipv6/xfrm6_protocol.c
> >>> +++ b/net/ipv6/xfrm6_protocol.c
> >>> @@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protoco=
l =3D {
> >>>        .handler        =3D       xfrm6_esp_rcv,
> >>>        .err_handler    =3D       xfrm6_esp_err,
> >>>        .flags          =3D       INET6_PROTO_NOPOLICY,
> >>> +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_ESP,
> >>>    };
> >>>
> >>>    static const struct inet6_protocol ah6_protocol =3D {
> >>>        .handler        =3D       xfrm6_ah_rcv,
> >>>        .err_handler    =3D       xfrm6_ah_err,
> >>>        .flags          =3D       INET6_PROTO_NOPOLICY,
> >>> +     .ext_hdr_order  =3D       IPV6_EXT_HDR_ORDER_AUTH
> >>>    };
> >>>
> >>>    static const struct inet6_protocol ipcomp6_protocol =3D {
> >>
>

