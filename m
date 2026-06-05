Return-Path: <netdev+bounces-295771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rFj/J+2mImofbgEAu9opvQ
	(envelope-from <netdev+bounces-295771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12186647656
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=isovalent.com header.s=google header.b=K2WrF0c6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295771-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295771-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=isovalent.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B54883003517
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1773F0ABF;
	Fri,  5 Jun 2026 10:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233140756C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 10:31:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655475; cv=pass; b=K1rcWB4HeB3Le+rTa1qtcWWTT/FxrjhmbDZNhp1JcX5K1s7/Mm1XRTqDj5FzqCQiS+7lRk76nHc7Tx0CfEvwqmr+SCjsb0Vi/E9Tlw/nI7xmNnKPfDWrTgNgB+dUHvQVy1z6/w54xXzBV3yIGXHfjxse9qnE8uSffrWWrrj7pn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655475; c=relaxed/simple;
	bh=sRt8JS912JREoBcAHM46+7EYpPh2lcY3q1z/abaug2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGp4G3WxDzhbuX/c2UOlGx/HINzLxN34QJDm9CoKYo+4cK2R9BTwk6mq+h3FX5dusL2msOugRzto3Aszu2iGSsMxlh4pbOb+lmkX8gzP7B+ORZ1mVW6onzaVRl19gibtTJT6DXhSwaVKrVb8pLpHWr6Os3PwHF7B4Ko5eWMobm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=K2WrF0c6; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13808436ccdso592329c88.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 03:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780655472; cv=none;
        d=google.com; s=arc-20240605;
        b=j14WACuk5XIVdRPRPGhXjQhNLQTCfNOIw7RDwnIGQaWBT798zD+YLswFxgHnBQH/aB
         z6288V5b3FLOT937VspRXR4t3aaA99HM9XbL2636J27vnK3FkuUVpxx5fofSQwDWCD6N
         N2TNaANoBTUGcE0GhqV7QFiGuaqijn2apF0Tp4i52nncN4Wang5wcFumtfQkO9TizrmD
         Qg6OiaaaxCWSrms3PBuXj7CWPOL0euiqJkiJwR4wCgNHXcIufuleetjh0esBtyzXyf/e
         QfysiAoO0f/53IImZuTDK7tADxcQ6gCuCdRhEhGXFF7uAmneH4KMOQ+MEyOZj4bDzOqp
         NhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jUGmVLdZXM6lA+x7FIGZvQpFJJNL4T9BbMIO05lwoHI=;
        fh=pmFBzae5mZCicQeCpY8roGhdGbnjF1tEoI9JiMiEY9k=;
        b=iITzyexqTlVsVNjEu5e0xswNfgF6kOTKZ6JnTaXFWaBg3Iav+1i0SmT95kdkRi9kAt
         Gff75uaQ9AFW7jYHUOU/1vcAX89niPfP+Je0X7ddReA/99GGylcg/PjIK/NDCSBpxDbu
         IzHuc791oWAwurnE3/D78MDi9ogX/MfxFSqxCd/MX9hJukJ7yKPMTrj1/VNJ9rxzeKeF
         6WmIlJX3Dosg/SZfn+qkzm8IpcZW8gbJKi+xIHcS7MRrRK9nsK0QjJVqtokDNAoHxCbL
         oOP6tDrQQMWud/wG8xTLCxIpUsTlFEjhKl+Vl6htdmx/LuzJNkMTDIkxnKXCZIN8LseW
         xrGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1780655472; x=1781260272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUGmVLdZXM6lA+x7FIGZvQpFJJNL4T9BbMIO05lwoHI=;
        b=K2WrF0c6jlanqcEpECRk1U9pe10Zyf36yEnZjm9AXGqkpRHQqqHasbnhA6oBWURkq0
         QGbsApkq2cOJFAj/m9Qma1EVeAu75t87U0b2ASVEtqT66SEyw8yR0G0KR+bnjHSHQcPt
         N3zp569mZbkFI4zCHQdzBzTp+pvMfTVWBDSe4Ot+c9ji0bc6Z7Q+sbJlQvTF3yfgldDr
         KiYxHxjii1ysOG+4DtSiuIcaYVlfArYonEKkW2nhPkgxwaVDnaskwt9DVVeQOthOIPk3
         MFcseLJrQLJHtiAHn29yRDDxLoocV8rHIAk9XT774/1DzOc7aX+He3hFJqQlpO3+N9oR
         gq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780655472; x=1781260272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUGmVLdZXM6lA+x7FIGZvQpFJJNL4T9BbMIO05lwoHI=;
        b=UW2v4qFdAoB45QLxli4+/OHHe0vZu9H37OBJmC5Jx9r0Bsg6d2taLoLppsUXObmS7o
         d7NmAWVTE70xZXruFFVmkLdW2mDWH/XdrFVa9KGJBseKIi225Ul2mMFypfGvxarn/scp
         HtinRk1v9+gmF39rXbb2L5Pr04GPydtwuAeKN7B375mQzcEm2rLGRQzGPR/z6JJwRFm+
         db84zB8pqE1DoyP5wj2sJSIEllNOUoxCebwyicKrckb8YBkirkEll6AqYvigSSNxWwdE
         h3PkDT6Xbt99O43dcw0y7blgq15JetmYrXGQxKums2ZZv6cELwUyYoXm7jbNtsqCAuIw
         AW0A==
X-Forwarded-Encrypted: i=1; AFNElJ+JPalAhb8JS8egBWB1uR5Y779uQMo8yqD3KwMV9VoXSAkmuIThOwwK/4YtLiA2mnz0p0+dUZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9VURWob+NYubdYjXms9cE68oXkxV+JIZsJvhchtsw6vrUQqu
	WfHlL97Tc20quJKeEg1J70QpT5HIJT8VwSTuzcyg6m2ZSlMfUq7jv8L4xWvU4uaXxUGGDCIo2Ks
	syJSKl8iFQp0l+bkMKCj3tnM0gC2vNlyeA79sFfb21A==
X-Gm-Gg: Acq92OEv/ASHYQmjEdfXbqFgWFtuzrRG3Acnvg20g+VJRdfNgkyWnBrDqTRqrrkDn5p
	MFBJET6O37MW0iUY7k7dcD9Q4b4azm4rKQjW8AeujaOgyKBCFasZSk9WmVhnH2fR1RiHqcq6ER2
	l1NJ/NXEzTNDPfEUPOi1gtxEnv+r4kkXjDg3DPMq86oClODNik1qXPxmZogEEdsYG4M29Vj8tXC
	D+mhP++3rfs5yDcimRrCYWg5FSb1K/cxSECh/55V0VyRu43gxPbCLz34Vdm5D9TXmtlUvj0Y1B2
	F3j4VRbMCdz/fW2LzhrHail5CHbm/g/OGvxiufD4Lf+fsNqnYvtbBrxulKbNGxs7+Hyda/5EUAr
	aOiI=
X-Received: by 2002:a05:7022:e985:b0:12d:b7e5:a67b with SMTP id
 a92af1059eb24-138066b9bf1mr1345747c88.14.1780655472204; Fri, 05 Jun 2026
 03:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602093931.516281-6-alice.kernel@fastmail.im> <20260605023712.3627277-1-kuba@kernel.org>
In-Reply-To: <20260605023712.3627277-1-kuba@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Fri, 5 Jun 2026 12:30:55 +0200
X-Gm-Features: AVHnY4Jvn8EK1GW9gEdWjZT1z3CFcBpxixLk1uXTWTcqD6D7qKd8PImKhy9SGjc
Message-ID: <CAD0BsJVydUv30m+35nzbmdCcAx=PdW5ahH2iW6BhUyT+y-e=2A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
To: Jakub Kicinski <kuba@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, lucien.xin@gmail.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org, 
	razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, fw@strlen.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[isovalent.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,isovalent.com:from_mime,isovalent.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12186647656

On Fri, 5 Jun 2026 at 04:37, Jakub Kicinski <kuba@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> udp: Support gro_ipv4_max_size > 65536
>
> This commit allows GRO to aggregate UDP packets larger than 65535 bytes
> by writing 0 to the UDP header length field (via udp_set_len()) and
> restoring the real length from skb->len in udp_rcv().
>
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 3e92575f1d55..856c23b9d6dd 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
> >       if (ulen > skb->len)
> >               goto short_packet;
> >
> > +     if (!ulen)
> > +             ulen = skb->len;
> > +
> >       if (ulen < sizeof(*uh))
> >               goto short_packet;
> >
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 96987b1c05cd..f7da760f046f 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
> >       struct sock *sk;
> >       int err;
> >
> > -     udp_set_len_short(uh, newlen);
> > +     udp_set_len(uh, newlen);
>
> [High]
> After this change, udp_gro_complete() may write uh->len = 0 when the
> aggregated packet is >= GRO_LEGACY_MAX_SIZE (65536).  How does this
> interact with conntrack on the receive path?
>
> Looking at udp_validate_len() in net/netfilter/nf_conntrack_proto_udp.c
> at this commit:
>
>     static bool udp_validate_len(...)
>     {
>         unsigned int udplen = udp_get_len_short(hdr);
>         ...
>         if (udplen > skblen || udplen < sizeof(*hdr))
>             return false;
>         ...
>     }
>
> For a super-packet where uh->len has been zeroed, udp_get_len_short()
> returns 0, which is less than sizeof(*hdr), so udp_validate_len() returns
> false.  udp_error() then logs "truncated/malformed packet" and
> nf_conntrack_udp_packet() returns -NF_ACCEPT, leaving the flow untracked.

This is fully addressed in patch "udp: Support BIG TCP GSO packets
where they can occur". The above misses the full context of the series
and is based on this patch solely. In the end, this function looks
like this, handling the uh->len = 0 case:

static bool udp_validate_len(struct sk_buff *skb,
                           const struct udphdr *hdr,
                           unsigned int dataoff)
{
      unsigned int udplen = ntohs(hdr->len);
      unsigned int skblen = skb->len - dataoff;

      if (!udplen && skblen >= GRO_LEGACY_MAX_SIZE)
              return true;
      if (udplen > skblen || udplen < sizeof(*hdr))
              return false;
      return true;
}

> The deployment this patch enables (gro_ipv4_max_size > 65536 with VXLAN
> or Geneve TCP-in-UDP and conntrack) is the very example given in the
> commit message.  Should this patch also update udp_validate_len() (or
> otherwise account for the zeroed length) so that conntrack does not drop
> out of the state machine for super-packets, breaking NAT and stateful
> firewalling?
>
> The follow-up patch in this series, "udp: Support BIG TCP GSO packets
> where they can occur" (b73c2d663201), updates udp_validate_len() to
> accept udplen == 0 when skblen >= GRO_LEGACY_MAX_SIZE, but until that
> patch is applied this commit on its own appears to regress conntrack for
> the configurations it is intended to support.
>
> >       sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
> >                               udp4_lib_lookup_skb, skb, uh->source, uh->dest);
>
> [ ... ]

OK, so it can see that it's handled in a follow-up patch. I can swap
them, so that the fix comes before the uh->len = 0 change. Would it
solve the issue?

Thanks,
Alice

