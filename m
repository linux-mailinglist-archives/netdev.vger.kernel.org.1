Return-Path: <netdev+bounces-290729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAAyIRweEGrqTgYAu9opvQ
	(envelope-from <netdev+bounces-290729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE35B0EE6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB40300332A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EE3B95F2;
	Fri, 22 May 2026 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBsgu/lO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610B3B8959
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440782; cv=pass; b=bvEzUm9K6ot77R0JBTC9x922cfzg2HnoYh/lPF/wLcBIl8Kd6bkh1849IXdeKCSzgEXANzWnuImA/W3Z0ybTgIccbYrFI23X2tityEj+zPrXwOJMRlhPVHrVi8mB0wryDW+iHwdiy8rwbDJyZbsW6x5qsb/ZW939x2ZBK/0w8YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440782; c=relaxed/simple;
	bh=R+S7aw8jm/S0niR/bgF2z9EKXggL1ReO5jO3N/+1zP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdStv3tLVlYE/jJjWKwyfNnym+VAqEh9rTQo2cFkM2aRI/Qk1J7uf9qrV+D2bfx8OzWK0oxta6ILu66RgV1wtPsHBvaGNgLwxAECP3uTxnQnXTPrcpHXR+tudWTe/EUKDYUvMX25ibcXCyfaZJ+JsMURgJK9biIDOaEmzJmGKaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBsgu/lO; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2baef9f5ecdso57175735ad.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779440780; cv=none;
        d=google.com; s=arc-20240605;
        b=kvmOOEAwKDEkCy3646NZSz+0oUlvtes0q1t+TH+HotGPR2u1T6RsxE3gNoMDQlpz4C
         M+cj1eflNB1pGqg6qSe39Kn1gu5T1lT7hP9JvA0WzBR8n+Nk90K5s8z89sgG9cvRdHaJ
         GCMD0cxvpb0i5jJhB4gdhH68jUalpfGu5Eke2hr2N2EV19Rjqig9w8kVjYpRvjGtD9Qk
         IJ6VXUStp1hNpV32Ta5vxH4r88GgFi76dHFuNK4SFj/cxt3W2Augw5ITqFj/ooNWKjbm
         NAtWd/4pDnFEqiSkHK5YPFRIkT+m11/Mr3w+QGwNzAgl+Cw44IIKpqCe8DSas4PWiv/I
         NTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0g2cVKUQEj9Q4kYnLCnoahgGlOqxaRvFqX0zcp0b8M=;
        fh=eR652PN6eGvsX3fUDoXjWL3D9a1S9ZXP63HvGJ2H8wU=;
        b=B1IQKshgU/QPuKHHcpnssiG6rPteEeyEStJDgDqlsHUTB0C87sH0AlFu4yjzNnAo8B
         FE1/zLafl8rPw8Wmnx+p8CoQVi9OK2gSCDFKmkc4dl+5R+FR//SceBjsn5Jj8+iN3Bm8
         vVLVSrKh4wOj9CBjjwJSQARalS1Qhv6y0dirlfmFjuTqbZ2T+gjhMNzivbuxi0hZ/zFF
         d+L+m+yrMnKzQ76LLWYy557JWKQXFvFLPGuj7+JBw1OgAAb3oBoCeQO74dwCsLbmfJWi
         Tdlpk1btzpcl8ngQFZUrDSVqdqOmJqUxTQdCn71bqxWrshrYSfof1klLYekRA27X8Zm5
         zjJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779440780; x=1780045580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0g2cVKUQEj9Q4kYnLCnoahgGlOqxaRvFqX0zcp0b8M=;
        b=nBsgu/lOM+L+g0xYW7sSm1uAkRersmD/hxD/ZkWGl8cY5lLvFHF84A2QchoMD18tfv
         XCjNxC7pH8ja59asDOz8aVZywmwHkTDJMBUPEMYq8kU/ECIPh3eUNHEVXbhm8kQ2oKTI
         OxISYWit8y2OYLK2LcqDai2lXxyzIgZuisXCAdMIj3YcwuBwdDetDCkOIUmIWSMLE17U
         tCeI3gdhgaiG1MggcFTBD5n7760fh9oKDaAt0dsO2hjkA7BUGsYMsPHgQSFrT4AJlyjb
         FOLH0VgvqIy4Gg1QyWsOn2KuUD1BGHP+Me+lq6I+ydLiHmdpE+yTguyktz3Bl74a3spw
         KQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779440780; x=1780045580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0g2cVKUQEj9Q4kYnLCnoahgGlOqxaRvFqX0zcp0b8M=;
        b=Q+zyq2UtdSpspbk2xQaILdVPMA37lzzQi+7EDfyfjB7a/T3juR+o51PtYY1v/uR6Gp
         gftJczFd/r/vM+9k5HoKGf5loFyPmrhgREo8xz72aPUWXKxSEBnhCh5hMYLh5C3XJTrX
         FJlUq3OSB72QTV2pKndXFZOG9cRk4+kgDj7XrilF71wEEeVJKMky1MaXKi+CD0pBhqgd
         ifK3hePx+GvCJk4SwLZAFL7xjgQZQaHV8dEjRQ6eRkCg4IByMEWaqDypJrVde7TmiBXR
         jSm+GaQ7RGd9g6DWh6w07GgAJdD+GuQp23clJBbVFy8/n09FqYKLNaTtsR85BX5eFNv2
         1E0A==
X-Forwarded-Encrypted: i=1; AFNElJ/KnXe1wmMgyFKhRFeftv769UzIIwH6thxV39Juvjfn3mOqYNyJ7eg9hMdqMzHOe2w/8ObhSrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJ0tJN6xJGfLzpK+wUmPXRFcx9eR5H5C4Cf+UUxXZYBixCDTS
	9x1geCouSb0I6FS5U/cUp542gNacTYoSx2LBt9mkrC/fQkCQOo1d2OIR6HwvjgJDGFIOuwqdYCL
	Wa90RpuJwl/cTwnN5k1qmg4J+7jhAFiU=
X-Gm-Gg: Acq92OFbH1RopEl5U1TMPU2zAhvBMewPRCX/DTs5/R6q6amBaxlZxRHmbsAODeys05i
	bAadRzzHGJPnfx6ynr1NZOtWatj05FTBPKM1ZNnQp2Ymk/Dgv7m/xcyyosXQFAH5Dfg+q+913CQ
	0S5kZHMMKarMjLgcyqNnDvuDseU/BwhGdASj9Oq9p5ALbMwCIhQTPi3Avd9gf4lp03QIABFmQs+
	YOClB3RU/Iic9woRhQMH0urh2OQa6SaEt9vJieO12LEh8c70YnAOOsCGG3+On9FS9SwnR8K4Kg6
	RZmWMnuCXQ==
X-Received: by 2002:a17:903:234e:b0:2b4:5931:bc4c with SMTP id
 d9443c01a7336-2beb069806dmr27409495ad.15.1779440779790; Fri, 22 May 2026
 02:06:19 -0700 (PDT)
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
In-Reply-To: <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 22 May 2026 11:06:05 +0200
X-Gm-Features: AVHnY4KiTvx6DrhHqiVR7wrSm7hruax0kEs4hqu-if92Ny5qh6-NW-NaDOy7_Ko
Message-ID: <CAJ8uoz0bKHSiHjRvNmvVs_z3cWg58U=6wGKKs9_n65yCCcYbEw@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Jason Xing <kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290729-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[magnuskarlsson@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: C8DE35B0EE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 at 15:42, Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 8:02=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> > > On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EO=
VERFLOW,
> > > > > only the current descriptor is released from the TX ring. The rem=
aining
> > > > > continuation descriptors of the same packet stay in the ring. Sin=
ce
> > > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > > leftover frags and misinterprets each one as the beginning of a n=
ew
> > > > > packet, corrupting the packet stream.
> > > > >
> > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow o=
ccurs
> > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is rai=
sed,
> > > > > so we have a chance to examine and handle the potential remaining=
 descs
> > > > > of this big overflow'ed skb.
> > > > >
> > > > > When the last fragment (without XDP_PKT_CONTD) is processed, the =
flag
> > > > > is cleared and the loop continues to process subsequent descripto=
rs
> > > > > with the remaining budget. This behavior follows how previous xmi=
t path
> > > > > treats overflow packets.
> > > > >
> > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@sm=
tp.kernel.org/
> > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on=
 Tx path")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  include/net/xdp_sock.h |  1 +
> > > > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > > > >  2 files changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > index ebac60a3d8a1..8b51876efbed 100644
> > > > > --- a/include/net/xdp_sock.h
> > > > > +++ b/include/net/xdp_sock.h
> > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > >        * call of __xsk_generic_xmit().
> > > > >        */
> > > > >       struct sk_buff *skb;
> > > > > +     bool drain_cont;
> > > > >
> > > > >       struct list_head map_list;
> > > > >       /* Protects map_list */
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index 0a6203c42576..f4add7be8c93 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock=
 *sk)
> > > > >                       goto out;
> > > > >               }
> > > > >
> > > > > +             if (unlikely(xs->drain_cont)) {
> > > >
> > > > Hi Jason,
> > > >
> > > > could we get away from introducing dedicated boolean to xdp_sock fo=
r
> > > > handling this rare case?
> > >
> > > I've tried several ways, but they didn't work. Please see the short
> > > conversation with Stan:
> > > https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=
=3Duxd2McuR-w@mail.gmail.com/
> > >
> > > That means we always rely on a flag (that is either static or like
> > > this patch) to recognize how we treat this abnormal descs.
> > >
> > > >
> > > > > +                     unsigned long flags;
> > > > > +                     u32 idx;
> > > > > +
> > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, =
flags);
> > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, des=
c.addr);
> > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_l=
ock, flags);
> > > >
> > > > It feels a bit off to do this cleanup one-by-one.
> > >
> > > Actually no, it adheres to the basic send logic in copy mode.
> >
> > Not really. Here you are producer to cq which we have batched variants =
for
> > usage.
> >
> > But after second thoughts I don't think it would be worth to put any
> > further effort onto optimizations here. Anyways, even though generic xm=
it
> > is a whole bunch of mess, maybe you could pull this out onto a helper
> > function?
>
> Sure thing. My takeaway is that it will be refactored once as the
> batch xmit feature lands in the tree.

I agree that the code has become really messy since I get a headache
when looking at it ;-). Do you want me to take a stab at simplifying
it?

> Thanks,
> Jason
>
> >
> > >
> > > >
> > > > I wonder if it could be covered by xsk_drop_skb() where you would w=
alk the
> > > > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_add=
r_locked() ?
> > > >
> > > > OTOH, in theory the amount of frags after we hit the overflow case =
could
> > > > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to c=
over
> > > > them.
> > >
> > > Right, this is why we now put the logic into the xmit path just like
> > > other kinds of descriptors. We need to check and send it under a
> > > series of protections like the check of cq pressure and budget. I
> > > don't think it's an exception to escape the check logic. The whole
> > > process should be fast as there is no need to build skb and send it t=
o
> > > the driver as long as this case is recognized.
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > > +
> > > > > +                     xs->tx->invalid_descs++;
> > > > > +                     xskq_cons_release(xs->tx);
> > > > > +                     if (!xp_mb_desc(&desc))
> > > > > +                             xs->drain_cont =3D false;
> > > > > +                     continue;
> > > > > +             }
> > > > > +
> > > > >               skb =3D xsk_build_skb(xs, &desc);
> > > > >               if (IS_ERR(skb)) {
> > > > >                       err =3D PTR_ERR(skb);
> > > > >                       if (err !=3D -EOVERFLOW)
> > > > >                               goto out;
> > > > > +                     if (xp_mb_desc(&desc))
> > > > > +                             xs->drain_cont =3D true;
> > > > >                       err =3D 0;
> > > > >                       continue;
> > > > >               }
> > > > > --
> > > > > 2.43.7
> > > > >
>

