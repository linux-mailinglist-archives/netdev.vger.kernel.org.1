Return-Path: <netdev+bounces-302159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LxYNFypwPmpvGAkAu9opvQ
	(envelope-from <netdev+bounces-302159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:27:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A285B6CCF8B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AHWFwgpH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C68830210E5
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EA3F4DCF;
	Fri, 26 Jun 2026 12:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13523F485D
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 12:25:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476741; cv=pass; b=t9BFKT6/THAD7AcaNuFBinaxfX5Ya3x/rgXqgDbVjQUn9rqqGrhzl5OC9u80+ZLYN+deEXbDgMxZuQD3FpVg6Aw/iUrH7ug2GlhMzcg/Dw5OtXN3r4Ixmkb73PQo+u/WrDfsj3MP9YxZHFuP/NzNMETIoqJ/bGcF/PNFFkMF4pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476741; c=relaxed/simple;
	bh=wcAW23DeNB+Geuqt+1Y4dPn5SMIhXoqynsUcFLY8Rz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPelTMJLrhfVoB6rzlGAIUPA5/dSJ2UySdgbyNsbxvzsBKzZxeqCO0nPMKKcWmJts0Qw3NvFqfV30Fx8wmk8kDbr95My3ZdWOKV0UHJlu4DzJnUuVCjQe01Q8bfEhMudjEqMT0QFRo30Xxg1BIhACHqeMXqiZJsHIEy7IzTKF+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHWFwgpH; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad58351784so692978e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 05:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782476738; cv=none;
        d=google.com; s=arc-20260327;
        b=EIGw6cJTg2XwZywwPKrGDeP36pcVIDH0v3a7gikEfxzUjoFLxKSKSav+0NrxT6cXnt
         OW1ZTYH0jXa+BIwU29RwSwDMwyWiOCR8k38gnOCXjmNxYsZudMQrmqfRZJWlIBfZieIL
         b0j/Btuz5O2H2lGRMIZvl1SpOENv7l0QK66V1SdScHtKtWlzj6YFQDA7LDS0CenyBK8W
         MKUPEtHVJVugEbyIjPfHQmw3zN8ya1rTDm8K3SzNMTdCnv28kmf8kRIlb3NxCkdTEPFW
         kLffYs060Ry4SAPqgreHRtcxob35fAhWQkBIyIAKLCeVciA2+6bvY4KAJFaqKmPxjE2a
         cCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Th1VvDD9Oki0IThJKp3H3ZhWOYcyT4z98kEdO2PovU=;
        fh=0NIk+BGKThqhO0fmirm9D9nZbZCYdG6mhoE+8AQcBds=;
        b=TPhYMo+aX57UApXua2stekjIbPtAwB/32B0Ym1sgyqZRIS4Jx/2GA2Izroe3UQXtdp
         3dtvxTZ9KgmtgXhkzfoZ8tzMTJX2cHemoGR3crWwTdF1GTT33gvikIJkX9JrLfBDVJZY
         vrXPgIdP4zeaoswxlDcpP29QyNfb9quld/E7mcBkfQDSJL+BPoeWGF8NBPu9FMkx+d4o
         x8gD9Ov8CzKttFoxBhLfp6CHlHusQ0zhc68i0O8+U1CvpztUljhv0b3v8HcawUJLdKCL
         Ngb4PZLWlv3UDHJFvYHHeeeJlH8dEgYvCUNuT4hSHefSsWR+avLs6yc7Dqjqxu8wC7ij
         lNnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782476738; x=1783081538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Th1VvDD9Oki0IThJKp3H3ZhWOYcyT4z98kEdO2PovU=;
        b=AHWFwgpHcVxfWC447JVo0H/qtJ3AbxHS+sHoBlRSwZRMERt9G9gBn247REsuxaau2y
         u2VjboIuTOIWM5UHD3RFJxXOazL65O4GZy+5BU+Z2rc6pGd6gEqGJR0ICHncbmamGalp
         sKwZFTvQy6Ate6iYXN0SlmrgTpeLRxr4IW6nypBREF/5Y/YJnQjqYxUsR4CTrquxmVRw
         /+NAnD1DfYHHaihUBChrQYDHhaIacvyl2lnNb6RR/iCjCjvzp9yRwllPoLVottUuuhn1
         kt0/o9bS99/8kt1MAxPh04+plPlXzmtNw3oYoPfeYrMuJj3mS64aY1j+KYkTS8cQ3PQQ
         J+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476738; x=1783081538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Th1VvDD9Oki0IThJKp3H3ZhWOYcyT4z98kEdO2PovU=;
        b=ieL6eH+emT05CBMGfT/cfRYg62cNtD9t8dCTdGBGj4gXd9Tw1Ab33nd4Ta8TmOpgsj
         80FZBlelCcmasO3icZiKgYZL5q7SG042jnTbSFt6zvrjqh8+snLMPfFZpW9RaOondEuH
         2GDXlCJ+mvLaqfBQrJ1YvZHYD1f/sAUu3SLw3oQeL4RCEyx7T4fD0oZLhJQDqI166orD
         AGaCEAeSvn0bpdUh2/4tWFlnCHyfnProDaS2JiB3w5Whz7pSZH4fHlfPV7lF6Sv2RnhB
         ZLkJKb+oiHM33qr6FOu6qIfmDy1vuaLzHfLUKiyTzNNIVBzpI0yOXJQ2lJfMcSBqQxKj
         FDuA==
X-Forwarded-Encrypted: i=1; AHgh+RpW9dqTCuF/brGRyQ/FesEcIRDSK2/s+RCXKwbISjWuSkrDfLI656Cq9QToQEzpbHlbJHAK/ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YynduozJ4Cd89uqCvM7KMv+jDCu9ZprhMQ8zeWEyoLW5qm3+yZA
	Kztt0jBIXbB6s6ynkioF74SUXAhldI/e8T8+8YvUUjQC0Xq19YH6KInz4HZOnis79gwAEUYJhgW
	jV/UazFUa9TIYKEX2SOeJnkhIFI82Rd4=
X-Gm-Gg: AfdE7ckPN5tuWsuHleGeR+iH6Zp8vUunuFB1pP/gOQ4CUDYlljHIAVm8MoM1SBOhk8m
	/VSC2nIit6fwWaCwLQMDEHUUva0DrqYocSp4OkDWNhjLh9X2jIHtftx9eIDdju92o4M3xxp9H6o
	ufNm4IknoVzh3c3yOvb7Vc9a/HWsVoeA96giu7YpnmB3KN5nbKV6QSuTV/lNd50AO10MY7ruwSG
	V68xV4gZ1eM0hJWzC4+h7oLngJ3MC1tn6nIO/pHSCVOw3wi4aCdWmICwO16b7Uj7t+7c8jn/8eS
	a7ya4LE17Wj8paQMS4tv630mf++5K8AfnzIfZ1gFvVIwDWGs4PnsRZ+EbcMThPP4nSos3w8AYcA
	Yqpko5zxV/w==
X-Received: by 2002:a05:6512:6281:b0:5ae:9ea1:a19c with SMTP id
 2adb3069b0e04-5aea1f28f57mr2292390e87.3.1782476737433; Fri, 26 Jun 2026
 05:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-2-maciej.fijalkowski@intel.com> <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Jun 2026 20:24:58 +0800
X-Gm-Features: AVVi8CdDyYaMDmGq0_7GM0EWKJw7dAH07LolOuKsGHa4cV7x5oKjlA_nn1_fMcQ
Message-ID: <CAL+tcoBCsn+b5bY-XAhbEw6wvceMNQwkyry0_NUun1AcR0b6Ag@mail.gmail.com>
Subject: Re: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP
 multi-buffer Tx
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,kernel.org,redhat.com,tencent.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:larysa.zaremba@intel.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kernelxing@tencent.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A285B6CCF8B

On Fri, Jun 26, 2026 at 7:12=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Tue, Jun 23, 2026 at 03:32:34PM +0200, Maciej Fijalkowski wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch is inspired by the check[1] from sashiko. It says when
> > overflow happens, the address of cq to be published is invalid.
> > Actually the severer thing is the whole process of publishing the
> > address of cq in this particular case is not right: it should truely
> > publish the address and advance the cached_prod in cq as long as it
> > reads descriptors from txq.
> >
> > The following is the full analysis.
> > xsk_drop_skb() is called in three places, which all discard a partially
> > built multi-buffer skb:
> > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> >    the TX ring prevents the partial packet from completing
> > 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> >
> > In all three cases, the TX descriptors for the already-processed frags
> > have been consumed from the TX ring (xskq_cons_release), and CQ slots
> > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > the buffer addresses never appear in the completion queue, userspace
> > permanently loses track of these buffers.
> >
> > Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> > destructor, which already submits buffer addresses to the CQ via
> > xsk_cq_submit_addr_locked().
> >
> > Note that cancelling the descriptors back to the TX ring (via
> > xskq_cons_cancel_n) is not a appropriate option because an oversized
> > packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> > which is an obviously deadlock bug in the TX path.
> >
> > Also move the desc->addr assignment in xsk_build_skb() above the
> > overflow check so that the current descriptor's address is recorded
> > before a potential -EOVERFLOW jump to free_err, consistent with the
> > zerocopy path in xsk_build_skb_zerocopy().
> >
> > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel=
.org/
>
> This change looks good, but overflow case with only 1 descriptor worries =
me.

I presume you referred to xsk_build_skb_zerocopy()?

> In such cases, once we get to following code, kfree_skb() has already hap=
pened:
>
>         if (err =3D=3D -EOVERFLOW) {
>                 if (xs->skb) {
>                         /* Drop the packet */
>                         xsk_inc_num_desc(xs->skb);
>                         xsk_drop_skb(xs->skb);
>                 } else {
>                         xsk_cq_cancel_locked(xs->pool, 1);
>                         xs->tx->invalid_descs++;
>                 }
>                 xskq_cons_release(xs->tx);
>         }
>
> kfree_skb() should have resulted in submission of the single fat descript=
or to
> xsk_cq_submit_addr_locked() via xsk_destruct_skb(), so far consistent wit=
h the

At least, in the NO_LINEAR case, xsk_skb_init_misc() is not called
since the OVERFLOW skips this function, which means kfree_skb()
doesn't invoke xsk_destruct_skb() to publish it in the CQ. So it's
safe to cancel the cq reservation (in xsk_cq_cancel_locked(xs->pool,
1)).

Thanks,
Jason

> multi-descriptor bevaior you are proposing here.
>
> But what happens when we cancel a submitted CQ slot via
> xsk_cq_cancel_locked(xs->pool, 1) in the above code?
>
> >
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx pa=
th")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index b970f30ea9b9..a7a83dc4546a 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -794,8 +794,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
> >
> >  static void xsk_drop_skb(struct sk_buff *skb)
> >  {
> > -     xdp_sk(skb->sk)->tx->invalid_descs +=3D xsk_get_num_desc(skb);
> > -     xsk_consume_skb(skb);
> > +     struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > +
> > +     xs->tx->invalid_descs +=3D xsk_get_num_desc(skb);
> > +     consume_skb(skb);
> > +     xs->skb =3D NULL;
> >  }
> >
> >  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > @@ -877,7 +880,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
> >                       return ERR_PTR(-ENOMEM);
> >
> >               /* in case of -EOVERFLOW that could happen below,
> > -              * xsk_consume_skb() will release this node as whole skb
> > +              * xsk_drop_skb() will release this node as whole skb
> >                * would be dropped, which implies freeing all list eleme=
nts
> >                */
> >               xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
> > @@ -969,6 +972,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >                               goto free_err;
> >                       }
> >
> > +                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc->ad=
dr;
> > +
> >                       if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS - 1) =
&& xp_mb_desc(desc))) {
> >                               err =3D -EOVERFLOW;
> >                               goto free_err;
> > @@ -986,8 +991,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >
> >                       skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE=
_SIZE);
> >                       refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> > -
> > -                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc->ad=
dr;
> >               }
> >       }
> >
> > --
> > 2.43.0
> >
> >

