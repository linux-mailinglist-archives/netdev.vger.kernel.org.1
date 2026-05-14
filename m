Return-Path: <netdev+bounces-287756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJM2K7MVBWoUSQIAu9opvQ
	(envelope-from <netdev+bounces-287756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21FD53C4E6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C6A3016C98
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9388263F4A;
	Thu, 14 May 2026 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slJoRPJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9719CD03
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718128; cv=pass; b=DaniAhpBXCQEWGEPFMhE/3EOzJTHZn1fJEhjKEJJADoUjmiC/DFfStWcqq2pjp/1Xb8c1Mh2HlMSnex6xjLgFeayXVf93pCc5XXCHfmLPsmCus0B/Mc+sq17N7KKL9FVuaHBZ5RI95jRHbnX6Xp3kCxwB55+MIYxC6kitVrYJyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718128; c=relaxed/simple;
	bh=Lc3oSZlCUzSkC3rQNdwVLXb9YFU0HUcQgXJicIKmQws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSD89k+9okWH7ICV1KxXGv5ScfEa6I5M6jEc+zXDTJRnl9lDip/GBSD5mFpeFWIol8K5+d/0ERQwNewGBvTEptcJqNYMj3rgJ0jRJZnx3jyTkQjl2IbILTLOAcz04Aud1/Zy95w59Qc80Z3KNhBHtvroz24UEszaiKssQFoZ5UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slJoRPJO; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a865d1547aso7441050e87.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778718125; cv=none;
        d=google.com; s=arc-20240605;
        b=Sywz0YlNi939Lpn5LSbAz0NcloIiU67ok4GEMNy2YT4wdEW2P+HcWxOAtnR+d+Ivbi
         OgKMV7H5KHmQXyD0G+an1/CxTujoV49Wo+Y92PMYl5rz8r7A0ShnmKLLI35SYO6NIQOC
         eUp8gEoHFJT8qIXI+HCI8wpGQ1PXQNIgeaDjSmcGltf1uc6GsJUyNnx4uB/g82GftaIy
         /it7RaAQXBEcmM2Fmlnyzn3ysFm0Pu33ZB1hsWX0XgL8LAQ8b9lylTsl70y/4jlw09Pq
         uYR7h6vRcYekcYabgO3NHjNtyAm6i9oOB/SpbeuXEor2ew12Zx13qZfJeTbPEub4owol
         D+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=elklsPS7/fsP24AvxZDwbdGxgVD1nkLgFN6em3Wy+xQ=;
        fh=N6StlzSpdN+NrovR1yjO1cwO8PgBogV/T/06sbM34D4=;
        b=Iy6gRWWdZmEeUE350lb+HN2ykxNQwwiq4UmKZUibBJi98PiloDAiSIQVWp/OaoUSvr
         oMxgP+c46/1mt5BByswVACQZZtPdWC8W9Voseg1qtHM98P7WzvSl2+rJaLrt02TgpION
         yXEBvUpNDPgnsDGA5R9lOhRElVdfamsamwFOAMmCcPTrbJP23eFPEmdWnlaknFQ3GDRS
         LD59R4ACqsaEEhcc9PGLpYk5jTJk0PbXcD+cXCadvBpMDgWin5rR9S6/+uEZqtsfUHPM
         yBQ3OSAiVy7ZsdChyaJYEVsdvO3AALGvOc7JW12lN2S7CdFdj/qn2iPpfa2u/Znmnpi6
         WqyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778718125; x=1779322925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elklsPS7/fsP24AvxZDwbdGxgVD1nkLgFN6em3Wy+xQ=;
        b=slJoRPJO6hG6tmQTgrsCNyH5Vds0effki7Ww1NAyd/JtfOmlypN23BFawL+Ft/jHLM
         1eZlr8BhL/5VtYnLli269EgvRvxqu00jit0jtZdUYyPREukLQk4uUFZMt6g9DiV89AqI
         SuvBMKpr12OLhFRZ7XccYGipem53+xtn0u6j4WJ+j3kfWwLVFS9W+rJWvtmEXBjZZLEO
         L7aOAQ+Vu8n0de9PXFGNIzo2Aj6PBB9NlutgalHdI5uLflXzA0dbSAr5i8FAYL+iiP2E
         afyWmGF0e9mHIZhNnuBE4cv2yZEIJgApUtBTHhaAQuO3lEkXPtVgmUNCMpxSGTasH8g+
         yLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778718125; x=1779322925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elklsPS7/fsP24AvxZDwbdGxgVD1nkLgFN6em3Wy+xQ=;
        b=DPq4ba+IQq0SQIEmOlGgy3xfKQurtNm9cyPCMSUIHRrQLAfJ2H9M6dLIvEV6uTBEal
         ct6dEofd8eXIichJzgcC6R+sWqawr1KWZFxqCrUDrOtxYxfWEih1xcEEJw9Z5+F8K8EH
         +jiPXjNFtpEpheI6xz/XgRq4fu74VLacUv6WPpefeFwpkW97siUARMQgzxytRkO1HctI
         +pZRGrO+sS8JCZLUgEElpBnjb4lySCxBJJnfe+xdJV5hmGmkW6Xzqzo2O61bgHobv5kX
         ly4vhKYY8sW7H5f3SsMIobDkU/OUpxfA5tXyW2XGrwhqjlwUkpYmGEj5UJIVUiNdznQ0
         ydaw==
X-Forwarded-Encrypted: i=1; AFNElJ9DVutydpmGS5E08X561YgK6Knl2gISS4RKxS9x6nGi3TY3xnPz06EOW8s7+KsAgS5Smvm+SbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDfLjXzE45VkKTtAcnBmgXIsubUcCSqWjvRXXZRKYEhIXFQqM
	nNtE5vAhU0a4iJ8CgAnfC1grNAFwxx1iiXh/OMos68vBDXgKTBjgNeOkcVoDMKpW1+k/wUEXmlI
	JtkA4agFaLshXo3guNOto1cyrRbw8dvE=
X-Gm-Gg: Acq92OG4yaaHghlTz+vjkbBjUl8MN7rbo4q87PZNAIuRXovPoB6cMhJcnrp8zKcbSda
	6rlDCEaf6f/UYeWB5V4BGO7gIZNAf2WWr0fCDQyDlgnpTIjXYQlcIVCXAWlM0VB+BUYx1xYxncB
	ygFJr2fFm0861q7vYXr8/VA/BYDaPniNKlZTec4+F4qK25gSTic6nVaplZyl58Tkub5eKMR+rLq
	Gwdd7vLZ+3G9XgCXpsk9a1QwKkyj5u8J7UYs+P3b+F9PJINAKMJnf7fzEnjDusy5bUjsW+kOqMF
	5QE0C+1VfdGL65M3khg7yiG2LFSFVyp6EQbo1PA=
X-Received: by 2002:a05:6512:3705:b0:5a9:61:91e9 with SMTP id
 2adb3069b0e04-5a9006192e1mr235422e87.5.1778718124774; Wed, 13 May 2026
 17:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com> <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
In-Reply-To: <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 14 May 2026 08:21:27 +0800
X-Gm-Features: AVHnY4Kr3pySaOM1DVuwqCO--aBL0CRlKfLqwTONR5pH9ZZWjMsLo8--RWbgeNo
Message-ID: <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in xsk_build_skb()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F21FD53C4E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287756-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/10, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLO=
W,
> > only the current descriptor is released from the TX ring. The remaining
> > continuation descriptors of the same packet stay in the ring. Since
> > xs->skb is set to NULL after the drop, the TX loop picks up these
> > leftover frags and misinterprets each one as the beginning of a new
> > packet, corrupting the packet stream.
> >
> > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > The main TX loop in __xsk_generic_xmit() then handles continuation
> > descriptors one at a time: each gets a normal CQ reservation (with
> > backpressure), its address is submitted to the completion queue, and
> > the descriptor is released from the TX ring. When the last fragment
> > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > function returns -EOVERFLOW so the next call starts with a fresh
> > budget for normal packets.
> >
> > This reuses the existing CQ backpressure and budget mechanisms, so if
> > the CQ is full the function returns -EAGAIN and userspace drains the
> > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> >
> > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.ker=
nel.org/
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx pa=
th")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h |  1 +
> >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 23e8861e8b25..1958d19d9925 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -80,6 +80,7 @@ struct xdp_sock {
> >        * call of __xsk_generic_xmit().
> >        */
> >       struct sk_buff *skb;
> > +     bool drain_cont;
> >
> >       struct list_head map_list;
> >       /* Protects map_list */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 3f1e590c855d..232dd7126905 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >                       xs->tx->invalid_descs++;
> >               }
> >               xskq_cons_release(xs->tx);
> > +             if (xp_mb_desc(desc))
> > +                     xs->drain_cont =3D true;
> >       } else {
> >               /* Let application retry */
> >               xsk_cq_cancel_locked(xs->pool, 1);
> > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > +             if (unlikely(xs->drain_cont)) {
> > +                     unsigned long flags;
> > +                     u32 idx;
> > +
>
> [..]
>
> > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags)=
;
> > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr=
);
> > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, f=
lags);
>
> Not sure I understand why you want this if you're still marking the desc
> invalid.

The key point is that as long as we read the desc from txq, the desc
should be either put back to txq again or publish it in the cq (for
application to keep track of this) at this point. Or else, the
application will lose track of this desc, which breaks the whole
logic.

>
> > +
> > +                     xs->tx->invalid_descs++;
> > +                     xskq_cons_release(xs->tx);
> > +                     if (!xp_mb_desc(&desc)) {
> > +                             xs->drain_cont =3D false;
> > +                             err =3D -EOVERFLOW;
> > +                             goto out;
> > +                     }
>
> I also don't understand why you want to return -EOVERFLOW again? Why not
> (quietly) swallow these invalid xp_mb_desc from the previous packet and m=
ove
> on?

This particular desc is really one of overflow cases, right? We should
warn users to handle this with this error code.

>
> Also, have you considered doing this drain in xsk_build_skb error path?
> Is it more messy? Carrying this drain_cont across the calls seems a bit
> too complicated (but idk, maybe the alternative drain in xsk_build_skb
> is even messier).

Sure, it was my first version actually. One of the primary reasons is
how to handle it gracefully when CQ is full? Then those descriptors
can not be processed in this loop at this time and will be delayed
until CQ has available slots. Another important reason is that I want
to put the whole read process under the previous clear logic in
__xsk_generic_xmit(). Some protections like budget/batch still take
effect in this case. In this way, there is no strange/exceptional read
process in copy mode :)

Thanks,
Jason

