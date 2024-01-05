Return-Path: <netdev+bounces-61958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485A82556F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D910F284B26
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7C2DF66;
	Fri,  5 Jan 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gM+XkMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969E2D7AB
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso12036a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704465400; x=1705070200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4dBXo/6IDVd/d8fbs0I4/6iMCv+/NJlhDw4IK52x6Y=;
        b=4gM+XkMpfNZ/QnvtBvAQd6T6gbTmKELYjdGZH2GpGp50yAMBJa0BL/03vIJczxSVZa
         ojJ3k6xGRfzaHfwXwMgvPK2UnaNvR5n+ChnQYTj44wDa+qldB3YQah8ZTkz9uONuXweU
         KgRo9FunLYzaynzDGm5Xe5Sef9Vf4feQiT3jLSYTd50X7lwnMAhNkhl7DMpQiltuF/5J
         vd8r4FBRUSZG77VaqNicDLOTFSTQlvYNHd1YpzhpN+03a/6iH6zp4oKbbzAOxEnxDWsu
         DnYh9wmrY/4mN26ULejTwbJNz3T+X4CgE6hpTRD87gGomzGI798VO/++YP/KNWQ1+nHb
         wRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704465400; x=1705070200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4dBXo/6IDVd/d8fbs0I4/6iMCv+/NJlhDw4IK52x6Y=;
        b=hjWTBRMW5l/Jq46Km+f2zumOMyNz8zRtikYYVWJv48giizgReaRWSJ1R7WdsNtbQNt
         Mwq09J5qcfYNZDIEqDotvd7JHwh2NJbKaURNu1HfYGSdONUwICPfuBk5U3gYCNTnztZN
         OwmQ1pwk3Z3OVe1kK1zAw1GPriILTV8aYFsIPj40FlCeddvcaqiy3Yamc4OHz8VEsT3W
         Mc57/d0JXs/UiRD+7KFq9J7dmi8yoTYanUSi9Ro3AjJvLDpq3vq/4w48l56biQOmYX84
         Dv5dumU54oYleLRafvDq15KdAGpUUlPNOK+PjCgjrMKtNZVfBdaBbWcLFywid8trQ7NG
         1wxg==
X-Gm-Message-State: AOJu0YxrXQfaCaUR4XKrJbHJEUOjl26xLfW/GIHiZlMDhCRqFRJATzCf
	A7HUVbpphyAc9K52QBf9ad6r5ehsAh2GpjmvGMJZnYW210dK
X-Google-Smtp-Source: AGHT+IHT7QLwvw6kDusVQmBgHL0Oj17HpiYz2rEEwzJronaZDz8VOQrCUcW0pPb55GKHBS7klwih3qlQzE8+ch5I9AY=
X-Received: by 2002:a50:c35e:0:b0:553:ee95:2b4f with SMTP id
 q30-20020a50c35e000000b00553ee952b4fmr134595edb.3.1704465399594; Fri, 05 Jan
 2024 06:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org> <20240105113247.wml4ldq3abvizi2a@skbuf>
In-Reply-To: <20240105113247.wml4ldq3abvizi2a@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jan 2024 15:36:28 +0100
Message-ID: <CANn89i+FSNSF5JgXZcq5h-h2o5QhzOmRDc3q6XT7dcxMG-S20w@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Household Cang <canghousehold@aol.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 12:32=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Tue, Jan 02, 2024 at 09:34:25PM +0100, Linus Walleij wrote:
> > @@ -1143,39 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *=
netdev, struct sk_buff *skb,
> >       struct gmac_txdesc *txd;
> >       skb_frag_t *skb_frag;
> >       dma_addr_t mapping;
> > -     unsigned short mtu;
> >       void *buffer;
> > -     int ret;
> > -
> > -     mtu  =3D ETH_HLEN;
> > -     mtu +=3D netdev->mtu;
> > -     if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> > -             mtu +=3D VLAN_HLEN;
> >
> > +     /* TODO: implement proper TSO using MTU in word3 */
> >       word1 =3D skb->len;
> > -     word3 =3D SOF_BIT;
> > -
> > -     if (word1 > mtu) {
> > -             word1 |=3D TSS_MTU_ENABLE_BIT;
> > -             word3 |=3D mtu;
> > -     }
> > +     word3 =3D SOF_BIT | skb->len;
> >
> > -     if (skb->len >=3D ETH_FRAME_LEN) {
> > -             /* Hardware offloaded checksumming isn't working on frame=
s
> > -              * bigger than 1514 bytes. A hypothesis about this is tha=
t the
> > -              * checksum buffer is only 1518 bytes, so when the frames=
 get
> > -              * bigger they get truncated, or the last few bytes get
> > -              * overwritten by the FCS.
> > -              *
> > -              * Just use software checksumming and bypass on bigger fr=
ames.
> > -              */
> > -             if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > -                     ret =3D skb_checksum_help(skb);
> > -                     if (ret)
> > -                             return ret;
> > -             }
> > -             word1 |=3D TSS_BYPASS_BIT;
> > -     } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>
> So are you taking back the statement that "Hardware offloaded
> checksumming isn't working on frames bigger than 1514 bytes"?
>
> Have you increased the interface MTU beyond 1500, and tested with plain
> TCP (no DSA) on top of it? Who will provide the TCP checksum for them now=
?
>
> I don't understand why you remove the skb_checksum_help() call.
> It doesn't play nice with skb_is_gso() packets, agreed, but you removed
> the TSO netdev feature.

This TSO feature never possibly worked.

This was probably hidden because TCP retransmits non TSO packets eventually=
.

A TSO enabled driver must use/propagate skb_shinfo(skb)->gso_size
value to the TSO engine on the NIC.
Otherwise, this is absolutely broken.

Please look at my original suggestion. I think the plan is to try to
add back TSO in next release, with proper testing (ie not rely on TCP
resilience)

https://lore.kernel.org/netdev/CANn89iJLfxng1sYL5Zk0mknXpyYQPCp83m3KgD2KJ2_=
hKCpEUg@mail.gmail.com/

