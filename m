Return-Path: <netdev+bounces-24386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B577005B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1DD28263D
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBECA95F;
	Fri,  4 Aug 2023 12:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DE8F52
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:40:24 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07046A8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:40:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 199FE5C0091;
	Fri,  4 Aug 2023 08:40:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 04 Aug 2023 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691152822; x=1691239222; bh=MjhgaDQPL21nI
	hvSns7G9GQAMxGe71mmFz1UUc6CMtE=; b=DUZQ+CRDQsQRSW51/c2ZHELkuLBfZ
	Y3GVsGnu/Iu0mbZo+7OGTV32y7Hj6uHrBEWyEvbu5qHdelren6lxsLpTCBOFHyLr
	L+9eSPJr9hx7hgVqo+8pa2zVODxy+W+cgTR7H8mlI0l/Vbx1cv8XE6JvPPJNMs8/
	eMhOnr4vyj5PffRFXCU+VQ+1gq4uwgPqBMxze6Od4h6BekJFkt+GR6ZISXusKVgw
	rnYMxxxKvFKYnE6gS8K+3KLTnjZM1zuyuzaqRzyYFfjKLYmD26cyxDZjNHjzqWqU
	uKeJiljqNJ0rSxyQPDhmrl9wMF4mSlK0MsHersmAOtMcQZGmaa4vErZLQ==
X-ME-Sender: <xms:tfHMZJ3y34xUIZ0ZZKrXxc9JH20wBb1Spvs-N5O7n3almST5rWfBEg>
    <xme:tfHMZAF3BUabuWd05A-R9C8R9P-E-q1s0B9KOBOvD6RPBp0FHgL_QBETVWRlNePVP
    bLwoORpA9TBZ-w>
X-ME-Received: <xmr:tfHMZJ7pikMNMGlWkb7RdE6T6ybKF8Da8ppGDgb7IAygbkVV5hTnTwzlsuFYfmiHtRD9ZUxFNP2x48gcBrBYWkNGILc9Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgud
    eifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:tfHMZG3YlDYtKz8L8nwgo2KYaKbVpkJkFW8nE_fxjQoL67qaFoVDiA>
    <xmx:tfHMZMHYkT6FcisiEbNKUiYh5hyPRK6k6plKR15TbPCM9HexT-md3A>
    <xmx:tfHMZH9MqV39lkLYKoYLBscf5IsqDtbEZiIAfJERWksQcKlyHfeEXQ>
    <xmx:tvHMZKZ1X4_eQjGKxSpBpQFlU7pG31Uk2GBVWm0_ZtLn4yIkVjMKhg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 08:40:20 -0400 (EDT)
Date: Fri, 4 Aug 2023 15:40:17 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
	tglx@linutronix.de, vadim.fedorenko@linux.dev, kaber@trash.net,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: Fix incorrect deletion of ETH_P_8021AD
 protocol vid from slaves
Message-ID: <ZMzxsYwiejVov13M@shredder>
References: <20230802114320.4156068-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802114320.4156068-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 07:43:20PM +0800, Ziyang Xuan wrote:
> BUG_ON(!vlan_info) is triggered in unregister_vlan_dev() with
> following testcase:
> 
>   # ip netns add ns1
>   # ip netns exec ns1 ip link add bond0 type bond mode 0
>   # ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
>   # ip netns exec ns1 ip link set bond_slave_1 master bond0
>   # ip netns exec ns1 ip link add link bond_slave_1 name vlan10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link add link bond0 name bond0_vlan10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link set bond_slave_1 nomaster
>   # ip netns del ns1
> 
> The logical analysis of the problem is as follows:
> 
> 1. create ETH_P_8021AD protocol vlan10 for bond_slave_1:
> register_vlan_dev()
>   vlan_vid_add()
>     vlan_info_alloc()
>     __vlan_vid_add() // add [ETH_P_8021AD, 10] vid to bond_slave_1
> 
> 2. create ETH_P_8021AD protocol bond0_vlan10 for bond0:
> register_vlan_dev()
>   vlan_vid_add()
>     __vlan_vid_add()
>       vlan_add_rx_filter_info()
>           if (!vlan_hw_filter_capable(dev, proto)) // condition established because bond0 without NETIF_F_HW_VLAN_STAG_FILTER
>               return 0;
> 
>           if (netif_device_present(dev))
>               return dev->netdev_ops->ndo_vlan_rx_add_vid(dev, proto, vid); // will be never called
>               // The slaves of bond0 will not refer to the [ETH_P_8021AD, 10] vid.
> 
> 3. detach bond_slave_1 from bond0:
> __bond_release_one()
>   vlan_vids_del_by_dev()
>     list_for_each_entry(vid_info, &vlan_info->vid_list, list)
>         vlan_vid_del(dev, vid_info->proto, vid_info->vid);
>         // bond_slave_1 [ETH_P_8021AD, 10] vid will be deleted.
>         // bond_slave_1->vlan_info will be assigned NULL.
> 
> 4. delete vlan10 during delete ns1:
> default_device_exit_batch()
>   dev->rtnl_link_ops->dellink() // unregister_vlan_dev() for vlan10
>     vlan_info = rtnl_dereference(real_dev->vlan_info); // real_dev of vlan10 is bond_slave_1
> 	BUG_ON(!vlan_info); // bond_slave_1->vlan_info is NULL now, bug is triggered!!!
> 
> Add S-VLAN tag related features support to bond driver. So the bond driver
> will always propagate the VLAN info to its slaves.
> 
> Fixes: 8ad227ff89a7 ("net: vlan: add 802.1ad support")
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

