Return-Path: <netdev+bounces-288159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMegD8+GBmr0kQIAu9opvQ
	(envelope-from <netdev+bounces-288159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F5548C75
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2AEE301BA40
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B93BFAEE;
	Fri, 15 May 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuyB+/zT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52623BFAED
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812621; cv=pass; b=uhL99zgQVKeQKg1j5DJ4yqTq1KTZPU05n8C7Xidmm1lK24A/gsUZeTJaNvsu/V08/dzyRwbgC1qM4ywR9HeDySnjr+7E1kcwaa0Xd2H5RWNqZsIcatA8luEb8OuGfrAOffwmJgDAZqM1Th0j4bHVi0cImEqZljo1hpXpxCca7lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812621; c=relaxed/simple;
	bh=jQsBjTgYWRd37BoT8zL4I69YBxXmzBFQDBEBiWWlxX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhdpEkagjmSljy/tgR8gByaBdlSLXNC4OI324VxxSjhxfvMnBd6VWLJIDH7uXOE8XvX8aJtcXdKFsD8x7Iz/ISLp1xFyieA1DuAlrCp+C+msk5vFVQAFjBm0jqQLnASUZpXmXhoFQE+sFQOhPP7wE4QvMkLB1+dHSOt3WoF538A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuyB+/zT; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso8638618e87.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778812616; cv=none;
        d=google.com; s=arc-20240605;
        b=VPGHa+hYFe/MsJXPpB/hn4DIlypXagjvPNGJM0Q7wYYpxwD8WSSe3ChAvZ72IK76/v
         NhsNEqSyJrNGC4p4o87svrslHl1OULSug2XcxlzdmTjBiF/D1+m3adCJcolF4xORUypy
         xd6GA95G/WNw2Wq3zaBzyob/R7FD13cBXfRpE8z1OOYndetD2IDwLtDXQKqls6Bs6k5H
         DdmsTn7rudqsJnrH2id99Ib2h9spipVo5yiSzvBaI/G/OnxAQiwB3uPHTGTv5StKYvBo
         jm4L3vNs1W6o1eQZphSnNcWQ4IHArMAFa4ClBdA4BP5LKpMoGtNEzsPCmBBHzfbe3Psx
         keag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5H6FMgknlF6hNoIW+s8VHjozDY2P7YaikVATd/DLqo=;
        fh=Qasy8fJCKtgSxqeyhSeB3ienAUIL9XBuencOIBaJyj4=;
        b=I0Kkez4RiLUXoVD8sQ5euKXGF1jkzMrIlqQIPRk+L25H+zDyNS9/h3hSJg46d+5+yb
         Bx97moi2M9q+FnvhepdHW+uDCMu5QdSckKyIbT4tDI9jtMV9QdHxANDWIRAGjDQthzDW
         SZL6Q9ieyhk/tps51UnwWm+LLy8SgdqNBCaC1E6hkYMdgEcU21f219UGcih3q3NF0cYr
         s1Qi449sUcEQW+B1HyzfCOpdjzEL14+1/rcEHk2CDyjnsr766Luhj/g3n7r8oUUcuTfy
         gIm98sqYdU5kwV5MaZhbaEVkiSiYOBmp3cchq7xi7bXfcEQNlYHUb7exqXdOH+/ZIgRA
         ooCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812616; x=1779417416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5H6FMgknlF6hNoIW+s8VHjozDY2P7YaikVATd/DLqo=;
        b=UuyB+/zTuEirv44YXPaeViTRGVgdkm4nKIpKPYKy5/EUWhq/w8UhV3lV/b25GQD1+s
         ZdWZ+ReAuhy0VzOjgqDmyBGSXy3KWkzIdjIGbkXnjZ1rsVHKR0arGXJf3ytAE/jUSKcB
         ttSABS790GjcbjXQLjYU+s2nwFiUOdPzJ1VD/mQQOqp3Zv9HtgDWKaEBsN3cZfqGp6b1
         Q8mYqQlS8XMQXrfnIRVcHO5bZuOa0rWCztAZwEmY3hTW6t/owcMuNxzR0lpkDlUPxqwo
         9sUitO2dLhxxooQXj0Z6vAQeTA2W9E4Js7zw5POf05k+3lBKDTbqohXpk2C0PUnfGk5t
         189A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812616; x=1779417416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5H6FMgknlF6hNoIW+s8VHjozDY2P7YaikVATd/DLqo=;
        b=LBHqxAjLg3sKLDYIYQdQmYqTp/eyOewzYTLkPmV1cLF8at+3qG6YcIjnzX5EFEpPiG
         J/vHpqyoNWZDxoKFZofX/bgm2bCaopSBtrsp5kpuNkc8wlD0I2kvAJQxLA/O8tKpomhl
         Xg2lsXer0guM/FM4e6Q7JfOrQfuopbG2ACSSkrhOhEUlLWqQ5fYOf1EPoSo1Recnu5qp
         iptVPeV4y2jDhGMUb+wepURQawfksWHcpmQkS2fBOevslnmGda0TToyoLn9fCBYod7nE
         WL6Qie80TatV6cH8DVmEmIwvmyLQPiHi9pm3ADhJ3bn9v9kJ1RI+LSHIECjIBqDLdDuy
         Pt8A==
X-Forwarded-Encrypted: i=1; AFNElJ/lLhsJr5Ibs44W3dC7/le+G1mAY6OD2IOta9pQhllwiTKMTcirSbfGHQsPxKLlx9sUw50jKl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOCzLM9+koCDH9sOOKy484mYt+/KCiFrngCT89ONNSvadtJFP
	cOu8NIo2QQOG7d7cMuAxkr50MgK+EMEpDOS7SVFFMAPkqMzM6y4ADMW9sGHDiid3J54oa6jizlK
	oB547+6j/ptP74iz6vEX0vrk5kuIAHNI=
X-Gm-Gg: Acq92OFh/H99xbEb0tPP9xREA4Y6M/TW++W/QDRnaNwpqdC3cnpaowulmH1gI7fGG1p
	KmVh+tuKLS2IWPRUKE6ta07qPGzsEsrUaiLXPT03sY65XmtFuv+RqyMepeS2R2EmDgH1rKpfD9e
	2bNVIpud8BaO6GZW3EYFhVMLvivhAl0SFj8whD8P+CHV2imgwNg3FQzYGyu9YwVpncb6Qi15hw6
	Ubh+2vfPhjglYc1/tLVIzfyDrQDeRcg6c8Gy0YUnILuD6CHJS50g45RWuXojyFQ/3OksDyaIQXX
	2WO/OkfDn1FELGTJPckkrkebyqd6plxRhRVMLVw6Qs7a8MJ0nXg=
X-Received: by 2002:a05:6512:1350:b0:5aa:1008:e174 with SMTP id
 2adb3069b0e04-5aa1008e225mr194321e87.9.1778812615698; Thu, 14 May 2026
 19:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com> <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com> <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
In-Reply-To: <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 15 May 2026 10:36:18 +0800
X-Gm-Features: AVHnY4Kr9ja2kr2U3eHpbgYT2B_b5P94TRZKb5gOLDiiD0v_4nwor76voyumwGg
Message-ID: <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: A92F5548C75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288159-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 8:29=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 05/14, Jason Xing wrote:
> > On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 05/10, Jason Xing wrote:
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
d.
> > > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > > descriptors one at a time: each gets a normal CQ reservation (with
> > > > backpressure), its address is submitted to the completion queue, an=
d
> > > > the descriptor is released from the TX ring. When the last fragment
> > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > > function returns -EOVERFLOW so the next call starts with a fresh
> > > > budget for normal packets.
> > > >
> > > > This reuses the existing CQ backpressure and budget mechanisms, so =
if
> > > > the CQ is full the function returns -EAGAIN and userspace drains th=
e
> > > > CQ before retrying. Zero buffer leakage, zero packet stream corrupt=
ion.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp=
.kernel.org/
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on T=
x path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/net/xdp_sock.h |  1 +
> > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > >  2 files changed, 23 insertions(+)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index 23e8861e8b25..1958d19d9925 100644
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
> > > > index 3f1e590c855d..232dd7126905 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >                       xs->tx->invalid_descs++;
> > > >               }
> > > >               xskq_cons_release(xs->tx);
> > > > +             if (xp_mb_desc(desc))
> > > > +                     xs->drain_cont =3D true;
> > > >       } else {
> > > >               /* Let application retry */
> > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >                       goto out;
> > > >               }
> > > >
> > > > +             if (unlikely(xs->drain_cont)) {
> > > > +                     unsigned long flags;
> > > > +                     u32 idx;
> > > > +
> > >
> > > [..]
> > >
> > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, fl=
ags);
> > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.=
addr);
> > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_loc=
k, flags);
> > >
> > > Not sure I understand why you want this if you're still marking the d=
esc
> > > invalid.
> >
> > The key point is that as long as we read the desc from txq, the desc
> > should be either put back to txq again or publish it in the cq (for
> > application to keep track of this) at this point. Or else, the
> > application will lose track of this desc, which breaks the whole
> > logic.
>
> Yes, makes sense!
>
> > > > +
> > > > +                     xs->tx->invalid_descs++;
> > > > +                     xskq_cons_release(xs->tx);
> > > > +                     if (!xp_mb_desc(&desc)) {
> > > > +                             xs->drain_cont =3D false;
> > > > +                             err =3D -EOVERFLOW;
> > > > +                             goto out;
> > > > +                     }
> > >
> > > I also don't understand why you want to return -EOVERFLOW again? Why =
not
> > > (quietly) swallow these invalid xp_mb_desc from the previous packet a=
nd move
> > > on?
> >
> > This particular desc is really one of overflow cases, right? We should
> > warn users to handle this with this error code.
>
> Right, but didn't we already return -EOVERFLOW to the user once?
> The part where you set drain_count=3Dtrue will -EOVERFLOW. Then this
> remainder will also return -EOVERFLOW?

Right, my intention is to alert users twice under this kind of
circumstance. We silently drain the remaining portion of the skb the
second time, which looks a bit strange, doesn't it?

>
> But let's maybe step back, what's the expectation on the user
> when we return -EOVERFLOW? In theory, the user can re-submit new
> shorter packet (at the current prod index), right? And then your
> !xp_mb_desc logic will break/swallow/-EOVERFLOW it?

People would be aware of the skb that is too big to handle when
receiving two times of overflow warning. To put it in a simpler way,
the second time in xmit path only handling the remaining is enough, no
more descs that belong to another skb should be taken care of.

If the user is able to quickly react to this case, I think the whole
skb should be re-put into the txq again instead of adding the
remaining part. I'm not so sure if I interpret the "break" correctly
here.

Thanks,
Jason

>
> > >
> > > Also, have you considered doing this drain in xsk_build_skb error pat=
h?
> > > Is it more messy? Carrying this drain_cont across the calls seems a b=
it
> > > too complicated (but idk, maybe the alternative drain in xsk_build_sk=
b
> > > is even messier).
> >
> > Sure, it was my first version actually. One of the primary reasons is
> > how to handle it gracefully when CQ is full? Then those descriptors
> > can not be processed in this loop at this time and will be delayed
> > until CQ has available slots. Another important reason is that I want
> > to put the whole read process under the previous clear logic in
> > __xsk_generic_xmit(). Some protections like budget/batch still take
> > effect in this case. In this way, there is no strange/exceptional read
> > process in copy mode :)
>
> Agreed, given the fact that we need to handle prod backpressure, your
> approach is good (but see above comment, we should probably clarify
> what's the expectation on the user side).

