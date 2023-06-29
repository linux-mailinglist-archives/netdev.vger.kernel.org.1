Return-Path: <netdev+bounces-14617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B2742AE7
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FDE1C20AA8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E7134C9;
	Thu, 29 Jun 2023 16:59:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513D13AC2
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:59:20 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597763585
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:59:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 1BC085C0275;
	Thu, 29 Jun 2023 12:59:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 12:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688057956; x=1688144356; bh=xEzbi19XlEF+w
	yANU2Wo06hoWaJvBXE/Cfmlo6BW1U4=; b=ST3kyErkWRLKesxqKoe+loVmiL70r
	q/wVOMHFlPmHbic5lNh1KXv3ynhXIKMx8SDrFEWoUTm24QIfj2dYNDPHM28dcCv7
	swBFhAmWM+D1K8j9VxOuWgR/1KYHcG/WvfKWuFnfQnKg+/7akKv1vWQ2UZcy7MfV
	S4a80fWXxPW8CFZaxSvU49zGXdxPE67GG7gIpKKgkNDKRjKiu+u8xV2rPJfLj70l
	EzqKC/ixgqF2k9DyEvyjEcOaxRewfTji35rx9DdzK8Lc8uxbDaJmo4UWwChd4xXx
	y5tXI/i3nKLlGhOkK7Azt9mOFh9Kl+Vcx9r56q1kXAMuX9iOkta1rgbbQ==
X-ME-Sender: <xms:Y7idZBgj1my1zoebrS8wv_Ug7d8iI48EWRcBjpsr8FiohbsPztSiTg>
    <xme:Y7idZGCdyiyDdaGLHcuvDA4t3fWJPlTFCMBd63XkpQjSNkqd8l5aE2hNLuRq56rFU
    X7FO2x4M7tgbjY>
X-ME-Received: <xmr:Y7idZBGaiWdbPwZLqFtVYxhD6FfRYhmjQnKG965yJq4AI4890ZKpRB9R40xPIlKOZWp-829g0KuLFxJ8yt-_UYmcs8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgf
    duieefudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:Y7idZGRLkcA5NoJ3Fw37xNJop5_IqRMeBaWgleXlgwYkyiUahshFUg>
    <xmx:Y7idZOy1DPytjctfFrjDZdEKl7RgLymUZsAw0yDtZD19h1dbZ4d9rQ>
    <xmx:Y7idZM4ZUpsH1xhlBLREE7uw81al9RAIEuWRqz5Z_QmvLtTfTwlIhA>
    <xmx:ZLidZDscgWwzvG-XCKUQVHxGr3E8H9FXlPvuMOVzVkTX16_-gCSK-A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jun 2023 12:59:14 -0400 (EDT)
Date: Thu, 29 Jun 2023 19:59:10 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nayan Gadre <beejoy.nayan@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Routing in case of GRE interface under a bridge
Message-ID: <ZJ24XsOnpKZFna/d@shredder>
References: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
 <ZJ1nIzt6IE0DSPKs@shredder>
 <CABTgHBu24rSvuECSAHRtLj21fzwzWnYpKd5M9uL-z-_tTT0THA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTgHBu24rSvuECSAHRtLj21fzwzWnYpKd5M9uL-z-_tTT0THA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

(Please avoid top-posting).

On Thu, Jun 29, 2023 at 09:00:21PM +0530, Nayan Gadre wrote:
> Yes, the l2gre0 on System A and System B is a gretap created using
> following command
> 
> ip link add l2gre0 type gretap remote 192.168.0.10 local 192.168.0.103
>             --> and vice versa on System B.
> 
> On system A, l2gre0 and eth0 are under a bridge br0. l2gre0 does not
> have an IP address.

That's OK. It's meaningless to assign an IP address to a bridge port.

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
> route to 10.10.10.0/24 it will encapsulate.

The overlay IP address is irrelevant. System A does not inspect it, it
simply forwards Ethernet frames (based on DMAC) between both bridge
ports - eth0 and l2gre0.

As to whether it gets flooded or not, it depends on the DMAC of the
frame received via eth0 and the FDB of br0. I expect the DMAC to be the
MAC of l2gre0 on system B. You can dump the FDB on system A using the
following command:

# bridge fdb show br br0 | grep master

> Is this the behavior in case of a bridged tunnel interface ?.

This is the encapsulation flow on system A as I understand it from your
data:

1. Ethernet packet is forwarded by br0 from eth0 to l2gre0.

2. l2gre encapsulates the Ethernet packet with
{sip=192.168.0.103,dip=192.168.0.10,ip_proto=0x2f,gre (proto=0x6558)}

3. Encapsulated packet is routed out of br.1 that has the most specific
route of 192.168.0.0/24 towards 192.168.0.10

