Return-Path: <netdev+bounces-14601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1837429C8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEF3280D2C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236D12B82;
	Thu, 29 Jun 2023 15:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E50125C3
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 15:37:25 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4481210B
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:37:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1317562e87.2
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688053042; x=1690645042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM+lYqGzvXpV6u9SbEyk8rOWJLGh0L4jY0jL+xwry6k=;
        b=jcA8pHiqpmgJU++hju+L04xulujGxHjcnCH708/C9ZJ4veHab+9lBh7u09Yjcq3rL5
         XLfcKBX1uxh0anHDtR7EsecPK/stYyUn7uWPTPvVkBLJ+vFmHj6qgPLAq2XGN0BxIcLd
         0uD+XwdTnE38ZpGD+6qDgMd+/UwNT/8oDUwEAcQjEsvpFmm9FPQ3h9iRoV1pIfmEv0YJ
         6f5+B49MFdyU+VJEkR31YN/6GRgjZtIemydFl8kh15mxmJD7fqMFAI6LYaq3BblXhReW
         mTyumrYDVHo8fdJZaHLM3EocRcdh8zXGbFnEG8PLcNu1NTJbBHfOlta0fiTE7sXAw8L5
         uaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688053042; x=1690645042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM+lYqGzvXpV6u9SbEyk8rOWJLGh0L4jY0jL+xwry6k=;
        b=iDVxaHrhcCXK0ETgHu7k/IeM7StKs4Oq8W9WCJZDZ73C+zIJKZXCvuVhhSji4isZPR
         uwkp4oLUHfUYrUBSzHyhu+dLyhM/YaEISbKmiyQeLm3/+KfSFV81MRYYXZlOW2w4WbQ8
         wsM3kcHRyXFzrQVxalmLSv1LPDjjcnQKxKdrYS/foFXc71RskQA5rThe/X5QZzR0+Fcs
         xeleAzbcxG1PWxxx5i0f4aqfroF6OSbFBSykXXQswOLK7TACJB7cniGBNueTCGiuZFC4
         4UVqmIRgg0QGjjgaOhPIxuya/29Kk7XwNkvagg0+zM9o1LAp6/HHzgPEVFYIxSv49dm0
         kZqQ==
X-Gm-Message-State: ABy/qLYx0JHuuY0KiqAw2rwJBEmDjaUVt+TzaCMfHmRRBtIUNoQgtPb5
	BlkPMdgevGMX1TJvSj7bcKnOmQbOmfpt9isWGS51+bZT+mhgew==
X-Google-Smtp-Source: APBJJlGN7N1fhLNGxj18xhEXDF/3wJh+fP4u/x54+AQnnMnd6nmJCaQMGAL0ny06Wlo1srjjiBMOXU96vAvoJ/6W6nk=
X-Received: by 2002:a05:6512:5c8:b0:4fb:8953:bb8 with SMTP id
 o8-20020a05651205c800b004fb89530bb8mr183905lfo.50.1688053041749; Thu, 29 Jun
 2023 08:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
 <ZJ1nIzt6IE0DSPKs@shredder> <CABTgHBu24rSvuECSAHRtLj21fzwzWnYpKd5M9uL-z-_tTT0THA@mail.gmail.com>
In-Reply-To: <CABTgHBu24rSvuECSAHRtLj21fzwzWnYpKd5M9uL-z-_tTT0THA@mail.gmail.com>
From: Nayan Gadre <beejoy.nayan@gmail.com>
Date: Thu, 29 Jun 2023 21:07:10 +0530
Message-ID: <CABTgHBsvmsr+re5wT=dmEyr9ZztZ5NWmYPXOGZ3gmrH7JttqCA@mail.gmail.com>
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

messed up the diagram, here's another attempt.

System A
192.168.0.103 br1.1 <-- eth1
br0 | <---l2gre0
      | <---eth0  --> client connected (receives IP 10.10.10.105)

System B
192.168.0.10 eth0
10.10.10.1  l2gre0 <---dhcp server

On Thu, Jun 29, 2023 at 9:00=E2=80=AFPM Nayan Gadre <beejoy.nayan@gmail.com=
> wrote:
>
> Yes, the l2gre0 on System A and System B is a gretap created using
> following command
>
> ip link add l2gre0 type gretap remote 192.168.0.10 local 192.168.0.103
>             --> and vice versa on System B.
>
> On system A, l2gre0 and eth0 are under a bridge br0. l2gre0 does not
> have an IP address.
> On system B, l2gre0 is independent but has IP address 10.10.10.1, and
> a DHCP server is running on it providing IP to clients connected
> through the tunnel.
>                       System A
>  |                               System B
>                                             192.168.0.103            |
>                      br0                         br1
>     |                        eth0
> l2gre0
>            eth0           l2gre0            eth1                     |
>                   192.168.0.10                        10.10.10.1
>
> On system A:
> / # ip r
> default via 192.168.0.10 dev br1.1
> 169.254.0.0/16 dev br1.1 proto kernel scope link src 169.254.32.107
> 192.168.0.0/24 dev br1.1 proto kernel scope link src 192.168.0.103
>
> On system B:
> ngadre@in01-7h4wrf3:~$ ip r
> default via 10.110.234.254 dev eno1 proto dhcp metric 100
> 10.10.10.0/24 dev l2gre0 proto kernel scope link src 10.10.10.1
> 192.168.0.0/24 dev enp3s0 proto kernel scope link src 192.168.0.10
>
> As we can see, on System B there is a route pointing at l2gre0.
> However, there is no such route on System A. Yet the packet gets
> encapsulated
> A client connected to eth0 on System A sends packet with destination
> 10.10.10.1 (def gateway). So I am guessing l2gre0 receives this packet
> since it gets flooded by br0 and even though System A not having a
> route to 10.10.10.0/24 it will encapsulate. Is this the behavior in
> case of a bridged tunnel interface ?.
>
> On Thu, Jun 29, 2023 at 4:42=E2=80=AFPM Ido Schimmel <idosch@idosch.org> =
wrote:
> >
> > On Wed, Jun 28, 2023 at 07:06:45PM +0530, Nayan Gadre wrote:
> > > I have a "l2gre0" and "eth0" interface under the bridge "br0".
> >
> > I assume "l2gre0" is a gretap, not ipgre.
> >
> > > If a packet comes to eth0 interface with a destination IP address say
> > > 10.10.10.1 which is not known on the Linux system, as there is no
> > > route for 10.10.10.1, will the l2gre0 interface encapsulate this
> > > packet and send it across the tunnel ?
> >
> > The bridge doesn't care about IP addresses when forwarding unicast
> > packets. Forwarding happens based on DMAC. Packet will be transmitted
> > through "l2gre0" if the bridge has a matching FDB entry for the DMAC
> > with "l2gre0" as the destination bridge port or if there is no FDB entr=
y
> > at all, in which case the packet will be flooded.
> >
> > One of the attributes of the GRE device is the remote address, which is
> > the encapsulating destination IP. Linux needs to have a route telling i=
t
> > how to reach this destination address or the packet will be dropped.
> >
> > > The other endpoint is on a different Linux system with another l2gre0
> > > interface having IP address 10.10.10.1
> > >
> > > Thanks
> > > N Gadre
> > >

