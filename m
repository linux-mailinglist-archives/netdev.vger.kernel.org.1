Return-Path: <netdev+bounces-19092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE7759A64
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B511C20818
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A83D3A5;
	Wed, 19 Jul 2023 16:02:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325A20F96
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:02:56 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3618CE42
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:02:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A032F5C005F;
	Wed, 19 Jul 2023 12:02:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 19 Jul 2023 12:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689782574; x=1689868974; bh=PmCQ6UyS0G6kN
	FrXMukpNdZM2pxX7XVXZoO3Ow/JLYw=; b=WAhyRz7J/IzFxpOvmdFsV6BAIS5wI
	OJ/+vY9VWW+loGJx0VjsuzPqxL7M9v41o95epbt4boFSNFAehSpWq5wquXOMI2mZ
	kT4ON3gMcbM3yzSJyJzuIZnPFNHf1nGPkFhwJHyfUnNAxLjJOARvbFs/1PNdqgLy
	26KpoxloGySuC6LgEu6IVNBrqu/9axbCDYLYVr3YYOmbzmY2/BMgCBacvC68WWGf
	kvQ+W9TQShj9DB+T5W3M5Ox6japzl1dTdSVCCPQ5FJ6nuZCyDVQB2ht0UH2drw7p
	iyYayYpDDAahN+O4oLI/y5SkVuBLgsUGTNjHHqGtiw4+5BVWKmHOE+lzQ==
X-ME-Sender: <xms:Lgm4ZNXDXdemWoK93PNUTq3AfXZwv3xAnbEMaVlQ-DcSpXeIzIpjbg>
    <xme:Lgm4ZNnbL3c1ERHGFF7NPY_Q0vC10uJhqQI6KhPtrI2mxB_jnH6NjYRksLX9ISHi8
    _nBKgt08kkaRbc>
X-ME-Received: <xmr:Lgm4ZJbpUZBkjH_YTDKRcYyeJhF0zZYq6eRGLhsi1eod6WJuO1PpcMpwv7vc5XWiic17dy1yfxnSdbAxj0M910t_Ogw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:Lgm4ZAWl6LmXdKNGD3lzmGXAep-z8LLHrlEC6C49M7WQFl_JF4FyVw>
    <xmx:Lgm4ZHmFMN-JuVq2qADDhxn5MzprjYvdN_lNk-TRKxcsF28pDsxkpA>
    <xmx:Lgm4ZNcmBhoOeG_dWxeE_wW4sL-XPavDOE5rENp3lQkBrS0twx_ydw>
    <xmx:Lgm4ZCsXS8bAF4rjzzIRu71gZ2dk6qJzLWY5dgbhVGdlo6T2CjoXLQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 12:02:53 -0400 (EDT)
Date: Wed, 19 Jul 2023 19:02:50 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: do not match device when remove source route
Message-ID: <ZLgJKo09Z3idzAr5@shredder>
References: <20230719095449.2998778-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719095449.2998778-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:54:49PM +0800, Hangbin Liu wrote:
> +ipv6_del_addr_test()
> +{
> +	echo
> +	echo "IPv6 delete address route tests"
> +
> +	setup
> +
> +	set -e
> +	$IP li add dummy1 type dummy
> +	$IP li set dummy1 up
> +	$IP li add dummy2 type dummy
> +	$IP li set dummy2 up
> +	$IP li add red type vrf table 1111
> +	$IP li set red up
> +	$IP ro add vrf red unreachable default
> +	$IP li set dummy2 vrf red
> +
> +	$IP addr add dev dummy1 2001:db8:104::1/64
> +	$IP addr add dev dummy1 2001:db8:104::11/64
> +	$IP addr add dev dummy1 2001:db8:104::12/64
> +	$IP addr add dev dummy1 2001:db8:104::13/64
> +	$IP addr add dev dummy2 2001:db8:104::1/64
> +	$IP addr add dev dummy2 2001:db8:104::11/64
> +	$IP addr add dev dummy2 2001:db8:104::12/64
> +	$IP route add 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
> +	$IP route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
> +	$IP route add table 0 2001:db8:107::/64 via 2001:db8:104::2 src 2001:db8:104::13
> +	$IP route add vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
> +	$IP route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
> +	set +e
> +
> +	# removing address from device in vrf should only remove route from vrf table

removing address from device in vrf should only remove it as a preferred
source address from routes in vrf table

> +	echo "    Regular FIB info"
> +
> +	$IP addr del dev dummy2 2001:db8:104::11/64
> +	# Checking if the source address exist instead of the dest subnet

s/exist/exists/

> +	# as IPv6 only remove the preferred source address, not whole route.

s/remove/removes/

> +	$IP -6 ro ls vrf red | grep -q 2001:db8:104::11

I prefer "src 2001:db8:104::11". Same in other places.

> +	log_test $? 1 "Route removed from VRF when source address deleted"

Unlike IPv4, the route is not removed so maybe "Preferred source address
removed ..." (or something similar). Same in other places.

> +
> +	$IP -6 ro ls | grep -q 2001:db8:104::11
> +	log_test $? 0 "Route in default VRF not removed"
> +
> +	$IP addr add dev dummy2 2001:db8:104::11/64
> +	$IP route replace vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
> +
> +	$IP addr del dev dummy1 2001:db8:104::11/64
> +	$IP -6 ro ls | grep -q 2001:db8:104::11
> +	log_test $? 1 "Route removed in default VRF when source address deleted"
> +
> +	$IP -6 ro ls vrf red | grep -q 2001:db8:104::11
> +	log_test $? 0 "Route in VRF is not removed by address delete"
> +
> +	# removing address from device in vrf should only remove route from vrf
> +	# table even when the associated fib info only differs in table ID

Likewise, route not remove.

> +	echo "    Identical FIB info with different table ID"
> +
> +	$IP addr del dev dummy2 2001:db8:104::12/64
> +	$IP -6 ro ls vrf red | grep -q 2001:db8:104::12
> +	log_test $? 1 "Route removed from VRF when source address deleted"
> +
> +	$IP -6 ro ls | grep -q 2001:db8:104::12
> +	log_test $? 0 "Route in default VRF not removed"
> +
> +	$IP addr add dev dummy2 2001:db8:104::12/64
> +	$IP route replace vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
> +
> +	$IP addr del dev dummy1 2001:db8:104::12/64
> +	$IP -6 ro ls | grep -q 2001:db8:104::12
> +	log_test $? 1 "Route removed in default VRF when source address deleted"
> +
> +	$IP -6 ro ls vrf red | grep -q 2001:db8:104::12
> +	log_test $? 0 "Route in VRF is not removed by address delete"
> +
> +	# removing address from device in default vrf should remove route from
> +	# the default vrf even when route was inserted with a table ID of 0.

Likewise.

> +	echo "    Table ID 0"
> +
> +	$IP addr del dev dummy1 2001:db8:104::13/64
> +	$IP -6 ro ls | grep -q 2001:db8:104::13
> +	log_test $? 1 "Route removed in default VRF when source address deleted"
> +
> +	$IP li del dummy1
> +	$IP li del dummy2
> +	cleanup
> +}

