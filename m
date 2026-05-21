Return-Path: <netdev+bounces-290426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMBPGSAKD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49915A5FC7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9578F329C810
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130333DB33B;
	Thu, 21 May 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g10aHEcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3313CF963
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369093; cv=pass; b=lgQw0AjKAgiCCeUBZJMEia9CvNiqX89d4dAMfitVjZU8GmAVLBK8igAHluOgpauc0cYVsPRvp+oW0UQ9dtKeg+3UROb0KzlxM7mFpmj6Zdf00yJPIv5y0vAIiLjxLQvgcPeUvsDEGI+SnUmhnHjcl9FW1vThWGRoe99fJ2eXgwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369093; c=relaxed/simple;
	bh=r6LxEN58qbq0Y/M28+MsnZWSw96N7dXM2LM1lFWQMNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toqsv1kYbR9byD++QkbCHcYocBr+zC2dgWUrIezntVyuGL6xNXWlAeIb2NrEYhghlHg7VXVRV8h1Jjf/4ct5atvmM/twagXGbIolgHexQQKDW9vYt1artJYVa1VpoUJpaqrs9/L37J6yeCdod3EVvVhM70vkMTu9VGd4BxYmaL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g10aHEcd; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso71483161fa.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369089; cv=none;
        d=google.com; s=arc-20240605;
        b=AnWsgOTB+rIRNVT8TtP2/lkRLOzACZyPTyNq5s5PTfCfEMjGwXWZMDa41iStQwoJsT
         rvstfwTsVU5asa993Mu/SUcY+Y/nq53/VBr/vrvmych+002YOVu05Xhxrlbk+ZC5ntTK
         3YMrRa+cbeVskH1MuCOtF5vwlxuuYpXg7+mwt2XfIcjiMuV0s/PiqveqbCYli28ZbUtf
         Ylc2fzuTuFiausHeSkDEhd6Cj2E5h02UDLYrpeTheY+tL09Gm4xWjHKJQCBfG11diGVh
         gd0OheYRRwnzTdf/IJ1x7NkK/icFCAVrqEqxaIKBAnhuD9cI7MBQcsLTT4+5gLltB9A4
         HpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPRoiP89QkO6oH3NtO+q0F6orRcQ/LGFJxe4k+Ya1A4=;
        fh=iV3cqKStAujPPkkZNo5gHkb0vi9t7VJ9E537e0SDSeA=;
        b=VqZdstruwOeGOWSYYUGkeFcCFhPZXpztXOsk6GXe9XfCLYvT7WpIUJX3uDAkNlw3zv
         /UUwKqE7pOzYfVx4jX9mr3AI86aTKukbu1TuG5aEP+Yy5NzGzJGVoHS0T5n60ylhrWfW
         7+k58oODM7/aNRRd3EXIXpCkx8bEGYt60VNzTY05uMBor8HYxhNTZ5g6bxPbX+GNG9sy
         e7kv7OPxH2rGPzrYrn8f7pIccR8sSFOMEYngyWeyE07dz+Jh1yQAIZwEQD+11j6MF9Ju
         DTg2+yViy0SVJL1nikpl0AbeG/FcHdiLSdNms5jDhGDcO/4XMaAld1A/QYAyAoutyp5G
         6VCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779369089; x=1779973889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPRoiP89QkO6oH3NtO+q0F6orRcQ/LGFJxe4k+Ya1A4=;
        b=g10aHEcd3xJj4AmkJhtNQT2e1SaP1Ul3P/u9lViAIt5OizEiDnYNBTl1HhA7hTI/5P
         vGKkzj9N+NJF0/BFnY4MWtcowetMSkFWAD7Wsnia8XafuRtZUytTlXfoXZzdNGAWog4T
         b22Itom+D1Qc0n8DjMGmSl0SgTyY/2xkNpOYF3lEWDIGaEXgUZ3XwWmKjBd1BhYkRjnR
         lzmGaIEBmjFa3N0VnVQwZ111zWOr6u+yF7NQDFmq7wsBWGojU96jZa0mn5CUzvQvk5Ls
         txegAbrMq2YvMiyntaiqLNj0ia5yLp4qyJg1917hdzFLz9grA5Je40rZ1fsjG80uvN/6
         N8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369089; x=1779973889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPRoiP89QkO6oH3NtO+q0F6orRcQ/LGFJxe4k+Ya1A4=;
        b=exEf4X3b1hVGRkfK4+JXYrZQPEvWRf7ItheP+MS0OhclPetwdLI2RGZcBvjAtjSYrl
         o0moSBLlbuL7PVL1Dz8J1H5mUtW/KPzWlk/vJL6b4kdrui4DCIWwjlyDaukXq4mWJOHD
         WbecC3HPIjwQukHjt2Ejbw6MFLY7Gs6glFSbGVMzdPcnIyoxh2f9ur1iEBkenx3feGyO
         rgvRfszn0psrto6s2Itt0Lx2wNW0i8f57eladbzc1UabH0QMwJ2YOPYXIXPr5t+THwly
         is4/z1NT/vJP6NPdemgbjYzoJU5VR7j6YfcrfPm0YvrYPdnCXYXyLBhukY9Qhiz84I2s
         XiuA==
X-Forwarded-Encrypted: i=1; AFNElJ/FnSgkEvmqAOvRn72N2TCox+u64AP3C2HKeLcbmutzGg8IEhC4LEKu+XwAF0RU79FqFOQBosc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdRJ8XjjN6teDPXa7d63RI3PCIEaGt0/GDYEGh8WmFgS7z5Xg
	Bxb7Jj3hO0z3TqL/X/JOAY/TpPuUSseu9nIezuwS/FlREjePjowQwqOAaXAF7S+qGjWPBVVX/Kv
	WIQUe+SFX+m5aFjyyupBSSJbIPbcDCI4=
X-Gm-Gg: Acq92OHWzqO7iiGWVtd7ztMs7aRKDan/e3bOWaUHnAd9Ua79NMWMmFimYvVXVemmol+
	Y/9XMjwaWjINlKJ+9mEmNVCab+I6mhC6neHgSzqd7J7NKS4BXJF+ilrkTCo8e2JjmoIa1xClNBS
	ntdyqy6oWXJjSKWzeOcxcnRlGa5meKJtbge/uCT0t9jqejowT6y2bBCfNodUIEMfQ0Wbo699cUT
	a7Adq3Wejd5nkfFm47qZw3BHy9UzcIhcGcNdkKtfAETWjGMqTfvJk4c3veye0G3r7pTtOIvzt8r
	aA2AAuvVi6JNuKLQrmJS167enI60xGCGYuIVj44=
X-Received: by 2002:ac2:5ed9:0:b0:5aa:b6b:796f with SMTP id
 2adb3069b0e04-5aa2bc916bemr719139e87.43.1779369089186; Thu, 21 May 2026
 06:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com> <ag3c9/EF4h7DLQu3@boxer>
 <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com> <ag70RrU4nGy0Nlna@boxer>
In-Reply-To: <ag70RrU4nGy0Nlna@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 21:10:49 +0800
X-Gm-Features: AVHnY4Kwv3EeqRw8Jlv440foRrB0qmD4hhTs741XyLFsgNn7yl66c2alVXVDX24
Message-ID: <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290426-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D49915A5FC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 8:02=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> > On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVE=
RFLOW,
> > > > only the current descriptor is released from the TX ring. The remai=
ning
> > > > continuation descriptors of the same packet stay in the ring. Since
> > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > leftover frags and misinterprets each one as the beginning of a new
> > > > packet, corrupting the packet stream.
> > > >
> > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occ=
urs
> > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raise=
d,
> > > > so we have a chance to examine and handle the potential remaining d=
escs
> > > > of this big overflow'ed skb.
> > > >
> > > > When the last fragment (without XDP_PKT_CONTD) is processed, the fl=
ag
> > > > is cleared and the loop continues to process subsequent descriptors
> > > > with the remaining budget. This behavior follows how previous xmit =
path
> > > > treats overflow packets.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp=
.kernel.org/
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on T=
x path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/net/xdp_sock.h |  1 +
> > > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index ebac60a3d8a1..8b51876efbed 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > >        * call of __xsk_generic_xmit().
> > > >        */
> > > >       struct sk_buff *skb;
> > > > +     bool drain_cont;
> > > >
> > > >       struct list_head map_list;
> > > >       /* Protects map_list */
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 0a6203c42576..f4add7be8c93 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *=
sk)
> > > >                       goto out;
> > > >               }
> > > >
> > > > +             if (unlikely(xs->drain_cont)) {
> > >
> > > Hi Jason,
> > >
> > > could we get away from introducing dedicated boolean to xdp_sock for
> > > handling this rare case?
> >
> > I've tried several ways, but they didn't work. Please see the short
> > conversation with Stan:
> > https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=3D=
uxd2McuR-w@mail.gmail.com/
> >
> > That means we always rely on a flag (that is either static or like
> > this patch) to recognize how we treat this abnormal descs.
> >
> > >
> > > > +                     unsigned long flags;
> > > > +                     u32 idx;
> > > > +
> > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, fl=
ags);
> > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.=
addr);
> > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_loc=
k, flags);
> > >
> > > It feels a bit off to do this cleanup one-by-one.
> >
> > Actually no, it adheres to the basic send logic in copy mode.
>
> Not really. Here you are producer to cq which we have batched variants fo=
r
> usage.
>
> But after second thoughts I don't think it would be worth to put any
> further effort onto optimizations here. Anyways, even though generic xmit
> is a whole bunch of mess, maybe you could pull this out onto a helper
> function?

Sure thing. My takeaway is that it will be refactored once as the
batch xmit feature lands in the tree.

Thanks,
Jason

>
> >
> > >
> > > I wonder if it could be covered by xsk_drop_skb() where you would wal=
k the
> > > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_addr_=
locked() ?
> > >
> > > OTOH, in theory the amount of frags after we hit the overflow case co=
uld
> > > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to cov=
er
> > > them.
> >
> > Right, this is why we now put the logic into the xmit path just like
> > other kinds of descriptors. We need to check and send it under a
> > series of protections like the check of cq pressure and budget. I
> > don't think it's an exception to escape the check logic. The whole
> > process should be fast as there is no need to build skb and send it to
> > the driver as long as this case is recognized.
> >
> > Thanks,
> > Jason
> >
> > >
> > > > +
> > > > +                     xs->tx->invalid_descs++;
> > > > +                     xskq_cons_release(xs->tx);
> > > > +                     if (!xp_mb_desc(&desc))
> > > > +                             xs->drain_cont =3D false;
> > > > +                     continue;
> > > > +             }
> > > > +
> > > >               skb =3D xsk_build_skb(xs, &desc);
> > > >               if (IS_ERR(skb)) {
> > > >                       err =3D PTR_ERR(skb);
> > > >                       if (err !=3D -EOVERFLOW)
> > > >                               goto out;
> > > > +                     if (xp_mb_desc(&desc))
> > > > +                             xs->drain_cont =3D true;
> > > >                       err =3D 0;
> > > >                       continue;
> > > >               }
> > > > --
> > > > 2.43.7
> > > >

