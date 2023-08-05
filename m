Return-Path: <netdev+bounces-24651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBCA770F30
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3821C20ABD
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CA8F41;
	Sat,  5 Aug 2023 10:09:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89423A2
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 10:09:43 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05274E57
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 03:09:42 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso102141cf.1
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691230181; x=1691834981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDjRtvEloyEdkDVkbudwty5ahRw+nCEFsqsZ8rwVoZo=;
        b=BiCBf+rSpyRhYQPBGJy21yX2ynmucFCgbW8HMx3sZG4/Pl6Auj4hDNe3+kF3/JFtZY
         CIMRVN2w6AICq2boQ5kd5z5jQE+4mUAi92JP3K13nCmZGJ/tjVmO+8UmNcVmekooruW1
         svyVERP8lVfGSMLpm54MkV2soJt1XS7UggqsNtIQzj659YsISys8yXji/WT7mT79wsAG
         R5YJG6V4FWvwPgnMXtrtG8QRiyp7lfqr9qbOg5upZj6PXtKYD1jbHBe5Qi4GIleAw2Wc
         pZsdem5LqOPQEh4ltk6RMhsYk3siEpivVjdeIseGgNncF68BY3oHUyNFwvT5yhw7WKsu
         dqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691230181; x=1691834981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDjRtvEloyEdkDVkbudwty5ahRw+nCEFsqsZ8rwVoZo=;
        b=RcOyUwB6+GrkwdssqQZr1F4pzaff1NR/srpndzP3OrL1juQhUAgrRy7KkQwKPy896m
         xHYuqtULoJzcmqwkHYRhQuxE+VQ9XaXFCJlkR6s2ENF1UK3ffFsYaWYJ5qVpy0V1QeLv
         4wMJjICRnDcRwv/xCV8XPByh1CNGq8xmBvcKVexaDNlQxdZ5TEHNT66kRRbSRIdJG/oV
         0ab5ij8hpzrAShrAZwK3YbsD9qU7MsDYcbYX3mm7kJY+NLp6kJxdBoG3iRommG+N8VZP
         j68Ih49NTjMh8Tmjb/r81+zT3cDOsFRaGUSALkJagLKzvTGDcLI9ASYiFmqjJ/bgrgBd
         CWNA==
X-Gm-Message-State: AOJu0YyTX3At2Hx3U1cRJppMK7gUIsTVEVP3h4i+b/LhOKNs5wnpX911
	nBUWbEn549/yDyO5o1EcwY0doysC3ZNXl0dUX0dNSA==
X-Google-Smtp-Source: AGHT+IGrJxc1S139CuWXNSvASbDnQs9AOxwSWGN8IwbRWW7P/YGWd9WmcXM1ft3msdrPVvry8GacNUQgAxosBCa/MJs=
X-Received: by 2002:ac8:5acc:0:b0:403:e924:49cc with SMTP id
 d12-20020ac85acc000000b00403e92449ccmr128067qtd.25.1691230180957; Sat, 05 Aug
 2023 03:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
 <d1b1c0cc-c542-e626-9f35-8ad0dabb56b0@kernel.org> <CANP3RGcTAjkPsFgqyeW5Tp9EJT-SrBX2CGVB7Zavkt6sKRKUOg@mail.gmail.com>
 <b9336a67-c337-ae86-2604-81368dcdfbac@bernat.ch>
In-Reply-To: <b9336a67-c337-ae86-2604-81368dcdfbac@bernat.ch>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 5 Aug 2023 12:09:08 +0200
Message-ID: <CANP3RGfpY28TQmzr=yBAS9qt3Tq9=cmjmj8j_gWzau0nb8VaQQ@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Vincent Bernat <vincent@bernat.ch>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Linux NetDev <netdev@vger.kernel.org>, Pengtao He <hepengtao@xiaomi.com>, 
	Willem Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@google.com>, Xiao Ma <xiaom@google.com>, 
	Patrick Rohr <prohr@google.com>, Alexei Starovoitov <ast@kernel.org>, Dave Tucker <datucker@redhat.com>, 
	Marek Majkowski <marek@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 10:55=E2=80=AFAM Vincent Bernat <vincent@bernat.ch> =
wrote:
> On 2023-08-03 10:46, Maciej =C5=BBenczykowski wrote:
> > I think a fair number of these can get by with non-ETH_P_ALL (for
> > example ETH_P_LLDP), or can use a different socket for RX (where you ca=
n
> > choose to not see your own TX packets) and transmit via ETH_P_NONE (btw=
.
> > that constant should really exist and be equal to 0)
>
> For lldpd, I was using ETH_P_LLDP in the past, but there was cases where
> packets are not received, notably when an interface is enslaved by an
> Open vSwitch. See:
> https://github.com/lldpd/lldpd/commit/8b50be7f61ad20ebae15372a509f7e778da=
2cc6f
>
> This may have been fixed, but this kind of differences between ETH_P_ALL
> and ETH_P_LLDP makes it difficult to trust ETH_P_LLDP to do the right
> thing as it will work for most people but a few edge cases may appear.

This *may* be fixed now - or may not - see what I wrote earlier,
as we (Google's host networking team for servers) ran into
(5+ years ago) somewhat similar problems with link local macs and
inactive bonding slaves...

However, it is still very much the case that ETH_P_ALL and ETH_P_X
hook in slightly different spots,
for example wrt. tc ingress bpf packet mangling...

Anyway, this lack of certainty, is really making me want to add a:
  int fd =3D socket(AF_PACKET, SOCK_RAW, ETH_P_ALL);
  be16 ethertype =3D htons(ETH_P_LLDP);
  setsockopt(fd, SOL_PACKET, PACKET_ETHERTYPE_FILTER, &ethertype, 2);
optimization/hint.

By not being a bpf filter, this would be easy to process prior to the
skb_clone...

You could of course ignore the failure of this setsockopt (thus
supporting older kernels),
and *still* attach a 4 instruction cbpf filtering on skb->protocol =3D=3D
htons(ETH_P_LLDP).

We could even declare that the api is a hint/optimization and not guarantee=
d to
fully filter things out...
For example we could use this hint to filter on TX but not on RX...
(ie. you still need the cbpf anyway to do guaranteed filtering just
like you did on older kernels).

This would also potentially fix the Android use case.
Split the socket into 3 sockets, attach PACKET_ETHERTYPE_FILTER of
appropriate type to each.
[though we'd want to go further and also add some u64 mask/value
filter at packet/mac/net offset X extra hint too]

*OR* we could try to not introduce an API for this at all, and instead
try to parse the first few instructions
of the cbpf program, detect some simple patterns, and use that to prefilter=
...

for example, if the cbpf filter begins with the 3 instructions
(writing from memory):
  LD H ABS SKF_NET_PROTOCOL // ie. A :=3D skb->protocol
  if (A =3D=3D ETH_P_LLDP) jump +1 // ie. skip next instruction
  ret 0 // ie. reject

then we could automatically set this 'extra' hook filter to only grab
skb->protocol =3D=3D ETH_P_LLDP...

I think the most common cases could probably be fixed by some pattern
matching on the first ~10 cbpf instructions.
I'd envision:
- match on ethertype
- match on ipv4 / ipv6 protocol
- match on udp/udplite/tcp/sctp/dccp source and/or destination port
(the above would I think be enough for Android)
and maybe:
- match on src and/or dst ip address

[note: there are some annoyances wrt. IPv4 options (and potentially
IPv6 extension headers) and matching on ports]

It would of course be pointless if we could get the bpf filter running
prior to the clone,
but that (at least to me) seems a *much* harder and open-ended problem.

But there are miracle workers among us :-)

