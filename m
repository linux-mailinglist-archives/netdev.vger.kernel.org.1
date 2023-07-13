Return-Path: <netdev+bounces-17353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F3751584
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E12A281AD2
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285F436E;
	Thu, 13 Jul 2023 00:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C357C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:51:10 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7010D1FFF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:51:09 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44387d40adaso97505137.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689209468; x=1691801468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7FqWbGI5Y3oPbhKTVcyuspn5tkMUIh+XFe9RTJX85g=;
        b=GmjSz2NLag7+ha4jZB6/jaec1HuOLMKyMy8jTlMeuWZBayhR1mAweofowBSfbgO7Qn
         gRAy/xBhtFxxUbErI7s6wDoXVoiFRpFsk3TmMARj+vlYFSvZElRZNldr5mb9IRiI/lGa
         QAMuTDIORQouFaW3TwyqXLwSxngpI3lN5VAj3rbd1GU1IUEOoupxEiteNzxCzEJFKWh3
         o5S9kfs5/11DiPYbbPo3bDaFyhvxJ8Qn2LfQgcZfB7cIZJdyP6ROmq1xSbuGxl5VayRn
         dwdSY7Zgp2v8gnmTRonSAIZ3K06esNicmJNqwpvCNCoW6FUsdEw/P01kSqs1b/fRwwZO
         UKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689209468; x=1691801468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7FqWbGI5Y3oPbhKTVcyuspn5tkMUIh+XFe9RTJX85g=;
        b=A/puX/DqppQv+2RxbJvJc8ouHtgbcOoIgvzMSTYnTyBDmRdHf2x2/BzgfJ7AEW7lTr
         PEL7jOS9h0o0wTSTRkcSWX6lY1bZjJS6T9D4+nF52X3Y6dAx6Q6gq0Ml4bojRj65WY2J
         /Z4Xf3BTSjB123PNe5sPk2uR8My5482iwE/Vkv0ALHHjiqrU9kE2m6oAYjDtaHhT5oB6
         TAb/kYW6thI6AtwXRDdnNrzeFLXZKvckNyz3Zlur9MRZBH15jTfbXN+HnLbMooPdxd9u
         0Zcy+r89UY6c3+1WiSQtX+hh9GfdFQjkEk/tSBog+XzTvAvLUGZl+SeeKAeBYR+l00Q3
         zxOw==
X-Gm-Message-State: ABy/qLYuYMEwymUHUe3KV+i5vIfooj3eJZJJ3zqHRhUoNt7VeSCZoD0Z
	yGSpD25nWMt+c2jp7lUlj05hkq83VGef3856v90=
X-Google-Smtp-Source: APBJJlGH1OZ+CQ2DYMTTOrVjLDcCozJgbJR2yDHWWV1f4pFNjsMZlBGLyXTCNttKgyTP1R/EjRi21p5nSfg2Xw8h4ZU=
X-Received: by 2002:a05:6102:284b:b0:440:ada6:2117 with SMTP id
 az11-20020a056102284b00b00440ada62117mr110355vsb.5.1689209468441; Wed, 12 Jul
 2023 17:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com>
 <CAO3-PboqjhNDcCTicLPXawvwmvrC-Wj04Q72v0tJCME-cX4P8Q@mail.gmail.com> <1c27e65962f983ae5fbe76b108f3b0b6be22ea1f.camel@redhat.com>
In-Reply-To: <1c27e65962f983ae5fbe76b108f3b0b6be22ea1f.camel@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 12 Jul 2023 20:50:32 -0400
Message-ID: <CAF=yD-LbXxa3g2YMUtGSaJRb5S6ggXJK9nmEf1TJzGf+tBbbaw@mail.gmail.com>
Subject: Re: Broken segmentation on UDP_GSO / VIRTIO_NET_HDR_GSO_UDP_L4
 forwarding path
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yan Zhai <yan@cloudflare.com>, Marek Majkowski <marek@cloudflare.com>, 
	network dev <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 11:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Adding Jason,
> On Wed, 2023-07-12 at 09:58 -0500, Yan Zhai wrote:
> > On Wed, Jul 12, 2023 at 9:00=E2=80=AFAM Marek Majkowski <marek@cloudfla=
re.com> wrote:
> > >
> > > Dear netdev,
> > >
> > > I encountered a puzzling problem, please help.
> > >
> > > Rootless repro:
> > >    https://gist.github.com/majek/5e8fd12e7a1663cea63877920fe86f18
> > >
> > > To run:
> > >
> > > ```
> > > $ unshare -Urn python3 udp-gro-forwarding-bug.py
> > > tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> > > lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 13=
92
> > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > =
1392
> > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > =
1200
> > > '''
> > >
> > > The code is really quite simple. First I create and open a tap device=
.
> > > Then I send a large (>MTU) packet with vnethdr over tap0. The
> > > gso_type=3DGSO_UDP_L4, and gso_size=3D1400. I expect the packet to eg=
ress
> > > from tap0, be forwarded somewhere, where it will eventually be
> > > segmented by software or hardware.
> > >
> > > The egress tap0 packet looks perfectly fine:
> > >
> > > tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> > >
> > > To simplify routing I'm doing 'tc mirred' aka `bpf_redirect()` magic,
> > > where I move egress tap0 packets to ingress lo, like this:
> > >
> > > > tc filter add dev tap0 ingress protocol ip u32 match ip src 10.0.0.=
2 action mirred egress redirect dev lo

This is the opposite of stated, attach to tap0 at ingress and send to
lo on egress?

It might matter only in the sense that tc_mirred on egress acts in
dev_queue_xmit before any segmentation would occur.

Probably irrelevant, as your example clearly hits the segmentation
logic, and it sounds like the root cause there is already well
understood.

> > >
> > > On ingress lo I see something really weird:
> > >
> > > lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 13=
92
> > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > =
1392
> > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > =
1200
> > >
> > > This looks like IPv4 fragments without the IP fragmentation bits set.
> > >
> > > I think there are two independent problems here:
> > >
> > > (1) The packet is *fragmented* and that is plain wrong here. I'm
> > > asking for USO not UFO in vnethdr.
> > >
> >
> > To add some context our virtio header in hex format (12 bytes) is
> > 01052a007805220006000000.
> >
> > Some digging shows that the issue seems to come from this patch:
> > https://lore.kernel.org/netdev/20220907125048.396126-2-andrew@daynix.co=
m/
> > At this point, skb_shared_info->gso_type is SKB_GSO_UDP_L4 |
> > SKB_GSO_DODGY, here the DODGY bit is set inside tun_get_user. So the
> > skb_gso_ok check will return true here, then the skb will fall to the
> > fragment code. Simple tracing confirms that __udp_gso_segment is never
> > called in this scenario.
> >
> > So the question is really how to handle the DODGY bit. IMHO it is not
> > right to fall to the fragment path when the actual packet request is
> > segmentation.
>
> I do agree with the above.
>
> > Will it be sufficient to just recompute the gso_segs
> > here and return the head skb instead?
>
> Something alike what TCP is currently doing:
>
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_offload.c#L85
>
> should be fine - constrained to the skb_shinfo(skb)->gso_type &
> SKB_GSO_UDP_L4 case.

Agreed. That's the canonical way to check dodgy segmentation offload
packets. All USO packets should enter __udp_gso_segment.

After validation and DODGY removal, a packet may fall through to
device segmentation if the devices advertises the feature (by returning
segs =3D=3D NULL).

