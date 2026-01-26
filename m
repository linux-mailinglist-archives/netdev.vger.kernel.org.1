Return-Path: <netdev+bounces-253496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGavEvx1d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:11:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A108956A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28A5330066A5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8F33C518;
	Mon, 26 Jan 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkfJ9WkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704233C506
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436664; cv=pass; b=Gpr+Z8+L65/9QngOESd7Orq/vVaXQUzxisgVX07/kNBwB1mvkpn3Y7gP/gkKd+NEhZtyRCkOnXz4qbzVHzmDOxRgkhyRQjtm7wNmnh2NotP6z9anvc1t9hHPW5zfe0NA+c/uL++GXsvOix3rb+7qreEJXITfGzMieOGFxcANNpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436664; c=relaxed/simple;
	bh=AtxhUAc3l/dal278H5dpvKcmKwbKoTNVyn4v0BLuTJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObiTwPfkb4NvaFfHBkjXN1U0FcQYa4K7AdDFh0Lx/v7augHLB1JMzd35brjIr4qicTSxViblEhHOylAEF4+Ep6d6wYviqUUGBC6NRbNBg0i6+SEEXjkEyL4KfAjaS8nBOcPYRqDcOqQhqbPwX5qFFbr4AuoCH22do7MpAMBE9aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VkfJ9WkL; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014b7de222so55180981cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:11:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769436661; cv=none;
        d=google.com; s=arc-20240605;
        b=JeHhYXAZdz81J9I8SKbaR8nxhFzpwBqZyDy9gr1togKc+Xwk1Dz37+yW+GZMqNCGBA
         5Q/cPpWWCT7jg/0w+tTsAxxWpWtqjfaaAge9nkrBY9zbn0t7iM/P4YTQc/detSBgm3gE
         wRe9EEfnkXotEfa99IySAgNhVSaqAUzPHo3aBtPFFbUJ11ui0Fxlti9wV8FWBrYT/gKX
         7GEobck1lqeo81oFD2irJHtFP2LqEIpztEexRE4XZV3KKQwh3tfbhcQfo9z10cHee7ml
         ggOgU++XQsQZinRf7Gb1ycuwcXqsdlOmE69s5MHCptu5kMhXn/zxuHDNSHUaIvAyehy/
         TdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f3Mcy5Bqouf/EGUDxL3OkdKhwSto/FPouOtah6mo5ao=;
        fh=n1PXiSVBUoxYqjaN4txACjyrgIC6NHb3jIhhjTfvG+M=;
        b=BMTR30178+J00WuzH0Nf5uctm8S2TiwJW2DtGriQHx9d8ESp3hKmERKy8lMoh32LUP
         oo+rZJHz1MqkIQFsh7mJrCO2lZ1mH62/QhONuPhke/RORm3KS7O9bq/h6Z4n+/or/MDy
         ZSjoRZM2JAa+g4fhu71voF8+kw+g7+v7OY6Y0Jy6hyllWAfqAU0SWu4Z+7J7FaRvwJuR
         oJWxQaqr0xi07Nu85lAeMi1FIX2oIbtHcg5wMCo5xcZZRQ6LAb7wk1FQTDePBsBzzNVC
         /H/ASxghGXcPObsSjwopHoLoq9dYsirdba2Q+D7UfPtpjP0Q+nY4ivmPJNSVKPHnZ3h7
         IrHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769436661; x=1770041461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3Mcy5Bqouf/EGUDxL3OkdKhwSto/FPouOtah6mo5ao=;
        b=VkfJ9WkLTz9OYkfLJ6tti8UDuQbUjqxjguCLjoq2pTgEllgTAwo6kd5dcOusZqDAnG
         pUSyhoYZ/LXdf5cqSMigeemU6jn7oHOwJnkZYPOY5BFafn/jJE1tX00KIpnbUQD+QMpT
         8Q7p6Pdzbp2Igi6LhJorr67BsCVCHgNiqrEFaWSzAuhfrw/DrMIUHmPmr2Oty65SObPf
         l1uvZtqsEPI6Qis+MprE0hvwN7ToBbVw/aoroBwMlqd4GXth1CcAlcMNFdcMM32n1LAb
         kQ70QLufXVtWfapqmv6bgoEhIb+DACpo9KAXb7e9t1sa2gAbmrbmlGwCd1Jfz8pInwr1
         NAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769436661; x=1770041461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3Mcy5Bqouf/EGUDxL3OkdKhwSto/FPouOtah6mo5ao=;
        b=pNgfrO7wRYWPNyc8Igzg/rBvHFN+Zb9bavqnXkcrx3nqTXs8aJT2o+RhypQDDm/1De
         cj5xuUOyqGcpa3pdO2potBB2JJ0oIXh5wGnsR8ovHk8nak4PDdAQlGSmChrT3ezA2VAi
         Q0CaKbhRMGd03dJvwtODkh1S2uydG1Ox0KjmnhY9msW3v4mneBvFi8oAseBdlnA7L6z3
         N5/4vz9bAHyY5eCZ6t57ooJM8MWQYuyMngqYWw8pAuz2u8dtFutXU2f5WWjM0Dofsq2W
         f0y49iyqbDdMPL1HcrExNLX33T/yYHfdK0Kf2/SI/x/aJiThs8jCVwyn2PF0OqFi7ftF
         PlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzt1m06cEWqkYGegajOjrAZ/8+mGcfgtke9huFqj+v3TI7sdoOMCAA/IrMCD9pytwkFNMu9cY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrp6q7/FNkGC254FtMGdjARIFKNFBcMrBydAbTVq920UgLiKH1
	4T9kz3+lacsK/qEpAL5QhNKzA9qifkazuOWCKsdq+BXQ0YPCTaTuE6ARjhfk+WpvieAbHWpqFQo
	9jI/4MJxU5e6Vt8nOKEQPE3YuLAtG0NW3wbvRWDjo
X-Gm-Gg: AZuq6aKEoH0eiZtYCP70Ml0Ap28ZlEGklsx4BvbX+ne8wXU61oa+lSLv4PSSPfv7QF4
	andpxGTxMC6AAYsKDXxg+RgcS2NbmZndnTvc35H8nOFeJEh9aztw5cxGqFD+AgG97exX86ZOKTq
	ajJtOWE5JQ4qz2ID2MzOd9kl+pfpScWdIFFvzzgcJ+AIWhWEmcYcoVlhi6UZbKplI8SnSg1bU1M
	SePvM1Rq5AqDdixedoOgRH653bKEi8Cn5WhLxgl6fa2GVa/OosydrI9nK9OI0Bt9DDRLA==
X-Received: by 2002:ac8:5a84:0:b0:4f1:dfc8:50b with SMTP id
 d75a77b69052e-50314ced815mr60372491cf.76.1769436661203; Mon, 26 Jan 2026
 06:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
 <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
 <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com>
 <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com>
 <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com> <CAM0EoMm49+9j77Xpb46Q7qVT7JBU2cXKZB-Oeurzsuoe-=3eJw@mail.gmail.com>
In-Reply-To: <CAM0EoMm49+9j77Xpb46Q7qVT7JBU2cXKZB-Oeurzsuoe-=3eJw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 15:10:50 +0100
X-Gm-Features: AZwV_QicRi10DQEIPDeaJrOKSFTAV4djTgGC_N2eoPezCFUeHgX9xy0TS11I9Oo
Message-ID: <CANn89iL1oB2J6whubYof+2AVWpWRm+gBsp3P8-xRP8Y22Jy6_w@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>, davem@davemloft.net, 
	jiri@resnulli.us, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,resnulli.us,kernel.org,vger.kernel.org,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-253496-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vadai.me:email]
X-Rspamd-Queue-Id: D8A108956A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 2:51=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Jan 26, 2026 at 7:26=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Jan 26, 2026 at 1:11=E2=80=AFPM =EA=B9=80=EA=B0=95=EB=AF=BC <km=
.kim1503@gmail.com> wrote:
> > >
> > > I propose the following patch and would appreciate your review.
> > >
> > > hoff is used as an offset argument to skb_header_pointer() in
> > > u32_classify(), and negative values can cause out-of-bounds read. As
> > > shown in the code below, offoff follows the same pattern and requires
> > > the same validation.
> > > ```
> > > TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
> > >    const struct tcf_proto *tp,
> > >    struct tcf_result *res)
> > > {
> > > ...
> > > if (n) {
> > > ...
> > > if (n->sel.flags & (TC_U32_OFFSET | TC_U32_VAROFFSET)) {
> > > off2 =3D n->sel.off + 3;
> > > if (n->sel.flags & TC_U32_VAROFFSET) {
> > > __be16 *data, hdata;
> > >
> > > data =3D skb_header_pointer(skb,
> > >   off + n->sel.offoff,
> > >   2, &hdata);
> > > if (!data)
> > > goto out;
> > > off2 +=3D ntohs(n->sel.offmask & *data) >>
> > > n->sel.offshift;
> > > }
> > > off2 &=3D ~3;
> > > }
> > > ...
> > > }
> > > ...
> > > }
> > > ```
> > > Therefore, I propose a patch that rejects negative hoff and offoff
> > > values during u32 classifier configuration.
> > >
> > > --- a/net/sched/cls_u32.c
> > > +++ b/net/sched/cls_u32.c
> > > @@ -1104,6 +1104,11 @@ static int u32_change(struct net *net, struct
> > > sk_buff *in_skb,
> > >   err =3D -EINVAL;
> > >   goto erridr;
> > >   }
> > > +
> > > + if (s->hoff < 0 || s->offoff < 0) {
> > > + err =3D -EINVAL;
> > > + goto erridr;
> > > + }
> > >
> >
> > Negative values are valid, it is ok to access data between skb->head
> > and skb->data.
>
> Right. We have to do this at runtime in classify().
> Can you test with your POC with Eric's suggested fix?
>
> Eric, can we do something like pedit? See: offset_valid() usage


Yes, it seems net/sched/act_pedit.c had a similar issue in the past :)
 Amir fixed it with

commit 95c2027bfeda21a28eb245121e6a249f38d0788e
Author: Amir Vadai <amir@vadai.me>
Date:   Mon Nov 28 12:56:40 2016 +0200

    net/sched: pedit: make sure that offset is valid

    Add a validation function to make sure offset is valid:
    1. Not below skb head (could happen when offset is negative).
    2. Validate both 'offset' and 'at'.

    Signed-off-by: Amir Vadai <amir@vadai.me>
    Signed-off-by: David S. Miller <davem@davemloft.net>

