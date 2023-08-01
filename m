Return-Path: <netdev+bounces-23251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B976B6D2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80E9281ACB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDA22F10;
	Tue,  1 Aug 2023 14:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344322F09
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:08:12 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC11B7
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:08:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7F9835C00F3;
	Tue,  1 Aug 2023 10:08:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 01 Aug 2023 10:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690898883; x=1690985283; bh=Xby8HLT8C7btS
	IsdEjYfEcLT37Dg9lTHcyAV7ilAYng=; b=OwgoBorPELIZ42kHN/zk+MI5Lc2/V
	y3l61xMx3PWsCmbXOud9W7jDphm/cpvfLjeRK1mGvp873bYi5ELc5pgVuuSGKyrC
	LkiuYXWvcteD/APMm8X1lr0eil2c8ve4H5OIsnXW0Nj8KAWTRQvX4VoGA3NPV4Q8
	qJ+RzGgvLG2uOVu6IUojcIFE4LKJ6TS79PPv/u88NL+xz9jYS7ZgOTBeNbHmTZCf
	TZRR+tmRQ1ptfNq80iPrJs3bRHEl2KTKaXEMqVHpQzzgYjesMUNdHXWluZOv/N0S
	AtWNIZB1h3Oo9wljbBHopzz/vI/DUZJJCv6M4dBfIzoc1JmZVKV5SrU4A==
X-ME-Sender: <xms:whHJZL8eUuRhYuuEMSRy74cFhH7ZowTpdUXV50g8LuncMvH1vu88nw>
    <xme:whHJZHvNoECEGXJdJ1jFdWYCmcaOeciwYb6-hz6aKZtNrzrXpkV1XtukNCR4_9BKU
    upKco9GQOtW-6w>
X-ME-Received: <xmr:whHJZJBX2AuZu3SGmAW9wZMaMoYuz9PNJp3pHUqb-eRjoTHiP0_cm7WhB0C65NIAAan4y9-FFRm39eLt3LsB6d7uFz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgud
    eifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:whHJZHcUbEf9XqoxzHuVql77GmfvAAQKjqgq7Bc7MLk6STapxMVBzQ>
    <xmx:whHJZANlX88fmRgv5xPSXLGI4LxVPzQnq72E9xw_CCBrqbujSl7QNA>
    <xmx:whHJZJlQCTpegwPHB1T680QS51eVl1HSVchGHjIgU7aXNw1SYHuk8Q>
    <xmx:wxHJZMCxENdgXeLWzBvZzEuf5FRqG3kaOWEuxDsrJGDxzPd54RcXxg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 10:08:01 -0400 (EDT)
Date: Tue, 1 Aug 2023 17:07:57 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bigeasy@linutronix.de,
	wsa+renesas@sang-engineering.com, kaber@trash.net,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] vlan: Fix to delete vid only when by_dev has hw
 filter capable in vlan_vids_del_by_dev()
Message-ID: <ZMkRvQFwMdjmcCh0@shredder>
References: <20230801095943.3650567-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801095943.3650567-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 05:59:43PM +0800, Ziyang Xuan wrote:
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index 0beb44f2fe1f..79cf4f033b66 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -436,8 +436,11 @@ void vlan_vids_del_by_dev(struct net_device *dev,
>  	if (!vlan_info)
>  		return;
>  
> -	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
> +	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
> +		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
> +			continue;
>  		vlan_vid_del(dev, vid_info->proto, vid_info->vid);

vlan_vids_add_by_dev() does not have this check which means that memory
will leak [1] if the device is enslaved after the bond already has a
VLAN upper.

I believe the correct solution is to explicitly set the STAG-related
features [3] in the bond driver in a similar fashion to how it's done
for the CTAG features. That way the bond driver will always propagate
the VLAN info to its slaves.

Please check the team driver as well. I think it's suffering from the
same problem. If so, please fix it in a separate patch.

[1]
unreferenced object 0xffff888103efbd00 (size 256):
  comm "ip", pid 351, jiffies 4294763177 (age 19.697s)
  hex dump (first 32 bytes):                                                          
    00 10 7a 11 81 88 ff ff 00 00 00 00 00 00 00 00  ..z.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:                                                                          
    [<ffffffff81a88c0a>] kmalloc_trace+0x2a/0xe0                     
    [<ffffffff840f349c>] vlan_vid_add+0x30c/0x790
    [<ffffffff840f4a68>] vlan_vids_add_by_dev+0x148/0x390
    [<ffffffff82eea5e8>] bond_enslave+0xaf8/0x5d50
    [<ffffffff837fbfd1>] do_set_master+0x1c1/0x220       
    [<ffffffff8380711c>] do_setlink+0xa0c/0x3fa0  
    [<ffffffff8381ee09>] __rtnl_newlink+0xc09/0x18c0
    [<ffffffff8381fb2c>] rtnl_newlink+0x6c/0xa0 
    [<ffffffff8381d4ee>] rtnetlink_rcv_msg+0x43e/0xe00
    [<ffffffff83a2c920>] netlink_rcv_skb+0x170/0x440
    [<ffffffff83a2a2cf>] netlink_unicast+0x53f/0x810  
    [<ffffffff83a2af0b>] netlink_sendmsg+0x96b/0xe90
    [<ffffffff83708e0f>] ____sys_sendmsg+0x30f/0xa70
    [<ffffffff837129fa>] ___sys_sendmsg+0x13a/0x1e0 
    [<ffffffff83712c6c>] __sys_sendmsg+0x11c/0x1f0  
    [<ffffffff842fe5c8>] do_syscall_64+0x38/0x80   
unreferenced object 0xffff888112ffab60 (size 32):
  comm "ip", pid 351, jiffies 4294763177 (age 19.697s)
  hex dump (first 32 bytes):
    a0 bd ef 03 81 88 ff ff a0 bd ef 03 81 88 ff ff  ................
    88 a8 0a 00 01 00 00 00 cc cc cc cc cc cc cc cc  ................
  backtrace:
    [<ffffffff81a88c0a>] kmalloc_trace+0x2a/0xe0
    [<ffffffff840f3599>] vlan_vid_add+0x409/0x790
    [<ffffffff840f4a68>] vlan_vids_add_by_dev+0x148/0x390
    [<ffffffff82eea5e8>] bond_enslave+0xaf8/0x5d50
    [<ffffffff837fbfd1>] do_set_master+0x1c1/0x220
    [<ffffffff8380711c>] do_setlink+0xa0c/0x3fa0
    [<ffffffff8381ee09>] __rtnl_newlink+0xc09/0x18c0
    [<ffffffff8381fb2c>] rtnl_newlink+0x6c/0xa0
    [<ffffffff8381d4ee>] rtnetlink_rcv_msg+0x43e/0xe00
    [<ffffffff83a2c920>] netlink_rcv_skb+0x170/0x440
    [<ffffffff83a2a2cf>] netlink_unicast+0x53f/0x810
    [<ffffffff83a2af0b>] netlink_sendmsg+0x96b/0xe90
    [<ffffffff83708e0f>] ____sys_sendmsg+0x30f/0xa70
    [<ffffffff837129fa>] ___sys_sendmsg+0x13a/0x1e0
    [<ffffffff83712c6c>] __sys_sendmsg+0x11c/0x1f0
    [<ffffffff842fe5c8>] do_syscall_64+0x38/0x80

[2]
#!/bin/bash

ip link add name dummy1 type dummy
ip link add bond1 type bond mode 802.3ad
ip link add link bond1 name bond1.10 type vlan id 10 protocol 802.1ad
ip link set dev dummy1 master bond1
ip link del dev dummy1

[3]
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 484c9e3e5e82..447b06ea4fc9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5901,7 +5901,9 @@ void bond_setup(struct net_device *bond_dev)
 
        bond_dev->hw_features = BOND_VLAN_FEATURES |
                                NETIF_F_HW_VLAN_CTAG_RX |
-                               NETIF_F_HW_VLAN_CTAG_FILTER;
+                               NETIF_F_HW_VLAN_CTAG_FILTER |
+                               NETIF_F_HW_VLAN_STAG_RX |
+                               NETIF_F_HW_VLAN_STAG_FILTER;
 
        bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
        bond_dev->features |= bond_dev->hw_features;

> +	}
>  }
>  EXPORT_SYMBOL(vlan_vids_del_by_dev);
>  
> -- 
> 2.25.1
> 
> 

