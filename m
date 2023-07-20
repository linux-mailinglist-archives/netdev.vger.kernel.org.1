Return-Path: <netdev+bounces-19499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3875AF93
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DF4281BD5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F918007;
	Thu, 20 Jul 2023 13:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957E17FE6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:22:13 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212F10FC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:22:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F9E85C0090;
	Thu, 20 Jul 2023 09:22:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 09:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689859331; x=1689945731; bh=9dt+OwiuQEPoV
	cyr8rsnyRt9cuZ+LObiG1wXmj06xW8=; b=KH/yXZT+nIicxhmJ0nW2w5HR7UWXN
	6HQElE9etwWkZjfKl7E6whgcTr0IBEj4dwsVCaReXYGBcaG/wCMlVzvAPSM36+XY
	/cT3aHe9+/FictXPxcvrHRhhlcva7H8LUAO++N8k9cMoY/hPVgyUrBdNHkoLiUvk
	ibSYRfygGgL29typ0ZoCqPADLYDjLHiWEU7GlJrvHgoLQ+pvpnNLiLHr288iNubU
	9uLsKAWO3tai3g4XTW9cp9fQPlZlCzRqAiT9aKH7mJfiIFV2h8Lu7jSQuyEJc31e
	hCY9PmSMKGVY6T2DLIW4aJiBMuzBov1arWq+nuK6fKm9XwgR4HOkroMRQ==
X-ME-Sender: <xms:AjW5ZPmrHFqKDcWISNotHVc0iGWg7v-rtG0wH8pSpqN6Idv-dqBRnA>
    <xme:AjW5ZC0LOeCACQ3g_8dqiiWewy-XOwiWrizGUKCANnYw-i0lkHuEJFhnV09zsQ-Dm
    lY9j02Tfwlb0PQ>
X-ME-Received: <xmr:AjW5ZFqIMAPL4ezNG7_tvxC4DeEg_Ph8Yc9i9ZIppMDseltMp-LKv-BcE9YmDjIIPiO2_xyEe-o0gliN4bemF9USzpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:AjW5ZHlWBvrWWK7g0eviHIz1zd-PwVxBXW4l0oLTz-PiBDvpQdynkg>
    <xmx:AjW5ZN1LMwgqM60f54315T-OJfjJEV5KANBvyO2_qwzIeQMuacgI7Q>
    <xmx:AjW5ZGt3oqotM34YrWx9sT3sx8tS3WuPD-W-Y9L8Bz-qfIx4X3TwsA>
    <xmx:AzW5ZF9OiF0Xy3v4YnVks21N71P-fW0YMBvL-nI1gsXz5MW5iER3tw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 09:22:10 -0400 (EDT)
Date: Thu, 20 Jul 2023 16:22:05 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZLk0/f82LfebI5OR@shredder>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720065941.3294051-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 02:59:41PM +0800, Hangbin Liu wrote:
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

[...]

> Ido notified that there is a commit 5a56a0b3a45d ("net: Don't delete
> routes in different VRFs") to not affect the route in different VRFs.
> So let's remove the rt dev checking and add an table id checking.
> Also remove the !rt-nh checking to clear the IPv6 routes that are using
> a nexthop object. This would be consistent with IPv4.
> 
> A ipv6_del_addr test is added for fib_tests.sh. Note that instead
> of removing the whole route for IPv4, IPv6 only remove the preferred
> source address for source routing. So in the testing use
> "grep -q src $src_ipv6_address" instead of "grep -q $dst_ipv6_subnet/64"
> when checking if the source route deleted.
> 
> Here is the fib_tests.sh ipv6_del_addr test result.

[...]

> 
> Reported-by: Thomas Haller <thaller@redhat.com>
> Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

One nit below

[...]

> @@ -1869,6 +1869,96 @@ ipv4_del_addr_test()
>  	cleanup
>  }
>  
> +ipv6_del_addr_test()
> +{

[...]

> +}
> +
>  

Double blank line

