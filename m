Return-Path: <netdev+bounces-58592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C329F817556
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB38283986
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F813D556;
	Mon, 18 Dec 2023 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VTUwr0Cm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166783A1B6
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28ba18740d6so446886a91.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702913719; x=1703518519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3odB7GvVfCpt6hAKkOq8Dzug7Y4DbAByO4D5CM2s3uc=;
        b=VTUwr0CmLTYYeHQUC9JoEMCQXvgo77zkhDFDg3PzluFU20nOAEIteT19aRQ0FQ0bXK
         af7cf1Fx4RQqypAN9AoId2sj8Fao1zMmW9NiAHQbA9zEvC0nLcqAoDIeykzo1wKbLR8f
         wRHqWo2sr2q6xR2GfE/88cOTbUWehNW2HAq4+sJELXm5yjH53+7eUDyv8RJbPM1TV+cO
         L8pEmNnYa0oN4L2JDmEjV8au/JrNTJreoYnqL+3dlKaBKd90LJAFUG1lih/4AhXIfyMi
         z/CepBfTiiC+SD/2TWE4mn+SRe9cS558xS0HK+YaXiQ0SKmnrGGII8ZGPwj2eXxZd7Vx
         BN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913719; x=1703518519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3odB7GvVfCpt6hAKkOq8Dzug7Y4DbAByO4D5CM2s3uc=;
        b=kiQaXMPqpe/s1bSFasnnZqPvIqm55wT9yxFkIT0RHWDF3+BtTK3mrsa0SuGJWvoH2g
         9e9qg2c7+5elNFH6emHdhDCltNfc1zZ13ObRblpU1p0Vni+irGB+ePHwLev2kgyqLvnL
         DzPfS/WnjVwZR/GcQa90nEsHzC1M2KfH/kpFECGcFIAcV09SR1aLoF5KwOssAZfBuR/g
         XfI0cIvHCXxlKrQQ1mvgju6vYU1+pMAfYgF2u5x05AqxdVIOs2EB6WlIO1jJbWGEJOz8
         l9C04d72G8gwed3q6km1lD49GnkBnl9N5yK0cHc2lyMuFmBFoB9b1mVOKu6hoyu+YV/q
         0mfQ==
X-Gm-Message-State: AOJu0YxcBJ87AZq7sp+X+UJH5ckOA1+HdzXxlT7e9GKHhd5T58r8xCfY
	sjj2mQKdOAH6JbNuy6ShTmv1gckoSRodLgxhRtTZkA==
X-Google-Smtp-Source: AGHT+IF9zvll8gtLQJeTHApkdcP9tE9zKBXC2J3Kql9IiJ/+HZPWL0Tz1UxW/WstUjmS318kSiD8CPTd90EaMWpoP4M=
X-Received: by 2002:a17:90a:2e8a:b0:28b:3504:713e with SMTP id
 r10-20020a17090a2e8a00b0028b3504713emr2526148pjd.70.1702913719313; Mon, 18
 Dec 2023 07:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215180827.3638838-1-victor@mojatatu.com> <ZYAHl3f4+scOdJYc@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZYAHl3f4+scOdJYc@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Mon, 18 Dec 2023 10:35:08 -0500
Message-ID: <CAAFAkD9nb1uRypAViV+OQ+M1NiFfO4DVozQb9U4UVD_K88OXBQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] net: sched: act_mirred: Extend the cpu
 mirred nest guard with an explicit loop ttl
To: Davide Caratti <dcaratti@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, mleitner@redhat.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:49=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> hello Victor, thanks for the patch!
>
> On Fri, Dec 15, 2023 at 03:08:27PM -0300, Victor Nogueira wrote:
> > As pointed out by Jamal in:
> > https://lore.kernel.org/netdev/CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUS=
ZYwkMOUJ4Lw@mail.gmail.com/
> >
> > Mirred is allowing for infinite loops in certain use cases, such as the
> > following:
> >
> > ----
> > sudo ip netns add p4node
> > sudo ip link add p4port0 address 10:00:00:01:AA:BB type veth peer \
> >    port0 address 10:00:00:02:AA:BB
> >
> > sudo ip link set dev port0 netns p4node
> > sudo ip a add 10.0.0.1/24 dev p4port0
> > sudo ip neigh add 10.0.0.2 dev p4port0 lladdr 10:00:00:02:aa:bb
> > sudo ip netns exec p4node ip a add 10.0.0.2/24 dev port0
> > sudo ip netns exec p4node ip l set dev port0 up
> > sudo ip l set dev p4port0 up
> > sudo ip netns exec p4node tc qdisc add dev port0 clsact
> > sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip \
> >    prio 10 matchall action mirred ingress redirect dev port0
> >
> > ping -I p4port0 10.0.0.2 -c 1
> > -----
> >
> > To solve this, we reintroduced a ttl variable attached to the skb (in
> > struct tc_skb_cb) which will prevent infinite loops for use cases such =
as
> > the one described above.
> >
> > The nest per cpu variable (tcf_mirred_nest_level) is now only used for
> > detecting whether we should call netif_rx or netif_receive_skb when
> > sending the packet to ingress.
>
> looks good to me. Do you think it's worth setting an initial value (0, AF=
AIU)
> for tc_skb_cb(skb)->ttl inside tc_run() ?
>

Good point but I am afraid that will reset the loop counter (imagine
ingress->ingress, egress->ingress etc). So it wont work. Unfortunately
we've hit a snag with cb because it is shared across multiple layers.
I am afraid we cant ignore it.
If the packet came downward from some upper layer (or driver, buggy
mostly) using the same ttl spot in the cb, then the ttl field will be
either 0 or > 0.
1) 0 < ttl < 4 then we will interpret it as "packet has looped before"
and we wont drop it, so we are good here and we will end up dropping
it later in one or more loop.
2) If the retrieved ttl is >=3D4 we will immediately drop it. This is
catastrophic because we cant stop ipv4 or esp from using this field to
their pleasure and they certainly dont reset these fields.

I dont see a way out unless we extend the skb->tc_at_ingress to be to
2 bits as it was originally. In the original code it was called we had
SET_TC_AT() which set two bits to in the skb->verdict to say "this
packet was last seen at ingress/egress/elsewhere". Elsewhere was a 0
and this got changed to a boolean which translates to "this packet was
last seen at ingress/egress". So if it came from a freshly allocated
skb eg from driver or if it came from the stack it will be 0 (since
the field is reserved for tc).

+Cc Florian.

cheers,
jamal

> other than this,
>
> Acked-by: Davide Caratti <dcaratti@redhat.com>
>

