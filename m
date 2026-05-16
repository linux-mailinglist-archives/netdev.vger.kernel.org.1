Return-Path: <netdev+bounces-288521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M6QbN9m8B2paFQMAu9opvQ
	(envelope-from <netdev+bounces-288521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352445598F3
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45E92301981C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB32264D6;
	Sat, 16 May 2026 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBbsjnNL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A0175A85
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891989; cv=pass; b=c1ij17lwhneqoDbIbnX34TEp+8K6vMxEh6VrQ3fDM2kZhJ9jjfbk1Fu9mPcxN7zOpK5b5FweRDPljEl3sfCpdBzexSMXhaKZGS23wRWwazotTup3AbyGU3/1nV5/M/RaMocu15E1JPwQqH9hE+aUSIqo5PfnkfC65I04t9QAlvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891989; c=relaxed/simple;
	bh=T+yUj63nr8G0D2RqAT2dp1bp65Xp4QhXHRGbEAsk0Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAKAckyeYJW8OMYm+yTdA1WHGCBIwIFVYLSX2M+RnTMvjiaiBTyKtJBbra1tHv6bNKLKKk7PVzQr1LcMyVev36+FwgP2sB8R4LWgZF2ou27dqiMtsaWL7YTKrmnzlDDKJCXSmry0S/KGH/+xjpcrgsA/W++kZNx2N3i3rG0FuCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBbsjnNL; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so502760e87.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 17:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778891985; cv=none;
        d=google.com; s=arc-20240605;
        b=b4qvAzwRsCs4x69I+JoU4JPr6jhGc/FIoUk0H1IVmo6SYGS7kNnwrnoL33gfXOAVxh
         VZbgy4rRLc8Gea1VPkvEHo4ykOhM6V7ENVFscuT6BuJJhiDZNLlPdgaoVRr8MaM8E/CB
         A/qlsqaSCpmBOvIPDwykqEhE4oJUWOj13+apA3VeO17KuKtff/IU5X7KYT541JC/eAqN
         xYp9eiLtnQWzO3W5P7kSRCmjruUMASHNGgUVQ70bLAfJ6x2cO22dvp04SfjC0rBWjNx5
         t4FNkceJwhHE6Uf6tWX239b3sq13kD+XOnP43my/DYhfVrjYrx2U833DabOvX6ElvSM7
         Qx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wXQw3ul382R2H1568ILjKfxwOS5UY4B0hdZAwg0074k=;
        fh=gNwW/KDp9vbMhVQGN3WTWBqzFBgG0n0fdoJ46OT9ccs=;
        b=BhhZXK0pkh/aIK6jyYKamnJOBpg9uM/+X+UHNMk4HWYrgYuPR968UvrsqDkY8DIfRs
         h4Ll4H2kQel3AIjjJzH2aAVVxXWlmLa3jAqz1psy5PrJKV5cLQaz4MXQucRSgBTSymZT
         YR2bc2V5C74ke+MGz1iIMZbvmJY3BOZGS0yHTlBNntVfF6SCGfxyRzrmMbJSHWm6B9nH
         2XYUFyXDePAnG8Huiv5A8+dD+Ir2kEyPnUcLfTJTgimkTo6YwxHUeX53cMT5Xu/HAVXy
         01VRzzHW4I9iXkAeLq9rUngWpQ/TNe4Lriqyh2C7zgX/7ULJ6fbT3fnzqOiQwuPxixGO
         P3ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778891985; x=1779496785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXQw3ul382R2H1568ILjKfxwOS5UY4B0hdZAwg0074k=;
        b=ZBbsjnNL4r5qt0WkjlnXHrWbsKWSulfgyCiuX50kN7HXYrsYyAoVoHnLZOgqVYMVaA
         eRxarTYhf+NEGHUTjvD74SDAx6MyhyfiYNFmPfdaV3yZ4OknTVsA2m2hKRBinZm3tlus
         mXUnqL+zogZnWOE4eH//KJ4sOBdvlpov5c0QQ2PZEj1RSxiq1Er6PFZAwwhY991ZhOXq
         ipjyU8bcsk3tDRjjyrb3Rt4HiZoIOzAuqopdkBhDuMc/GAvSmU+9t5t96xLM9siFBKKA
         Xh/evveE4M0M/ydRvf2cWKY8+jfBaVZ3cWsApqkA+ruRcOKAy7cAHKaGg85voHbfB5At
         UnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778891985; x=1779496785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXQw3ul382R2H1568ILjKfxwOS5UY4B0hdZAwg0074k=;
        b=ZVR/EQGWB5OFX3ksWBr6rpbIunaiWJm+VTMZ6qc92pZwuIM6ny1hO2dxF3N6gtrD8p
         Z24/GvwiOVYD3UkF6ncOx01Afrj4CL38kBRhpwhqxrIcoem6h9D3AY1ZNcobvf4xFrop
         tScWmlhsdXzkJiDg1dEfByXSyWBJDLt7iDFpofAyVC1wjkml0U9PzvvUfazetdrBD3ru
         id4oz8d4+qc8xvtg6eAehZbK8guaHOt17Lf1xVDvVWt9FqThEZ0r/l1g77CKM7Mu6ueY
         +5/QvftPwVsCm1ozjbAqeGcv7f/W0WIvEbh823u47dySGhxxnHTjnIYTMN9+3Q+XEu4v
         pyig==
X-Forwarded-Encrypted: i=1; AFNElJ+lbHsTAUcM3vJvEWT4Lvj1HpzSb65kF4Wrtwb9mcHN/v4MIqWShzSon/lDRsaogNmUqEdWDHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVl2xQGbfgMIorYFXWK+2W8KIbzfAoNIdOU71Qx9w2qrB+UMCK
	z/3iPf8iDSqwGBhIsBJy3TQLy96em23kgzZWZ26s8i6upTNCGRYAc+3zXJKiXpP0NoXWWa+qI0d
	0BjV0T5K+5ljq1N7r5RORx55FE1gbU7I=
X-Gm-Gg: Acq92OGtleUkXHHOlxvtwVo6IF3LJ2+lWEvaiAkyCcERJi3tCdJt+6UrLaFvkVpyQWJ
	OjAvLNM9/R44TmyA4QyR4maroghkL88hznDysUVZJCXpkLJiFH9Fa1/OYCfYgugdQibeO8XuAZs
	IuGAiTuIWkEpV98iUionZ87ypRE17PQwEwCCxSe28yix/u9cUwkhD/WtObvruQ9AeccGdTeQ+bR
	bPGGJnphnkzEIR32VCcka84MkOgajtG/j1l1pCh2mRT5oOoCTgFWfWfkQHyK698PctAf0UCt7du
	xc5/FBdf+gQB+YWCf7l2n1G6i/YZto3Y5iNYqU4/H4TbfFZmCA==
X-Received: by 2002:a05:6512:33d3:b0:5a7:4699:9fd8 with SMTP id
 2adb3069b0e04-5a8ffc67143mr3197300e87.16.1778891985134; Fri, 15 May 2026
 17:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com> <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
 <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com> <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
In-Reply-To: <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 16 May 2026 08:39:08 +0800
X-Gm-Features: AVHnY4K3LQI7Ue7pUUyQTA0Ygv5_VAl1KOEhJ-ibFjUCQa_lphV8g5fy1rKEc54
Message-ID: <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
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
X-Rspamd-Queue-Id: 352445598F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-288521-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:41=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/15, Jason Xing wrote:
> > On Fri, May 15, 2026 at 8:29=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 05/14, Jason Xing wrote:
> > > > On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
> > > > <sdf.kernel@gmail.com> wrote:
> > > > >
> > > > > On 05/10, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -=
EOVERFLOW,
> > > > > > only the current descriptor is released from the TX ring. The r=
emaining
> > > > > > continuation descriptors of the same packet stay in the ring. S=
ince
> > > > > > xs->skb is set to NULL after the drop, the TX loop picks up the=
se
> > > > > > leftover frags and misinterprets each one as the beginning of a=
 new
> > > > > > packet, corrupting the packet stream.
> > > > > >
> > > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow=
 occurs
> > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is r=
aised.
> > > > > > The main TX loop in __xsk_generic_xmit() then handles continuat=
ion
> > > > > > descriptors one at a time: each gets a normal CQ reservation (w=
ith
> > > > > > backpressure), its address is submitted to the completion queue=
, and
> > > > > > the descriptor is released from the TX ring. When the last frag=
ment
> > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and t=
he
> > > > > > function returns -EOVERFLOW so the next call starts with a fres=
h
> > > > > > budget for normal packets.
> > > > > >
> > > > > > This reuses the existing CQ backpressure and budget mechanisms,=
 so if
> > > > > > the CQ is full the function returns -EAGAIN and userspace drain=
s the
> > > > > > CQ before retrying. Zero buffer leakage, zero packet stream cor=
ruption.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@=
smtp.kernel.org/
> > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer =
on Tx path")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  include/net/xdp_sock.h |  1 +
> > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > index 23e8861e8b25..1958d19d9925 100644
> > > > > > --- a/include/net/xdp_sock.h
> > > > > > +++ b/include/net/xdp_sock.h
> > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > >        * call of __xsk_generic_xmit().
> > > > > >        */
> > > > > >       struct sk_buff *skb;
> > > > > > +     bool drain_cont;
> > > > > >
> > > > > >       struct list_head map_list;
> > > > > >       /* Protects map_list */
> > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct=
 xdp_sock *xs,
> > > > > >                       xs->tx->invalid_descs++;
> > > > > >               }
> > > > > >               xskq_cons_release(xs->tx);
> > > > > > +             if (xp_mb_desc(desc))
> > > > > > +                     xs->drain_cont =3D true;
> > > > > >       } else {
> > > > > >               /* Let application retry */
> > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock =
*sk)
> > > > > >                       goto out;
> > > > > >               }
> > > > > >
> > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > +                     unsigned long flags;
> > > > > > +                     u32 idx;
> > > > > > +
> > > > >
> > > > > [..]
> > > > >
> > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock=
, flags);
> > > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, d=
esc.addr);
> > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod=
_lock, flags);
> > > > >
> > > > > Not sure I understand why you want this if you're still marking t=
he desc
> > > > > invalid.
> > > >
> > > > The key point is that as long as we read the desc from txq, the des=
c
> > > > should be either put back to txq again or publish it in the cq (for
> > > > application to keep track of this) at this point. Or else, the
> > > > application will lose track of this desc, which breaks the whole
> > > > logic.
> > >
> > > Yes, makes sense!
> > >
> > > > > > +
> > > > > > +                     xs->tx->invalid_descs++;
> > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > +                             xs->drain_cont =3D false;
> > > > > > +                             err =3D -EOVERFLOW;
> > > > > > +                             goto out;
> > > > > > +                     }
> > > > >
> > > > > I also don't understand why you want to return -EOVERFLOW again? =
Why not
> > > > > (quietly) swallow these invalid xp_mb_desc from the previous pack=
et and move
> > > > > on?
> > > >
> > > > This particular desc is really one of overflow cases, right? We sho=
uld
> > > > warn users to handle this with this error code.
> > >
> > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > The part where you set drain_count=3Dtrue will -EOVERFLOW. Then this
> > > remainder will also return -EOVERFLOW?
> >
> > Right, my intention is to alert users twice under this kind of
> > circumstance. We silently drain the remaining portion of the skb the
> > second time, which looks a bit strange, doesn't it?
> >
> > >
> > > But let's maybe step back, what's the expectation on the user
> > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > shorter packet (at the current prod index), right? And then your
> > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> >
> > People would be aware of the skb that is too big to handle when
> > receiving two times of overflow warning. To put it in a simpler way,
> > the second time in xmit path only handling the remaining is enough, no
> > more descs that belong to another skb should be taken care of.
> >
> > If the user is able to quickly react to this case, I think the whole
> > skb should be re-put into the txq again instead of adding the
> > remaining part. I'm not so sure if I interpret the "break" correctly
> > here.
>
> Let's say the user puts a packet with too many descriptors. We find that
> mid-way and return -EOVERFLOW. What is user supposed to do with that erro=
r?
> In my mind, the user should drain TX ring completely and start posting
> shorter packets. You seem to be trying to handle the case where the user
> leaves the remainder of the previously EOVERFLOW'd packet in place, why?

Good point. I think now I understand what your opinion is here:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3b604776f09f..72d05a1fb0b5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)

                        xs->tx->invalid_descs++;
                        xskq_cons_release(xs->tx);
-                       if (!xp_mb_desc(&desc)) {
+                       if (!xp_mb_desc(&desc))
                                xs->drain_cont =3D false;
-                               err =3D -EOVERFLOW;
-                               goto out;
-                       }
                        continue;
                }

Then as long as we have enough budget, we silently handle the whole
big skb and then continue with the rest of the skbs in txq. Users will
be alerted by the counter of invalid_descs. I think that is what
you're asking, right?

Thanks,
Jason

