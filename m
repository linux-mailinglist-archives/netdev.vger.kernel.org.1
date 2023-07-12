Return-Path: <netdev+bounces-17178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D384750B89
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9C92817AD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1F34CEB;
	Wed, 12 Jul 2023 14:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF934CC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:58:25 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553601BC6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:58:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e5da79223so3996528a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689173903; x=1691765903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9hdB9GbF5/+huC5QUpTges7SmWqLW/8JHfy7jXuVYY=;
        b=Bw/EHYT5YTF7yjml3rKdbNJNg5XcviPn7tArwv8Sa7+TsjX4O3R0tgLEgmp2Im2dgh
         0QfDGOF7RV1+YAtXqfu7qg7TuEoxEE+XyTjWIp5Ua5wsUFlsNYR63JzumZK+pY0weJbz
         kzWHKJva0Tasv37/DbhKSVYSoNhbSJS6xBnBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173903; x=1691765903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9hdB9GbF5/+huC5QUpTges7SmWqLW/8JHfy7jXuVYY=;
        b=G5MuUGPVhtoQJR28L947oCSk0fjo5Uqw/F0SofVObk3BaJRqu1ZsyTaRMiXtilB+Q3
         VL3VLDJtGS+vkzBlyCbjSD/9P4mUkmEPJiEVVgIZz4j1fgTnYMORVeUvHEOCf2DKnYWz
         cmvkkdGtLnR5t+joG5c3E1GHeXqELMiZr43TTJAjLeteUlVu/RFFvzG8qcqp+TlTJWKR
         WXyQNJy8pGtt0A/JUdYaxHfw2TzlDvy87Hmya+s8qJX+OR0BDDRfvLL7/frqaQ/aJtkO
         s5n3LRqc5mtSc+6G6LYCPxXNXyJng/by8zlSc/972YTJrAwICx/vZirkaWRZUJjroCW4
         gTAg==
X-Gm-Message-State: ABy/qLY/h7Fj/eA2U94KK5SHwO0Yc4f2d7bOeA/+mGkM2o0IZsyt0vw5
	p4FLHylKtVwInkV80kdBqc89YQ1fnMuZnReLt7QjCKOdUKgN+uq7tO4=
X-Google-Smtp-Source: APBJJlEBGiUm4ek8IujU8Mh0NSVTdVqZUp8Kz2aD3WlJsmXSBCoHKbi7gPSaY+lWTBYLwobIP4aURHHYi0vBxBLMdgE=
X-Received: by 2002:aa7:ccd1:0:b0:51e:12b:b989 with SMTP id
 y17-20020aa7ccd1000000b0051e012bb989mr17362185edt.20.1689173902721; Wed, 12
 Jul 2023 07:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com>
In-Reply-To: <CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 12 Jul 2023 09:58:11 -0500
Message-ID: <CAO3-PboqjhNDcCTicLPXawvwmvrC-Wj04Q72v0tJCME-cX4P8Q@mail.gmail.com>
Subject: Re: Broken segmentation on UDP_GSO / VIRTIO_NET_HDR_GSO_UDP_L4
 forwarding path
To: Marek Majkowski <marek@cloudflare.com>
Cc: network dev <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 9:00=E2=80=AFAM Marek Majkowski <marek@cloudflare.c=
om> wrote:
>
> Dear netdev,
>
> I encountered a puzzling problem, please help.
>
> Rootless repro:
>    https://gist.github.com/majek/5e8fd12e7a1663cea63877920fe86f18
>
> To run:
>
> ```
> $ unshare -Urn python3 udp-gro-forwarding-bug.py
> tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
> lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 1392
> lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1392
> lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1200
> '''
>
> The code is really quite simple. First I create and open a tap device.
> Then I send a large (>MTU) packet with vnethdr over tap0. The
> gso_type=3DGSO_UDP_L4, and gso_size=3D1400. I expect the packet to egress
> from tap0, be forwarded somewhere, where it will eventually be
> segmented by software or hardware.
>
> The egress tap0 packet looks perfectly fine:
>
> tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
>
> To simplify routing I'm doing 'tc mirred' aka `bpf_redirect()` magic,
> where I move egress tap0 packets to ingress lo, like this:
>
> > tc filter add dev tap0 ingress protocol ip u32 match ip src 10.0.0.2 ac=
tion mirred egress redirect dev lo
>
> On ingress lo I see something really weird:
>
> lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 1392
> lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1392
> lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1200
>
> This looks like IPv4 fragments without the IP fragmentation bits set.
>
> I think there are two independent problems here:
>
> (1) The packet is *fragmented* and that is plain wrong here. I'm
> asking for USO not UFO in vnethdr.
>

To add some context our virtio header in hex format (12 bytes) is
01052a007805220006000000.

Some digging shows that the issue seems to come from this patch:
https://lore.kernel.org/netdev/20220907125048.396126-2-andrew@daynix.com/
At this point, skb_shared_info->gso_type is SKB_GSO_UDP_L4 |
SKB_GSO_DODGY, here the DODGY bit is set inside tun_get_user. So the
skb_gso_ok check will return true here, then the skb will fall to the
fragment code. Simple tracing confirms that __udp_gso_segment is never
called in this scenario.

So the question is really how to handle the DODGY bit. IMHO it is not
right to fall to the fragment path when the actual packet request is
segmentation. Will it be sufficient to just recompute the gso_segs
here and return the head skb instead?  The only missing bit in the
device feature is the DODGY bit here.

> (2) The fragmentation attempt is broken, the IPv4 fragmentation bits are =
clear.
>
> Please advise. I would assume transmitting UDP_GSO packets off tap is
> a typical thing to do.
>
> I was able to repro this on a 6.4 kernel.
>
> For a moment I thought it's a `ethtool -K X rx-udp-gro-forwarding on`
> bug, but I'm not sure anymore.
>
> Marek



--=20

Yan

