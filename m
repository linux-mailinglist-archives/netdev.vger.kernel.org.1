Return-Path: <netdev+bounces-28415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B077F5E7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5690A1C2137B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65613AEA;
	Thu, 17 Aug 2023 12:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8E13AE9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:02:26 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C627B2D65
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:02:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9B281320094C;
	Thu, 17 Aug 2023 08:02:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Aug 2023 08:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692273734; x=1692360134; bh=I+p3R/kSgY3RO
	7p5DuAoJ4o8+P0+J51nm4r/CnuNdhA=; b=ljjH7iQMdAe2JDpwGrIrL2enWiosf
	C0a1sphxHHYYQV2cVxXIToXjsynN8ujURMOPTdxKd+OlpwgskWJwrNReFP2nf8mD
	UCnh6r6cKG19EGqlisHFswCBBRlfJLK0L2zZaHN7JbgdW5UG0p/MAxzukvDrSHot
	Vk/jboHQilMucuzvRDhPwoe2LUWhBhpAsGmrgeJdtc99Fm+wwYWK6UqyGO57s8iC
	7Gu37UUq+rHxrocc5A05XP15eGKCcgSJtebf4Ar5JcSTLqpu5AeYj3pjiFp7WXuc
	TOALY7PjS6cvVXWpIxVjYsOqH/zJhAIzRRcMXc+rYHJqVfQjWFSyJwNOA==
X-ME-Sender: <xms:RQzeZIMfa7_OfbFDajMmSKImpLyS8wqn1Hi0yB4fikXWcLp88lOYMw>
    <xme:RQzeZO84pq1MMDLups4UjXveYCcQkIPei_9OK25UzRnNuHllPkjCo9FrgMezDPqfM
    qkLjQaCM3nd3O8>
X-ME-Received: <xmr:RQzeZPRPofxSX5ytcdJKfGUWxYCnKGhiER4xdj0mNUhpntICa7h3iIgCqPz7A662MhjcmBNsRXh5PpeIca3z2Yu5EtluPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepueelgfegleelvdehteekleejgffgjefgjeejiedtgfekjeffhedvheeutedv
    udeinecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:RgzeZAuvVxAt2C-BfEftCKGQpPVb8I3Z89bPux4c-i6bqSXLndI4Qg>
    <xmx:RgzeZAcuAeHbc2lxBZM-XARwnjCVPCLYVOebrrRgI_bjnmO4p3bE1Q>
    <xmx:RgzeZE1_Nd55tklad2LS9YnL5MXtZqIdR9CQf9AekiLAh9FwllIJjw>
    <xmx:RgzeZFHiAAs1NjUbfFmR2Qa4s7OrVnYUbEjqjBiVAYOfCDRBiNUoAA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Aug 2023 08:02:13 -0400 (EDT)
Date: Thu, 17 Aug 2023 15:02:07 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv6 net-next 1/2] ipv6: do not match device when remove
 source route
Message-ID: <ZN4MP+9wi5w9AL7h@shredder>
References: <20230816060724.1398842-1-liuhangbin@gmail.com>
 <20230816060724.1398842-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816060724.1398842-2-liuhangbin@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 02:07:23PM +0800, Hangbin Liu wrote:
> After deleting an IPv6 address on an interface and cleaning up the
> related preferred source entries, it is important to ensure that all
> routes associated with the deleted address are properly cleared. The
> current implementation of rt6_remove_prefsrc() only checks the preferred
> source addresses bound to the current device. However, there may be
> routes that are bound to other devices but still utilize the same
> preferred source address.
> 
> To address this issue, it is necessary to also delete entries that are
> bound to other interfaces but share the same source address with the
> current device. Failure to delete these entries would leave routes that
> are bound to the deleted address unclear. Here is an example reproducer
> (I have omitted unrelated routes):
> 
> + ip link add dummy1 type dummy
> + ip link add dummy2 type dummy
> + ip link set dummy1 up
> + ip link set dummy2 up
> + ip addr add 1:2:3:4::5/64 dev dummy1
> + ip route add 7:7:7:0::1 dev dummy1 src 1:2:3:4::5
> + ip route add 7:7:7:0::2 dev dummy2 src 1:2:3:4::5
> + ip -6 route show
> 1:2:3:4::/64 dev dummy1 proto kernel metric 256 pref medium
> 7:7:7::1 dev dummy1 src 1:2:3:4::5 metric 1024 pref medium
> 7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
> + ip addr del 1:2:3:4::5/64 dev dummy1
> + ip -6 route show
> 7:7:7::1 dev dummy1 metric 1024 pref medium
> 7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
> 
> As Ido reminds, in IPv6, the preferred source address is looked up in
> the same VRF as the first nexthop device, which is different with IPv4.
> So, while removing the device checking, we also need to add an
> ipv6_chk_addr() check to make sure the address does not exist on the other
> devices of the rt nexthop device's VRF.
> 
> After fix:
> + ip addr del 1:2:3:4::5/64 dev dummy1
> + ip -6 route show
> 7:7:7::1 dev dummy1 metric 1024 pref medium
> 7:7:7::2 dev dummy2 metric 1024 pref medium
> 
> Reported-by: Thomas Haller <thaller@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2170513
> Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

But I suggest removing the Fixes tag given the patch is targeted at
net-next and does not fix a regression (never worked).

