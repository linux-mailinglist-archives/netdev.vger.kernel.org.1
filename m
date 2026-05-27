Return-Path: <netdev+bounces-292401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM4vM1AhF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:52:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B98975E80C7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 430C230093B8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A873C7E0E;
	Wed, 27 May 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="DwOrKvEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81B37AA7A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900746; cv=pass; b=CellESmpyDLpRZobeAo0vVHlK/dI9c0F8B0bssvEGlgqCRYjozGvaTbxCGTKSeiSlhFezXDVsIkAS2yGo5aV+N+byoms5LtHUc7KCYhCYYS+0oT0PAJDoLPO0tee2UrdJ0QryoSjcHF/MMzQ88ocmyTXVn9mCpmNrkrOoHFQaQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900746; c=relaxed/simple;
	bh=UOl2rLunurLCgOcugvrwPxAhcVJo/aonvwRx5/Tqgec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc1khe9IvYTrFynjo9/SrVrEaAyAbmHAAl+iHfMF+y2JDyJyHSif2gjQyOlPtH1OYMAqv3xjpPb8wvEIgggEXpTg9R5lyi7uIMtxhXn8AbCVi0PC3ar3lOuqVFkt7ehNWpUGgOL0sve0pa9E19gv5jlT16iAWjJPNU1GFOCL+6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=DwOrKvEY; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-837dfccd950so5614347b3a.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779900744; cv=none;
        d=google.com; s=arc-20240605;
        b=O2dIB6Kk4IBeiTr3SXAkF3XFul/8mKIhZ47ozWnO5eat/7AEhc3RdiPtGazX1HxCdy
         MGwaFH5BUU5yrwQy4lXcTkS6x7ka5ge0/S8m3Z8t40p4lD7nshTOlsSCznhzxbUxJdZN
         0WkTDFLzVX8XsZYuNMfSiKqt14ZRY8U0ZwHM6FBqpyDkTAkW7QCNgEMu/YEaTyiQMHWF
         aE7vWlI4ahuu+tyIRLR7krLfZHrkJTtBDabzfVD8wME0SHa7TDKND3tvWHbTAtbITo5S
         TuFGmGa9ySnJ+F9KjHXzm+rn8oaHAej2uTEIlS9z+F5QdmRkScmqIoNfT8RH+EI8hJKL
         DGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3o4bRaiil/PFsPqaPqRZXFYwMjqY++xfKRZ1z2pNUK0=;
        fh=xLmr3BgYswbxrl1OAvn56pinlO5Zxhhy/tRkr+c/5us=;
        b=i2KWgtackKXo5QaxcbN/Ea4GDEHLE9IBUOwfkTMTXuxmrlQJfTyOHE9Cnmc3tNKb9f
         rBuAUD6shdu568PyaYZF7Jz+qMBtCbYLp/QIoJkUghvNo850rMZ0uJciVx0Ct+hPMNoL
         7W6W+48eXBDR1uJTI1WYmPnXrUs+WVDURrX8HsxxIwktb5C3GofgUpw+ZkR5itO7+WAn
         eaZM1VXlHiB5oxYmcS1szLcq2nCkBhRpGAFwERatochWu1hd1sXGSlZQJq9XFfS+IHA0
         MxlVxT3J3XMapkMSNw6/z53Q9/qtP137W+K2VRYCq5ZzNiwcnGPs6lDDDkL3733itTla
         XQ6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779900744; x=1780505544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o4bRaiil/PFsPqaPqRZXFYwMjqY++xfKRZ1z2pNUK0=;
        b=DwOrKvEYbjufhVKJArtiv6CaS7xoN7Tvi7b9XcU5BJQraCN8RGjzBCMoHuy62mb2tf
         1Lh9gSCZ+0fnwlF4aYORA8LAceigyf8XvlysepmqndlVi4yzD/Y/OfZZzq0lqmxWWpvd
         MsAN+FZOobutbIMGNXvkrxZVILunqVgknkrrc7TCxEyZKINe/Jpnrev5MIgGymh7rXZ0
         zWOf9F/cqfN5ZWx8AFl+o+cMr6otfdtkwI3lAJ2Luf0UvFwOIhnHDWYIgqmChfGRZaBa
         CFn70RBcMH3vtsOuqF5lpG8+70pgn4JQecSEgHKVg0jqoNoobKOnE98Ro66IyW2pkBBB
         yYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900744; x=1780505544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3o4bRaiil/PFsPqaPqRZXFYwMjqY++xfKRZ1z2pNUK0=;
        b=EMBr9fEEvoMf6A1ydOe5NEP1ir/tSArC6XOVqJrU15OFD9G8KzfsI+v2x/RdRHr1w7
         r1i1SczKv6uS8ht9G5ilVCO1dRNJ+lG+8j2FWDLASF2uOvBECTOxIUpUBzKXnRVt2VYp
         UFKkmzAN8fGoxrDdmdoDh/bqlyTdmAhBrIv3zd9QQAuR4v81qx/Bp4CP2M8dvnQ/Hu1Y
         Px7K4LlxHmJkG/w5nhtQ45aYRurX/UmdYfhnRBGXXfWNuIbhGL5bKDB3ouAy8P2nqmtc
         jKI/TYu229nWrRTyeSZGiw0CfTuv8+oUddIIvKzfl+kVd/g4T1a4DdQjA/9vHnX/l/UT
         cjhw==
X-Gm-Message-State: AOJu0YxAn/FxQQW4iT3kXG4XaCbp3Y+LKkC8yeu8ffc77EttiMqxw8kg
	XjzQA/O5SBspd8CRR+GCdpgF5x8KVcL1HlJFS6qBwpKxGl77vhifYp/8TM7Auy5N1jsOQ+aZEh5
	F3wSnlsrXhzIf8qugR9JLwfnvCWqS8yhrnciS/BIu
X-Gm-Gg: Acq92OEa1ZqWlI4NKf0o8ewTxEpcndUDQ8lUTadf3BDvoTWKsmRsJbZayFeEW59tbl/
	Gq14Cz3VoNAHRBuv7oGUnJBe0ilFOiUeGDhAcmN3fA3tBJIRQyrwY/aIgP/dF4Zl7FU2sSSsLkC
	G31T2N/S6/CY3eJS6rmjXzRErkMo8Lri10aYsGu8DJUt+rcGluwpc2BDmNqueLQJkAMDiv7hOWJ
	u/iVQ2AZZgnSUn9iwdclbsRLgVTBdq+Lz/pY9oM82ckwSEYJ4mDycOiPCn9OHZIdD2WoNymZvtP
	qTOzjg5pxgwW34l2UpsOxKZhIte5XA==
X-Received: by 2002:a05:6a00:a90:b0:82c:212a:a9b5 with SMTP id
 d2e1a72fcca58-8415f37c00fmr23486839b3a.36.1779900743733; Wed, 27 May 2026
 09:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521131436.748832-1-jhs@mojatatu.com> <d22446ec-d5bd-4950-998f-2af15a46bfea@redhat.com>
 <CAM0EoM=CPeOaoMUjXEp3eGeBVjomyWYV-2qj0jMOP+DNvjuPMA@mail.gmail.com>
 <78db23f1-1ac7-4d87-97e5-668b685818c4@redhat.com> <CAM0EoMnaqFgKBYBKrXh4tdbo6-JXC1HBhHWqOx=kQu9yFxk2fQ@mail.gmail.com>
 <6c4e1859-bd3f-4227-b268-1c7dbe5935cb@redhat.com>
In-Reply-To: <6c4e1859-bd3f-4227-b268-1c7dbe5935cb@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 12:52:12 -0400
X-Gm-Features: AVHnY4LJL_qZfUE_X7ytsTLzt-jTDZzU3kzzi7GXJCSj4zD9A-vSGhpVc5E0jM4
Message-ID: <CAM0EoM=WCCrsHa7PgCLPr2o=_nXAAkGFF74mmq-Y6=bNSt8SAQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292401-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B98975E80C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 5/27/26 5:34 PM, Jamal Hadi Salim wrote:
> > On Wed, May 27, 2026 at 4:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 5/26/26 2:38 PM, Jamal Hadi Salim wrote:
> >>> On Tue, May 26, 2026 at 5:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>> On 5/21/26 3:14 PM, Jamal Hadi Salim wrote:
> >>>>> Context: This commit fixes a UAF in Geneve. The UAF component was d=
iscovered
> >>>>> because it is triggered by a buggy 'pedit' action[1]. the buggy ped=
it uses
> >>>>> skb_store_bits() and can write into shared or non-linear data witho=
ut copying
> >>>>> the entire skb head. The Geneve device invoking either pskb_may_pul=
l() or
> >>>>> iptunnel_pull_header() is much more likely to reallocate the skb he=
ad, freeing
> >>>>> the memory pointed to by geneve's stale geneveh pointer.
> >>>>>
> >>>>> Note, although the patch looks big it's mostly re-arranging functio=
ns to avoid
> >>>>> forward declaration.
> >>>>>
> >>>>> Sample UAF below:
> >>>>> ....
> >>>>> BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3=
190
> >>>>> Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62
> >>>>>
> >>>>> CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-001=
82-g0e3e91779b94 #551 PREEMPT(full)
> >>>>> Workqueue: ipv6_addrconf addrconf_dad_work
> >>>>> Call Trace:
> >>>>>  <IRQ>
> >>>>>  dump_stack_lvl+0x8c/0xd0
> >>>>>  print_report+0xce/0x5e0
> >>>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>>>  ? kasan_complete_mode_report_info+0x80/0x200
> >>>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >>>>>  kasan_report+0xd6/0x110
> >>>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >>>>>  __asan_report_load1_noabort+0x18/0x20
> >>>>>  geneve_udp_encap_recv+0x2e8c/0x3190
> >>>>>  ? get_stack_info+0x38/0xc0
> >>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>>>  ? __pfx_geneve_udp_encap_recv+0x10/0x10
> >>>>>  ? udp4_lib_lookup2+0x31c/0x700
> >>>>>  ? __pfx_udp_ehashfn+0x10/0x10
> >>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>>>  ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
> >>>>>  udp_queue_rcv_one_skb+0x65e/0xd20
> >>>>>  udp_queue_rcv_skb+0x142/0xb00
> >>>>>  udp_unicast_rcv_skb+0xd3/0x2c0
> >>>>>  udp_rcv+0x198f/0x2570
> >>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>>>  ip_protocol_deliver_rcu+0x1f8/0x3c0
> >>>>>  ip_local_deliver_finish+0x362/0x5d0
> >>>>> ....
> >>>>>
> >>>>> [1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta=
@oss.qualcomm.com/
> >>>>> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> >>>>> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> >>>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>>> ---
> >>>>> v1->v2 Address gemini-sashiko.
> >>>>> 1. local variable "len" initialization in geneve_post_decap_hint()
> >>>>>    Although doesnt contribute to the fix, it was introduced in fd0d=
d796576e
> >>>>> 2. resolve out-of-bounds transport header for non-GSO packets
> >>>>> ---
> >>>>>  drivers/net/geneve.c   | 174 ++++++++++++++++++++++---------------=
----
> >>>>>  include/linux/skbuff.h |   5 ++
> >>>>>  2 files changed, 98 insertions(+), 81 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> >>>>> index c6563367d382..dc5f5394836a 100644
> >>>>> --- a/drivers/net/geneve.c
> >>>>> +++ b/drivers/net/geneve.c
> >>>>> @@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(st=
ruct geneve_sock *gs,
> >>>>>       return NULL;
> >>>>>  }
> >>>>>
> >>>>> +/*
> >>>>> + * Look for GRO hint in the genenve options; if not found or does =
not pass basic
> >>>>> + * sanitization return 0, otherwise the offset WRT the geneve hdr =
start.
> >>>>> + */
> >>>>> +static unsigned int
> >>>>> +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
> >>>>> +                     unsigned int *gh_len)
> >>>>> +{
> >>>>> +     struct geneve_opt *opt =3D (void *)(gh + 1);
> >>>>> +     unsigned int id, opt_len =3D gh->opt_len;
> >>>>> +     struct geneve_opt_gro_hint *gro_hint;
> >>>>> +
> >>>>> +     while (opt_len >=3D (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
> >>>>> +             if (opt->opt_class =3D=3D htons(GENEVE_OPT_NETDEV_CLA=
SS) &&
> >>>>> +                 opt->type =3D=3D GENEVE_OPT_GRO_HINT_TYPE &&
> >>>>> +                 opt->length =3D=3D GENEVE_OPT_GRO_HINT_LEN)
> >>>>> +                     goto found;
> >>>>> +
> >>>>> +             /* check for bad opt len */
> >>>>> +             if (opt->length + 1 >=3D opt_len)
> >>>>> +                     return 0;
> >>>>> +
> >>>>> +             /* next opt */
> >>>>> +             opt_len -=3D opt->length + 1;
> >>>>> +             opt =3D ((void *)opt) + ((opt->length + 1) << 2);
> >>>>> +     }
> >>>>> +     return 0;
> >>>>> +
> >>>>> +found:
> >>>>> +     gro_hint =3D (struct geneve_opt_gro_hint *)opt->opt_data;
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Sanitize the hinted hdrs: the nested transport is UDP and =
must fit
> >>>>> +      * the overall hinted hdr size.
> >>>>> +      */
> >>>>> +     if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
> >>>>> +         gro_hint->nested_hdr_len)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     if (gro_hint->nested_nh_offset +
> >>>>> +         (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
> >>>>> +                                   sizeof(struct iphdr)) >
> >>>>> +         gro_hint->nested_tp_offset)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     /* Allow only supported L2. */
> >>>>> +     id =3D gro_hint->inner_proto_id;
> >>>>> +     if (id >=3D ARRAY_SIZE(proto_id_map))
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     *type =3D proto_id_map[id];
> >>>>> +     *gh_len +=3D gro_hint->nested_hdr_len;
> >>>>> +
> >>>>> +     return (void *)gro_hint - (void *)gh;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct geneve_opt_gro_hint *
> >>>>> +geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_=
off)
> >>>>> +{
> >>>>> +     return (const struct geneve_opt_gro_hint *)((void *)gh + hint=
_off);
> >>>>> +}
> >>>>> +
> >>>>> +static unsigned int
> >>>>> +geneve_sk_gro_hint_off(const struct sock *sk, const struct geneveh=
dr *gh,
> >>>>> +                    __be16 *type, unsigned int *gh_len)
> >>>>> +{
> >>>>> +     const struct geneve_sock *gs =3D rcu_dereference_sk_user_data=
(sk);
> >>>>> +
> >>>>> +     if (!gs || !gs->gro_hint)
> >>>>> +             return 0;
> >>>>> +     return geneve_opt_gro_hint_off(gh, type, gh_len);
> >>>>> +}
> >>>>> +
> >>>>>  /* geneve receive/decap routine */
> >>>>>  static void geneve_rx(struct geneve_dev *geneve, struct geneve_soc=
k *gs,
> >>>>>                     struct sk_buff *skb, const struct genevehdr *gn=
vh)
> >>>>> @@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *genev=
e, struct geneve_sock *gs,
> >>>>>       if (tun_dst)
> >>>>>               skb_dst_set(skb, &tun_dst->dst);
> >>>>>
> >>>>> +     if (skb->encapsulation) {
> >>>>> +             unsigned int len =3D 0, hint_off;
> >>>>> +             __be16 p;
> >>>>> +
> >>>>> +             hint_off =3D geneve_sk_gro_hint_off(gs->sock->sk, gnv=
h, &p, &len);
> >>>>> +             if (hint_off && len <=3D skb_headlen(skb)) {
> >>>>> +                     const struct geneve_opt_gro_hint *gro_hint;
> >>>>> +
> >>>>> +                     gro_hint =3D geneve_opt_gro_hint(gnvh, hint_o=
ff);
> >>>>> +                     skb_set_transport_header(skb, gro_hint->neste=
d_tp_offset);
> >>>>> +             }
> >>>>> +     } else {
> >>>>> +             skb_unset_transport_header(skb);
> >>>>> +     }
> >>>>
> >>>> It's not clear to me why the above chunk is needed.
> >>>
> >>> I think you understand this so i may be stating the obvious:
> >>> The main motivation was to isolate the pulls from making the transpor=
t
> >>> header stale
> >>> IOW, geneve_hdr(skb) pointer could become "stale" if the packet's hea=
d
> >>> was reallocated (because geneve_rx() is called after all the "pull"
> >>> operations) - so this ensures that the inner transport header is only
> >>> set after all header pulling is done - otherwise we get a UAF.
> >>
> >> Uhmm... my questions sparked because this patch adds quite a bit of ne=
w
> >> conditionals in the data-path, which I would like to avoid them.
> >>
> >> But I must admit that re-reading the code - I'm likely low on coffee -=
 I
> >> don't see the UaF. This sequence:
> >>
> >>         pskb_may_pull(skb...)
> >>         geneveh =3D geneve_hdr(skb);
> >>
> >> is correct/does not yield to UaF, and AFAICS `geneveh` is always
> >> reloaded after pskb_may_pull()/iptunnel_pull_header(). Could you pleas=
e
> >> share a decoded stack trace for the UaF you are observing? So it's cle=
ar
> >> where exactly kasan reports the problem.
> >>
> >
> > The only one i have is what is in the commit. Comments below..
> >
> >>>> Why can't
> >>>> geneve_post_decap_hint() retain the transport header set in the curr=
ent
> >>>> place? it would make this patch much shorter.
> >>>>
> >>>
> >>> It was more to ensure clean state for cases where we dont have GRO hi=
nts.
> >>> The "else {skb_unset_transport_header(skb);} " handles the case where
> >>> we are missing GRO hints - at that point outer UDP header is stripped
> >>> but tranport header is still pointing to where this outer header used
> >>> to be and something down the road may misintepret the header.
> >>
> >> This looks like an unrelated problem?!? And possibly not a problem at
> >> all?!? Upper layers (outside GSO) are expected to re-evaluate the
> >> transport header as needed.
> >
> > Let me provide context, maybe that will help explain or provide a way
> > to fix this better.
> >
> > I received multiple patches (via security) to resolve the pedit issue;
> > Rajat's was the first one.
> > Rajat's repro tricks geneve into having _negative transport offsets_.
> > Does that trigger anything for you? geneve just trusts those headers
> > are valid.
> > It was not Rajat's patch that caused this splat but one of the
> > multiple other reported alternative patches. I would have to dig in to
> > find which patch caused the splat.
> >
> > Does this help? The key i believe is looking at the effect of negative
> > transport headers.
>
> Indeed, thank you for the context! My (very) wild guess/first suspect is
> that what really fixes the issue is the transport header reset.
>

I believe so. Initial patch was to reset it in the core code in my
adventure to ensure all tunnels are handled equivalently but gave up
after thinking it's too risky.

> > I can send you the repro maybe you will be able to have a better approa=
ch.
>
> I think I already have that one. Let me try to use it and do some
> experiments. Unfortunatelly it will require a little calendar time, due
> to obvious EOUTOFTIME :(

I will leave it in your able hands to whatever is appropriate.
The sense of urgency to get a fix is not there anymore since it seems
we are making good progress on the pedit one.

cheers,
jamal

> /P
>

