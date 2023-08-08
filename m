Return-Path: <netdev+bounces-25287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB33773B16
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A252814F4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58B134A5;
	Tue,  8 Aug 2023 15:41:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D44C6B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:41:36 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842EC3C39
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 959485C0045;
	Tue,  8 Aug 2023 08:01:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 08 Aug 2023 08:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691496103; x=1691582503; bh=3MZ1DQDBoqq2T
	OoMbhXUPnxYoSc2t7zsZwCDLc3nVaU=; b=ND09TakPepLuGjRUW2jZ3Mk9hQjAB
	coc/qryWv3nMoMD/+Cb/ZMcRG5Rm3ut0goZy5HqqlZGcx66kYbuNYpzmEuop6YX8
	1+6OF06IawBQP9LGoDljjVo2L74Sc1lcBzdZAW132ent4zNQ33HhM0QokYDEoYJY
	uUdKHhmwo+gFA10y0FqD/4tiFiv8cPoPxLEDcenyQMS1ma05Lnw4t7+uxvwGW6PL
	DwwlWtNqnuz0BEqAr8SMGoyfE7Y/KgzWkxpXOZba+hu2otF1lHIxS49D1tFM4kvn
	UOUxMRYTS7xBwvkzFOXhEtmobmFCpMfW3pZt3oiuiY894zmvbmnuECn8w==
X-ME-Sender: <xms:py7SZEC8wyTQpGxFrQLjM9rGwjyC39jkcbHlR-6pbSEBx7TeJ86zdw>
    <xme:py7SZGjDbtUft_4a5HHf4BdxaBbMiY-JDrFzWeFMmtSTp6lkz66BhWsrUSrkm3LXZ
    COHDCacCdF5q04>
X-ME-Received: <xmr:py7SZHn7-K4YusiAR6GTGp9KhjsNkNysalPWF4GVjeCHWim6uRjioerHVKnSviwU4IUCchhE56V8MXIbO3NHD7yjLfNGDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:py7SZKw0YTj2XvsdWqDREiI9p2zn4rrxojudgZfFxJ6tOCR4cmWWug>
    <xmx:py7SZJS5iUlq-8Ug_zbcUlcAhxKcBSeucP0_BWshOQHejtBBu2FMdQ>
    <xmx:py7SZFaYtfm1me2P2Ruy6YQXGbKm1Dj6I5ZYlRpLNtB9uH1Viwg9Sg>
    <xmx:py7SZKT3L4yZ_HGx6nqoxeS0U-tEa1uYd-G89VTKBzpdCWJqn_ojuw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 08:01:42 -0400 (EDT)
Date: Tue, 8 Aug 2023 15:01:39 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org, amir.hanania@intel.com,
	jeffrey.t.kirsher@intel.com, john.fastabend@gmail.com,
	horms@kernel.org
Subject: Re: [PATCH net v2] vlan: Fix VLAN 0 memory leak
Message-ID: <ZNIuo2ckq39GUvAW@shredder>
References: <20230808093521.1468929-1-vladbu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808093521.1468929-1-vladbu@nvidia.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 11:35:21AM +0200, Vlad Buslov wrote:
> The referenced commit intended to fix memleak of VLAN 0 that is implicitly
> created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
> doesn't take into account that the feature can be re-set during the
> netdevice lifetime which will cause memory leak if feature is disabled
> during the device deletion as illustrated by [0]. Fix the leak by
> unconditionally deleting VLAN 0 on NETDEV_DOWN event.

[...]

> Fixes: efc73f4bbc23 ("net: Fix memory leak - vlan_info struct")
> Signed-off-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

