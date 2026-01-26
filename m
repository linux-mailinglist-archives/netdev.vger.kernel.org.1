Return-Path: <netdev+bounces-253489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ErUJpNyd2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:56:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47B892C9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45FE43079D42
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B033A6FF;
	Mon, 26 Jan 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AAlUKS45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD701F2380
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435470; cv=pass; b=kYk/C8jd2dfDAtJ9KjqasldUdWaWSWxOL2RyrOEPxsiyCjkrDBcLjYuPS/tHpxOeOD2OTzpVtDlzD/6WJkmaNcLmsAc8OugJlFvlnYQLko90utbTPR2NAGNpZH8tRCkKC0rwOO2lVE+spNuY7qMm3uR8oHT2YT0TR+Y+Flpw5eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435470; c=relaxed/simple;
	bh=rqpqdgIRhNOFoUIcjikZjqtl10dj1sqXrOg7rpFUh/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC5kyYewP+08cwuMK+l+Y4TbkvfRBDPj3JcPvYzT7ctRXtwRwVlUDYlIlJr5AbKO1z/WktBNy7iIkvcrh0wH8D164+3hYhSAnVvyoh/o/FaEFsokgiMyWjqUEX8OuzKSaRkF/nnBIDNQ/gq85zPc3uncOcKH5q3bMw+0+IZGRUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AAlUKS45; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso2582533a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 05:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769435469; cv=none;
        d=google.com; s=arc-20240605;
        b=U5Z22dihrAFENiQBvJKHh0YiHRukEGS4LwiXhhR/xvLvhKkZ5iE61hXJ3sbrTsmYrl
         Yq3TpujAZtPm5Ig4EMMonBLb99UwVoNvKw+1lwnB0r63IqpDxJZnBQ0R4ygPL6L4vfJZ
         ldVdPH0J7u7ZAZ6OzGbhQpWW0hLjROExXPZn/Xp10Ypx7Mk6jB3RDjKBr8fPjMbEWbB2
         cN/dWCxb2zg+CZCuX53rCUnfZcgt2ItmmgD0tXMeFNYmsFydqdYgVpizj+uJVmpGA7A6
         OZyGDLL4qxmqRLgiuzxhCNeOjzsUFBzznJl8SYqw3WxW8hJfJTVjFpjNJoka/jczZeLj
         RyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NTQcfeK2JukcHMzbGTCcT8d3dgggjupy8UzqKBL80Vw=;
        fh=HJxJUgJ6S53XZW6bRkYM5TxIBBuJQL0KTPJ4py8OoTo=;
        b=TyzBzwxAY5lGZTBlwNHha6Kz5vRkfiCtI2nezh1+995DdWIVRzVykzo1g1wEZJyroA
         4KlYIsYdOarzAAr237OG7UMd9tpg90zoQy0ah9+hvaHHagokbFC7ioJhotxGPfEfvOLg
         fOUph+TlLAW11SNC5kKbwoAzvdZsTnETaPksCeVABG28L8O8ZxKSG/wUc/+8cpGK496H
         VYjdQrZwCqYtf7+TFIFnCSe7K/6xbLeRGJw/NSa6fF/nn9YDuM1kVWABc0E0kFGNnltd
         BcsRVbKz6Duq6rGgVAIT2i+3j6qUCKlmlbbmevcnpa69aq5vhpVJM0gm5+Sn4/+GoGG8
         DwuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769435469; x=1770040269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTQcfeK2JukcHMzbGTCcT8d3dgggjupy8UzqKBL80Vw=;
        b=AAlUKS450yT1/4en88KqJAdFWXb4kiYDm2vD1kInhjMxhx3aO62b+o/38rg9awuAuL
         0n8Ac/qpueZ08LBeO+kmDtxPw1tn1OcWuyfl/rJ8SgCwV35EPkYsX3yi6qs5paPfqbK7
         4eSA/5YuUqRYFZfSZ0whlvCeP9XYBoNYKG2xdNWPpIN6uhECQoOzidipfw7IOkWc84Z6
         Gwjnyp6s9Dng6ECGWRsGT/ohQKx3mfuHAZuTVWoE5q/ctgCY/iSWqpjvTT5T+8Tqv+vJ
         2Qprq0ghACZqCnzdLmYUwM5rKqCIZdnZA0ism7gMkcchGIrq7kqTEE6tgXtfygI8+wKz
         EdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769435469; x=1770040269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTQcfeK2JukcHMzbGTCcT8d3dgggjupy8UzqKBL80Vw=;
        b=w1t6ZggG9EJrPPalTs1Hdg9r0bE4J6iveqfl2lcfoywIGZTZQDJF20LLrhhq8qCamU
         92Vx1McURQnbQmGkHgTVM+1snoBkHpuvLHnMby1sjTJ2++2K24aAQurjSd8X8feSdvQJ
         Hl8qouv/rmD9ZBD1HJkdvtyO4AB03o8YDNBPB7cp+tey7Ax2yTYTIKf7fYO7IBQ82tjv
         mDnUMVOXJWAJPewFvge6tyFwOAFwLw52Yv1wC00uqelC+l1zNydUogFnGhDvOWGVWLcl
         jBwApCz6xowZFoWyWlz7f46go3xMizFEE7Q3vw1AITHhz/Jqm795Id8HV099Eq8gQjkI
         Ltbg==
X-Forwarded-Encrypted: i=1; AJvYcCUAYR3YAYDPlQLCqx99dg8GP+nygVEKUZw0XE/4TLskL9f2ru4ezBHeSV3ulr6zl4Zsnuh1kRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDO6a09d77l9aGAiBGXY/XghhWMqNRehbH6LXZjiQQTmTaHaR5
	iniB6gTFzfMwDGzv5tUgRH4FHRKWuxAs/y59lI3LWrbxzWXP2+t3Re1IF79b3NbGlvFxHUNFO8W
	mO9Ht32+JT4OLDFxvgInWhQaKwVkFx91T5OIr9qEx
X-Gm-Gg: AZuq6aJYJ7+wtcQqU7YogA3BLz96EPTE67fKVrLVd20zLcTGNJP2ua4QXoZI6fazwde
	CHdhpOsjrHUc9djjxk7sklSihhciZJBERNzTwz3AHBEsHhw3W9/3BcK5u+GlNCiARZvvin9jzL3
	AuC4xvhMXkHM8lyuuZtRQLuAVR+NmVX+htuZf+7Sy40Hzn15WMtDTOtvtlZXFi0h9n7Xv6KoDHn
	a+Wp/GA4srtasZrvQ8uV7tW9vnEa/V6mTJtHcaQ+wEG5bzzTm8vFkvZS/o1g/7P9KTCSQzKK59C
	ejE=
X-Received: by 2002:a17:90b:534e:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-353c458fe52mr3665842a91.3.1769435468514; Mon, 26 Jan 2026
 05:51:08 -0800 (PST)
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
 <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com> <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com>
In-Reply-To: <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Jan 2026 08:50:57 -0500
X-Gm-Features: AZwV_Qi5_QgjDQPQ6IB1PuXgW9OHYb_V2eZZdKxdMsMv2OZTw011MA7aNXhUpDc
Message-ID: <CAM0EoMm49+9j77Xpb46Q7qVT7JBU2cXKZB-Oeurzsuoe-=3eJw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253489-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: EC47B892C9
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 26, 2026 at 1:11=E2=80=AFPM =EA=B9=80=EA=B0=95=EB=AF=BC <km.k=
im1503@gmail.com> wrote:
> >
> > I propose the following patch and would appreciate your review.
> >
> > hoff is used as an offset argument to skb_header_pointer() in
> > u32_classify(), and negative values can cause out-of-bounds read. As
> > shown in the code below, offoff follows the same pattern and requires
> > the same validation.
> > ```
> > TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
> >    const struct tcf_proto *tp,
> >    struct tcf_result *res)
> > {
> > ...
> > if (n) {
> > ...
> > if (n->sel.flags & (TC_U32_OFFSET | TC_U32_VAROFFSET)) {
> > off2 =3D n->sel.off + 3;
> > if (n->sel.flags & TC_U32_VAROFFSET) {
> > __be16 *data, hdata;
> >
> > data =3D skb_header_pointer(skb,
> >   off + n->sel.offoff,
> >   2, &hdata);
> > if (!data)
> > goto out;
> > off2 +=3D ntohs(n->sel.offmask & *data) >>
> > n->sel.offshift;
> > }
> > off2 &=3D ~3;
> > }
> > ...
> > }
> > ...
> > }
> > ```
> > Therefore, I propose a patch that rejects negative hoff and offoff
> > values during u32 classifier configuration.
> >
> > --- a/net/sched/cls_u32.c
> > +++ b/net/sched/cls_u32.c
> > @@ -1104,6 +1104,11 @@ static int u32_change(struct net *net, struct
> > sk_buff *in_skb,
> >   err =3D -EINVAL;
> >   goto erridr;
> >   }
> > +
> > + if (s->hoff < 0 || s->offoff < 0) {
> > + err =3D -EINVAL;
> > + goto erridr;
> > + }
> >
>
> Negative values are valid, it is ok to access data between skb->head
> and skb->data.

Right. We have to do this at runtime in classify().
Can you test with your POC with Eric's suggested fix?

Eric, can we do something like pedit? See: offset_valid() usage

Sample config using negative values:
#dst MAC starts at -14
#src MAC at -8
#ethertype at -2
#
#matches: #src MAC address 00:ff:07:e7:29:47 dst MAC 00:ff:07:e7:29:44
tc filter add dev dummy0 parent ffff: protocol ip prio 10 u32 \
match u16 0x00FF 0xffff at -14 \
match u32 0x07E72944 0xffffffff at -12 \
match u32 0x00FF07E7 0xffffffff at -8 \
match u16 0x2947 0xffff at -4 \
flowid 1:12 \
action ok
#

#to display
tc -s filter show parent ffff: dev dummy0


cheers,
jamal

