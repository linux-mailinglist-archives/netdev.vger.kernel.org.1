Return-Path: <netdev+bounces-20173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010775E070
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 10:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB68281C68
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B1ED6;
	Sun, 23 Jul 2023 08:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92137EBD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 08:13:44 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE8E41
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 01:13:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7486432003C0;
	Sun, 23 Jul 2023 04:13:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 23 Jul 2023 04:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690100020; x=1690186420; bh=ptgadqpyzBQEh
	AKCgvZ/HGi5Nhzh2eNlEkKFO/giR7o=; b=gYtPvgCPHFxD6WGiJVlPSsePOz2W7
	6G2QMZDuNPcUE3zVHOqQDhVIdTMNO6+EYpsktxGkUuXd21OsLiAhONnwm2Rk/UFl
	6VG11j4UnzjiZ10Fn+Pg8JNBCoEDb9AWp0X0/BQlcOyvbPXnTocJyKhNfqnl0zx8
	P705DIw+xOoUxkq8Bw1D4KQGH9eHLhxcA1pXym8KVzqcf3eAfcZHiFFXjO2XzuWY
	1PN+XI7t7NjsN/+VUj7X0MUXAUGumyZcg85qqjeVl5/lUq3NstL2rliQv3Om81hZ
	ackbDXTsc5U8aKIPBKChqf1BMpQZFRrK/X9kNhPFonEYlIFeSNBAhA42g==
X-ME-Sender: <xms:NOG8ZBgvaRNZSvo6E-2yzOg9O6fPl3fuOtK_PAYIT5ylLm9VKpiokA>
    <xme:NOG8ZGC5Lkb-cynuXQkSZ0zEqG9fpsT5DBAxlpk4H1H44B4SMt9_ZlpLold0B7l2t
    HYa9Tx0r5SvuUA>
X-ME-Received: <xmr:NOG8ZBGGUfi5XUe2h74TQQ1O0IoU6SX5ClYr0fS-F3aDFT-btrDPx-y4AXQS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:NOG8ZGTHuJODhwC7tzoiZhQqgb2WfB-x8UDeTy67Toi463lQLaNpng>
    <xmx:NOG8ZOyBRK1HVZXSoQM-8HGRL6-AIM59c5nyZ1AGrBEMsgEislIOTA>
    <xmx:NOG8ZM71W0H4TFI4O8HIqii5LmTqy7Hy25X9mfcUplIIFVa_Idxjpg>
    <xmx:NOG8ZFrb1t83hyCwgz3OTuoIkUmeWBAuQ75Resb-r5u1OlyLoaFzqA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jul 2023 04:13:39 -0400 (EDT)
Date: Sun, 23 Jul 2023 11:13:36 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZLzhMDIayD2z4szG@shredder>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
 <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpI6YZPjmVD4r39@Laptop-X1>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 04:59:21PM +0800, Hangbin Liu wrote:
> Hi Ido,
> 
> On Thu, Jul 20, 2023 at 05:49:47PM +0300, Ido Schimmel wrote:
> > Actually, there is another problem here. IPv4 checks that the address is
> > indeed gone (it can be assigned to more than one interface):
> > 
> > + ip link add name dummy1 up type dummy
> > + ip link add name dummy2 up type dummy
> > + ip link add name dummy3 up type dummy
> > + ip address add 192.0.2.1/24 dev dummy1
> > + ip address add 192.0.2.1/24 dev dummy2
> > + ip route add 198.51.100.0/24 dev dummy3 src 192.0.2.1
> > + ip address del 192.0.2.1/24 dev dummy2
> > + ip -4 r s
> > 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
> > 198.51.100.0/24 dev dummy3 scope link src 192.0.2.1 
> > 
> > But it doesn't happen for IPv6:
> > 
> > + ip link add name dummy1 up type dummy
> > + ip link add name dummy2 up type dummy
> > + ip link add name dummy3 up type dummy
> > + ip address add 2001:db8:1::1/64 dev dummy1
> > + ip address add 2001:db8:1::1/64 dev dummy2
> > + ip route add 2001:db8:2::/64 dev dummy3 src 2001:db8:1::1
> > + ip address del 2001:db8:1::1/64 dev dummy2
> > + ip -6 r s
> > 2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
> > 2001:db8:2::/64 dev dummy3 metric 1024 pref medium
> > fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> > fe80::/64 dev dummy2 proto kernel metric 256 pref medium
> > fe80::/64 dev dummy3 proto kernel metric 256 pref medium
> 
> Hmm, what kind of usage that need to add same address on different interfaces?

I don't know, but when I checked the code and tested it I noticed that
the kernel doesn't care on which interface the address is configured.
Therefore, in order for deletion to be consistent with addition and with
IPv4, the preferred source address shouldn't be removed from routes in
the VRF table as long as the address is configured on one of the
interfaces in the VRF.

> BTW, to fix it, how about check if the IPv6 addr still exist. e.g.
> 
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4590,10 +4590,11 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>         struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
>         struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>         struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> +       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> 
> -       if (!rt->nh &&
> -           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> -           rt != net->ipv6.fib6_null_entry &&
> +       if (rt != net->ipv6.fib6_null_entry &&
> +           rt->fib6_table->tb6_id == tb6_id &&
> +           !ipv6_chk_addr_and_flags(net, addr, NULL, true, 0, IFA_F_TENTATIVE) &&
>             ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {

ipv6_chk_addr_and_flags() is more expensive than ipv6_addr_equal() so
better to first check that route indeed uses the address as the
preferred source address and only then check if it exists.

Maybe you can even do it in rt6_remove_prefsrc(). That would be similar
to what IPv4 is doing.

>                 spin_lock_bh(&rt6_exception_lock);
>                 /* remove prefsrc entry */
> 
> Thanks
> Hangbin

