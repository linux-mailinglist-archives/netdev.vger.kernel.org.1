Return-Path: <netdev+bounces-17193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF6750C4A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDF1C20F34
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E3924170;
	Wed, 12 Jul 2023 15:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E124160
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:20:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA1526A1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689175178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ic3vDDr+GNzz909kaKnojXYaul6w7qbitzzLSgf0kb0=;
	b=c4G+JdkwQo4ljh1YkdxKQff/C/FbqGk4TAvGB4X/7Vciwa/WETyyF92ve8O0RgcY8u+hKF
	XEmUX17ia7DK3PTiqPiA3y/7i9u+Scy2Zhu1XQfmAA+YkZCSpFU+utXWmVplREOHPh8qim
	EGwtqDSJsJuHq5Vs/MiU6R0VcCwr6SM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-jn6ZWNBsOT6CnJi0xzjVfw-1; Wed, 12 Jul 2023 11:19:36 -0400
X-MC-Unique: jn6ZWNBsOT6CnJi0xzjVfw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635de6f75e0so16074116d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175176; x=1691767176;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ic3vDDr+GNzz909kaKnojXYaul6w7qbitzzLSgf0kb0=;
        b=PxmXo65k7ZQqKtRDBae7z5ZYXXdOrweeqAGy4sl8uRi+udS2NsObbaU6Ak7u8jKlCV
         4qRSWJ7iywWCrPvJGfnwLIductvabrS7DvItG04sjmfwA34kHSjeCr04TVIabLL1JoE2
         5415wAfB01OVwPJODBuk4RZWHLztX/FwtwvxqvDa/ElaIMxuRRX4LrEKz3OYbBxHQjo9
         1kixRIKZkO2e7sdSjdIUzG4OLIOReYBlCoBR5wkufk7i7gwMTQM8gl/BKPUdrpbsCSJg
         5YXPr7ivoREG/iR5zcJ00m2Hhf8UpBtXhBoocy1MOzUCTj6RiBqiHdXdBj24CgvZvDaB
         YJhw==
X-Gm-Message-State: ABy/qLbh/QlzkO8jNwZ+cKfM5ilmdMPxWCQZ4O195ijHikWdReY8zWLI
	mFpDjfFSeGT+AmOGE7Q15LPvD/s+lBouYoQIHwZ0kTbL4+PdhBUc4R1o2M3IJOOJLmXjMSA+i1a
	UcanWDNffl72W6Lpg
X-Received: by 2002:a05:6214:2aa3:b0:62d:fdc4:1e8b with SMTP id js3-20020a0562142aa300b0062dfdc41e8bmr20601485qvb.2.1689175175817;
        Wed, 12 Jul 2023 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXYIAwl40wYOpzKDx/30lmBWZTsHPsDgMGYOsL5Q6cum3OZNQV3hz4M2jEoti2Zapm4pEYwg==
X-Received: by 2002:a05:6214:2aa3:b0:62d:fdc4:1e8b with SMTP id js3-20020a0562142aa300b0062dfdc41e8bmr20601466qvb.2.1689175175539;
        Wed, 12 Jul 2023 08:19:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id o3-20020a0cf4c3000000b0062439f05b87sm2312589qvm.45.2023.07.12.08.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:19:35 -0700 (PDT)
Message-ID: <1c27e65962f983ae5fbe76b108f3b0b6be22ea1f.camel@redhat.com>
Subject: Re: Broken segmentation on UDP_GSO / VIRTIO_NET_HDR_GSO_UDP_L4
 forwarding path
From: Paolo Abeni <pabeni@redhat.com>
To: Yan Zhai <yan@cloudflare.com>, Marek Majkowski <marek@cloudflare.com>
Cc: network dev <netdev@vger.kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Andrew Melnychenko <andrew@daynix.com>, Jason
 Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 17:19:32 +0200
In-Reply-To: <CAO3-PboqjhNDcCTicLPXawvwmvrC-Wj04Q72v0tJCME-cX4P8Q@mail.gmail.com>
References: 
	<CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com>
	 <CAO3-PboqjhNDcCTicLPXawvwmvrC-Wj04Q72v0tJCME-cX4P8Q@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adding Jason,
On Wed, 2023-07-12 at 09:58 -0500, Yan Zhai wrote:
> On Wed, Jul 12, 2023 at 9:00=E2=80=AFAM Marek Majkowski <marek@cloudflare=
.com> wrote:
> >=20
> > Dear netdev,
> >=20
> > I encountered a puzzling problem, please help.
> >=20
> > Rootless repro:
> >    https://gist.github.com/majek/5e8fd12e7a1663cea63877920fe86f18
> >=20
> > To run:
> >=20
> > ```
> > $ unshare -Urn python3 udp-gro-forwarding-bug.py
> > tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> > lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 1392
> > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 13=
92
> > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 12=
00
> > '''
> >=20
> > The code is really quite simple. First I create and open a tap device.
> > Then I send a large (>MTU) packet with vnethdr over tap0. The
> > gso_type=3DGSO_UDP_L4, and gso_size=3D1400. I expect the packet to egre=
ss
> > from tap0, be forwarded somewhere, where it will eventually be
> > segmented by software or hardware.
> >=20
> > The egress tap0 packet looks perfectly fine:
> >=20
> > tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> >=20
> > To simplify routing I'm doing 'tc mirred' aka `bpf_redirect()` magic,
> > where I move egress tap0 packets to ingress lo, like this:
> >=20
> > > tc filter add dev tap0 ingress protocol ip u32 match ip src 10.0.0.2 =
action mirred egress redirect dev lo
> >=20
> > On ingress lo I see something really weird:
> >=20
> > lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 1392
> > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 13=
92
> > lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 12=
00
> >=20
> > This looks like IPv4 fragments without the IP fragmentation bits set.
> >=20
> > I think there are two independent problems here:
> >=20
> > (1) The packet is *fragmented* and that is plain wrong here. I'm
> > asking for USO not UFO in vnethdr.
> >=20
>=20
> To add some context our virtio header in hex format (12 bytes) is
> 01052a007805220006000000.
>=20
> Some digging shows that the issue seems to come from this patch:
> https://lore.kernel.org/netdev/20220907125048.396126-2-andrew@daynix.com/
> At this point, skb_shared_info->gso_type is SKB_GSO_UDP_L4 |
> SKB_GSO_DODGY, here the DODGY bit is set inside tun_get_user. So the
> skb_gso_ok check will return true here, then the skb will fall to the
> fragment code. Simple tracing confirms that __udp_gso_segment is never
> called in this scenario.
>=20
> So the question is really how to handle the DODGY bit. IMHO it is not
> right to fall to the fragment path when the actual packet request is
> segmentation.=C2=A0

I do agree with the above.

> Will it be sufficient to just recompute the gso_segs
> here and return the head skb instead?

Something alike what TCP is currently doing:

https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_offload.c#L85

should be fine - constrained to the skb_shinfo(skb)->gso_type &
SKB_GSO_UDP_L4 case.

Cheers,

Paolo


