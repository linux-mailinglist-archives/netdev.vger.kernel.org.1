Return-Path: <netdev+bounces-279964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHvANX3K5ml40wEAu9opvQ
	(envelope-from <netdev+bounces-279964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:53:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658224352DA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E76B30162B1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D641E834E;
	Tue, 21 Apr 2026 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epoiVO3G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAA1DE2D3
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732736; cv=pass; b=amcYuLlTa/szIF5zPCQFozIVwEv1G84EbdZSVDh8Ru6V8mW+BH7o7klQuyoEj9NxWwf016Lq/dlerkHH07Ai854TXZG6ufhAvhKFWUhXeMlQ1RFq6dMD/eBuVvwQ8Y4pCl5h9J5JEYzOeie8EhCLD8fm2E8Ves4Z0MsWs1UUGM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732736; c=relaxed/simple;
	bh=ilgZvMWhTP8TuR2D837xRb5YUp/BqfQS+mT4OqZApHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErkdZfwSd+9X1eKa4RF5L2aYnYm0IM6D+LosIH5Xj1MO5nStSo4b7baItF/U1TaQJDChRsKwftzVomDH3eeuEKVn8TzExtf18/6z25dHO+qTEoiCeuURJkRPBhu25bmPZD2Z4LzDDjYy79NV6/jA7TgJRPQ/YxCVRWGNr19ANwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epoiVO3G; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dcdf60427so3280982e87.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732733; cv=none;
        d=google.com; s=arc-20240605;
        b=VQZlxGuhJr/vBTKqZ1o1KT8591C9CIpk9qR/UE0i9GPB1KpiPCTyV6mrV06UYqx5KC
         EVkzzZ0ssL+O1SZOa8SJ1kPNawtiLabveBnPzdgG0guKTHEaMf+6anh2ZaMBwfYTuy6L
         fpn0lBMlFQBZPmWbuSylEk9zyyCiQzuTL9Q8s+0i0s0QDFJuCQJMV0sxnXVkTfmsZKpf
         uWnXTrkqZhhG8IbRIpEBRy579Zqfac23+cERci/UNztHFywTPU/mMe72zH/myMiGqiGn
         B0ZCJvzUbGTChnkfXqMmcSQ+u3F/cGr6MBlyx3zSGE0myAJs8iLzsEW5hPK5bkPiRBFj
         ZXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ciNUsYZGg5OOsZxV9U8O6SdkAhWyByMHojw4SCqb2k=;
        fh=F8/obQ7rRjuVmOFjli0/Mg1v7eh6Pe5xGO84AfuvhAo=;
        b=LhdBwaL9IswL+fFHPn85eOs24osMAQ9nkG1aCsY2XNFCbZM5P5fFC60Iy4/GT87X2+
         hUT/a+pgcP1YIPMZJDutKGhvE0O/tkVhi3fhLD7UcVgDTiAVWh29vprhltY246T1iXIG
         xL7NnQdzWhPxOWTEiU00SYD0fCOAJUr0LnI+llNFuWwWO1OUuXksJaqyb6aAjAx4CDm5
         hPZUtYGFYvoGXwDsbylsAhjeZOpCq2iblf3vJAlQF2gGPaHdMg4lajh39xYT+5b9Jwag
         TL2hq05buSJl48pjKSc5UCBifWt1hCMVgWen18GZFaiyr8RtqkaPTJpu9ts/uz3LIPlV
         HkGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776732733; x=1777337533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ciNUsYZGg5OOsZxV9U8O6SdkAhWyByMHojw4SCqb2k=;
        b=epoiVO3GX+lgl8cwWHQehQeReGdigsOvVDw6thyyXofA4O0cTHOIYGbDUG0VHfg+tP
         6ypfivYdgY0lAmOiL8vFsF2ypU1qAJHNP/howkT08orEes9qYJP3auq/uEaaGpGjoMHA
         0s9EaRHIBdDhSlIezQ6OYRfjYpLNSZlZMVYY6JyXJG25usiaICV496iiNgrudwspdfPT
         glZgQamK0iF1zPQxbrOWPrAkw1vZWAGEhfjSeK97MWH8JAOoKFhaO2LNh+sylUPTHP0g
         YqALE0G1ETLo/Aq4181hsCZUDH39eiCEXD395ylq+vgx02pBtP4ZAG0gzJJ977ki0Bg1
         WGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776732733; x=1777337533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ciNUsYZGg5OOsZxV9U8O6SdkAhWyByMHojw4SCqb2k=;
        b=hIDXKQZyvySA2sKOMrwtQglr/49kfljb49r6mQ/Pz7QMMzdYItnd46SdrIEA0AjmRI
         FUtKj6tAJ43O9m5q6rd5iqEJhSUUvieR0XCMj/c4UwC3TDjO1DmMk4WQAIDefIGJGFTF
         on3771Xtp5qUnwPqZwGCk9cxej1DiO3FUnXnFa0ojOJ6dNOQRP8KSZzgR2rVe+zHkcz1
         X8lmA3J9Xg2y2rBKGTSQDBgWLcORFaAZVK999qSbhkzbcjCEgE3YFkz+eb2uYnAImxTy
         iNE5m4Ga5R9yD3gdR6n9u/ZUYJjfEugm8eCBB76dflQCL5z4Lpvcf3f+Z4xyu5Rok+7D
         10Lw==
X-Forwarded-Encrypted: i=1; AFNElJ/xlV3ugvrKCFAHEaFihjRTiW6nXWbDCyzRVTWOGtPdBTvfyn+qRtJ3ODOoHqW+EAl40oyibn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wvlBAbc4MA/SNU8yVa0jKh0jSvQCyn3BCew6F/zu5WwbNG0/
	fbtVF7CpMYA0aBJkmCMeyqu/+R/eMvsE8YbWGntSb/1vbkMIsBgWSR+ZEUrhbOl9o8HkjYq9QCO
	mZ1JRd/8sh5k2BBSbJiln3NZz9BOajFU=
X-Gm-Gg: AeBDieuPli+xZZSmrsGNq+SeEpDikPvQ04DpyC20/X+XUrj7qH1xeHs1HL+qakkxlXk
	cf+oB7VFoLZEhN/7MjXbnF3sxFLsgcGvjTNUQnLIoQFYK3GKnOyyjwPK44EXenowHO6f7Cmjj7n
	96LupVahqvziTQXMNVJ5+c9J4/O4mw1ykXPKh9w9SCzKZB8wmg9YmUDtQU/cs78biCoZuXHN+L8
	G069ixhNcEwgmkWC9vzYvll8HargpYpjUhU0N1t/wsPaX3hvW80mcIdhv8K3tZEv1UumtgZbNjz
	UAW0fhOjGA2P6Xbtaw==
X-Received: by 2002:a05:6512:239d:b0:5a4:505:f62f with SMTP id
 2adb3069b0e04-5a4172ca7fbmr4550210e87.6.1776732732509; Mon, 20 Apr 2026
 17:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-5-kerneljasonxing@gmail.com> <7f15844902d6dcee6ba070b0f3002b20.sdf.kernel@gmail.com>
In-Reply-To: <7f15844902d6dcee6ba070b0f3002b20.sdf.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:51:33 +0800
X-Gm-Features: AQROBzAy09mKiSjSVzCffG-8u0Ouuj3XshZ6nG46XKvls7xHD9P_Hpu1q0JerqE
Message-ID: <CAL+tcoBZMictQwO0WyaXGT3-2uanO1wz5bDip6=YB4RCn61JEw@mail.gmail.com>
Subject: Re: [PATCH net v2 4/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279964-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 658224352DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 3:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Once xsk_skb_init_misc() has been called on an skb, its destructor is
> > set to xsk_destruct_skb(), which submits the descriptor address(es) to
> > the completion queue and advances the CQ producer. If such an skb is
> > subsequently freed via kfree_skb() along an error path - before the
> > skb has ever been handed to the driver - the destructor still runs and
> > submits a bogus, half-initialized address to the CQ.
> >
> > Introduce a new common helper to fix the issue. That function will be
> > used by the subsequent patches soon.
> >
> > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.ker=
nel.org/
> > Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffe=
r traffic")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 4fdd1a45a9bd..614e7bd1252b 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -717,6 +717,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
> >       return 0;
> >  }
> >
> > +static void xsk_drop_untrans_skb(struct sk_buff *skb)
> > +{
> > +     skb->destructor =3D sock_wfree;
> > +     kfree_skb(skb);
> > +}
> > +
> >  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >                                             struct xdp_desc *desc)
> >  {
> > @@ -890,7 +896,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >
> >  free_err:
> >       if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> > -             kfree_skb(skb);
> > +             xsk_drop_untrans_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
> >               if (xs->skb) {
> > --
> > 2.41.3
> >
>
> Have you considered the alternative where we postpone `skb->destructor =
=3D
> xsk_destruct_skb` to a later point? Will this be less messy than
> undoing that descriptor in a few curated places?

Thanks. It does make sense. Adding the following code seems fine:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 887abed25466..02e723ca3080 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -820,7 +820,6 @@ static struct sk_buff
*xsk_build_skb_zerocopy(struct xdp_sock *xs,

                skb_reserve(skb, hr);

-               xsk_skb_init_misc(skb, xs, desc->addr);
                if (desc->options & XDP_TX_METADATA) {
                        err =3D xsk_skb_metadata(skb, buffer, desc, pool, h=
r);
                        if (unlikely(err))
@@ -914,7 +913,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *x=
s,
                        if (unlikely(err))
                                goto free_err;

-                       xsk_skb_init_misc(skb, xs, desc->addr);
                        if (desc->options & XDP_TX_METADATA) {
                                err =3D xsk_skb_metadata(skb, buffer, desc,
                                                       xs->pool, hr);
@@ -964,6 +962,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *x=
s,
                }
        }

+       if (!xs->skb)
+               xsk_skb_init_misc(skb, xs, desc->addr);
        xsk_inc_num_desc(skb);

        return skb;

Thanks,
Jason

