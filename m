Return-Path: <netdev+bounces-291685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OUEAEWUFWpSWgcAu9opvQ
	(envelope-from <netdev+bounces-291685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:38:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180B5D5A6A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40F5F30041DD
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2B3E0252;
	Tue, 26 May 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="Gn608j46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23E3DB99C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799106; cv=pass; b=JxzJOSkhZ7FP4RiFMdRFRhLUBzrt6CrHofp61aLbhwIYOEA5fchdGBWOB1Vcvfd6IH0KyU7VnuCZEeLFobQdWMxSeHxrTfWThS+0zRlHERoqTybSAEM8irw52INkaiL+J/XH+AoARNTfFiRLC48d3x8/z/WnJsfh/FsiLjVsWfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799106; c=relaxed/simple;
	bh=tRJ7Ju5wO65R9VxD5WXhoxqcIMog5FuB4jZbbBw8U1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOGsdskqsmFRb+8OmFhiSnQ/qIdvHEbhla1UmpSZLWzkurFfDSjwxODhcds5Lr4Wpr1ay/m3IJpBkPnOR+D7T2xXdjOuYj0Xz7v7mV0KPsKd3xwx3kjhJOs57Mj12BcGBUeZFfCJoGWs8vh0OzhUHxsUPZqUUU0MPgeB3rdq3Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=Gn608j46; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36aa4ae1f11so1561692a91.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 05:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799104; cv=none;
        d=google.com; s=arc-20240605;
        b=AvhxI/2qC5WbvAqH4aGLMy11olbhpBWHRWxAkeIpxN9uIekyNdR2bgvFQCqnD7ckg3
         TkREwjELn/0hDtLbP0FxrEKlYU5LqAaHHRDJQZzxMdDYjtSh8DTH4NaFTu7PZkfNVRCA
         R3BO6R/DXGVcqTNhYcgtF+nKm2hdOxH3TWH4XFlPaiJIUd5Q4nSC26ZNKTy+SZLDjuYL
         Grw0Ynwip0rz6HaEzQ1PgI09RHnIuDwELRXOXXpdK0jJ5TDyCbZunfV9O/8XzPYrfA19
         O6BfLIbz8H6mtwrJeCGXFZZDkgHfnV1Lkul4OmWzl9cehYAqgLbCnKThnlc1VkyRUNc0
         STPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M4glyFhk391JPzzVkC9/QIFk6CNzGxCN+fzZSBS4Qd4=;
        fh=xLmr3BgYswbxrl1OAvn56pinlO5Zxhhy/tRkr+c/5us=;
        b=iyaf3bbsjEdBnfOtNYWxGOeBtCS4oZFGNBdEB3HRrsRLK/wR2uVI19tJcHldXRHnUF
         PcxVGMljdsaI0XnADQH6RfBjsw2nJsESuySdFoB4P5voCBrtrBP+iztYRzSiDGq9T7eY
         Mkzenfbi/oe2Y1z4zGFz/HzUZAV3RKH3IDEdh6s2nkjsZB1BR9ljMxWFtkuyz+Unr50O
         tQ2pW+bm4jC7cBkuY3zhFZ5duzawXoxwaDPCpAQSR32O8wlTi0QRTRVwyHkSvraBXQop
         9UxKGIBf4tFcLYOiknLt+jRDNMzkcitG9hG0yvStR1Azg5EFdfgenKH1Qq0vBBrCwbnF
         LDeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779799104; x=1780403904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4glyFhk391JPzzVkC9/QIFk6CNzGxCN+fzZSBS4Qd4=;
        b=Gn608j466RXpCQlsG6EM647RUIQLSRJHxZwbZ3x64X0gBpxZd7wffrV+2fv5HTQ29+
         7vUV3J1R3+KdcMUVA16TuXSzpFiwyHBT0F6eI2XVBXh4K/ca+ALflozSg5+g+NIHnAnA
         UpKPDDv+8K2uI4ZuEz8ppFEj1NXfJTHVL5zXESkJVmVTvw9BxjEnHO8d9oqWHimEtpjy
         ynl17xxUqgnTE26WuLRTcm9qPyw8pVKEBBXbwVsBiolyE097F3pz9VRx7kfAVMtD64c6
         x0kdby2mlmsaZtXczqr7NEhfgIkso0l3n9Mt7zsc56EnDNLoHEoabhcaflkgjnQ81fug
         /QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799104; x=1780403904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M4glyFhk391JPzzVkC9/QIFk6CNzGxCN+fzZSBS4Qd4=;
        b=nVHpD0GFNL3G9DL3lF+gmqGC3Ec7QaETbobPKJNuuKdpN21cUDTMP/BIjfgVNn3KCz
         SELsIzXpOOzjailEx7OhDdHM0BTtxCv2ealVEzg8GwLLnDBZiMOGH20zrwo7o/AuLCP9
         7z76FGfzKhbM8hZJoRcnViFFsqVfcvuPeZI2xLfvzYGpH9UWR5+rAf4DTJJtM/sIy0VC
         2wZQwDN/yrR+0ePehv2iKbk4qVihCouq6XJ1advHFUvr5Osb+2Zsy3eMLhZZwwsljtKW
         /C4DsykD6Kho8L1yNY5umkQHJircKWagd4XHo9FQ3FaEqHplLuL1lBrQ1g6ZfqSsAmkJ
         LGIg==
X-Gm-Message-State: AOJu0YzGg47hgCSmMJiHAAWg8xG91LTNCO9Zgs3/sYPvwgp7lT2oYwPf
	O0hdT/CtG8xeiRvQfhQ6hgfp12jCVbJQ2eaacn9lb2Z+6b9Kh92KpAzz/M8B3No6T0d4ZFA3e6g
	TPev/jMNdKB3piwbcZHOxvR/RnpWXjrHfOqlQ8djP
X-Gm-Gg: Acq92OG2pUsyMkCZaSpEC8Z9QRAS3XwzkI1+XprbkbxWXNHfhcdRnKPDv/BM3hVIrOS
	y+mFAM0d+86AzRduzqZxS8rEYfZw6fYsYsXQW/ymP5Ej1Gnzc6NjjeWzZuWLz/pYLw+wcONi67X
	7U72+2E68W9fECa+u8eiuv8rtpNtHxbKrVGpwWLx+yp2zObPtEhWLTs+XCH8Vr72m+aS5MgQo6D
	Xbo/RTv8usYuTtUzX17tEDyHhfU2qUrzL3RxFVcLqcPx90eiUOC3eaF4TjCVqFx7gid6nF5lHxI
	8rJZZ4XSwxsVWADBCwI=
X-Received: by 2002:a17:90b:5845:b0:366:4a47:f267 with SMTP id
 98e67ed59e1d1-36a6765a7b1mr17489035a91.16.1779799103718; Tue, 26 May 2026
 05:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521131436.748832-1-jhs@mojatatu.com> <d22446ec-d5bd-4950-998f-2af15a46bfea@redhat.com>
In-Reply-To: <d22446ec-d5bd-4950-998f-2af15a46bfea@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 May 2026 08:38:11 -0400
X-Gm-Features: AVHnY4IiwgmNxOmYpZJp8cgDONEBrgNyJFH-U1LtfJbkNaFW4wbpQV8QWDDQ_fA
Message-ID: <CAM0EoM=CPeOaoMUjXEp3eGeBVjomyWYV-2qj0jMOP+DNvjuPMA@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/1] geneve: fix Use-After-Free in RX path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, andrew+netdev@lunn.ch, 
	rajat.gupta@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291685-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,qualcomm.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9180B5D5A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 5/21/26 3:14 PM, Jamal Hadi Salim wrote:
> > Context: This commit fixes a UAF in Geneve. The UAF component was disco=
vered
> > because it is triggered by a buggy 'pedit' action[1]. the buggy pedit u=
ses
> > skb_store_bits() and can write into shared or non-linear data without c=
opying
> > the entire skb head. The Geneve device invoking either pskb_may_pull() =
or
> > iptunnel_pull_header() is much more likely to reallocate the skb head, =
freeing
> > the memory pointed to by geneve's stale geneveh pointer.
> >
> > Note, although the patch looks big it's mostly re-arranging functions t=
o avoid
> > forward declaration.
> >
> > Sample UAF below:
> > ....
> > BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3190
> > Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62
> >
> > CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182-g=
0e3e91779b94 #551 PREEMPT(full)
> > Workqueue: ipv6_addrconf addrconf_dad_work
> > Call Trace:
> >  <IRQ>
> >  dump_stack_lvl+0x8c/0xd0
> >  print_report+0xce/0x5e0
> >  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? kasan_complete_mode_report_info+0x80/0x200
> >  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >  kasan_report+0xd6/0x110
> >  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >  __asan_report_load1_noabort+0x18/0x20
> >  geneve_udp_encap_recv+0x2e8c/0x3190
> >  ? get_stack_info+0x38/0xc0
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? __pfx_geneve_udp_encap_recv+0x10/0x10
> >  ? udp4_lib_lookup2+0x31c/0x700
> >  ? __pfx_udp_ehashfn+0x10/0x10
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
> >  udp_queue_rcv_one_skb+0x65e/0xd20
> >  udp_queue_rcv_skb+0x142/0xb00
> >  udp_unicast_rcv_skb+0xd3/0x2c0
> >  udp_rcv+0x198f/0x2570
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ip_protocol_deliver_rcu+0x1f8/0x3c0
> >  ip_local_deliver_finish+0x362/0x5d0
> > ....
> >
> > [1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@oss=
.qualcomm.com/
> > Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1->v2 Address gemini-sashiko.
> > 1. local variable "len" initialization in geneve_post_decap_hint()
> >    Although doesnt contribute to the fix, it was introduced in fd0dd796=
576e
> > 2. resolve out-of-bounds transport header for non-GSO packets
> > ---
> >  drivers/net/geneve.c   | 174 ++++++++++++++++++++++-------------------
> >  include/linux/skbuff.h |   5 ++
> >  2 files changed, 98 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index c6563367d382..dc5f5394836a 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
> > @@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(struct=
 geneve_sock *gs,
> >       return NULL;
> >  }
> >
> > +/*
> > + * Look for GRO hint in the genenve options; if not found or does not =
pass basic
> > + * sanitization return 0, otherwise the offset WRT the geneve hdr star=
t.
> > + */
> > +static unsigned int
> > +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
> > +                     unsigned int *gh_len)
> > +{
> > +     struct geneve_opt *opt =3D (void *)(gh + 1);
> > +     unsigned int id, opt_len =3D gh->opt_len;
> > +     struct geneve_opt_gro_hint *gro_hint;
> > +
> > +     while (opt_len >=3D (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
> > +             if (opt->opt_class =3D=3D htons(GENEVE_OPT_NETDEV_CLASS) =
&&
> > +                 opt->type =3D=3D GENEVE_OPT_GRO_HINT_TYPE &&
> > +                 opt->length =3D=3D GENEVE_OPT_GRO_HINT_LEN)
> > +                     goto found;
> > +
> > +             /* check for bad opt len */
> > +             if (opt->length + 1 >=3D opt_len)
> > +                     return 0;
> > +
> > +             /* next opt */
> > +             opt_len -=3D opt->length + 1;
> > +             opt =3D ((void *)opt) + ((opt->length + 1) << 2);
> > +     }
> > +     return 0;
> > +
> > +found:
> > +     gro_hint =3D (struct geneve_opt_gro_hint *)opt->opt_data;
> > +
> > +     /*
> > +      * Sanitize the hinted hdrs: the nested transport is UDP and must=
 fit
> > +      * the overall hinted hdr size.
> > +      */
> > +     if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
> > +         gro_hint->nested_hdr_len)
> > +             return 0;
> > +
> > +     if (gro_hint->nested_nh_offset +
> > +         (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
> > +                                   sizeof(struct iphdr)) >
> > +         gro_hint->nested_tp_offset)
> > +             return 0;
> > +
> > +     /* Allow only supported L2. */
> > +     id =3D gro_hint->inner_proto_id;
> > +     if (id >=3D ARRAY_SIZE(proto_id_map))
> > +             return 0;
> > +
> > +     *type =3D proto_id_map[id];
> > +     *gh_len +=3D gro_hint->nested_hdr_len;
> > +
> > +     return (void *)gro_hint - (void *)gh;
> > +}
> > +
> > +static const struct geneve_opt_gro_hint *
> > +geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
> > +{
> > +     return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off=
);
> > +}
> > +
> > +static unsigned int
> > +geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *=
gh,
> > +                    __be16 *type, unsigned int *gh_len)
> > +{
> > +     const struct geneve_sock *gs =3D rcu_dereference_sk_user_data(sk)=
;
> > +
> > +     if (!gs || !gs->gro_hint)
> > +             return 0;
> > +     return geneve_opt_gro_hint_off(gh, type, gh_len);
> > +}
> > +
> >  /* geneve receive/decap routine */
> >  static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *g=
s,
> >                     struct sk_buff *skb, const struct genevehdr *gnvh)
> > @@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve, s=
truct geneve_sock *gs,
> >       if (tun_dst)
> >               skb_dst_set(skb, &tun_dst->dst);
> >
> > +     if (skb->encapsulation) {
> > +             unsigned int len =3D 0, hint_off;
> > +             __be16 p;
> > +
> > +             hint_off =3D geneve_sk_gro_hint_off(gs->sock->sk, gnvh, &=
p, &len);
> > +             if (hint_off && len <=3D skb_headlen(skb)) {
> > +                     const struct geneve_opt_gro_hint *gro_hint;
> > +
> > +                     gro_hint =3D geneve_opt_gro_hint(gnvh, hint_off);
> > +                     skb_set_transport_header(skb, gro_hint->nested_tp=
_offset);
> > +             }
> > +     } else {
> > +             skb_unset_transport_header(skb);
> > +     }
>
> It's not clear to me why the above chunk is needed.

I think you understand this so i may be stating the obvious:
The main motivation was to isolate the pulls from making the transport
header stale
IOW, geneve_hdr(skb) pointer could become "stale" if the packet's head
was reallocated (because geneve_rx() is called after all the "pull"
operations) - so this ensures that the inner transport header is only
set after all header pulling is done - otherwise we get a UAF.

>Why can't
> geneve_post_decap_hint() retain the transport header set in the current
> place? it would make this patch much shorter.
>

It was more to ensure clean state for cases where we dont have GRO hints.
The "else {skb_unset_transport_header(skb);} " handles the case where
we are missing GRO hints - at that point outer UDP header is stripped
but tranport header is still pointing to where this outer header used
to be and something down the road may misintepret the header.

> If the above is really needed, I think it would be better to move the
> code around in a separate, pre-req, patch.
>

Yes, that would be more readable. So if i understood you correctly - break =
into:
patch 1: move GRO hint functions to avoid forward declarations
patch 2: Fix the UAF

cheers,
jamal

