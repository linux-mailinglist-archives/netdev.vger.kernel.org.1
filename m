Return-Path: <netdev+bounces-29771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51067849C9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C06A2811AF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE8B1DDEE;
	Tue, 22 Aug 2023 18:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439911D317
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:57:37 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F51CD1;
	Tue, 22 Aug 2023 11:57:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BC04B5C0156;
	Tue, 22 Aug 2023 14:57:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 22 Aug 2023 14:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692730649; x=1692817049; bh=NuEanQ67p/F6J
	zbkMSjd9SblUPUJPw+qIEvafnE1DO8=; b=ubNz5RnR8nvmpBqTaIpFn2vO2jLNo
	yy9hzwLfFaQFe8RRZZiougpFinfktew9EB5oXZhGyYa3RjAx054PGwlC3ihJ8GAY
	rlokgNZL6dMbGfNl1ZcW9J+joQRD8aXrmd7ViCdhB4H23bBYS2unGAECNhEUuJ7o
	OMqbsO5exV9WoLomUQydFQdCsmVCT3tdpyojxNmTw40YLrI+pitVtzLDNb/gH8qD
	R5ouZc1dBYT/K0I3qqKfGEQlliOlPXTkNeevBZ6jZOiDAHAnHlUue7wrXQiVVAgG
	7uzZ6+shVDb27dpSsF9ySTvD9Je1x9O9/R7LfpeyznkxdPzdwyu2Ebsjg==
X-ME-Sender: <xms:GQXlZJeeQoHigCBFkPywLGMZj6Irrn9lRXAUjnUo3R-PNLkK891DSQ>
    <xme:GQXlZHNMA1HhHsv8ytJ5q8Qwb8TjAZYawadjH5s8F6Z2EorteJ3mKL982jJxlzkpR
    JNj6N24pC4ea3c>
X-ME-Received: <xmr:GQXlZCg3e6CNPrprm4xRV9LtnDPjqt2x4v4kC4c8qfRJqG9RZU6w60oAuYXe4oDcN6w9p7G-2u9LB_Mb1wmsA65_LdHLlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:GQXlZC_Yx9VolEZZH_1hYXhK_PwafUOyVULCxIogbkvjRgPjbVizmQ>
    <xmx:GQXlZFsK6dsoe3d13X3kb9xhGC6GwMUYVsDB98vcSrBSnSpkq0qizA>
    <xmx:GQXlZBHHUfgVldKRWWXx0o5mvoU4jtfCjdLF-7130wcDBa3nF0qrIw>
    <xmx:GQXlZG_Z9E5a0B7-DpBsKrX--Qpqp2PFB8XYfaF4ydXMzlJccyyB3w>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 14:57:28 -0400 (EDT)
Date: Tue, 22 Aug 2023 21:57:24 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 3/3] selftests: forwarding: Add test for load-balancing
 between multiple servers
Message-ID: <ZOUFFOIQeGazn2Dr@shredder>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
 <20230819114825.30867-4-sriram.yagnaraman@est.tech>
 <ZONLz5IyaG+XnUSJ@shredder>
 <DBBP189MB1433714989BBE41321848336951EA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBP189MB1433714989BBE41321848336951EA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 07:36:47PM +0000, Sriram Yagnaraman wrote:
> Do you think it would be OK to drop this patch from the series for now? I can come back with the selftest when I have something working correctly?

There's a more direct way of testing it and that's by counting the
number of times the relevant FIB trace point was triggered. This script
[1] does it for IPv4. For IPv6 the equivalent trace point is called
fib6:fib6_table_lookup. The script can obviously be made nicer.

Before the patches:

# ./mp_repo.sh 
10020

After the patches:

# ./mp_repo.sh 
65535

You can see that after the patches the trace point is triggered for
every packet. Sometimes it's a bit less. I assume because some events
are lost.

Another approach would be to tweak the current test so that $h1 and $rp1
are configured in a similar fashion to veth0 and veth1.

[1]
#!/bin/bash

ip link del dev veth0 &> /dev/null
ip netns del ns1 &> /dev/null

ip link add name veth0 type veth peer name veth1
ethtool -K veth0 tcp-segmentation-offload off
ethtool -K veth1 generic-receive-offload on
echo 20000 > /sys/class/net/veth1/gro_flush_timeout
echo 1 > /sys/class/net/veth1/napi_defer_hard_irqs

ip netns add ns1

ip link set dev veth0 up
ip address add 192.0.2.1/28 dev veth0

ip link set dev veth1 netns ns1
ip -n ns1 link set dev veth1 up
ip -n ns1 address add 192.0.2.2/28 dev veth1

ip -n ns1 link set dev lo up
ip netns exec ns1 sysctl -w -q net.ipv4.conf.all.forwarding=1
ip netns exec ns1 sysctl -w -q net.ipv4.fib_multipath_hash_policy=1

ip -n ns1 link add name dummy1 up type dummy
ip -n ns1 address add 192.0.2.17/28 dev dummy1
ip -n ns1 neigh add 192.0.2.18 lladdr 00:11:22:33:44:55 nud perm dev dummy1
ip -n ns1 neigh add 192.0.2.19 lladdr 00:aa:bb:cc:dd:ee nud perm dev dummy1
ip -n ns1 route add 198.51.100.0/24 nexthop via 192.0.2.18 nexthop via 192.0.2.19

dmac=$(ip -n ns1 -j link show dev veth1 | jq -r '.[]["address"]')
fout=$(mktemp)
perf stat -o $fout -j -e fib:fib_table_lookup -- \
        mausezahn veth0 -a own -b $dmac -A 192.0.2.1 -B 198.51.100.10 \
        -t udp "sp=12345,dp=0-65535" -q
tail -n 1 $fout | jq '.["counter-value"] | tonumber | floor'

