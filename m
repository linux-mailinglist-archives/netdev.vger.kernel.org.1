Return-Path: <netdev+bounces-22634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75380768638
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1444281797
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A83D2E5;
	Sun, 30 Jul 2023 15:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DA3D8A
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:30:28 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206FC4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 08:30:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 4FE595C00F7;
	Sun, 30 Jul 2023 11:30:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 30 Jul 2023 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690731020; x=1690817420; bh=VregdV5gGQLDv
	W2O7QGAy98FSYpJP/hL6Oze/UDQzrM=; b=1wPdlKe5CTHhAwfrvfnRX710AlV71
	AvdyWwik0IDZS3SIPBWmZDD2AfzN+wBBAYFoptYuwgxJfVVirq+4N5Qs4+AZNSzM
	Qr7BOdxAvu/G2KRxKsgPVp6dw1lfcF9/uPb2Wtbbx4T5ZInJil8sYSWKH2Gza5tT
	k9yeFe+fA2t3A5x++QvcZa9oEXDU8F0ZkLv4TtgyOywVSboyq/PqX4oTU1PdXZ6k
	rFk+s0l6BjsAEbiK4Dx+8nxQBzXWPm+SgrEfdbCEPTfu5q600xPV0MwxoYBFOM05
	MdeES5aQIrDHSdEaME58ddCx6rFZt/y7C+QWN6Cszpyof3DOsoRuzwfVw==
X-ME-Sender: <xms:DILGZNVOm4uUqpDxFTVNBnXiBxdALVv5grmy4zOho_1JJsm9fxekgQ>
    <xme:DILGZNkKRqT1CLbPHo3zniKTfTlY03oVcfkKFj0xLC6lo5kMbhZrBHoPBJWPmm1Q6
    DmZXUfWTLpAS20>
X-ME-Received: <xmr:DILGZJbs_QRnEgBpB2lTKHhL3ba44WNDTKIq8QtKfNbIYi5bdbrzY6Q2RWMr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedugdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:DILGZAXs17Wdc6UoK0l1fxDwYS0hqxa8kTsjDomW37BLY2ZdopUm8g>
    <xmx:DILGZHnA25FR3CoxU9VufWFPGItH_SUwsmGgIKI1icHBK5shcfBVQQ>
    <xmx:DILGZNdF8GdEaUV-ePo87JVwyNHz5EUTmqBd4O5p5Y5gIq4KEmfDYg>
    <xmx:DILGZFYT_uwSqLyTbSGGDJWmY9s3Y0KrwW7dX1ldM98GiP3rf-7SkQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 11:30:18 -0400 (EDT)
Date: Sun, 30 Jul 2023 18:30:15 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org, amir.hanania@intel.com,
	jeffrey.t.kirsher@intel.com, john.fastabend@gmail.com
Subject: Re: [PATCH net] vlan: Fix VLAN 0 memory leak
Message-ID: <ZMaCB/Pek5c4baCn@shredder>
References: <20230728163152.682078-1-vladbu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728163152.682078-1-vladbu@nvidia.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 06:31:52PM +0200, Vlad Buslov wrote:
> The referenced commit intended to fix memleak of VLAN 0 that is implicitly
> created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
> doesn't take into account that the feature can be re-set during the
> netdevice lifetime which will cause memory leak if feature is disabled
> during the device deletion as illustrated by [0]. Fix the leak by
> unconditionally deleting VLAN 0 on NETDEV_DOWN event.

Specifically, what happens is:

> 
> [0]:
> > modprobe 8021q
> > ip l set dev eth2 up

VID 0 is created with reference count of 1

> > ethtool -k eth2 | grep rx-vlan-filter
> rx-vlan-filter: on
> > ethtool -K eth2 rx-vlan-filter off
> > ip l set dev eth2 down

Reference count is not dropped because the feature is off

> > ip l set dev eth2 up

Reference count is not increased because the feature is off. It could
have been increased if this line was preceded by:

ethtool -K eth2 rx-vlan-filter on

> > modprobe -r mlx5_ib
> > modprobe -r mlx5_core

Reference count is not dropped during NETDEV_DOWN because the feature is
off and NETDEV_UNREGISTER only dismantles upper VLAN devices, resulting
in VID 0 being leaked.

> > echo scan > /sys/kernel/debug/kmemleak
> > cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888165af1c00 (size 256):
>   comm "ip", pid 1847, jiffies 4294908816 (age 155.892s)
>   hex dump (first 32 bytes):
>     00 80 12 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000081646e58>] kmalloc_trace+0x27/0xc0
>     [<0000000096c47f74>] vlan_vid_add+0x444/0x750
>     [<00000000a7304a26>] vlan_device_event+0x1f1/0x1f20 [8021q]
>     [<00000000a888adcb>] notifier_call_chain+0x97/0x240
>     [<000000005a6ebbb6>] __dev_notify_flags+0xe2/0x250
>     [<00000000d423db72>] dev_change_flags+0xfa/0x170
>     [<0000000048bc9621>] do_setlink+0x84b/0x3140
>     [<0000000087d26a73>] __rtnl_newlink+0x954/0x1550
>     [<00000000f767fdc2>] rtnl_newlink+0x5f/0x90
>     [<0000000093aed008>] rtnetlink_rcv_msg+0x336/0xa40
>     [<000000008d83ca71>] netlink_rcv_skb+0x12c/0x360
>     [<000000006227c8de>] netlink_unicast+0x438/0x710
>     [<00000000957f18cf>] netlink_sendmsg+0x7a0/0xc70
>     [<00000000768833ad>] sock_sendmsg+0xc5/0x190
>     [<0000000048d43666>] ____sys_sendmsg+0x534/0x6b0
>     [<00000000bd83c8d6>] ___sys_sendmsg+0xeb/0x170
> unreferenced object 0xffff888122bb9080 (size 32):
>   comm "ip", pid 1847, jiffies 4294908816 (age 155.892s)
>   hex dump (first 32 bytes):
>     a0 1c af 65 81 88 ff ff a0 1c af 65 81 88 ff ff  ...e.......e....
>     81 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000081646e58>] kmalloc_trace+0x27/0xc0
>     [<00000000174174bb>] vlan_vid_add+0x4fd/0x750
>     [<00000000a7304a26>] vlan_device_event+0x1f1/0x1f20 [8021q]
>     [<00000000a888adcb>] notifier_call_chain+0x97/0x240
>     [<000000005a6ebbb6>] __dev_notify_flags+0xe2/0x250
>     [<00000000d423db72>] dev_change_flags+0xfa/0x170
>     [<0000000048bc9621>] do_setlink+0x84b/0x3140
>     [<0000000087d26a73>] __rtnl_newlink+0x954/0x1550
>     [<00000000f767fdc2>] rtnl_newlink+0x5f/0x90
>     [<0000000093aed008>] rtnetlink_rcv_msg+0x336/0xa40
>     [<000000008d83ca71>] netlink_rcv_skb+0x12c/0x360
>     [<000000006227c8de>] netlink_unicast+0x438/0x710
>     [<00000000957f18cf>] netlink_sendmsg+0x7a0/0xc70
>     [<00000000768833ad>] sock_sendmsg+0xc5/0x190
>     [<0000000048d43666>] ____sys_sendmsg+0x534/0x6b0
>     [<00000000bd83c8d6>] ___sys_sendmsg+0xeb/0x170
> 
> Fixes: efc73f4bbc23 ("net: Fix memory leak - vlan_info struct")
> Signed-off-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

