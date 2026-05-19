Return-Path: <netdev+bounces-289652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZeN+BXPwDGr2qAUAu9opvQ
	(envelope-from <netdev+bounces-289652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C29585F9A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F1A130207E6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D6351C24;
	Tue, 19 May 2026 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc7yzXCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8A3112DA
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232876; cv=pass; b=k7abfawk2pnwzfKDRRpuZjA0l6k/toX+PCWoVqpEL4xHuTB5Tw2hpaaohRpuIQOSjsOTTgf6z6lOjseS2CqZrRW7g9MOThZVw8kYi6iSYsJDQupWRk0bVMNvFcC16TondyIrnGCW6G16H13efrtryqO8d0lWrJfE/lN9ghxK3Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232876; c=relaxed/simple;
	bh=0HJvPMskz64iLjn658sJLzxp9W4oeojL4y/6CD2PAjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0dyUjff3mt4dJSyUJG5qAdqm+Y8q8V//FNHhSzxbw6u8zVv2ZfuVrQMOqraUxSqqUrv2BwitpUqZrY8ZgldTvAydGlz3Ut1yXJPr/dXEryP6CL3PHNw7feZk8qBJd5+hVYku6VdvuAEKITqfxGW7VhuVk9c7LZ+fv9H+PRnuKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc7yzXCV; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39380e79936so45113301fa.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779232873; cv=none;
        d=google.com; s=arc-20240605;
        b=TuAlCaD7i7xWbqGlwevEUItZZiCCcWmWQhlozJTPl960PoHjrghOHGCeq/DtDwkPGh
         XRhHqiRXjRJ7hkp93imY8XPTXmW0CoGTGZGWFDGmHhiVOYIU+IghzpIBdO2bklDesSHj
         f6CDElrIISzUGaovH6f8fgnj8unyrdS5uFHewSwn4yysntQEPzS83bNhCBfqAAGoZBAc
         dVsBM0rk0R8hSw4LujZno4VUgRu2KmMuglBeYKekeBmRnnYYZ4EdcQA/7P/StKkPI38z
         8hOZXlffgTX1r6GCdP+EByvq3HGXM9ShI8CzIlSW5A8kJwKuOyHmAcPRfjrQZbKkaXu2
         VFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtDS8H6/4LJAue06gEKQz2TXraZRCihB+Ehk4X15M/Q=;
        fh=eYE7xGYEYqRM1Jt04gPED3q8oa4AaLeo4N8pMKv60Qs=;
        b=O5GOl2pft+PFQlZASm+YZ2Bq0LZPl/LUeh6oWqX6UZyOwERwVzl8kotov6l4tU/oaa
         5e0MABjNkCJ/Cg8qEpKkmokIqyo8QUuyCOj1WIbaAg40jZDi7BpeK2hciS8bGwl/qvbL
         ACqsU0VklZaxEKe6W1MKLWm/YYj2mjKgD8/3CQl75ANgpn/NjrTJ6wZK9XTFfM7+L7OI
         plX1DkQJYt6GB8W+IJ1wP7UUDYDZe/XZl6wq7LHozs127WxCL6x8laOHgjV/yf/z3dIY
         syoCY31L4igSVdPQL9V88ziS84TdnbpHl78jt+BssI1GK2roXGPChUtdyz1s8ldVjHv+
         Bo4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232873; x=1779837673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtDS8H6/4LJAue06gEKQz2TXraZRCihB+Ehk4X15M/Q=;
        b=Nc7yzXCV/oU1PGv5K9KYQYZELZ5CGKjkoTio5DOY0bMop8Jeay3sb63oiJvwX5+cHO
         0TMg9zBzip8n1Q4XKlHGO/XoSJ+qq2+bVizoWF6yGtbmoCco18cqEYpKdeZPGSbMf7aP
         fv1Dzn38geGtGQ/QcDVE5lKrvUp88LU/+7HpH7TZvJfv5znYTqSCb9jwNQcuPsLp7qL0
         8QiJnNoZwr2peghyYMRlAsh3kRDIACDB3a5w5djw0DYzBlTaX8rI9s5tRdEbqZftnS7G
         zenW6v1XGQcFfK8lQS0mdlzvIx1Hstr/LYykI/mGTVLQsbV6NNPwP2oYD0MbIoqPqGHp
         ZK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232873; x=1779837673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtDS8H6/4LJAue06gEKQz2TXraZRCihB+Ehk4X15M/Q=;
        b=UwFs/VuvIc47pNV2KoGmJxntXLoxMWg3rjcP6k1ntswaRLy/R1Kay4ZtPRHj7AQb4r
         mCvnNRufmLb77oaH3J/EvCFOOPsutG/o+JL49Y79mAr5H2JYYNpbCTL5fYR8d6CQ0PYa
         WbuDOBPZnMnJW16+DA8ubC3oqoLkbjtfb1/8Z40tpNHLUzBvFD39ncvxcpClJcBBJSmV
         g0CTXhX2sXBmor0eu9Dqi/HUAvFKi6IY6kZdhc+SUdWSwSXg/odoImr9SPqyn5Hod7xI
         lo+PSo1eaijBMNrMnz+JjAI4tKlIZinOsXM3Dk+zAM93zA6cPEyq/JPvZ0LCD3dkTQj0
         G+Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+8qGMcF7G5wQ08B/XLV+EImTt427pdwK01Eq4AdvjqQ/izCBtXDf1glOuu8wZYClNwRWfWwKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2RtXEWKyWFP1H6/+VtupFL7G2ksKKI3mv6KTRTsam1IEc8hy
	rtEQuo5AR75D7A/ZQ+zOlzYa1mO8y0qpjt1JA70GbA5lqzbluklb958kYGDOs3983wdls/b8Z+A
	pjSmYSM3GRDUNhMS9HhWAtENCtf0inB4=
X-Gm-Gg: Acq92OHfoefmlu0UtKsQre9z3pqaOvaM53ux9Hvm+Sfm7RgIM+kE9w+5sTcdJ2LD4Rg
	qHAVYNvAFvCJ8h0aPWcxPL4lliUW0Y/F2Am1zyuNN+X7XTdPO3KdlDmcB94kKenvrcuCxUZZvH2
	9rnrqxtpK0xvW6/NwGaMyr7opAe9ZjcYA2b1NqL75nWNI7Jv0AeST3JIDIwxkDTvKgcr5EKNOWU
	dLdhxa535ls+01Sz9FSy8OJo80up+Rp3ddT29HsDXtXw7UTPWmWd+RTNTwBs9Hv8Q/67U7XWGdY
	zjqceKV7upv6f+mnL4MeXrKltlk4mi2otfPrCMw=
X-Received: by 2002:a05:6512:b07:b0:5a8:6e64:a932 with SMTP id
 2adb3069b0e04-5aa0e769bd1mr6901985e87.32.1779232872772; Tue, 19 May 2026
 16:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
 <20260517063311.28921-4-kerneljasonxing@gmail.com> <agzTbgnDCd9DkPOz@devvm7509.cco0.facebook.com>
In-Reply-To: <agzTbgnDCd9DkPOz@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 20 May 2026 07:20:34 +0800
X-Gm-Features: AVHnY4JEfXwtFT7bIRXYGiyd_zeLKnFWHRb69nrElUL_D-JJj9Wh5C0s79DQrL8
Message-ID: <CAL+tcoCWs+kor-Uxkbwb9q3+mW2Mtw7eEevUo51LqzdvPJx8NQ@mail.gmail.com>
Subject: Re: [PATCH net v3 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289652-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 15C29585F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:19=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 05/17, Jason Xing wrote:
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
> > budget for normal packets. This behavior roughly follows how xmit path
> > treats overflow packets previously: stop sending packets when detecting
> > the desc has problems. Here, it is stopped only when this group of desc=
s
> > from the same skb are completed.
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
> >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ebac60a3d8a1..8b51876efbed 100644
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
> > index 0a6203c42576..298194b7335e 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1016,6 +1016,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> >                       xs->tx->invalid_descs++;
> >               }
> >               xskq_cons_release(xs->tx);
>
> [..]
>
> > +             if (xp_mb_desc(desc))
> > +                     xs->drain_cont =3D true;
>
> Since you're gonna be addressing sashiko comment, should we also move thi=
s
> part to __xsk_generic_xmit? Right after err=3D0? Feels like having
> both true/false/check in the same function is a bit cleaner?

It makes sense. Thanks. Will do that:)

Thanks,
Jason

