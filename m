Return-Path: <netdev+bounces-279957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPDIAXW+5mln0QEAu9opvQ
	(envelope-from <netdev+bounces-279957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:01:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD76435059
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5953015E33
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9E347C6;
	Tue, 21 Apr 2026 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P00mYAWS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5714A8B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729712; cv=pass; b=JVZsb1fwV2THjBIiL4KPaxCBQZyRwXQR4lOMb5eWIkTvpBbT2RYb7f5Cyw6JZZor9FWht351u5VtUfibpTAWB5cvZ0MWwCqh/BVmQ5TO3m+jrXotq77BbepFsaXkCZ8rxJEGrDjcRxwE5SDsgCH1wACMl9gPJBan4VAhe70ccII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729712; c=relaxed/simple;
	bh=QpWJKareNO5H98YyLb0quk17q7qr2NRU4LvzMmwho5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq804SQWNEOLmNwCojpuVI28dwovBgR2vtII0mpx6vznNPSyeUYaT+PeGMw4MZqejOVjvSpGOiRzbwLZIX1WyTN0CbN2l4+F0ZnyNVQylA+nne/Y5jyrh1T5GlT9Zj2rgHgDG0bdL5dWhJ1bMz+DEr1KWhQYt+kWaNoFBXWnl3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P00mYAWS; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2b636b944so4435235e87.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776729708; cv=none;
        d=google.com; s=arc-20240605;
        b=S2JzmHZ5FvPcY4WW7r2BhDw6i5Jah6eef/aDHqwWO3mb0QFt1W9eIeGwtc4s8QOqZo
         9Km4X67zeTYOC5eaXxHWb8tdaGs0cpgTaCIu6pET8qOKW4j24S7pImpyJD6YMjfwYNq2
         mNbhsHh/e4ttoxjc3Rxgcp3G5L3V2y64jxJL62QccoEiMFA5jmNv9mJbUyrVx2XoBGdv
         2aADZZRjN4bbvel2dnOQiAceTjvu2xsuhBdH//Dw5Kru/Yt36pZ1e0IB97ZBR/uGdV+6
         l2tMtvmwkCKQ29uCMwGqYB+8YoU+fHs4LsP4YuZvdgePjWMaRIDlEXh0vUZDUqvqSsRp
         lzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwqYBk6NXXSPHGyD5sybR1eylulA18+2Dt3czptKcJA=;
        fh=4PDwgfomimWT08fGTtJadE4EV9Yx3RNbUq/I7DHzYRA=;
        b=bG9HxkO+O4fO4oVRUKmrH6vCZ5AnN5+BqvC0H0asF/VKphZDDQMdB/SG9P8Qv/0xjv
         WeL2Xq47yCx0kim0odCDf/nyANxe6Gx+PetDd/PzzeV4fwgVRoUgg6jRWldCn79iVDxX
         M7e+38svNsISSKBT9LFpdbtw7ACRe99ZISwDqKkD+76tiG5cfteldXomCDXidaOKdE/5
         KZ5C7UGEQVnF7D37wmSa9lBd7oxXdQMLAhBC72ZgxdwhQta+d7nZzBvAuzBAyRbb7bb8
         7qonliWhFdc1+Bu5mJgQFsxT572LfaQRSui+wy1SI5x3qI/lfn2ErEqLJZ6XvGqnfek3
         VmLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776729708; x=1777334508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwqYBk6NXXSPHGyD5sybR1eylulA18+2Dt3czptKcJA=;
        b=P00mYAWSCW7EzwgWm5Bvbso8+LU+ieLtpFMc4+WjMpkLCfbmCWlRoKmkIFRT9uuu1L
         9MG1OP/0HVH6HzzEClC+qpZIz5Uz5+nH/bxW27IynDJR53kWJsDkSpLC6m9KkhhtJaub
         d5/Tn9e2wZ1JT5DD553cMkH8Q10g3SlFpie8CBLXccs6o4JlOk5Yz6aZCbdQ8AUO+KPZ
         0MnXpmW54N6uaEnv8qBhyAPmtbN9YhQCy0Cn2u3jgePJvpwCokBLDEWMDLcFdUI0dK5B
         j9PZbqtsHlIcP+6NBGXxorlWfnDLHKBBN4ZcDSl8skPAdF08MaBHBZS9rNO5bYLF2e88
         y6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729708; x=1777334508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwqYBk6NXXSPHGyD5sybR1eylulA18+2Dt3czptKcJA=;
        b=LHLjfPT9MGGXtEuCtlR8CVyoT0XuerX7SSYb90psb3X0w1dI1Ip0NKBYiPJ880p/Le
         aNSruvuGAPOsk0QIkgK+lX665+Uxxdj+nWS2ctDDUB16mC0JcA1lmJ6KyH21SOF3f1ys
         NOrUhZcTayQRmtawq7uMXXdx2nsxZTPUe01MlgUq9W8iCIzV559jgHtcpD04+H9qQrhq
         RNwktq65EfNnso13eRGVU4TD1W9vXd+gxTojbBSjRLHF71ftiMmVrXEV9fCnfoiDGJbW
         Rf7+DwYVc9qyqg7FIdHS2sny+4xdt1u51oiyUFPBv4zLGipb1LMmHyatezycYSAwToCC
         6goA==
X-Forwarded-Encrypted: i=1; AFNElJ9GCtudjDM9O5HkHWDafF5zCYuFU6P6+Y5jDaQcdxGKvT4I7Zsz11oC92oKNNFyPFKch7grfvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhwyXVLOcClXDcUF+Upr6SdxWlxjtTQx5XI2QwQA1O7vSSi6F
	YPVJo+eStOoCLe5jAR1im0F3vDZWm09Izd5tqsSwJMuMEV06UBmrYbNuKm4hKi9J1ixgAEWAPzQ
	NgGbaOxHpl3pCm6ORK8/FWghYfL73fyQ=
X-Gm-Gg: AeBDieshI6xDXZxzXxoYI8Bsk8a7tDWUf2fHmBkZl5AQWN22njQg+C9SUTvA8Wo0qXB
	I/P35jswXUc7QioT1fd9x3/S9IZiwFQCBrbwtr+OF0mLd8aUyWaG0KBgJg5hV1Lz6eQaHNNglgk
	Cjw0v227voABRlrvA6QFNSdkAc6aZD/x5/2u7WaJ80qQrbR+rSoCcHHGN4+0tDqlgczPuflVT8x
	l1yo1iMLxhRe4jiunBeJbd6Gp6FwLWdSjhPUaLI/7wZg9cQRPdMv8AJpj7wTjSDo+Ch87dZ6Vtx
	sSNeytFFDAcXvJk0IitwXQ/5ORu2
X-Received: by 2002:a05:6512:39c8:b0:5a2:babe:3da0 with SMTP id
 2adb3069b0e04-5a4172ba72emr4754212e87.9.1776729708289; Mon, 20 Apr 2026
 17:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-4-kerneljasonxing@gmail.com> <eef5d62d475b0aeb93f6f84585f36972.sdf.kernel@gmail.com>
In-Reply-To: <eef5d62d475b0aeb93f6f84585f36972.sdf.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:01:08 +0800
X-Gm-Features: AQROBzAmCeHn5V3FByry0y6t-4lLb9mei_UE75lqdN7bsNqPuXgNHUB8tIgfdyo
Message-ID: <CAL+tcoCFiTsze+bb7V8XwX-ELSwnG8h6errtoJMB3MY9-HKSuA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5DD76435059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 3:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When xsk_build_skb() processes multi-buffer packets in copy mode, the
> > first descriptor stores data into the skb linear area without adding
> > any frags, so nr_frags stays at 0. The caller then sets xs->skb =3D skb
> > to accumulate subsequent descriptors.
> >
> > If a continuation descriptor fails (e.g. alloc_page returns NULL with
> > -EAGAIN), we jump to free_err where the condition:
> >
> >   if (skb && !skb_shinfo(skb)->nr_frags)
> >       kfree_skb(skb);
> >
> > evaluates to true because nr_frags is still 0 (the first descriptor
> > used the linear area, not frags). This frees the skb while xs->skb
> > still points to it, creating a dangling pointer. On the next transmit
> > attempt or socket close, xs->skb is dereferenced, causing a
> > use-after-free or double-free.
> >
> > Fix by adding a !xs->skb check to the condition, ensuring we only free
> > skbs that were freshly allocated in this call (xs->skb is NULL) and
> > never free an in-progress multi-buffer skb that the caller still
> > references.
> >
> > Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonx=
ing@gmail.com/
> > Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 6521604f8d42..4fdd1a45a9bd 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       return skb;
> >
> >  free_err:
> > -     if (skb && !skb_shinfo(skb)->nr_frags)
> > +     if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
> > --
> > 2.41.3
>
> Now "!skb_shinfo(skb)->nr_frags" feels redundant? It's either
> "skb && !xs->skb" and we own the kfree. or "xs->skb !=3D NULL" and we
> want xsk_drop_skb? Or am I missing something?

Your feeling about being redundant is right. I'm removing it now:)

At this stage, the job of this if statement is to find out the first
skb, so !xs->skb is a clear indicator as you said.

Thanks,
Jason

