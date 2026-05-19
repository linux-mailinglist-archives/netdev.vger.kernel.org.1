Return-Path: <netdev+bounces-289212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F18BzGqC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB457565A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3B63044214
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAEA128816;
	Tue, 19 May 2026 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9OT+2K0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6684AEEF
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149275; cv=pass; b=hr/S4stvld8cPaBfpPnpDmoeqEzzNSOZrQHKm07b7RNxYufJDUX0mzlXfdkZ0XuF1uAGnDki3nM7Tj6vlQwVKYqGAyxQZhZKsNnOqc1fvAM+HJjvDRz735f6jXmHuxFb2979XPJun7ofz1YbSgJfCNUEpzccHJFXD/xL18BR68g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149275; c=relaxed/simple;
	bh=9hILS1zDb+jPchgacVcoJ3YWwARXDYScIVCTRw1ScOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6KaE1CdQOvDto+o4oXhTnVIlRZBRX/bKGmMtfR0k/3ZN7pOeeOLHnxndJ0s6HkPvcNrwLYynj7z4svsax+wEqGetdJYS7kiaJd38qtYvLBHwBYyM+UjjmfZMWFRNyjG7NJhBwhuL3nwEc/gwzP6Gcq77KZV+l4oSrbpxzx3h/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9OT+2K0; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so3152286e87.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 17:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779149272; cv=none;
        d=google.com; s=arc-20240605;
        b=Pn2Dm75weCdG3fCeCh4tPgT3hM51prwiG1w1ZWvLerW29SpktXWOozkEQqbhQfVXWW
         fshU+wGMZUQHW6Hw995tyCoambKCJ213K2ckxGQXgF1pB/zk9+60MqI+3CJ3FlwL4RDA
         u3ANAQxEIUHAgZB/3EXhO8zlPUGlP7cuAEb6YmroS9i8sfmQPLAkElABsx0FQCAoGNm5
         TX+V8dnR/koN4YEXc4QApDwFBu+hf5gDlmY73SvRwy7nncmZ++FShABT/o8llJS4L8dX
         1D4z27y+CTIcvE1Fykwfon3Smp/GLwcbtE4K0IT+8WMls7fZkXmf9y6KBFcHAWnPdG7N
         jP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qovj3NDVZxKBs2Er+LgveuzgeEyaYQonhNZuNeoGmdU=;
        fh=WTH3I/SsLSrdV9papix7bKf/u8CheWr2NqWob0vSDE8=;
        b=F/cp4df2Y//1zhQJl4QzawFjLjrUnAznlSaqjJEruRVQIJQAyBR3YdnZz0zA59gbID
         dpXeHfs1aQNesP1UK+9VJtX0AaNWkDoXeuvnpzgOJkbqg4OcvEY+4728kfjVXkQ2Wd8d
         c+K+qS9gW9t+1J3ZW6EjTvN6XeR2mnaI2MsEP54i2yfi7Lz4LCa4JRexs/Mn1IYrK/Hz
         JcuhhfcIEUOAiUrmK1mPDco5m69YjvIsb2M+l1oCMeEGERaYMuHurhg7pSOHk1kPSgM/
         r71RUmuUoUmA1ud4D4Gut4oUajt+AxbXWpeJfbN2xoDBRaeWJoTkzeEKnDWGCGvujmYL
         4utg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149272; x=1779754072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qovj3NDVZxKBs2Er+LgveuzgeEyaYQonhNZuNeoGmdU=;
        b=U9OT+2K0z4Rw7PVmLFaNP0yVaD2ezc5pM2BCOrtC6tUaPsRfQGa2iDixdaWxyF7Q6b
         FCH3n/baI4jZKkmpouR5NA2bt/K1DBJAJhXOxq2PJhi7mv00JdsPevJdyj3oB/dSBVOG
         IhOI9QU4TZ8G13FKkipsrLIInILtcmp8CX4ZAEdonQIdkiLKpfdsa4E7IhbPeoHen9QX
         R+PrhYT9XOKFe7YkyLtY4RqNvLeky9xfasErvyF2uyW/A4M3fN+XZroz7Ee7ofsfY4HG
         Pp9x7jJcJyl4mXuR8Z3DqMp5psHMPcXYDpa/u1+kVjLgFHAWKpMil6n8i8lD0WbDedHY
         5HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149272; x=1779754072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qovj3NDVZxKBs2Er+LgveuzgeEyaYQonhNZuNeoGmdU=;
        b=S2XbPzcpBD60RCr00Wt2cCyAQHric1eoTu0VmJH2veMfv+3MDC8ekz4KKKsdfU9jKI
         VIlfO3eAtmiQPfKMIwjyjFo/VqzSUMosDMAeEtYkA6+DU9oI6paJl66pFYRKUNsRwjd7
         8QS0BkRjSDgSOHhLOL2iCPhtNZwylMEi/P07CAhN8zk1syaD+BmUeAG3zROkDANCYKWC
         8+d78Ya/lRzFfu6fNhdGwHEPgoThL53s9dwLL6ueTShdbTGDLOzP7Qea+kqTB4lDK+kW
         ynEROVYfrxAwZkQFua71NGikuWLlkzPhSnnKum6EtuVuvGoiOvCVwNGxs9s1npXErcpy
         zprw==
X-Forwarded-Encrypted: i=1; AFNElJ8sQZfG/r8fnbgfyRV/zr39oIImOE8L2FvyR1zhswtCFgxD7lQGm88RavcNhII9xY4RPzTtpLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6m61k0RNqiDY2cXgRLYGTz1n3HiLbbUZM68Nu0kIpbp9ZumT
	k05Jf0x0uBM/nMzjOltiP5AXvGcq+j7kSd/6SRoCuVtLbraB6tB7K37Xi20i4HoV22PR5OBgNC4
	3fnaVHq4fwwx7wU1NMS2B/SvDaMaeLMg=
X-Gm-Gg: Acq92OGZTJjouE58zw2H6oJubKye8jQ5Go27XBOrKeX1m0/mY6qiWi0kLQ7Tip5/OBJ
	liEOS3hvykSaSiGZDetWGEjMVqisI1+KJRn7yDRUId3IKHu2rYNGCi7p2bojMQUAxdMq6SUryLV
	s5P0PJt0Ketk/iDxaelfDA8u4+JWG6on2O22WgYEeeJQxdqr/Vw2C5tLN3Za88zfDRALL78CoYL
	+yhXGvN/yJRh/9S2hCT3sQzmLFpHZLBoK+U8tnQQ3IgiOupikPWiumYhWwqC2Z4EX280HmmuiuT
	ubxRERP2q1PZkcix/ZfXvSn2jOtWUSzp/SOqEXs=
X-Received: by 2002:a05:6512:1590:b0:5aa:b6b:93c3 with SMTP id
 2adb3069b0e04-5aa0e74512dmr5337393e87.45.1779149271779; Mon, 18 May 2026
 17:07:51 -0700 (PDT)
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
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com> <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
 <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
In-Reply-To: <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 08:07:14 +0800
X-Gm-Features: AVHnY4Jli4ZYZ34dgWSRjvY5BP-C0qxPE8w64703gMJMVUWklQLMw3sQs8VkTQk
Message-ID: <CAL+tcoD8dtua=ErG63Rn1xNhhWGx=RY-FLa2_rcH78k_Fy7=qg@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289212-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 7BEB457565A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:54=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/16, Jason Xing wrote:
> > On Fri, May 15, 2026 at 11:41=E2=80=AFPM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 05/15, Jason Xing wrote:
> > > > On Fri, May 15, 2026 at 8:29=E2=80=AFAM Stanislav Fomichev <sdf.ker=
nel@gmail.com> wrote:
> > > > >
> > > > > On 05/14, Jason Xing wrote:
> > > > > > On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
> > > > > > <sdf.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > On 05/10, Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and trigge=
rs -EOVERFLOW,
> > > > > > > > only the current descriptor is released from the TX ring. T=
he remaining
> > > > > > > > continuation descriptors of the same packet stay in the rin=
g. Since
> > > > > > > > xs->skb is set to NULL after the drop, the TX loop picks up=
 these
> > > > > > > > leftover frags and misinterprets each one as the beginning =
of a new
> > > > > > > > packet, corrupting the packet stream.
> > > > > > > >
> > > > > > > > Fix this by adding a drain_cont flag to xdp_sock. When over=
flow occurs
> > > > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag =
is raised.
> > > > > > > > The main TX loop in __xsk_generic_xmit() then handles conti=
nuation
> > > > > > > > descriptors one at a time: each gets a normal CQ reservatio=
n (with
> > > > > > > > backpressure), its address is submitted to the completion q=
ueue, and
> > > > > > > > the descriptor is released from the TX ring. When the last =
fragment
> > > > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared a=
nd the
> > > > > > > > function returns -EOVERFLOW so the next call starts with a =
fresh
> > > > > > > > budget for normal packets.
> > > > > > > >
> > > > > > > > This reuses the existing CQ backpressure and budget mechani=
sms, so if
> > > > > > > > the CQ is full the function returns -EAGAIN and userspace d=
rains the
> > > > > > > > CQ before retrying. Zero buffer leakage, zero packet stream=
 corruption.
> > > > > > > >
> > > > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2B=
CB2@smtp.kernel.org/
> > > > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buf=
fer on Tx path")
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > >  include/net/xdp_sock.h |  1 +
> > > > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > > > >  2 files changed, 23 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.=
h
> > > > > > > > index 23e8861e8b25..1958d19d9925 100644
> > > > > > > > --- a/include/net/xdp_sock.h
> > > > > > > > +++ b/include/net/xdp_sock.h
> > > > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > > > >        * call of __xsk_generic_xmit().
> > > > > > > >        */
> > > > > > > >       struct sk_buff *skb;
> > > > > > > > +     bool drain_cont;
> > > > > > > >
> > > > > > > >       struct list_head map_list;
> > > > > > > >       /* Protects map_list */
> > > > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > > > --- a/net/xdp/xsk.c
> > > > > > > > +++ b/net/xdp/xsk.c
> > > > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(st=
ruct xdp_sock *xs,
> > > > > > > >                       xs->tx->invalid_descs++;
> > > > > > > >               }
> > > > > > > >               xskq_cons_release(xs->tx);
> > > > > > > > +             if (xp_mb_desc(desc))
> > > > > > > > +                     xs->drain_cont =3D true;
> > > > > > > >       } else {
> > > > > > > >               /* Let application retry */
> > > > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct s=
ock *sk)
> > > > > > > >                       goto out;
> > > > > > > >               }
> > > > > > > >
> > > > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > > > +                     unsigned long flags;
> > > > > > > > +                     u32 idx;
> > > > > > > > +
> > > > > > >
> > > > > > > [..]
> > > > > > >
> > > > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_=
lock, flags);
> > > > > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > > > > +                     xskq_prod_write_addr(xs->pool->cq, id=
x, desc.addr);
> > > > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_=
prod_lock, flags);
> > > > > > >
> > > > > > > Not sure I understand why you want this if you're still marki=
ng the desc
> > > > > > > invalid.
> > > > > >
> > > > > > The key point is that as long as we read the desc from txq, the=
 desc
> > > > > > should be either put back to txq again or publish it in the cq =
(for
> > > > > > application to keep track of this) at this point. Or else, the
> > > > > > application will lose track of this desc, which breaks the whol=
e
> > > > > > logic.
> > > > >
> > > > > Yes, makes sense!
> > > > >
> > > > > > > > +
> > > > > > > > +                     xs->tx->invalid_descs++;
> > > > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > > > +                             xs->drain_cont =3D false;
> > > > > > > > +                             err =3D -EOVERFLOW;
> > > > > > > > +                             goto out;
> > > > > > > > +                     }
> > > > > > >
> > > > > > > I also don't understand why you want to return -EOVERFLOW aga=
in? Why not
> > > > > > > (quietly) swallow these invalid xp_mb_desc from the previous =
packet and move
> > > > > > > on?
> > > > > >
> > > > > > This particular desc is really one of overflow cases, right? We=
 should
> > > > > > warn users to handle this with this error code.
> > > > >
> > > > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > > > The part where you set drain_count=3Dtrue will -EOVERFLOW. Then t=
his
> > > > > remainder will also return -EOVERFLOW?
> > > >
> > > > Right, my intention is to alert users twice under this kind of
> > > > circumstance. We silently drain the remaining portion of the skb th=
e
> > > > second time, which looks a bit strange, doesn't it?
> > > >
> > > > >
> > > > > But let's maybe step back, what's the expectation on the user
> > > > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > > > shorter packet (at the current prod index), right? And then your
> > > > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> > > >
> > > > People would be aware of the skb that is too big to handle when
> > > > receiving two times of overflow warning. To put it in a simpler way=
,
> > > > the second time in xmit path only handling the remaining is enough,=
 no
> > > > more descs that belong to another skb should be taken care of.
> > > >
> > > > If the user is able to quickly react to this case, I think the whol=
e
> > > > skb should be re-put into the txq again instead of adding the
> > > > remaining part. I'm not so sure if I interpret the "break" correctl=
y
> > > > here.
> > >
> > > Let's say the user puts a packet with too many descriptors. We find t=
hat
> > > mid-way and return -EOVERFLOW. What is user supposed to do with that =
error?
> > > In my mind, the user should drain TX ring completely and start postin=
g
> > > shorter packets. You seem to be trying to handle the case where the u=
ser
> > > leaves the remainder of the previously EOVERFLOW'd packet in place, w=
hy?
> >
> > Good point. I think now I understand what your opinion is here:
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 3b604776f09f..72d05a1fb0b5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> >
> >                         xs->tx->invalid_descs++;
> >                         xskq_cons_release(xs->tx);
> > -                       if (!xp_mb_desc(&desc)) {
> > +                       if (!xp_mb_desc(&desc))
> >                                 xs->drain_cont =3D false;
> > -                               err =3D -EOVERFLOW;
> > -                               goto out;
> > -                       }
> >                         continue;
> >                 }
> >
> > Then as long as we have enough budget, we silently handle the whole
> > big skb and then continue with the rest of the skbs in txq. Users will
> > be alerted by the counter of invalid_descs. I think that is what
> > you're asking, right?
>
> Yes, this resolves one part. But the larger question still stands:
> why do this tracking at all? Why can't we clarify in the documentation
> that the user is responsible for flushing tx queue completely after
> EOVERFLOW? What am I missing?

Previous and current (v3 as you may notice) impl always silently
handle the overflow packet which means kernel never returns -EOVERFLOW
back to the userspace and users have no way to receive this signal and
stop sending more overflow packet.

Another point is kernel should be capable of tackling this overflow
issue separately without considering how users would do after
realizing the problem.

The v3 patch doesn't change any pre-set behavior of xmit path but only
publish the desc into the cq.

Thanks,
Jason

