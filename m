Return-Path: <netdev+bounces-19527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8E75B197
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142DC281ED9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3711182D2;
	Thu, 20 Jul 2023 14:49:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC4171D8
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:49:53 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E142127
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:49:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9B1B35C0284;
	Thu, 20 Jul 2023 10:49:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Jul 2023 10:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689864591; x=1689950991; bh=89gugF5HupRKM
	4z70U0+6psL9R7Hp6p81a8aIm1J5+E=; b=Tu0j+VJpqOB97FsvUr9ia7Wh8W4Jj
	fFF544qBm47+kIIU+DYnKzQ80w2FI5df6KmKusYc0oZnPoBapnAq/NgeXK8FMF+8
	al0HZby3BGsRxp9n+wQWh7yPGmY912IcMtqi8Y1mUEIyQ727PTt6iGEUUCH7wUeQ
	+cWjv94Br1MWD8ImFZw/pSZcQPAoOnwDFh0UugfGG9UnUW4fznWOlB8+OK95QzH3
	9LlHdwGlw4pk3K/nMywZ+VL15SyDAPKo/YlsP7KLmABQQQ5SPRd6KeJrTGUAfhJa
	03hOFOeSYYWxRaYcIjm76Mc/FqBNAR1GLs9FQXIkSHJjG4t2DWlHowhXw==
X-ME-Sender: <xms:j0m5ZIiJoM29yf_rC329mDZMQZB2ayrCLolR3vG18aonMa3dALxZ_g>
    <xme:j0m5ZBDbQMpdh6CmkT59sdNAdSuHEA_aav1e6_VrgFNM2yYiafnriD2bnv07h4qo-
    jCB0dLqJNdcJJc>
X-ME-Received: <xmr:j0m5ZAH-jSyA-h6Wg0PYQpW7iIKAtMnIVbc0g5Oonx6TF3iKI-no-rYzL5Lo6dMLiteaA6UxH0-_LTD4uRIS6IAvXrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:j0m5ZJR4edbiq8MV8ad10nYoaulmbhrcY25VjI8TCOGflin1Ci1WVQ>
    <xmx:j0m5ZFwTwTDDj1aNEmI5zi4QZtDacOe6-jbLLCd4zLxizKzCJzZ9ng>
    <xmx:j0m5ZH6CUFtYgIvX9Oa3WuWYgndYDYhdd2gnHPUJ3jfmhdukPsZ-bw>
    <xmx:j0m5ZIrFL3ljlup9M21hYse2xFjy8Chrn0uCUq5gQOUSp0CZUE8vBA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 10:49:50 -0400 (EDT)
Date: Thu, 20 Jul 2023 17:49:47 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZLlJi7OUy3kwbBJ3@shredder>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLk0/f82LfebI5OR@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 04:22:11PM +0300, Ido Schimmel wrote:
> On Thu, Jul 20, 2023 at 02:59:41PM +0800, Hangbin Liu wrote:
> > After deleting an IPv6 address on an interface and cleaning up the
> > related preferred source entries, it is important to ensure that all
> > routes associated with the deleted address are properly cleared. The
> > current implementation of rt6_remove_prefsrc() only checks the preferred
> > source addresses bound to the current device. However, there may be
> > routes that are bound to other devices but still utilize the same
> > preferred source address.
> > 
> > To address this issue, it is necessary to also delete entries that are
> > bound to other interfaces but share the same source address with the
> > current device. Failure to delete these entries would leave routes that
> > are bound to the deleted address unclear. Here is an example reproducer
> > (I have omitted unrelated routes):
> 
> [...]
> 
> > Ido notified that there is a commit 5a56a0b3a45d ("net: Don't delete
> > routes in different VRFs") to not affect the route in different VRFs.
> > So let's remove the rt dev checking and add an table id checking.
> > Also remove the !rt-nh checking to clear the IPv6 routes that are using
> > a nexthop object. This would be consistent with IPv4.
> > 
> > A ipv6_del_addr test is added for fib_tests.sh. Note that instead
> > of removing the whole route for IPv4, IPv6 only remove the preferred
> > source address for source routing. So in the testing use
> > "grep -q src $src_ipv6_address" instead of "grep -q $dst_ipv6_subnet/64"
> > when checking if the source route deleted.
> > 
> > Here is the fib_tests.sh ipv6_del_addr test result.
> 
> [...]
> 
> > 
> > Reported-by: Thomas Haller <thaller@redhat.com>
> > Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Actually, there is another problem here. IPv4 checks that the address is
indeed gone (it can be assigned to more than one interface):

+ ip link add name dummy1 up type dummy
+ ip link add name dummy2 up type dummy
+ ip link add name dummy3 up type dummy
+ ip address add 192.0.2.1/24 dev dummy1
+ ip address add 192.0.2.1/24 dev dummy2
+ ip route add 198.51.100.0/24 dev dummy3 src 192.0.2.1
+ ip address del 192.0.2.1/24 dev dummy2
+ ip -4 r s
192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
198.51.100.0/24 dev dummy3 scope link src 192.0.2.1 

But it doesn't happen for IPv6:

+ ip link add name dummy1 up type dummy
+ ip link add name dummy2 up type dummy
+ ip link add name dummy3 up type dummy
+ ip address add 2001:db8:1::1/64 dev dummy1
+ ip address add 2001:db8:1::1/64 dev dummy2
+ ip route add 2001:db8:2::/64 dev dummy3 src 2001:db8:1::1
+ ip address del 2001:db8:1::1/64 dev dummy2
+ ip -6 r s
2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
2001:db8:2::/64 dev dummy3 metric 1024 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
fe80::/64 dev dummy2 proto kernel metric 256 pref medium
fe80::/64 dev dummy3 proto kernel metric 256 pref medium

