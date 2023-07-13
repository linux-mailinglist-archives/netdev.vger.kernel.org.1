Return-Path: <netdev+bounces-17361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9117515FB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA6E2811DC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EF63D;
	Thu, 13 Jul 2023 02:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990467C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:02:03 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE71BEC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:02:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3110ab7110aso293117f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689213719; x=1691805719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/m1iIGRAEVez5/UJLInDOwYLbUQP9TFtpWuFVr4tgo=;
        b=WGQefeZNbFEGsugx1WY6seIS0Hs2h2xIM4QLojZogcNBRQ72ElgdzJZYuwpD5OhacN
         cPHpcaSNdrTEDDfnmuCdTxP8WffJjd/iti1osceyWHa2hJkx1EstLRoYSm7cWsI7/GHH
         VTV32ClrVLnnkE4BSwOE9v4ZSOU9o/mLFBM1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689213719; x=1691805719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/m1iIGRAEVez5/UJLInDOwYLbUQP9TFtpWuFVr4tgo=;
        b=T2PzV6IRi/R6/P+dAOK62c1B+nFrTiFIEggSiQuQDICcg5+kvs6Vk8wD+nHdAi6Ah1
         1OVqoo8pfSuXhKrThYqVpHDxvBzsZTkUNnvnoKokscCYto6Fa60qN6afrROJAJGI22Db
         U4f7e9rqvvvlWcrBUb8dllAARdSgTtsblOlMx7xmQJAsb//dstThaP0RSt/PN0pzz4l+
         msHswlHt/HUQthPS6gE+xhvffWKm18l0OFyn6nrsb+vrP8t5tuq1NzdZ8Rz7NpsbZW4+
         t5rpoMlgLp/VcDRwBjLsSoKIuXyVYKy83zfPh1q2JQVyGEafKPhMQRO0Plb7Ol2PiN8E
         RtNA==
X-Gm-Message-State: ABy/qLZUdruDkFNyoa6OmyE2lFgEvkso3zuOT79HGNrNYncBmSSBRQMq
	r0N7/qteuualk/KKuWYYYEeJ5XDD9kOYtNZUNnWesQ==
X-Google-Smtp-Source: APBJJlGNJbnvNstTIVO4c/8TYzRzeCIRAByACkHvrz2rPeGZkUvncLxJ/F+6+FLClwQtXFvUTdY23qMsmPMK1xQmJic=
X-Received: by 2002:a5d:4b8d:0:b0:313:f0d7:a43 with SMTP id
 b13-20020a5d4b8d000000b00313f0d70a43mr184023wrt.23.1689213719404; Wed, 12 Jul
 2023 19:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com>
 <CAO3-PboqjhNDcCTicLPXawvwmvrC-Wj04Q72v0tJCME-cX4P8Q@mail.gmail.com>
 <1c27e65962f983ae5fbe76b108f3b0b6be22ea1f.camel@redhat.com> <CAF=yD-LbXxa3g2YMUtGSaJRb5S6ggXJK9nmEf1TJzGf+tBbbaw@mail.gmail.com>
In-Reply-To: <CAF=yD-LbXxa3g2YMUtGSaJRb5S6ggXJK9nmEf1TJzGf+tBbbaw@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 12 Jul 2023 21:01:46 -0500
Message-ID: <CAO3-PbpmNx+Ja2DkW+R6jwCVTxS6zKP4VxJ8+HXCuo4s-7xPiQ@mail.gmail.com>
Subject: Re: Broken segmentation on UDP_GSO / VIRTIO_NET_HDR_GSO_UDP_L4
 forwarding path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Marek Majkowski <marek@cloudflare.com>, 
	network dev <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 7:51=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, Jul 12, 2023 at 11:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > Adding Jason,
> > On Wed, 2023-07-12 at 09:58 -0500, Yan Zhai wrote:
> > > On Wed, Jul 12, 2023 at 9:00=E2=80=AFAM Marek Majkowski <marek@cloudf=
lare.com> wrote:
> > > >
> > > > Dear netdev,
> > > >
> > > > I encountered a puzzling problem, please help.
> > > >
> > > > Rootless repro:
> > > >    https://gist.github.com/majek/5e8fd12e7a1663cea63877920fe86f18
> > > >
> > > > To run:
> > > >
> > > > ```
> > > > $ unshare -Urn python3 udp-gro-forwarding-bug.py
> > > > tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> > > > lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > =
1392
> > > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 =
> 1392
> > > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 =
> 1200
> > > > '''
> > > >
> > > > The code is really quite simple. First I create and open a tap devi=
ce.
> > > > Then I send a large (>MTU) packet with vnethdr over tap0. The
> > > > gso_type=3DGSO_UDP_L4, and gso_size=3D1400. I expect the packet to =
egress
> > > > from tap0, be forwarded somewhere, where it will eventually be
> > > > segmented by software or hardware.
> > > >
> > > > The egress tap0 packet looks perfectly fine:
> > > >
> > > > tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> > > >
> > > > To simplify routing I'm doing 'tc mirred' aka `bpf_redirect()` magi=
c,
> > > > where I move egress tap0 packets to ingress lo, like this:
> > > >
> > > > > tc filter add dev tap0 ingress protocol ip u32 match ip src 10.0.=
0.2 action mirred egress redirect dev lo
>
> This is the opposite of stated, attach to tap0 at ingress and send to
> lo on egress?
>
> It might matter only in the sense that tc_mirred on egress acts in
> dev_queue_xmit before any segmentation would occur.
>
> Probably irrelevant, as your example clearly hits the segmentation
> logic, and it sounds like the root cause there is already well
> understood.
>
> > > >
> > > > On ingress lo I see something really weird:
> > > >
> > > > lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > =
1392
> > > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 =
> 1392
> > > > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 =
> 1200
> > > >
> > > > This looks like IPv4 fragments without the IP fragmentation bits se=
t.
> > > >
> > > > I think there are two independent problems here:
> > > >
> > > > (1) The packet is *fragmented* and that is plain wrong here. I'm
> > > > asking for USO not UFO in vnethdr.
> > > >
> > >
> > > To add some context our virtio header in hex format (12 bytes) is
> > > 01052a007805220006000000.
> > >
> > > Some digging shows that the issue seems to come from this patch:
> > > https://lore.kernel.org/netdev/20220907125048.396126-2-andrew@daynix.=
com/
> > > At this point, skb_shared_info->gso_type is SKB_GSO_UDP_L4 |
> > > SKB_GSO_DODGY, here the DODGY bit is set inside tun_get_user. So the
> > > skb_gso_ok check will return true here, then the skb will fall to the
> > > fragment code. Simple tracing confirms that __udp_gso_segment is neve=
r
> > > called in this scenario.
> > >
> > > So the question is really how to handle the DODGY bit. IMHO it is not
> > > right to fall to the fragment path when the actual packet request is
> > > segmentation.
> >
> > I do agree with the above.
> >
> > > Will it be sufficient to just recompute the gso_segs
> > > here and return the head skb instead?
> >
> > Something alike what TCP is currently doing:
> >
> > https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_offload.c#L=
85
> >
> > should be fine - constrained to the skb_shinfo(skb)->gso_type &
> > SKB_GSO_UDP_L4 case.
>
> Agreed. That's the canonical way to check dodgy segmentation offload
> packets. All USO packets should enter __udp_gso_segment.
>
> After validation and DODGY removal, a packet may fall through to
> device segmentation if the devices advertises the feature (by returning
> segs =3D=3D NULL).

I sent a patch at
https://lore.kernel.org/netdev/ZK9ZiNMsJX8+1F3N@debian.debian/T/#u.
Tested on my local machine it is working correctly now.

--=20

Yan

