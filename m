Return-Path: <netdev+bounces-20165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96975E046
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 09:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2006281D18
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF053ECF;
	Sun, 23 Jul 2023 07:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB0EBD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 07:31:14 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B7410FA
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 00:31:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BA8EA320024A;
	Sun, 23 Jul 2023 03:31:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 Jul 2023 03:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690097469; x=1690183869; bh=IEx9sUvXOPDDb
	jS6gWKWNJhZ2Zyy7Nv1QdpeRBUBZeE=; b=oT07vgZDg03WvQ3D3gYPMkec4Yvdm
	xLErGj6FTFgWDNxTjQmRalmVLQhfb8tZRMl2d8z3+n9vaVxzIYe1GshNOq79fGGX
	hSssznMs+GxqvFSKFymnxlUBN+9mMwqD8UQu9LnOn3M8KTKcbVEylpn1foWXsMbJ
	2ZMPax2m1cSwdX58zl2GeM26Cdhisg77fpQeXqWui/bjtlTyRhPP2bQnsRxLXjJ9
	BN+mRhTwFLjJezjrirZ2N+zxm+28/oyGVzAwjLO5b2f7QzokG5lwlkLICZ+l+x7m
	oPrb0u6rhHtjEC9xGyyerWNEtgTAkP/+t5O2Ztsb0c28ObcPh9TRCh9Vg==
X-ME-Sender: <xms:Pde8ZMcrJeqUYf_ujHM022qq8VcgTQtOH71FBHzGDVVHpJLrTYZOVg>
    <xme:Pde8ZOOJkkwIBbm9NU2G1dxYfh7DnPdIseSWMHy5flx7wPW23xR_bP952EXraVXX1
    qvCodubtc11phI>
X-ME-Received: <xmr:Pde8ZNj_6jB8lFCDxD5m-96X0e0R7yS74kf2xqwdOFLop-VPBL9IRPsLVAYu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepudevgfefffetieekffelieejjeefgfekheegveffheelhefgteejvddugeej
    hfetnecuffhomhgrihhnpegrlhhpihhnvghlihhnuhigrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgt
    hhdrohhrgh
X-ME-Proxy: <xmx:Pde8ZB9r7mUpjOyXxt4ok3R_-D1gmpmmNCkrsDBrnmjPmNWJvAfXjw>
    <xmx:Pde8ZIs6mXnt3JFmySomcS0qjwHFj1voLaqCPldSpU8L9qubwLbYBA>
    <xmx:Pde8ZIFr4XPXWnA6r0rLaGE3TcD6u8bRQmU4GerNgTW6txVJWQHXrg>
    <xmx:Pde8ZB72Gj3FLaxno-LNpfesz9S2eZof2tVT6T9Sg4omAe0L5jWCbw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jul 2023 03:31:08 -0400 (EDT)
Date: Sun, 23 Jul 2023 10:31:05 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] bridge/mdb.c: include limits.h
Message-ID: <ZLzXOR6pS/2P+BUX@shredder>
References: <20230720203726.2316251-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720203726.2316251-1-tgamblin@baylibre.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 04:37:26PM -0400, Trevor Gamblin wrote:
> While building iproute2 6.4.0 with musl using Yocto Project, errors such
> as the following were encountered:
> 
> | mdb.c: In function 'mdb_parse_vni':
> | mdb.c:666:47: error: 'ULONG_MAX' undeclared (first use in this function)
> |   666 |         if ((endptr && *endptr) || vni_num == ULONG_MAX)
> |       |                                               ^~~~~~~~~
> | mdb.c:666:47: note: 'ULONG_MAX' is defined in header '<limits.h>'; did you forget to '#include <limits.h>'?
> 
> Include limits.h in bridge/mdb.c to fix this issue. This change is based
> on one in Alpine Linux, but the author there had no plans to submit:
> https://git.alpinelinux.org/aports/commit/main/iproute2/include.patch?id=bd46efb8a8da54948639cebcfa5b37bd608f1069
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Fixes: c5b327e5707b ("bridge: mdb: Add destination VNI support")
Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Similar change was done in commit dd9cc0ee81a6 ("iproute2: various
header include fixes for compiling with musl libc").

Thanks

