Return-Path: <netdev+bounces-20795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EF0761040
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F961C20E46
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB51D2FA;
	Tue, 25 Jul 2023 10:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206D1D2E3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:06:48 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F510F7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:06:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 561CA32007F1;
	Tue, 25 Jul 2023 06:06:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 25 Jul 2023 06:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690279574; x=1690365974; bh=qEHtKmnPuw12O
	0RcAfxMPhs2BOM4wbOIMzYOD+yXDCw=; b=ukHx7/A8RWZQeu+b0CumiUf0FS9dS
	2kTGnzAHlAWGXahjXDJ3Z/hRAkeIuQjunZEfOI+78lS4x3FAiF/ChP1qKH3s+E4l
	M9HjbzSwpcHtJmz7mtcCjSpij44Zke0O6Pd5W0fAdvEFy77uvV5B2iVwXbo/3A0S
	BFhldCYr5r4FLdC8db0Lw346BkpJbuk+yOSxhddv6EiFhUoYLEhwX4Z61/sDrPYo
	dSkaM1rGFG0EhN9gSKEc7FLbssSO1tN1XHNrmphgdE4pAIktlGInM6K5lgm6YbYn
	5VnxyhUJDz7BldpulrmqTVEDJVep1Y1d05IqmHIgQe0srp6epi8adI6+A==
X-ME-Sender: <xms:lp6_ZFZ15jCq1UDHcVQQL8T-NmUP0V-oa4ihFXoqG1ydyiV4BLQfcA>
    <xme:lp6_ZMZVyeb-9HNOKWsLhqkAoA3svBR8W0-wSyFGNrEVOEKNa1Z7WxD4q2gT4LbqG
    XD2YUFEPCFy6bI>
X-ME-Received: <xmr:lp6_ZH_BseQLqVZSKF0VzmeBMYR-jaRjqeCgaBsWY-9zFmrMF5aD8BGP-QkEkQWgg4I_-8tMI2zPGKAbotYKAIuApng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:lp6_ZDrpfttaHVClX1yGMelBg6C3zC7lUmFl-gbmoiniSt8qQVMX_w>
    <xmx:lp6_ZAouTwSyQ3Jo3qp2Jo-_frtSdFkKzKb4n7uOSngqVS3V1iJUFA>
    <xmx:lp6_ZJQyMpegDM8oMyCFmm-EkomUR0EIBrEGCuN4vUjGUPAtFf2M3Q>
    <xmx:lp6_ZFA1Ec_w_hb7jxzVgXlBrXvkYdNWiK7yv12DGKLHota50N4xqQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 06:06:13 -0400 (EDT)
Date: Tue, 25 Jul 2023 13:06:09 +0300
From: Ido Schimmel <idosch@idosch.org>
To: David Ahern <dsahern@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZL+ekVftp24TzrHz@shredder>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
 <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1>
 <ZLzhMDIayD2z4szG@shredder>
 <8c8ba9bd-875f-fe2c-caf1-6621f1ecbb92@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8ba9bd-875f-fe2c-caf1-6621f1ecbb92@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 12:12:00PM -0600, David Ahern wrote:
> On 7/23/23 2:13 AM, Ido Schimmel wrote:
> > 
> > I don't know, but when I checked the code and tested it I noticed that
> > the kernel doesn't care on which interface the address is configured.
> > Therefore, in order for deletion to be consistent with addition and with
> > IPv4, the preferred source address shouldn't be removed from routes in
> > the VRF table as long as the address is configured on one of the
> > interfaces in the VRF.
> > 
> 
> Deleting routes associated with device 2 when an address is deleted from
> device 1 is going to introduce as many problems as it solves. The VRF
> use case is one example.

This already happens in IPv4:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip address add 192.0.2.1/24 dev dummy1
# ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
# ip -4 r s
192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
198.51.100.0/24 dev dummy2 scope link src 192.0.2.1 
# ip address del 192.0.2.1/24 dev dummy1
# ip -4 r s

IPv6 only removes the preferred source address from routes, but doesn't
delete them. The patch doesn't change that.

Another difference from IPv4 is that IPv6 only removes the preferred
source address from routes whose first nexthop device matches the device
from which the address was removed:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip address add 2001:db8:1::1/64 dev dummy1
# ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
# ip -6 r s
2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
2001:db8:2::/64 dev dummy2 src 2001:db8:1::1 metric 1024 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
fe80::/64 dev dummy2 proto kernel metric 256 pref medium
# ip address del 2001:db8:1::1/64 dev dummy1
# ip -6 r s
2001:db8:2::/64 dev dummy2 src 2001:db8:1::1 metric 1024 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
fe80::/64 dev dummy2 proto kernel metric 256 pref medium

And this is despite the fact that the kernel only allowed the route to
be programmed because the preferred source address was present on
another interface in the same L3 domain / VRF:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
Error: Invalid source address.

The intent of the patch (at least with the changes I proposed) is to
remove the preferred source address from routes in a VRF when the
address is no longer configured on any interface in the VRF.

Note that the above is true for addresses with a global scope. The
removal of a link-local address from a device should not affect other
devices. This restriction also applies when a route is added:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip -6 address add fe80::1/64 dev dummy1
# ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1
Error: Invalid source address.
# ip -6 address add fe80::1/64 dev dummy2
# ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1

