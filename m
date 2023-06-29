Return-Path: <netdev+bounces-14600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D187429AC
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E36C1C20AD9
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6812B80;
	Thu, 29 Jun 2023 15:30:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0E12B7A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 15:30:36 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0CAA
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:30:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a5fd1f46so11849661fa.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688052633; x=1690644633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhvyN5mCDcssCXhlyJjVwwAPKJvLMvVKP24NNNAnf0g=;
        b=H3ALMCMWbAXTt6/Ni2xHDyf+FOibsl5DhFVUo1BgAU/K6L5gB5YxPG8WSNMrXNUR5G
         iolOV+7F8apjUKBADtN5NtZsAn0+7wudjsv9BfrVysb4P7VWX+bH7iph83hTAuoPzQKP
         EvaFQxomiK/VkgnxeU2IZ8z/uE/TlEfYaa1v4Ve+MzvdL3O2eSbdTHOylwlkviPddmdf
         Tuns0ZAuPBZ95Ux/ZQXdRq7izhgf9/ToWLqEF+fdck6p0J98csId3SWGY6DMboLe5iww
         TDGWrg2SuSQlQ7HTeiQ/+XYuuJ8AGpNwo14p8OM2Q6iPnUEoJRMzmdlexRf7ZSQBkjrG
         4OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052633; x=1690644633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhvyN5mCDcssCXhlyJjVwwAPKJvLMvVKP24NNNAnf0g=;
        b=Kmxc5AJfqn1gc6IAPmLSac3fEalFy/6UDj/tSkwzmmebAKWLaGtp+RIV3hcHQK3xlx
         Kc0qw1jsg3/96wEHMw8EhHBGkhoJksiOrBjbDYiYSeoXfbEAFs2EzWFyPN+DLHGQPbjK
         GdF3KL2et5WA9ootNBcqJAD3zMrDwfZ7rQd7gqtUHm/J+ZZiCSrHUWNIiskNYtxG/mg7
         LLj33clSv49qL/r6hE3YBA07Aowku3c7EufLcCNy63CE97WD9Qb7M9xM6Y0lPax+QNxC
         7oOBGVmPTYqJ6+rLlskafr78ItgAhXWTKl2yYRmbxbpts2jZSDF/9wdzuxEB+w4DQmMZ
         tgWg==
X-Gm-Message-State: ABy/qLYZNqEeES4bAILgcLhZ0EqdOh1temV6Kc1Wregy0ytrxYTXbkhE
	+ZU1qRINWdMjZtTucdayS93r2me8omtNOWsBhigdBiAmYSozCg==
X-Google-Smtp-Source: APBJJlHM7wMDaEVLiRcla0SZKB14zEdLbuWZbGF/yt2DRvmeH7KcShTB56G5Xgr9+KdsT2ua3u6NZVWYkWC0yg0M4qs=
X-Received: by 2002:ac2:4e87:0:b0:4fb:772a:af13 with SMTP id
 o7-20020ac24e87000000b004fb772aaf13mr209560lfr.28.1688052632837; Thu, 29 Jun
 2023 08:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
 <ZJ1nIzt6IE0DSPKs@shredder>
In-Reply-To: <ZJ1nIzt6IE0DSPKs@shredder>
From: Nayan Gadre <beejoy.nayan@gmail.com>
Date: Thu, 29 Jun 2023 21:00:21 +0530
Message-ID: <CABTgHBu24rSvuECSAHRtLj21fzwzWnYpKd5M9uL-z-_tTT0THA@mail.gmail.com>
Subject: Re: Routing in case of GRE interface under a bridge
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Yes, the l2gre0 on System A and System B is a gretap created using
following command

ip link add l2gre0 type gretap remote 192.168.0.10 local 192.168.0.103
            --> and vice versa on System B.

On system A, l2gre0 and eth0 are under a bridge br0. l2gre0 does not
have an IP address.
On system B, l2gre0 is independent but has IP address 10.10.10.1, and
a DHCP server is running on it providing IP to clients connected
through the tunnel.
                      System A
 |                               System B
                                            192.168.0.103            |
                     br0                         br1
    |                        eth0
l2gre0
           eth0           l2gre0            eth1                     |
                  192.168.0.10                        10.10.10.1

On system A:
/ # ip r
default via 192.168.0.10 dev br1.1
169.254.0.0/16 dev br1.1 proto kernel scope link src 169.254.32.107
192.168.0.0/24 dev br1.1 proto kernel scope link src 192.168.0.103

On system B:
ngadre@in01-7h4wrf3:~$ ip r
default via 10.110.234.254 dev eno1 proto dhcp metric 100
10.10.10.0/24 dev l2gre0 proto kernel scope link src 10.10.10.1
192.168.0.0/24 dev enp3s0 proto kernel scope link src 192.168.0.10

As we can see, on System B there is a route pointing at l2gre0.
However, there is no such route on System A. Yet the packet gets
encapsulated
A client connected to eth0 on System A sends packet with destination
10.10.10.1 (def gateway). So I am guessing l2gre0 receives this packet
since it gets flooded by br0 and even though System A not having a
route to 10.10.10.0/24 it will encapsulate. Is this the behavior in
case of a bridged tunnel interface ?.

On Thu, Jun 29, 2023 at 4:42=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Wed, Jun 28, 2023 at 07:06:45PM +0530, Nayan Gadre wrote:
> > I have a "l2gre0" and "eth0" interface under the bridge "br0".
>
> I assume "l2gre0" is a gretap, not ipgre.
>
> > If a packet comes to eth0 interface with a destination IP address say
> > 10.10.10.1 which is not known on the Linux system, as there is no
> > route for 10.10.10.1, will the l2gre0 interface encapsulate this
> > packet and send it across the tunnel ?
>
> The bridge doesn't care about IP addresses when forwarding unicast
> packets. Forwarding happens based on DMAC. Packet will be transmitted
> through "l2gre0" if the bridge has a matching FDB entry for the DMAC
> with "l2gre0" as the destination bridge port or if there is no FDB entry
> at all, in which case the packet will be flooded.
>
> One of the attributes of the GRE device is the remote address, which is
> the encapsulating destination IP. Linux needs to have a route telling it
> how to reach this destination address or the packet will be dropped.
>
> > The other endpoint is on a different Linux system with another l2gre0
> > interface having IP address 10.10.10.1
> >
> > Thanks
> > N Gadre
> >

