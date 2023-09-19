Return-Path: <netdev+bounces-35029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045007A67E5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C9B281760
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA593B7B5;
	Tue, 19 Sep 2023 15:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD23B7AD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:21:07 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03909BC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:21:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2D2B65C0127;
	Tue, 19 Sep 2023 11:21:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Sep 2023 11:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695136864; x=1695223264; bh=RYZQV/afaZN6d
	3w6KRS3aGSW8L5oIQdtZ+qcJ9O+p0g=; b=WnJEbIxIy+wq0VBsYtE6a5GI5zDoP
	qJUTo2LPSLypoAmEg6bq11fu1HtzIlHs5wRVpJYtlPRPbbMFFb3Vdlf0sxA2AbPZ
	v5zhG/v56JKpLlEiShNcdJ90NRnS3svMW7isAi3ZfmkK67Mmoo+phrZgt2G5JVc2
	fuWJ3Iscs7VQQ2fo0akrHkp7ztpuK5hn6TT4fwSgz6cDdFYkvnr1mWHAA0cny9QA
	2ENg5ofZeE2OJOt4Rx/w8QY1xoNa7FEWVha358CYc9Rz6x7Cplj/Oc6xg55THtpl
	OcRIM2YIustJgRrWIyz/oCx2pQ6NfK3FllolUyLYRcPDCCavxBnYTRwLg==
X-ME-Sender: <xms:X7wJZQnwtBsD2_SV07lMBf-CFgsMZWZf-Z8NqTymMfFSBo71Dp_42w>
    <xme:X7wJZf1l9LnhkHLRwbl6S_6tkYLtJFDTy5DvrDWp7obEU9GSP5TgwEUHhbLBzKakt
    2CaClIwesm0xh0>
X-ME-Received: <xmr:X7wJZeoSTSPlcD6lIZGi13rDzsdRxcquoTWlUQ72R_ejBb033DkIF3nPshhleOTftqGefIwbdbpLwYamjsSO6sjZ3d5DhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:X7wJZcm1auchfi68w2wvlUedAIs4k4zO0_5oaTZ2ZQYAffNY6v5FdQ>
    <xmx:X7wJZe3AUYfe_dPLjKilEHEoHsYPcd7QB4lWEu-RNWuo3JRjBTGlbQ>
    <xmx:X7wJZTuvhvK0K3BUbbePnFrRQs41OetxOXtGVU7F4dtAetx7sYgXWA>
    <xmx:YLwJZYM4EeEsGdz3vytKhuueLr01OA46DBihLUrrI3Jmc6fmL0vXyQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 11:21:02 -0400 (EDT)
Date: Tue, 19 Sep 2023 18:20:59 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jiri Benc <jbenc@redhat.com>,
	Gavin Li <gavinl@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Li Zetao <lizetao1@huawei.com>, Thomas Graf <tgraf@suug.ch>,
	Tom Herbert <therbert@google.com>, Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH net] vxlan: Add missing entries to vxlan_get_size()
Message-ID: <ZQm8W9O6WLZ+G5QM@shredder>
References: <20230918154015.80722-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918154015.80722-1-bpoirier@nvidia.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 11:40:15AM -0400, Benjamin Poirier wrote:
> There are some attributes added by vxlan_fill_info() which are not
> accounted for in vxlan_get_size(). Add them.
> 
> I didn't find a way to trigger an actual problem from this miscalculation
> since there is usually extra space in netlink size calculations like
> if_nlmsg_size(); but maybe I just didn't search long enough.
> 
> Fixes: 3511494ce2f3 ("vxlan: Group Policy extension")
> Fixes: e1e5314de08b ("vxlan: implement GPE")
> Fixes: 0ace2ca89cbd ("vxlan: Use checksum partial with remote checksum offload")
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

