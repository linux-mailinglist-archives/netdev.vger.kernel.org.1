Return-Path: <netdev+bounces-207374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFD7B06E77
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B451A621B3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175F289375;
	Wed, 16 Jul 2025 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVStu8eP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9D2857CD;
	Wed, 16 Jul 2025 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649489; cv=none; b=R4PLcl24Es6hb7SS88QJUm+ZY8HVWBLsNkhZqraf+zA/xPGvvxQ1T+xZZGXnxVnF8qsD+lgG6LcPDNAENAmDTxN3AeIUAuRS1vy2RdvVr23I2mFn3fdBZIvtvtzpOuhWHF+fCqGCnoWAfEyiSHGKZB6w+sfoxqjuVuZmVT4iPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649489; c=relaxed/simple;
	bh=mVpCntK75xS5jzzTpeuJ3CoLQsH6KBrp3X5Ed3AgC5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQj15pN2vM6yu18RH9pQDPAIKqOhX639QOTYRO6rpBZDxQFqHZLT5hex8rG5DZd13jTBCmyQmScrh/N3tVmec2BvCkiPVUJuhqCkuwWS4M0U8WOM3OYXVQlEHeBy+jGhNscpZguq2/zu9Oxf27WZ0ciMTRch9KmW4DIGRs04SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVStu8eP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B172C14000C1;
	Wed, 16 Jul 2025 03:04:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Jul 2025 03:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752649486; x=1752735886; bh=PUDpJ8glISb5rW5RwOBPI0cKFoJihOy1ltu
	IeJ0T9XA=; b=QVStu8ePl8+cSqRx3Sg+fo3N55GNPrbIeL2VauUH7CO8t/x1IVm
	wYvciHjA9mO4cKZ81UOSmOIP5Dy+uvE0gpMkuYgsQ+ZR/rJalv15Kkae45632+HN
	5yLDslM2+u6Mbif0t2rB3v7T91zymt1GiOCeQZiBLQ2f7LgeyFNrpdLD+gwgyhB7
	y5sZWRZB4hu43OV6E9CMcZfP3epnMXB1A6PcnG1dDUtNw+PEaPjgqDbLzJsttyeK
	TU1BiYpDa+jZFTxP/GiiJvCdEuvCKJNAB/norStjHtsMMM7xfJ1AUsd3EhdjI+kG
	ginF3RCgVvfM5t7Lpc6WF+0Qv8+ZcvZeDVg==
X-ME-Sender: <xms:DU93aBAg0CoHWR3q4e0VUAY39w8V5sosQ2qOJiKXl6kMeSTLuBFBSQ>
    <xme:DU93aJkRFj8XCjTMeIdV70zFy1zck6Uez7o8zwsU1eEz0jzvRZbK9LQAUUuWMnJx5
    9ySVPGVg6ngzQI>
X-ME-Received: <xmr:DU93aBhA66QtQNklu1TPz1VhGfavxDjD50OvOoK90w-MfUUD2DvjHm5i-2af>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgeeguefgudeuudeuveelgefgjeeftdelgeffgfejjeduudfffefftddthedtteen
    ucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihgu
    ohhstghhrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepughonhhgtghhvghntghhvghnvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhisehrvghsnhhu
    lhhlihdruhhspdhrtghpthhtohepohhstghmrggvshelvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhg
X-ME-Proxy: <xmx:DU93aDi9zfOPu3EFbcYCWJe7p_gqtktO0jRNigK3nTNS3wavAXd7-Q>
    <xmx:DU93aDvU_0MXSyh4mZYjIma6BoaSsALfMA723BA2LQXO_g6v68wGGQ>
    <xmx:DU93aLusdWQyxmtXXMEtgvpF-AAP_i-IfrRWv0vGPqqcXUxWhLZRcA>
    <xmx:DU93aBrVLhZYLSMBhxPr3bWk3OMyrZAEAY6SGYO_lNW6-GzSSbubww>
    <xmx:Dk93aMUiT5Zi42GJtUVllf40mSoDSF--9goV3psyA0P5_RsNy6e7TO12>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 03:04:44 -0400 (EDT)
Date: Wed, 16 Jul 2025 10:04:42 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
	oscmaes92@gmail.com, linux@treblig.org, pedro.netdev@dondevamos.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v3 1/2] net: vlan: fix VLAN 0 refcount imbalance of
 toggling filtering during runtime
Message-ID: <aHdPCpsUUVH-p-mX@shredder>
References: <20250716034504.2285203-1-dongchenchen2@huawei.com>
 <20250716034504.2285203-2-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716034504.2285203-2-dongchenchen2@huawei.com>

On Wed, Jul 16, 2025 at 11:45:03AM +0800, Dong Chenchen wrote:
> Assuming the "rx-vlan-filter" feature is enabled on a net device, the
> 8021q module will automatically add or remove VLAN 0 when the net device
> is put administratively up or down, respectively. There are a couple of
> problems with the above scheme.
> 
> The first problem is a memory leak that can happen if the "rx-vlan-filter"
> feature is disabled while the device is running:
> 
>  # ip link add bond1 up type bond mode 0
>  # ethtool -K bond1 rx-vlan-filter off
>  # ip link del dev bond1
> 
> When the device is put administratively down the "rx-vlan-filter"
> feature is disabled, so the 8021q module will not remove VLAN 0 and the
> memory will be leaked [1].
> 
> Another problem that can happen is that the kernel can automatically
> delete VLAN 0 when the device is put administratively down despite not
> adding it when the device was put administratively up since during that
> time the "rx-vlan-filter" feature was disabled. null-ptr-unref or
> bug_on[2] will be triggered by unregister_vlan_dev() for refcount
> imbalance if toggling filtering during runtime:
> 
> $ ip link add bond0 type bond mode 0
> $ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
> $ ethtool -K bond0 rx-vlan-filter off
> $ ifconfig bond0 up
> $ ethtool -K bond0 rx-vlan-filter on
> $ ifconfig bond0 down
> $ ip link del vlan0
> 
> Root cause is as below:
> step1: add vlan0 for real_dev, such as bond, team.
> register_vlan_dev
>     vlan_vid_add(real_dev,htons(ETH_P_8021Q),0) //refcnt=1
> step2: disable vlan filter feature and enable real_dev
> step3: change filter from 0 to 1
> vlan_device_event
>     vlan_filter_push_vids
>         ndo_vlan_rx_add_vid //No refcnt added to real_dev vlan0
> step4: real_dev down
> vlan_device_event
>     vlan_vid_del(dev, htons(ETH_P_8021Q), 0); //refcnt=0
>         vlan_info_rcu_free //free vlan0
> step5: delete vlan0
> unregister_vlan_dev
>     BUG_ON(!vlan_info); //vlan_info is null
> 
> Fix both problems by noting in the VLAN info whether VLAN 0 was
> automatically added upon NETDEV_UP and based on that decide whether it
> should be deleted upon NETDEV_DOWN, regardless of the state of the
> "rx-vlan-filter" feature.

[...]

> Fixes: ad1afb003939 ("vlan_dev: VLAN 0 should be treated as "no vlan tag" (802.1p packet)")
> Reported-by: syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a8b046e462915c65b10b
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

