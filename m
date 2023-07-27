Return-Path: <netdev+bounces-21843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16157764FD4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BBC282217
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0310797;
	Thu, 27 Jul 2023 09:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF42FBF9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:31:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741529012
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690450249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qh+q07rt8r6bDYqg41H3ezz9L7B6DNPwkct/izi2KJE=;
	b=gr0OhK94/YkLtt7Ockv4cjxdroFUnnEuglRIVrN7poI+w/Rf18xktSomkPJw61P//sciJL
	8HuGRKzewsdLXbQoiVkPZqIbFDnd4YwUkhbeYzdLtN6Bi36rbg4VJHFl10IvulVarMpHsv
	8B1Z2RLZdzjZxiKh7rfJXt+kPmqVPiM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-EzX3W44zPOOhTNBSj0-zNQ-1; Thu, 27 Jul 2023 05:30:48 -0400
X-MC-Unique: EzX3W44zPOOhTNBSj0-zNQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767edbf73cbso17470985a.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690450247; x=1691055047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qh+q07rt8r6bDYqg41H3ezz9L7B6DNPwkct/izi2KJE=;
        b=b8wWOoFpw8mv8otMLwkzyfectbaK0VpfHR1IXOM8PLh0qzfBL1fmFivtJrWAyosgjp
         5IPOg3zi0irEpuZJYbau/bye5Ch+pB1kShujyiznNkAo2vnqgwRsQ4l2DFk9QVy/W6Ip
         QeD4oxgjEYGt1nQYpiNj57NCEmnwXuzfs5RS/klpWgr6ILbA7GF5PD43s0ir88VyUsNa
         CKt9zIlx+7Nrfp8r2p4jb96YH/7C2s0Ytq29dES/t5cepiCoNP2eoXIsBo1stF7wg/MU
         cUKR3kyfSPU/4aFhCmeu9sSb9j7LpQdOIQjuzjdHoLQyFx/pUNfwAlm264vKSsy0VY3e
         HSKw==
X-Gm-Message-State: ABy/qLY008JOPEElRlP4hdpDa4AOo4lg+14MwfBLj49FGgBm/X2HR6Bb
	pL37IF435VZzVJdHHKYac+n6xwLyPhgwzTMnFUr4smBlXtWciQtuZ5REgTe8G9t3uK6KJNZM3nF
	V/2DnpysFsh9ZHznk
X-Received: by 2002:a05:620a:1987:b0:765:3b58:99ab with SMTP id bm7-20020a05620a198700b007653b5899abmr5086299qkb.4.1690450247437;
        Thu, 27 Jul 2023 02:30:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTPmJ6ywjMXcOn37fllkuxYqQBuqUnEaMX6eyYTMzWMl4po0H4sZqAd9VzOIr31KLGtaJuDg==
X-Received: by 2002:a05:620a:1987:b0:765:3b58:99ab with SMTP id bm7-20020a05620a198700b007653b5899abmr5086288qkb.4.1690450247118;
        Thu, 27 Jul 2023 02:30:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a071000b00767cf270628sm276536qkc.131.2023.07.27.02.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:30:46 -0700 (PDT)
Message-ID: <220fc36ba1086c1390ba087d08561b61762c965a.camel@redhat.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>, David Ahern <dsahern@gmail.com>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, Andrew Kanner
 <andrew.kanner@gmail.com>, brouer@redhat.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com, John Fastabend
 <john.fastabend@gmail.com>
Date: Thu, 27 Jul 2023 11:30:43 +0200
In-Reply-To: <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
References: <20230725155403.796-1-andrew.kanner@gmail.com>
	 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
	 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
	 <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
	 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
	 <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-27 at 14:07 +0800, Jason Wang wrote:
> On Thu, Jul 27, 2023 at 8:27=E2=80=AFAM David Ahern <dsahern@gmail.com> w=
rote:
> >=20
> > On 7/26/23 1:37 PM, David Ahern wrote:
> > > On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
> > > > Cc. John and Ahern
> > > >=20
> > > > On 26/07/2023 04.09, Jason Wang wrote:
> > > > > On Tue, Jul 25, 2023 at 11:54=E2=80=AFPM Andrew Kanner
> > > > > <andrew.kanner@gmail.com> wrote:
> > > > > >=20
> > > > > > Syzkaller reported the following issue:
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > Too BIG xdp->frame_sz =3D 131072
> > > >=20
> > > > Is this a contiguous physical memory allocation?
> > > >=20
> > > > 131072 bytes equal order 5 page.
> > > >=20
> > > > Looking at tun.c code I cannot find a code path that could create
> > > > order-5 skb->data, but only SKB with order-0 fragments.  But I gues=
s it
> > > > is the netif_receive_generic_xdp() what will realloc to make this l=
inear
> > > > (via skb_linearize())
> > >=20
> > >=20
> > > get_tun_user is passed an iov_iter with a single segment of 65007
> > > total_len. The alloc_skb path is hit with an align size of only 64. T=
hat
> > > is insufficient for XDP so the netif_receive_generic_xdp hits the
> > > pskb_expand_head path. Something is off in the math in
> > > netif_receive_generic_xdp resulting in the skb markers being off. Tha=
t
> > > causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.
> >=20
> >=20
> > BTW, it is pskb_expand_head that turns it from a 64kB to a 128 kB
> > allocation. But the 128kB part is not relevant to the "bug" here really=
.
> >=20
> > The warn on getting tripped in bpf_xdp_adjust_tail is because xdp
> > generic path is skb based and can have a frame_sz > 4kB. That's what th=
e
> > splat is about.
>=20
> Other possibility:
>=20
> tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM this may end up
> with producing a frame_sz which is greater than PAGE_SIZE as well in
> tun_build_skb().
>=20
> And rethink this patch, it looks wrong since it basically drops all
> packets whose buflen is greater than PAGE_SIZE since it can't fall
> back to tun_alloc_skb().
>=20
> >=20
> > Perhaps the solution is to remove the WARN_ON.
>=20
> Yes, that is what I'm asking if this warning still makes sense in V1.

I understand the consensus is solving the issue by changing/removing
the WARN_ON() in XDP. I think it makes sense, I guess the same warn can
be reached via packet socket xmit on veth or similar topology.

Cheers,

Paolo


