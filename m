Return-Path: <netdev+bounces-253519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPpOJVSHd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:25:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBCF8A1B0
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E83A6300D17A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D533C1BD;
	Mon, 26 Jan 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="emoSN7AB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915C26E6F4
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441077; cv=pass; b=M3mRXBdhQtGZ3Gtx76m3vR2nq999eMTgsN3UztJge8a0NHFSuiFjE2mQSJA7yURjbT75PrkW1Sn0sJPVP7/VulULajntliZpDyFpNGKpYaMbHlFEHXez2BukdWmDCcjUCz3N5tKk7JlXjzgPVdQHmTmGgXxOINo0mieclNyjlp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441077; c=relaxed/simple;
	bh=AtkjgheHFRz232YeezgplcyAWxSNqThTBPDtNmqMFfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzAr3EFUOqNPGXWJVrpkALGMzZrX58dTjFL2l6oL/FKbzPMhslAMRwDsB/ALoatbqU4USK8M0OopxSXQs8gGDBNDdn7BXBvRKaf3GE+zXxDSlNnjpRsFvCJTUMjKNksSLaLC2BENf6aVmdbOGKR9z252tCIENI00gpIjOpk260o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=emoSN7AB; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09d981507so31171895ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 07:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769441074; cv=none;
        d=google.com; s=arc-20240605;
        b=jWAuZe3XacaOHuHaOORP5WoZQeBOywsK2f+atDqDaEodMqEiGSczHkayj6AshfwVX2
         BSBjrWKvG9Kc5eV/DQX8q7+6CUC2o39UzIDRao/ri83TJgQHHIXbtNI40GyPMsX4VyYO
         p4ZBgdXEF+I+QSeJ4oEnYh64XnlgW0lwrdsQroGLK2gpfr71TAl8iv/tqHl61iSY7wVI
         45sqdR5ta3Z2dIaqZ7CMShoOd4lFAjTV05HjfceB+agYUerA0xGB8B1VJNoATvAAgS2T
         /defVlPjxlHPCXwleLL2qryvu7cK8+zDYp4aNFcRT0aeOvEcgP4JEC130/TxDbLgC2zJ
         zjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EiVjxQGRao7xnd2E/gIJBKtFb7ROOiCEX8h6EN5f6qI=;
        fh=RMfgJZiZvXLhl24vC/GWoywQDZ2kyZf9xkGPQMvyiAI=;
        b=AEvahUOgeXegVsJ8xyOzogAAf5BV+PljtOQExHSxEwF7ywo6JgoNs37/slulwyApJ8
         1Yta4oaFANgRzKuz0X1HYZ4jfw4oX/JNqxpJZTItuW4TmUTnlj7tIKih7+NNfBp0dbAZ
         hBvzphcPCruzApA4Y26ybYZDRndQXC+39D91odFkkmZnBsaEH5zKtIMhWENIp8rW5CbO
         Ig5vfKpv26aXLogfdLgn5l792HVZlrQwraHCTUhhLER6WON1pCF0orQ5Wn4z371yA5nO
         U50rL1FG4cB1eTkDzLFlOdc0TnfXA5J7eZALy6hUlQNZK1587EefHtpOlxYkJ53vpKhH
         20PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769441074; x=1770045874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiVjxQGRao7xnd2E/gIJBKtFb7ROOiCEX8h6EN5f6qI=;
        b=emoSN7ABW40UJr4DvX7ql5B+wFbyO1zHU1ZW8eRTCVww5j8xm7Adjct0/KL2oKz5+M
         +rrLn+ZcVbsYeyZljO0nHObLxXAoAHcR3eLvlghukkllMcAgmS7LdlOPSp180NhdzJ9q
         fRFtQEQUFlmKRm1mq5NUYEIVvO077rBBy1bYTd2D7Z6aWRjSK/gMHGe6KbPCp2gehxBY
         3eAqQVkMvRISh3zC8EVpyZr1SNnAsYEYTMnC4PKbArWE44h37Zh8tAbIk683nffzTPyQ
         DYc4IgKbSC022NLz8DnfPLeK8cWQdIfoycztwLGsD/GU3o25RqiXDd8n3kKFLiyH4uWD
         CVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769441074; x=1770045874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EiVjxQGRao7xnd2E/gIJBKtFb7ROOiCEX8h6EN5f6qI=;
        b=W9oTAIQfyTjZPepnV3Ce2jZndwZq+jwQ/khfImfz9Qq6Q3Wk/vzzFs4wHYlVpK6r9q
         x3wm4s8OeH7bDn3os5NWgbkVKqQqTupgaxYd9o2rFJWUHXeBYtvokb2tI08XG7RcPscM
         y6JH22kBtLtc/+gOQSU27Vntk8WFC9v3zCb3zk1Ly+o6X87uKVpty0RVedCYLbabtBk/
         rV3KfE8UCuNU53RiwlpSbWp7xen8/UCZcfms3d9gt+qnl/BadE/RMid242aWpOia0s3u
         uGVAFxPrKyu1GuWvKWnJ8U4P6t+rVMjhODpEGHMT1ChfVjysEJv5PdHnmiIMrEhL5wLR
         I/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhPJHV7YCLqvyHMZLp6YeVy6eTm00v7+YILOzUTfh04MFmVFIFkVok43vnyVDSfaowyXeiWnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UeZiVVVJRF46gk9OC/RvsvQPcId8v950U48/7PSv2Q2pRQMu
	fqFSluXujgujpB3abaB5xaFmEJCsvGlEXAVuj+MCj5kz0wgKIHuGgNgviXrUI5UlgHQVRaR+MkS
	IwQ0uT4yyiLJnWCGXg6LxicVc5De6GEbVFKRQueIA
X-Gm-Gg: AZuq6aIkzNOaQ1ZTbepdVvm6wd3Kq9Ss3gm8lVMBNvB7TDC1xlNwZR7hnMI8MBv4uvg
	dC4YKf+LLj/TnqhaGc+IeVZzi/DWiMTOa8c9PF/8aNVckS15a8fVf56AsuaucXihi3J5BqmOs5v
	5oaqjSFxFSHpjaeUO/ZdfVyrOF9VZzH5O3AitEj2ZHU9o5sKx6MtEgL9QBT9sQAADVguDm58VH7
	9/vkr9LUQ2l+oQQuc6uq9cTsYy2erGBCpuMyYaLQAe6TVQZGahWlPFiAJ/FzT7ZHrWh1OpdP/SA
	PYU=
X-Received: by 2002:a17:902:c94d:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-2a845502f26mr47537115ad.13.1769441074384; Mon, 26 Jan 2026
 07:24:34 -0800 (PST)
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
 <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com>
 <CAM0EoMm49+9j77Xpb46Q7qVT7JBU2cXKZB-Oeurzsuoe-=3eJw@mail.gmail.com> <CANn89iL1oB2J6whubYof+2AVWpWRm+gBsp3P8-xRP8Y22Jy6_w@mail.gmail.com>
In-Reply-To: <CANn89iL1oB2J6whubYof+2AVWpWRm+gBsp3P8-xRP8Y22Jy6_w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Jan 2026 10:24:22 -0500
X-Gm-Features: AZwV_QhrUNfMJfwZN64jDviP85j-RotZAo_DAlEWkNx6IccB0YCddDfKfX1-dgs
Message-ID: <CAM0EoMnwGW05yc50ZyoKE28F-jZHeEtX+X4H2Xx6+KBQn-v6DQ@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: Eric Dumazet <edumazet@google.com>
Cc: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>, davem@davemloft.net, 
	jiri@resnulli.us, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253519-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,resnulli.us,kernel.org,vger.kernel.org,redhat.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email,vadai.me:email]
X-Rspamd-Queue-Id: 0CBCF8A1B0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 9:11=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 26, 2026 at 2:51=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Jan 26, 2026 at 7:26=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 1:11=E2=80=AFPM =EA=B9=80=EA=B0=95=EB=AF=BC <=
km.kim1503@gmail.com> wrote:
> > > >
> > > > I propose the following patch and would appreciate your review.
> > > >
> > > > hoff is used as an offset argument to skb_header_pointer() in
> > > > u32_classify(), and negative values can cause out-of-bounds read. A=
s
> > > > shown in the code below, offoff follows the same pattern and requir=
es
> > > > the same validation.
> > > > ```
> > > > TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
> > > >    const struct tcf_proto *tp,
> > > >    struct tcf_result *res)
> > > > {
> > > > ...
> > > > if (n) {
> > > > ...
> > > > if (n->sel.flags & (TC_U32_OFFSET | TC_U32_VAROFFSET)) {
> > > > off2 =3D n->sel.off + 3;
> > > > if (n->sel.flags & TC_U32_VAROFFSET) {
> > > > __be16 *data, hdata;
> > > >
> > > > data =3D skb_header_pointer(skb,
> > > >   off + n->sel.offoff,
> > > >   2, &hdata);
> > > > if (!data)
> > > > goto out;
> > > > off2 +=3D ntohs(n->sel.offmask & *data) >>
> > > > n->sel.offshift;
> > > > }
> > > > off2 &=3D ~3;
> > > > }
> > > > ...
> > > > }
> > > > ...
> > > > }
> > > > ```
> > > > Therefore, I propose a patch that rejects negative hoff and offoff
> > > > values during u32 classifier configuration.
> > > >
> > > > --- a/net/sched/cls_u32.c
> > > > +++ b/net/sched/cls_u32.c
> > > > @@ -1104,6 +1104,11 @@ static int u32_change(struct net *net, struc=
t
> > > > sk_buff *in_skb,
> > > >   err =3D -EINVAL;
> > > >   goto erridr;
> > > >   }
> > > > +
> > > > + if (s->hoff < 0 || s->offoff < 0) {
> > > > + err =3D -EINVAL;
> > > > + goto erridr;
> > > > + }
> > > >
> > >
> > > Negative values are valid, it is ok to access data between skb->head
> > > and skb->data.
> >
> > Right. We have to do this at runtime in classify().
> > Can you test with your POC with Eric's suggested fix?
> >
> > Eric, can we do something like pedit? See: offset_valid() usage
>
>
> Yes, it seems net/sched/act_pedit.c had a similar issue in the past :)
>  Amir fixed it with
>
> commit 95c2027bfeda21a28eb245121e6a249f38d0788e
> Author: Amir Vadai <amir@vadai.me>
> Date:   Mon Nov 28 12:56:40 2016 +0200
>
>     net/sched: pedit: make sure that offset is valid
>
>     Add a validation function to make sure offset is valid:
>     1. Not below skb head (could happen when offset is negative).
>     2. Validate both 'offset' and 'at'.
>
>     Signed-off-by: Amir Vadai <amir@vadai.me>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

=EA=B9=80=EA=B0=95=EB=AF=BC,
Are you able to send a similar patch? Otherwise one of us will.

cheers,
jamal

