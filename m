Return-Path: <netdev+bounces-37885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734DF7B78BA
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E66941F21DFB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD679D4;
	Wed,  4 Oct 2023 07:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D77489
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 07:29:39 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E61CC
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 00:29:37 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so1089541fac.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696404577; x=1697009377; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c42V3xh00u6Rw91KKP1qVbCjTWZQAB66jSqVwATqV3k=;
        b=Ec6WXDatjgMhHxUra3unLDH27luEh71nTBkSEg5F4842GH+ujw4kQGNEq9KuQtKSji
         /++LQ2CvCXgfGWmowfUX8VKU07yMZYnQSlhibLFpvQBlr98xvRf16SNKYeuUaKDTOfp9
         3S7OaPeX/q56GsjozuAd72Kzu2MFPv0N7zue3FrETzzRgdaKVBYSR30Sz+ePh4c3rF2S
         HI0ouw8OBd0aKRaCA7dpuD0x+zk76lmaWMiwKVCaEOQDdgQGVCYCZb9AjG0SPm2M9PCP
         zkfv8hyPrCUGxJOcgsLsHmjfOUpyDsOKQRfY4hq/oC+Zka6NgeZOTSJEDEoKJa9ipVaW
         cg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696404577; x=1697009377;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c42V3xh00u6Rw91KKP1qVbCjTWZQAB66jSqVwATqV3k=;
        b=pZdiSwGNCNyGYtjvgXItF+RH82eq/wGnkTixEEq3FZQNlI89gOnUlII6OgsZBUMAU9
         gHTYGL50hIi/kgcepG1kPLeU+R/QTxIsG0bcTtuo+hCwV6m+bB3EhRVXTFXiiVxb4Crm
         jpyTtJh+63y22dJToMz5GgrukAEfqi1QDS31TLFBaa4394UYyayJq8ARJbxylhMSoyH6
         wRTe5aS8a3QIAJPfhnJqk5DIyi5WJpF8IOqqxsoOuvA7ahCe2q82a8mdujgbyuwDv+wX
         P1K1yTWHaq6x2ZrxN7qV1hmiam1+Mt+B5iTaKWpqb9G/9wlc0m+7rxPOIZW3+ium8y1I
         c5qg==
X-Gm-Message-State: AOJu0YxnSEn4u/bOhgzzUc7V8ClNXQm1xyzLq6mUdopWKDDcoxE5Oi/L
	4QM2rAhiWSY1aKuReptOAvQ=
X-Google-Smtp-Source: AGHT+IFeQ+SzNhAqx9qfHtm+MytnECTxtf78s16kjqNPFOo/UaFNABNJsC5YoHQU8sMUnc7Iq8nQIw==
X-Received: by 2002:a05:6870:88aa:b0:1d5:a955:8bb3 with SMTP id m42-20020a05687088aa00b001d5a9558bb3mr1539158oam.43.1696404576676;
        Wed, 04 Oct 2023 00:29:36 -0700 (PDT)
Received: from localhost (193-116-195-242.tpgi.com.au. [193.116.195.242])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00690ca4356f1sm2546344pfb.198.2023.10.04.00.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 00:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Oct 2023 17:29:30 +1000
Message-Id: <CVZH8D7WMBDW.3D77G01KQ48R3@wheely>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aaron Conole" <aconole@redhat.com>
Cc: <netdev@vger.kernel.org>, <dev@openvswitch.org>, "Ilya Maximets"
 <imaximet@redhat.com>, "Eelco Chaudron" <echaudro@redhat.com>, "Flavio
 Leitner" <fbl@redhat.com>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-5-npiggin@gmail.com> <f7tfs2ymi8y.fsf@redhat.com>
In-Reply-To: <f7tfs2ymi8y.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Dynamically allocating the sw_flow_key reduces stack usage of
> > ovs_vport_receive from 544 bytes to 64 bytes at the cost of
> > another GFP_ATOMIC allocation in the receive path.
> >
> > XXX: is this a problem with memory reserves if ovs is in a
> > memory reclaim path, or since we have a skb allocated, is it
> > okay to use some GFP_ATOMIC reserves?
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>
> This represents a fairly large performance hit.  Just my own quick
> testing on a system using two netns, iperf3, and simple forwarding rules
> shows between 2.5% and 4% performance reduction on x86-64.  Note that it
> is a simple case, and doesn't involve a more involved scenario like
> multiple bridges, tunnels, and internal ports.  I suspect such cases
> will see even bigger hit.
>
> I don't know the impact of the other changes, but just an FYI that the
> performance impact of this change is extremely noticeable on x86
> platform.
>
> ----
> ip netns add left
> ip netns add right
>
> ip link add eth0 type veth peer name l0
> ip link set eth0 netns left
> ip netns exec left ip addr add 172.31.110.1/24 dev eth0
> ip netns exec left ip link set eth0 up
> ip link set l0 up
>
> ip link add eth0 type veth peer name r0
> ip link set eth0 netns right
> ip netns exec right ip addr add 172.31.110.2/24 dev eth0
> ip netns exec right ip link set eth0 up
> ip link set r0 up
>
> python3 ovs-dpctl.py add-dp br0
> python3 ovs-dpctl.py add-if br0 l0
> python3 ovs-dpctl.py add-if br0 r0
>
> python3 ovs-dpctl.py add-flow \
>   br0 'in_port(1),eth(),eth_type(0x806),arp()' 2
>  =20
> python3 ovs-dpctl.py add-flow \
>   br0 'in_port(2),eth(),eth_type(0x806),arp()' 1
>
> python3 ovs-dpctl.py add-flow \
>   br0 'in_port(1),eth(),eth_type(0x800),ipv4()' 2
>
> python3 ovs-dpctl.py add-flow \
>   br0 'in_port(2),eth(),eth_type(0x800),ipv4()' 1
>
> ----
>
> ex results without this patch:
> [root@wsfd-netdev60 ~]# ip netns exec right ./git/iperf/src/iperf3 -c 172=
.31.110.1
> ...
> [  5]   0.00-10.00  sec  46.7 GBytes  40.2 Gbits/sec    0             sen=
der
> [  5]   0.00-10.00  sec  46.7 GBytes  40.2 Gbits/sec                  rec=
eiver
>
>
> ex results with this patch:
> [root@wsfd-netdev60 ~]# ip netns exec right ./git/iperf/src/iperf3 -c 172=
.31.110.1
> ...
> [  5]   0.00-10.00  sec  44.9 GBytes  38.6 Gbits/sec    0             sen=
der
> [  5]   0.00-10.00  sec  44.9 GBytes  38.6 Gbits/sec                  rec=
eiver
>
> I did testing with udp at various bandwidths and this tcp testing.

Thanks for the test case. It works perfectly in the end, but it took me
days to get there because of a random conspiracy of problems I hit :(
Sorry for the slow reply, but I was now able to test another idea for
this. Performance seems to be within the noise with the full series, but
my system is only getting ~half the rate of yours so you might see more
movement.

Instead of slab it reuses the per-cpu actions key allocator here.

https://github.com/torvalds/linux/commit/878f01f04ca858e445ff4b4c64351a25bb=
8399e3

Pushed the series to kvm branch of https://github.com/npiggin/linux

I can repost the series as a second RFC but will wait for thoughts on
this approach.

Thanks,
Nick

