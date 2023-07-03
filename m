Return-Path: <netdev+bounces-15026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7242974550C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694111C2040E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499687F9;
	Mon,  3 Jul 2023 05:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DD7E3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:45:13 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4690
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 22:45:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fba03becc6so4366607e87.0
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688363109; x=1690955109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3z7/4iM/dWZrOl5igcoZlxQftKmnq4HcL4Ni+lHR10=;
        b=qXSjQOWLqP+DJYirpFGi8yHP0CtISotGm4MtQ3LfzUrhVqcjia/zoDM8ACsjiXSQoJ
         EweXU+DZpyjnAmfw6au6Qxw1yvl7M8vU3SxqZtw5uvGF82uHSiG0EFaHWK7uVOtVpEEi
         t4hia0Uz9M5tTDJgGTwd3jJF+yVzFFVPwrqd12oEc1WJ6R0q+7ROUIjL3V1Z3Yu+G/Df
         42NFzv3nfTDjUzyeqixvjfJDU38lZnm01wa/FCv8CA/ol5Bx4vlkLnq2bdvYYRSsWKg4
         WgFIJhTp4KHEWX9/xJBXwHkl8qvDOmUwl75lcEu1vKlwnF+lHBlTcqsUy/RgZi/YdTxK
         XySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688363109; x=1690955109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3z7/4iM/dWZrOl5igcoZlxQftKmnq4HcL4Ni+lHR10=;
        b=N60RoCIQRdjmPZ1vSDUIWewgU1rU5Ri0MPDocatVDliWeTEpRsDwzpZFc19tleHy9/
         RbrkHuuvHzS/3rQefhpgis5+KBh+9aWO2th35syVyfI7iBPhpWTeTJXkFwqaY441KoPH
         /3KBXJrDi3BeizZ2Ussiw0VNyk6TT2bn9r9BmfgeqcPe0xhIpGaMP+RxNLij6viPwe0M
         3k2QSH4wQuewCxSt2D+qlyC5PI34Vm+BuAox7y803fjKStT9Ft35elNDc9tClbsY8hKT
         RvOseIYyczp/7go0M1FH8fgfN1O7c4EMetP+ZtauSreaobnaoZLUMGqA2LXiOEdutbj3
         Ju2A==
X-Gm-Message-State: ABy/qLYOcKw2ENP0PJvDD4vFGXFHMM1WR04en34VT8CMw5is1gRsMaCx
	MN/zN0UjdJKltJc6Ontcv3hN5VY6+sgS4smg8W/G5jP9IfNLUA==
X-Google-Smtp-Source: APBJJlHLiMslvnnJLFKK18mOIRMPt8SOP9aaPIRjpMc6HPIy9smioI5N9TwvYovIpwEB+gp3IS/y9OEjoeDZ2RRqrjk=
X-Received: by 2002:a05:6512:252b:b0:4f8:5e62:b94b with SMTP id
 be43-20020a056512252b00b004f85e62b94bmr3287404lfb.9.1688363109173; Sun, 02
 Jul 2023 22:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
 <ZJ1nIzt6IE0DSPKs@shredder> <CABTgHBu24rSvuECSAHRtLj21fzwzWnYpKd5M9uL-z-_tTT0THA@mail.gmail.com>
 <ZJ24XsOnpKZFna/d@shredder>
In-Reply-To: <ZJ24XsOnpKZFna/d@shredder>
From: Nayan Gadre <beejoy.nayan@gmail.com>
Date: Mon, 3 Jul 2023 11:14:57 +0530
Message-ID: <CABTgHBvV=dv-W2N7Jxqp3AWqq+XC3majN2oqdd26bBu4WrobHg@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 10:29=E2=80=AFPM Ido Schimmel <idosch@idosch.org> w=
rote:
>
> (Please avoid top-posting).
>
> On Thu, Jun 29, 2023 at 09:00:21PM +0530, Nayan Gadre wrote:
> > Yes, the l2gre0 on System A and System B is a gretap created using
> > following command
> >
> > ip link add l2gre0 type gretap remote 192.168.0.10 local 192.168.0.103
> >             --> and vice versa on System B.
> >
> > On system A, l2gre0 and eth0 are under a bridge br0. l2gre0 does not
> > have an IP address.
>
> That's OK. It's meaningless to assign an IP address to a bridge port.
>
> > On system B, l2gre0 is independent but has IP address 10.10.10.1, and
> > a DHCP server is running on it providing IP to clients connected
> > through the tunnel.
> >                       System A
> >  |                               System B
> >                                             192.168.0.103            |
> >                      br0                         br1
> >     |                        eth0
> > l2gre0
> >            eth0           l2gre0            eth1                     |
> >                   192.168.0.10                        10.10.10.1
> >
> > On system A:
> > / # ip r
> > default via 192.168.0.10 dev br1.1
> > 169.254.0.0/16 dev br1.1 proto kernel scope link src 169.254.32.107
> > 192.168.0.0/24 dev br1.1 proto kernel scope link src 192.168.0.103
> >
> > On system B:
> > ngadre@in01-7h4wrf3:~$ ip r
> > default via 10.110.234.254 dev eno1 proto dhcp metric 100
> > 10.10.10.0/24 dev l2gre0 proto kernel scope link src 10.10.10.1
> > 192.168.0.0/24 dev enp3s0 proto kernel scope link src 192.168.0.10
> >
> > As we can see, on System B there is a route pointing at l2gre0.
> > However, there is no such route on System A. Yet the packet gets
> > encapsulated
> > A client connected to eth0 on System A sends packet with destination
> > 10.10.10.1 (def gateway). So I am guessing l2gre0 receives this packet
> > since it gets flooded by br0 and even though System A not having a
> > route to 10.10.10.0/24 it will encapsulate.
>
> The overlay IP address is irrelevant. System A does not inspect it, it
> simply forwards Ethernet frames (based on DMAC) between both bridge
> ports - eth0 and l2gre0.
>
> As to whether it gets flooded or not, it depends on the DMAC of the
> frame received via eth0 and the FDB of br0. I expect the DMAC to be the
> MAC of l2gre0 on system B. You can dump the FDB on system A using the
> following command:
>
> # bridge fdb show br br0 | grep master
>
> > Is this the behavior in case of a bridged tunnel interface ?.
>
> This is the encapsulation flow on system A as I understand it from your
> data:
>
> 1. Ethernet packet is forwarded by br0 from eth0 to l2gre0.
>
> 2. l2gre encapsulates the Ethernet packet with
> {sip=3D192.168.0.103,dip=3D192.168.0.10,ip_proto=3D0x2f,gre (proto=3D0x65=
58)}
>
> 3. Encapsulated packet is routed out of br.1 that has the most specific
> route of 192.168.0.0/24 towards 192.168.0.10

Ok, so packet is forwarded from eth0 to l2gre0, and it would be internally
(by the kernel "br_flood/br_forward") pushed on the l2gre0 transmit
path via  "ipgre_xmit"

