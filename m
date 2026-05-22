Return-Path: <netdev+bounces-290744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EsZGEAiEGqsUAYAu9opvQ
	(envelope-from <netdev+bounces-290744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C75E5B1354
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CCCA304554F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313593C9899;
	Fri, 22 May 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/tVPBOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635093C1996
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441769; cv=pass; b=oXXb6v5OmIy7V81Jve5BqXbXdeMyiIzERUPh3frExisIiXRdu615N0TvuoM9lCmFzgZMt5t7GRHmD8OxC7kziDXZjUcJxU3H/b0KzDM2yvBNUKMiBkI19OtSXKfBsyPixW10a680xtHkQ+E2Y8Okxq8RI/q94HeK6o6Zb/j1Iqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441769; c=relaxed/simple;
	bh=9HTYdj36OP19ar/Z2o1Nflr6TtOAK0uthrZE/uqdMNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXcOhxPxxKmVfDaprP6dWx85VcSj0+oq8iitWKBYoFRSZhLem9jXf3/muNDhvJGXXb3sw4dSxNT0vsbQocavD3xvf1IzUj6uSm5fz6yYzE2NSudRT69p6eimTMjhvM5yujzUtSNSIgW2KqpFIv8O1z3WjtB8D2Zn1BIzY+XeG70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/tVPBOW; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso8307504e87.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779441766; cv=none;
        d=google.com; s=arc-20240605;
        b=SJCK5pLivrHKaNGjkKlbYSSEyRD10JjGHZmQWGlqV4ChkenOBMBrLIbxAu7fZSYW+k
         fziic008HRXGRtZLlKSORLoXQy03N+ehl8/tHRUOAXkarsyUEReEzf/VkJV4U4Zauw7I
         C0hKAhAiZYo/d7mfJ6soxRYn6nK7PJR+rCenElHoHVsTd4ijVVBQO6opJz/Nc3VQGb3i
         xodnoKbFzN+EPHKRx3xgfFDJdQgamyvZL0oCgL0bX2ZKBBe6QTGBjtc3Mj1LSZrWSows
         43yaFDiCXO60EEosqUkQaW32CO0mcL9tEMLvTM6RHKAgT93lF2XDs72BvSO3TKhichTl
         EKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLKzwkXsCEt56sWNeFNYAOv+OWTqrZnI1zQs1+4PXdM=;
        fh=tRwUbl3Xie1yIprOz4/G+swn3XAwkFT0Cu46lLu+rvQ=;
        b=CGvIzIji60C7Wf9L7Pu7VU63pitArXHzkxmBibOOW9lW6kGn6/yajIfb1dXKkh4BiG
         0CfwGTN5WbsJldxROSflGDsFKjyc65z75oqVp/ybNFfLK5WucHhUTR0dNUnUG9Lh5FyC
         W6EKIkfviuWY4G9a51IDrscKhoEXls2Ib3rkyjgokqgExk+nKoHz/N+yEu0uwulYc1Hg
         9DAsH4v6WtURSG1gAcvGDZ9bNIDRd24KzMXS1qrdEfjG3fzuULGdGHXi6PqV9e0rvH4r
         PNQH4HWmAwjX1b65ZOfS4ecr2QDd5rOCVWZlv0zPbwUhR2ZzrGXRhD3heCNvJkhnbhZX
         B8Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779441766; x=1780046566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLKzwkXsCEt56sWNeFNYAOv+OWTqrZnI1zQs1+4PXdM=;
        b=i/tVPBOWKwQKTMJHexmn9jgbS8/fi5U3qcvSgUrpdlhE5PVkJKTN20++If+w7MmD5z
         i4Cr4cifRYNkprGvVWx2vvoP685y5DwJt7fBQyPavTcq3Bwhl+NJ1C2YnFd87GL3wYhw
         pMv5MJkZtyIKdrlr9UWs1XIXG8QDg1gSUzLLqSApOZNEPI2l0ibyW6ChqM9oaz/FXLej
         rGXBowq5WNOkjBNMapNTUs11/bvX69kAEPgt29/TrLor1NNNk3132hLo8JHhrtnCyguX
         WlmjZw/IkTsShtdZ9anYsxIEZldFI9ykOt+3DpQcdrUGZS4Dyn6ruYluBioIHCmM6uLN
         C6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441766; x=1780046566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLKzwkXsCEt56sWNeFNYAOv+OWTqrZnI1zQs1+4PXdM=;
        b=pNQbhMZHK9wgM98+LQWqgSq+NORtQ/PMxqdlFaE8ii/PY4CddT/1KtFmPieL5aT5F4
         kH6RjSiObXTyp6NqCkylyuDfBmRor5bcEUSHkestvNNNTor+xdfIS9g6tyV1YgqzkdLm
         89lPQd/EZ9q3ni+Xf0lywcItEnCvz+tKMCaXok1bY58stVRb07cPqg+1cJ30EZmEF+61
         KJ0Dbg03NuLy2K87BXO7+15Ns1UMypcVBLYEmgnFFtQ62Ywi7oUkfPu9I0lC4LnKPH5D
         VQ7TsmuKjwGJHi8SkTh0dPL+51X1jQg9Zf/2pohAi9JP3KFy63NFc84LWaASQRiSNa7z
         3VLA==
X-Forwarded-Encrypted: i=1; AFNElJ+5gkP2WxWMUi/qLHsjQskKcrkIEzGvvJ0icnReQCTpAyplLrxnd8t1jqXe/cxB58KzLicfu6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGRKpjyDpsACedclCBaFt2u0U7F2wCi3C8u3pEyR3bJwqzLlw
	nsudaksLSq01N+hMcZbpAvfIAJOY4EJ9ZwESYosdGd6KMRCFiOtDvB05p/+W7rdKxY64JDnM4YD
	+I/Kfu3w5iI9TIePibmMrmFnvN76idEY=
X-Gm-Gg: Acq92OFyGImRZqH0MS6xD5/3NbGAm4EHIhXDDIup5DmwN+R8z79y+Py1eC1EsRJDZvv
	r/CQzmJmjsWLT8oWKShPr2HGsHjr2Kbgtdcm0IsiKafDCcZsJgiBQ2wliv1QMTlFk2yHs6k7x/j
	amKeJkAnxMz1VgNmCjZWM0BUnIqn5Yizjuzou+EPsNrhgrHX8U9hFvjQ/fBkwfdUmP+8w1qjSqd
	MwZHGmcS514uk1zZElpdtSpT7OOrVWomM1hUCjqVTLvDr2pHowP0rvKnfnFZ5koAtMWn+uNf0UE
	QOWqfYDGMER48yHIEmQTloNBsRQnxzkMZHk3TY00
X-Received: by 2002:a05:6512:40cf:20b0:5aa:b6b:93c1 with SMTP id
 2adb3069b0e04-5aa323a9376mr569353e87.43.1779441765358; Fri, 22 May 2026
 02:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com> <ag3c9/EF4h7DLQu3@boxer>
 <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com>
 <ag70RrU4nGy0Nlna@boxer> <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
 <CAJ8uoz0bKHSiHjRvNmvVs_z3cWg58U=6wGKKs9_n65yCCcYbEw@mail.gmail.com>
In-Reply-To: <CAJ8uoz0bKHSiHjRvNmvVs_z3cWg58U=6wGKKs9_n65yCCcYbEw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 22 May 2026 17:22:08 +0800
X-Gm-Features: AVHnY4KPJR2T7YSjs_8Ul5sH3l2nA99WuQMZIMYetyUuNvVQFeSa6E2jFKaCndM
Message-ID: <CAL+tcoCaOY=YEDM2N0tuWjyQpOrTZMkHSYT4KQsy_fn2757V6g@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290744-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5C75E5B1354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 5:06=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Thu, 21 May 2026 at 15:42, Jason Xing <kerneljasonxing@gmail.com> wrot=
e:
> >
> > On Thu, May 21, 2026 at 8:02=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> > > > On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
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
aised,
> > > > > > so we have a chance to examine and handle the potential remaini=
ng descs
> > > > > > of this big overflow'ed skb.
> > > > > >
> > > > > > When the last fragment (without XDP_PKT_CONTD) is processed, th=
e flag
> > > > > > is cleared and the loop continues to process subsequent descrip=
tors
> > > > > > with the remaining budget. This behavior follows how previous x=
mit path
> > > > > > treats overflow packets.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@=
smtp.kernel.org/
> > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer =
on Tx path")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  include/net/xdp_sock.h |  1 +
> > > > > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > > > > >  2 files changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > index ebac60a3d8a1..8b51876efbed 100644
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
> > > > > > index 0a6203c42576..f4add7be8c93 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct so=
ck *sk)
> > > > > >                       goto out;
> > > > > >               }
> > > > > >
> > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > could we get away from introducing dedicated boolean to xdp_sock =
for
> > > > > handling this rare case?
> > > >
> > > > I've tried several ways, but they didn't work. Please see the short
> > > > conversation with Stan:
> > > > https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1Lveq=
H=3Duxd2McuR-w@mail.gmail.com/
> > > >
> > > > That means we always rely on a flag (that is either static or like
> > > > this patch) to recognize how we treat this abnormal descs.
> > > >
> > > > >
> > > > > > +                     unsigned long flags;
> > > > > > +                     u32 idx;
> > > > > > +
> > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock=
, flags);
> > > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, d=
esc.addr);
> > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod=
_lock, flags);
> > > > >
> > > > > It feels a bit off to do this cleanup one-by-one.
> > > >
> > > > Actually no, it adheres to the basic send logic in copy mode.
> > >
> > > Not really. Here you are producer to cq which we have batched variant=
s for
> > > usage.
> > >
> > > But after second thoughts I don't think it would be worth to put any
> > > further effort onto optimizations here. Anyways, even though generic =
xmit
> > > is a whole bunch of mess, maybe you could pull this out onto a helper
> > > function?
> >
> > Sure thing. My takeaway is that it will be refactored once as the
> > batch xmit feature lands in the tree.
>
> I agree that the code has become really messy since I get a headache
> when looking at it ;-). Do you want me to take a stab at simplifying
> it?

Thanks for your help. But not now probably. I think we can focus on
the batch xmit feature[1] where the main xmit path will be rewritten.
I admit it's still complex to understand :S Could you shed some light
on the series that I'm going to post?

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gma=
il.com/

Thanks,
Jason

> >
> > >
> > > >
> > > > >
> > > > > I wonder if it could be covered by xsk_drop_skb() where you would=
 walk the
> > > > > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_a=
ddr_locked() ?
> > > > >
> > > > > OTOH, in theory the amount of frags after we hit the overflow cas=
e could
> > > > > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to=
 cover
> > > > > them.
> > > >
> > > > Right, this is why we now put the logic into the xmit path just lik=
e
> > > > other kinds of descriptors. We need to check and send it under a
> > > > series of protections like the check of cq pressure and budget. I
> > > > don't think it's an exception to escape the check logic. The whole
> > > > process should be fast as there is no need to build skb and send it=
 to
> > > > the driver as long as this case is recognized.
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > > +
> > > > > > +                     xs->tx->invalid_descs++;
> > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > +                     if (!xp_mb_desc(&desc))
> > > > > > +                             xs->drain_cont =3D false;
> > > > > > +                     continue;
> > > > > > +             }
> > > > > > +
> > > > > >               skb =3D xsk_build_skb(xs, &desc);
> > > > > >               if (IS_ERR(skb)) {
> > > > > >                       err =3D PTR_ERR(skb);
> > > > > >                       if (err !=3D -EOVERFLOW)
> > > > > >                               goto out;
> > > > > > +                     if (xp_mb_desc(&desc))
> > > > > > +                             xs->drain_cont =3D true;
> > > > > >                       err =3D 0;
> > > > > >                       continue;
> > > > > >               }
> > > > > > --
> > > > > > 2.43.7
> > > > > >
> >

