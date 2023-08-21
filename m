Return-Path: <netdev+bounces-29289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518E78281B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFB6280E80
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BAE525B;
	Mon, 21 Aug 2023 11:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F84A3B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 11:39:30 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5ECC3;
	Mon, 21 Aug 2023 04:39:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 507585C274F;
	Mon, 21 Aug 2023 07:39:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 21 Aug 2023 07:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692617968; x=1692704368; bh=L8L1QtzKhNCEw
	R/2bL5QtRE2Pi9Wv5JGehO3UrLRIFE=; b=QMIPMZW3xTf9RjwygzvlG2PPqDkEa
	F+n9EvdBHhvqcRdrAjyMlePtpmTsWJsWEJp/bbe84/f8MVcjMKFhjVBuLwQt82da
	ZF0wdbi8e5Z9NYC4sl83qIwS9tebqA+Xd8OcTodUnsphkM88YVj5R/41bT0zQRvK
	6V1tFNrF0xl3m3ziB+px3p/t1N3rujUNuDkxu2ajZRED0JJg2+ul00NQVA2npeYh
	aWtmvwAuYcVTBUKgAO1hQ4HhjX9CUmhDxRrutS90HK6V267jtnVeqceOCjDKsZGV
	iqJ1hKv01KdPKpgR7IpKavZANj1d864YZpQIxUBFfg4DuP3Z7Yrm/gWtg==
X-ME-Sender: <xms:8EzjZPxh2wXQJu5Wv6SMlVru2Lwbwx6b8UHTAWy2XjCFnP1x-W6HHg>
    <xme:8EzjZHQ8t7zqWgIvzJIGETYVJs50zJCd4peqXFu8R8ldsGYXkHZIoLzdryEI8hSBS
    C1aJ1XseyQVlPk>
X-ME-Received: <xmr:8EzjZJVNpUQCAqekLCkmlxMg06U-4uj0aJeANLCyL4I3IGJna9pXFRY6gsR2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduledggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:8EzjZJhSVb6phvhgU3xRYAF_kYa30DYe1bVyGtT_R_KCpBYQxJqebQ>
    <xmx:8EzjZBB_7OIMXUepYQJmNpJw9Rm4OPOJT0z5duGyF85gpVgMaZWBaw>
    <xmx:8EzjZCIWgZxXHtpOL66t3Sio8rgY9jh_jHe5aqQ1-vhzsLMEGH2KmQ>
    <xmx:8EzjZLDL-C-hg5H7mKbt-px65a5y5cxJ5DG-SpQJieWUca4bs-7pZA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Aug 2023 07:39:27 -0400 (EDT)
Date: Mon, 21 Aug 2023 14:39:24 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/3] ipv4: ignore dst hint for multipath routes
Message-ID: <ZONM7BkQPuPGaYz0@shredder>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
 <20230819114825.30867-2-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819114825.30867-2-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 01:48:23PM +0200, Sriram Yagnaraman wrote:
> Route hints when the next hop is part of a multipath group causes
> packets in the same receive batch to the same next hop irrespective of

Looks like you are missing a word here. "causes packets in the same
receive batch to the same next hop" ?

> multipath hash of the packet. So, do not extract route hint for packets
> whose destination is part of multipath group.

The commit message should also explain how this is done.

> 
> Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> 

No blank line between the fixes tag and the SoB.

In addition, patch prefix should be "PATCH net". See:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Same comments for the IPv6 patch.

Thanks

> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

