Return-Path: <netdev+bounces-14545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83C7424D6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03021280CA9
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE209107B3;
	Thu, 29 Jun 2023 11:12:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321610949
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:12:45 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98D125
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 04:12:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0095F5C0117;
	Thu, 29 Jun 2023 07:12:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Jun 2023 07:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688037159; x=1688123559; bh=ukfwBVdtsxIn4
	shVj8CUA3yoKBUYzs3tebDftyZdP3g=; b=fcgqHl+5g3IdeCpxIvvaB7vQzLAus
	c0I8s5wSFKUQ0555imppMu824xABNXB9MRhBTULlSPZCzFrEjeUUnteqJikefrlZ
	bn/cOfaIiDT+3PzPLX/QgQ8SHCznn3HDGDnwPmWrD3TmX4k0JihMGnWHhv58Jg2w
	EjJmsu7Aqin5BNSLJyY88azERADrZDaTVcYRwmYmBnF5bu0sHPFMVCXISrnvMVg5
	NbM/iOjqjPSfZXkYtv8DOwAZ5T+hyJuN2FpES9p+W3Fu+zZ5vQyyP0leAxF4x/Bp
	2p/ezPpbyxn2FfBg6922VHW6WRAu5DLh6OXQbx+L8L4PPYXBKqqnFuI9Q==
X-ME-Sender: <xms:J2edZK1w-EWlSOKnpvjH3Nksb_jVYW6Ba1fmzyk5d-CYQYLOhSvXUg>
    <xme:J2edZNGDdS2765Xs4-SW3u1AYgQLwYkdKSm3_6cYl3VVNWeimzsC6oc9UA9W2Zpg0
    SBX_2C_QYphF1c>
X-ME-Received: <xmr:J2edZC4-g6lwVwdJa8uRPbz-m0zRUcAzeO0ySmUH4bdg02oPbmrhdYVqPGGw6l9t4QYEj-apJ_GF9QWE3p7QUd3QKTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgud
    eifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:J2edZL05CpJKiCQGxPpAwk3528YCFZGAoI9vvQzuh2_3yMqrrm-Ybw>
    <xmx:J2edZNEnurqzAsvUeLLPzpF5yFlT2O39H32DzpisapK551qFom_ofw>
    <xmx:J2edZE9WmzRge5AWxeKWZEzpw6oNc_Kh4Aj65o7aafmSvnAfKt_K_w>
    <xmx:J2edZMz__SRMvzXqyXLp1_LdnAGg7FbwaAheWmIER48fGe-E6tHH1g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jun 2023 07:12:39 -0400 (EDT)
Date: Thu, 29 Jun 2023 14:12:35 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nayan Gadre <beejoy.nayan@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Routing in case of GRE interface under a bridge
Message-ID: <ZJ1nIzt6IE0DSPKs@shredder>
References: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 07:06:45PM +0530, Nayan Gadre wrote:
> I have a "l2gre0" and "eth0" interface under the bridge "br0".

I assume "l2gre0" is a gretap, not ipgre.

> If a packet comes to eth0 interface with a destination IP address say
> 10.10.10.1 which is not known on the Linux system, as there is no
> route for 10.10.10.1, will the l2gre0 interface encapsulate this
> packet and send it across the tunnel ?

The bridge doesn't care about IP addresses when forwarding unicast
packets. Forwarding happens based on DMAC. Packet will be transmitted
through "l2gre0" if the bridge has a matching FDB entry for the DMAC
with "l2gre0" as the destination bridge port or if there is no FDB entry
at all, in which case the packet will be flooded.

One of the attributes of the GRE device is the remote address, which is
the encapsulating destination IP. Linux needs to have a route telling it
how to reach this destination address or the packet will be dropped.

> The other endpoint is on a different Linux system with another l2gre0
> interface having IP address 10.10.10.1
> 
> Thanks
> N Gadre
> 

