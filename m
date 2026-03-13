Return-Path: <netdev+bounces-267337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA5GBKLOs2mBbAAAu9opvQ
	(envelope-from <netdev+bounces-267337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87127FE8C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13E7302C925
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A453859DC;
	Fri, 13 Mar 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VTNGtEEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C534EEED
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391459; cv=pass; b=qB6SeZFp08GBI4Xu1GvX1DFIK6QAKYxZY5z/Rz/0JXBCX4JSjuHnUCb0SS47B2Wfe4uNnExUOKQzcTIQWDYFnUdz0/hoyEHsCjRGjiacBBQdx9tZOjXJB+s80FrF4by1wP5VqbiMeZo1HU4zZX53eBfcsmSEuMEh4QbcuCMFRSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391459; c=relaxed/simple;
	bh=tz0n4MmxLr8j57aV2f3i3/CTRH9Vez6xRK5fVWoP6MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNQqIvzncdyqamL7v4GxMPbs2qw/7+as2PWdVTMU7PEHcTad/PakW3MBCaG07YOIvl2OpdRsFHstrROJF+WbtmOOuUl7+6XlkR2YuxAJlYQK3PiykqlNpptSGj6MLNNh9yvkYmE702pMSz1+WYAVCCYvCzH7JBV8wkuy8fuaifY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VTNGtEEO; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b940f962a82so299456066b.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 01:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773391455; cv=none;
        d=google.com; s=arc-20240605;
        b=QNuIJpSrxjoAJN2ImqCTQC1ZDm6qw/j9Cc4/iV8V27a7QXzTjf7w0441z50G/wlLki
         6kpLc5IYnWTCISphv3nIPSj1wvx5aXmURm4f9vvgzxYylLU8aqlEATxSFqWATN0xYSKv
         7Y1rTBkMcvWr3K1ted3T/ccGYxNANphlf2Nm4iU8UZHWnjCZTRDCP4iggcMq54YfvRAm
         gQ8zJI3FJQHwUfm5MOoc4CuXLWb1bXaIIuuwSrKaIIyU7+tZg2PNrBOOyXfd8qZ5rTkN
         xG0EWIXOveIFbT1vMmKcbXdtjvDJn1fCGSV7db5isuDIOHUibCCXypuAL9hVHl8vtX6R
         b+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zk7nu81wiNZUqi00WbNosDoODHLipTARL1NbBxC6DH4=;
        fh=1k9WKU6p4wGUqLDeodrEK3Qgf6diSvAG2L8KjbzFvRc=;
        b=SIM1WuunzaNAev6EUDPjktAsnSPKpxZ3MM4uoAJifFUi5LXzBiT+0jX9PN4QOcFyZo
         LAW1O2g+8VbvohUpA2I0GCGAPbe6HkkNqyweQHKWzbI/WASQmMPNfdKv11rqhmtCxpfa
         9f4NvOL+BU04JjIIAxir2heMPe0stiVNgywPRohebm0wYStW9ZDriZgr0ESVd4VzmHQ7
         bvfZu05/W372Vc4PYvkSbp7e5Jk/BZfFf2SCnLbpKGO1ukCz03AdC0HMAIvMIeRiAFNw
         bHLXkVCKBZUFLsYbgWx31MByKrNfjxnRkqie8kW49y0zYVTC9VgUal2rz/ulM2kPc+Zb
         dgzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773391455; x=1773996255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk7nu81wiNZUqi00WbNosDoODHLipTARL1NbBxC6DH4=;
        b=VTNGtEEOFcNCGVU7pcg7KrVTFVXqL8Mo96qpIS+w85rO2iKOvGP/FxbO/5MfTa2wXQ
         AJKFFsMBFgXaJFsboF2rs1DnFA8h8/RmFZ7wy1yvan+gQS87d8zOR7RTcZjX7iG5VpU8
         BvN7Em0XHn6pSyohMdZ11QfTAkZXtBDxBnS7g7NiSa0wDVfkriLfaRxul6DZR9sk8O72
         QrrvambQYHxQEuogj4PHVUugGzFDuoKvMBT/MM6+IwrD1SwxsF8ujk3raKxhatRigkqT
         nKSKkfx6eC3UuVuXYEZvbMIRjuY93t3kEjlXODo9F2bWA2o7qp8YTDE9BX/s0bxXR2hU
         bbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773391455; x=1773996255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zk7nu81wiNZUqi00WbNosDoODHLipTARL1NbBxC6DH4=;
        b=ePvngfe96AbalpsL2siR1Vzy7+OvUkTMdXbipvnssK/qfv7Doo1oUJtl+3sIvZgXrM
         +Xn/nJsqecJBXu/WEjhDb2MRKKLcIo4wF2GUw5MWguLu7FHt5LJ3PnxfY6lfMyithog6
         SqdYTVDuJeTY75XToEK3wycpe9UciWe3IpYLtabeepBbkUPRfjF0fuga9QlGUJprm2uN
         pGRJJTTz+fuVadgkntj5shwInlMvol055/pveZpO6yG+ULVXYjd074ssbcJmBblApFUQ
         5iwvBDl62T9Y4Lyx64ceeYZDNkhwdqeOflcf+u30EiSNEHNy++Iey0DG5iuPKi/Uz1HZ
         lgyQ==
X-Gm-Message-State: AOJu0Ywx6oT8uDhGXOfXzR4M5GXp8fIutKs0tO2ypiihIeTy2JU4KZLs
	jfn9bwduuD6MihS7N1lAm0YbYsKI9rKe3Yz8KrhgTR1mLsAyLESB2Bt02G9j0nhtaAA7dbytJJz
	dncffg+nb5Rg0ANqTvLarZ0/cHZZSCzmHDYhypdku8g==
X-Gm-Gg: ATEYQzx5aJsuiki6TxYz0l+9Nrm6ts5h7fZ9Fwshggig/zHBb/Bpm7lFlEGL0xgZ9w7
	OuGonNhYaEDUBmdJA7WKdHQJ6TjvEIHAhh5f+1i4BM24uEoaGoNerDEmCAcHbFQTQbCfodpfjHk
	c3gKqcGbx3Qz3yLByzc4NgiUQuV0ZdpAx5JXdQFXFWTmS0raWy/5+hpSivljWrl/h/VnaZB/cYp
	TfQMQkpCO7cRFTHd5g2Upb5Ibar73eNBRqRCdEO/xLn+XBcyKm9c+phTMEyeXnRKGV+Hk5+gh+u
	db7dSetLjF4dnCxCMOZ+6n9anjKfcPew6HlLFay70w==
X-Received: by 2002:a17:906:6b84:b0:b96:ef3a:46d1 with SMTP id
 a640c23a62f3a-b976515ebe3mr102420666b.46.1773391455384; Fri, 13 Mar 2026
 01:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311152845.278354-1-justin.iurman@6wind.com> <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it>
In-Reply-To: <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Fri, 13 Mar 2026 08:44:04 +0000
X-Gm-Features: AaiRm529jNwlV-vTpQbvstlWVwt1o1h3ibhQv26j2Dm_GP4JcJhUZBsHi4TOMyE
Message-ID: <CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	justin.iurman@gmail.com, nicolas.dichtel@6wind.com, 
	stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,6wind.com,uniroma2.it];
	TAGGED_FROM(0.00)[bounces-267337-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,6wind.com:dkim,6wind.com:email,srv6_hencap_red_l3vpn_test.sh:url,srv6_hl2encap_red_l2vpn_test.sh:url]
X-Rspamd-Queue-Id: 6C87127FE8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 2:02=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> On Wed, 11 Mar 2026 16:28:45 +0100
> Justin Iurman <justin.iurman@6wind.com> wrote:
>
> > Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
> > tunnel source address. Make seg6_iptunnel handle the new attribute
> > correctly. It has priority over the configured per-netns tunnel
> > source address, if any.
> >
> > Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> > ---
> > v2:
> >  - AI review: fix seg6_encap_nlsize() and seg6_encap_cmp() to include t=
unsrc
> >  - AI review: make set_tun_src() agnostic of seg6_lwt because it is cal=
led from
> >               two contexts other than seg6_iptunnel
> >
> > v1: https://lore.kernel.org/netdev/CAOY2BqxUswHYoisKjABPunMUC5QJ-B-O9aX=
u=3DwKrhTZaqSqedQ@mail.gmail.com/T/
> > ---
> >  include/uapi/linux/seg6_iptunnel.h |   1 +
> >  net/ipv6/seg6_iptunnel.c           | 115 +++++++++++++++++++++--------
> >  2 files changed, 85 insertions(+), 31 deletions(-)
> >
>
> Hi Justin,
> thanks for the fixes in v2.

Hi Andrea,

> IMHO, two things that would be really valuable to have alongside this pat=
ch:
>
> 1) I couldn't find the matching iproute2 patch for the new
>    SEG6_IPTUNNEL_SRC attribute; did I miss it, or is it still in the
>    works? In the second case, having it available would be great to
>    fully test the new feature;

I was waiting for this patch to reach maturity before submitting PATCH
iproute2-next. Fair enough, I'll send it too, it is ready anyway.

> 2) Since this introduces a new UAPI attribute, we definitely need
>    selftest coverage for it. Perhaps extending one of the
>    existing seg6 selftests (e.g. srv6_hencap_red_l3vpn_test.sh?) might
>    be a good option rather than writing a new one from scratch.

I agree. The reason why I did not is simply that, IIRC, none of the
srv6 selftests actually check the source address ("ip sr tunsrc set
xxx" is not even used, and dynamic resolution is the default
behavior). Note that the source address is specifically checked in
ioam6 selftest though (packet capture + parsing), but srv6 selftests
are not designed the same way. What I suggest is to not overcomplicate
things and simply modify srv6_hencap_red_l3vpn_test.sh and
srv6_hl2encap_red_l2vpn_test.sh to include a test that does encap with
"tunsrc" (and we could also add the same with "ip sr tunsrc set xxx").
It wouldn't check for a specific source address though, would just
make sure connectivity doesn't break like for other tests. Also, the
other question is should we duplicate all tests for those cases: with
"ip sr tunsrc set xxx", and with "tunsrc". WDYT?

> > diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/se=
g6_iptunnel.h
> > index ae78791372b8..485889b19900 100644
> > --- a/include/uapi/linux/seg6_iptunnel.h
> > +++ b/include/uapi/linux/seg6_iptunnel.h
> > @@ -20,6 +20,7 @@
> >  enum {
> >       SEG6_IPTUNNEL_UNSPEC,
> >       SEG6_IPTUNNEL_SRH,
> > +     SEG6_IPTUNNEL_SRC,      /* struct in6_addr */
> >       __SEG6_IPTUNNEL_MAX,
> >  };
> >  #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
> > diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> > index 3e1b9991131a..d45b6b49dd48 100644
> > --- a/net/ipv6/seg6_iptunnel.c
> > +++ b/net/ipv6/seg6_iptunnel.c
> > @@ -49,6 +49,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_=
encap *tuninfo)
> >

[snip]

> > @@ -702,13 +721,21 @@ static int seg6_build_state(struct net *net, stru=
ct nlattr *nla,
> >       slwt =3D seg6_lwt_lwtunnel(newts);
> >
> >       err =3D dst_cache_init(&slwt->cache, GFP_ATOMIC);
> > -     if (err) {
> > -             kfree(newts);
> > -             return err;
> > -     }
> > +     if (err)
> > +             goto free_lwt_state;
> >
> >       memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
> >
> > +     if (tb[SEG6_IPTUNNEL_SRC]) {
> > +             slwt->tunsrc =3D nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
> > +
> > +             if (ipv6_addr_any(&slwt->tunsrc)) {
> > +                     err =3D -EINVAL;
> > +                     NL_SET_ERR_MSG(extack, "tunsrc cannot be ::");
> > +                     goto free_dst_cache;
> > +             }
> > +     }
> > +
>
> build_state() only rejects ::. Multicast or loopback will be silently
> accepted, leading to an asymmetric black hole:
>
>  - seg6_input() path: encapsulated packet enters ip6_forward()
>    which has the "security critical" saddr check; drop on the same
>    node, packet never leaves;
>  - seg6_output() path: goes through ip6_output() which has no saddr
>    check; packet leaves, first transit drops it in ip6_rcv_core()
>    or ip6_forward().
>
> Either way, silent black hole.
>
> I think we could reject these at build_state time, matching a similar
> logic already present in ip6_forward(), e.g.:
>
>         if (ipv6_addr_any(&slwt->tunsrc) ||
>             ipv6_addr_is_multicast(&slwt->tunsrc) ||
>             ipv6_addr_loopback(&slwt->tunsrc)) {
>                 NL_SET_ERR_MSG(extack, "invalid tunsrc address");
>                 err =3D -EINVAL;
>                 goto free_dst_cache;
>         }

+1, makes sense.

> Whether to also reject link-local is debatable: ip6_forward() does
> drop it, but is there a legitimate use case where a link-local tunnel
> source would actually be needed?!
> I'd argue we should reject link-local addresses as well.
> For instance, using them as a tunnel source violates scope boundaries and
> breaks ICMPv6 error reporting.

IMHO, I also think we could reasonably forbid LLs.

> Side note: seg6_genl_set_tunsrc() in seg6.c has the same gap; likely wort=
h a
> separate fix targeting net. If we agree this is an issue, I'll try to sen=
d a
> follow-up patch later on, so that we can have a similar validation logic =
for
> both per-route and per-netns tunsrc.

I agree. We could synchronize offline to squash the same fix for ioam6_iptu=
nnel.

> >  static void seg6_destroy_state(struct lwtunnel_state *lwt)
> > @@ -731,29 +764,49 @@ static int seg6_fill_encap_info(struct sk_buff *s=
kb,
> >                               struct lwtunnel_state *lwtstate)
> >  {
> >       struct seg6_iptunnel_encap *tuninfo =3D seg6_encap_lwtunnel(lwtst=
ate);
> > +     struct seg6_lwt *slwt =3D seg6_lwt_lwtunnel(lwtstate);
> > +     int err;
> >
> >       if (nla_put_srh(skb, SEG6_IPTUNNEL_SRH, tuninfo))
> >               return -EMSGSIZE;
> >
> > +     if (!ipv6_addr_any(&slwt->tunsrc)) {
> > +             err =3D nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->t=
unsrc);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
>
> Minor nit: seg6_fill_encap_info() could drop the local `err` in favour
> of something like:
>
>         if (!ipv6_addr_any(&slwt->tunsrc) &&
>             nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc))
>                 return -EMSGSIZE;
>
> nla_put_in6_addr() can only return 0 or -EMSGSIZE, so this stays
> consistent with the nla_put_srh() pattern above.

Good catch!

Thanks,
Justin

