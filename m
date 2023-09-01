Return-Path: <netdev+bounces-31739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3E78FE51
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75512281AAB
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68808BE5A;
	Fri,  1 Sep 2023 13:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DBBE4D
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:32:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A010F1
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693575166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi2RFiSqS90try5umBCa3fQNKy+XWOzNuHb+fMKDjX4=;
	b=FCmQ7hNAAtceXMb54+LFbaXMpVEw6WcTIKAh/l61VXwK2+i+TUx1RoenKhEGNHjltsfwKi
	AoIidnfsf10esm005CN1LxJeS1YgZr5QCfZfeh+W1Qefatu9OjuZJpsWEm3RnM9fLbS3UT
	70MNFL5hV6T00yQded+xKFbbLVbH4So=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Hw0Cm8_eMzeQOUBc6sc39w-1; Fri, 01 Sep 2023 09:32:45 -0400
X-MC-Unique: Hw0Cm8_eMzeQOUBc6sc39w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5009ee2287aso2551755e87.2
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 06:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575164; x=1694179964;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi2RFiSqS90try5umBCa3fQNKy+XWOzNuHb+fMKDjX4=;
        b=g+EHpnqAwUVVejeBYabZGflnzwUZfUiuJui9TjfBQidvebejQhVFkKzq22dI5hTbNq
         MP5RVkIhECcp9FX5V1vpbr00NP62n7CGcDdTKGLUXbx4kXqRM4A3XKwbCDYRixCVbPcP
         JKbZh9BySCoVAKmG2Iz7SiAK+m1yr5cb724n5vDlTGImfW8SMbXX/Bg1yz1dppmFKti0
         b2EbU0YxKbwWLlbPNcFTYqLm2qWNig32USJ03Q3o3i7Btmx8HBhxbRpDYeTa4VexCSbg
         0gUov8xzKHP294A8hK5iiyc71girouf0nJ252UC6nqihgtb/TcyOVxufkojGRZZW8Km+
         fW2g==
X-Gm-Message-State: AOJu0YxSljM0dnUmfg0WRP1G0mmFn5TlogTTnQgR7zethR97/aanaLvC
	ZeOUdQ88SLGejT/xYhO3LnPmp4VeYZgNAU90zw4VE6AXZJ0ZSRoO7OqQ0wLwNAXS3sZaE1vtGrR
	XP8EoBGUBY/C0cCouhSDfO2Pg
X-Received: by 2002:ac2:52ab:0:b0:500:b301:d8db with SMTP id r11-20020ac252ab000000b00500b301d8dbmr1502380lfm.28.1693575163627;
        Fri, 01 Sep 2023 06:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDIgtwW/WZVKKuUMod4IXcehqAGMXyTiB6vMBoauULajM+Bm1Pd0+eJTB27LM5g+uEEsO4GQ==
X-Received: by 2002:ac2:52ab:0:b0:500:b301:d8db with SMTP id r11-20020ac252ab000000b00500b301d8dbmr1502347lfm.28.1693575163108;
        Fri, 01 Sep 2023 06:32:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7d98c000000b005256aaa6e7asm2060292eds.78.2023.09.01.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:32:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0FA1FD82444; Fri,  1 Sep 2023 15:32:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: hawk@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, lorenzo@kernel.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 edumazet@google.com, Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH net-next RFC v1 2/4] veth: use generic-XDP functions
 when dealing with SKBs
In-Reply-To: <d7d3e320-9b2c-fbc4-7d2d-866741b10cf7@kernel.org>
References: <169272709850.1975370.16698220879817216294.stgit@firesoul>
 <169272715407.1975370.3989385869434330916.stgit@firesoul>
 <87msyg91gl.fsf@toke.dk> <d7d3e320-9b2c-fbc4-7d2d-866741b10cf7@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Sep 2023 15:32:42 +0200
Message-ID: <87a5u6t3wl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 24/08/2023 12.30, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> The root-cause the realloc issue is that veth_xdp_rcv_skb() code path (=
that
>>> handles SKBs like generic-XDP) is calling a native-XDP function
>>> xdp_do_redirect(), instead of simply using xdp_do_generic_redirect() th=
at can
>>> handle SKBs.
>>>
>>> The existing code tries to steal the packet-data from the SKB (and free=
s the SKB
>>> itself). This cause issues as SKBs can have different memory models tha=
t are
>>> incompatible with native-XDP call xdp_do_redirect(). For this reason th=
e checks
>>> in veth_convert_skb_to_xdp_buff() becomes more strict. This in turn mak=
es this a
>>> bad approach. Simply leveraging generic-XDP helpers e.g. generic_xdp_tx=
() and
>>> xdp_do_generic_redirect() as this resolves the issue given netstack can=
 handle
>>> these different SKB memory models.
>>=20
>> While this does solve the memory issue, it's also a subtle change of
>> semantics. For one thing, generic_xdp_tx() has this comment above it:
>>=20
>> /* When doing generic XDP we have to bypass the qdisc layer and the
>>   * network taps in order to match in-driver-XDP behavior. This also mea=
ns
>>   * that XDP packets are able to starve other packets going through a qd=
isc,
>>   * and DDOS attacks will be more effective. In-driver-XDP use dedicated=
 TX
>>   * queues, so they do not have this starvation issue.
>>   */
>>=20
>> Also, more generally, this means that if you have a setup with
>> XDP_REDIRECT-based forwarding in on a host with a mix of physical and
>> veth devices, all the traffic originating from the veth devices will go
>> on different TXQs than that originating from a physical NIC. Or if a
>> veth device has a mix of xdp_frame-backed packets and skb-backed
>> packets, those will also go on different queues, potentially leading to
>> reordering.
>>=20
>
> Mixing xdp_frame-backed packets and skb-backed packet (towards veth)
> will naturally come from two different data paths, and the BPF-developer
> that redirected the xdp_frame (into veth) will have taken this choice,
> including the chance of reordering (given the two data/code paths).

I'm not sure we can quite conclude that this is a choice any XDP
developers will be actively aware of. At best it's a very implicit
choice :)

> I will claim that (for SKBs) current code cause reordering on TXQs (as
> you explain), and my code changes actually fix this problem.
>
> Consider a userspace app (inside namespace) sending packets out (to veth
> peer).  Routing (or bridging) will make netstack send out device A
> (maybe a physical device).  On veth peer we have XDP-prog running, that
> will XDP-redirect every 2nd packet to device A.  With current code TXQ
> reordering will occur, as calling "native" xdp_do_redirect() will select
> TXQ based on current-running CPU, while normal SKBs will use
> netdev_core_pick_tx().  After my change, using
> xdp_do_generic_redirect(), the code end-up using generic_xdp_tx() which
> (looking at the code) also use netdev_core_pick_tx() to select the TXQ.
> Thus, I will claim it is more correct (even-though XDP in general
> doesn't give this guarantee).
>
>> I'm not sure exactly how much of an issue this is in practice, but at
>> least from a conceptual PoV it's a change in behaviour that I don't
>> think we should be making lightly. WDYT?
>
> As desc above, I think this patchset is an improvement.  It might even
> fix/address the concern that was raised.

Well, you can obviously construct examples in both direction (i.e.,
where the old behaviour leads to reordering but the new one doesn't, and
vice versa). I believe you could also reasonably argue that either
behaviour is more "correct", so if we were just picking between
behaviours I wouldn't be objecting, I think.

However, we're not just picking between two equally good behaviours,
we're changing one long-standing behaviour to a different one, and I
worry this will introduce regressions because there are applications
that (explicitly or implicitly) rely on the old behaviour.

Also, there's the starvation issue mentioned in the comment I quoted
above: with this patch it is possible for traffic redirected from a veth
to effectively starve the host TXQ, where before it wouldn't.

I don't really have a good answer for how we can make sure of this
either way, but I believe it's cause for concern, which is really my
main reservation with this change :)

-Toke


