Return-Path: <netdev+bounces-22868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989C2769B07
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AE3281351
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72918C32;
	Mon, 31 Jul 2023 15:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4F14F8E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:45:32 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF21738
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:45:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 99A375C0193;
	Mon, 31 Jul 2023 11:45:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 31 Jul 2023 11:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690818327; x=1690904727; bh=xkQXXzNX8GGnR
	vN3zwpQkG167vWU6FTAGbhJJerYK7s=; b=uYmPsikaLSiZcV/l/+dqhm8LhEhcJ
	IzvPrrlQbpNc2OJ/41isRY9oYAp8EKubA7bOJDPwbUQk8uEXoG1Yf3zmchlAYqLo
	XFQrksJ3oAMcyFRVFuch8FF32ekWWYDJZCDEEqZAaT4vRn//suH49zXN3JuxaPTv
	GlLRKzybNO4hp+ZL5wvgj2CJp4fETbtl+Ju06YZGa+qWz30jJSZN+r96+QqDX5cm
	2enIRtPJxNZHdVfy2Xn/RVtFR4qPKiOlxUH9fpOgtImj82F9rFQWvkoMIDJhc9MJ
	682mRi7SIb8A5zZrE0OC/wFLU1qDY3ebh+vPQBIfQwvAQrziwud/Gh6Hw==
X-ME-Sender: <xms:FtfHZM5hDZcVIOU_wn0bJ80h-FNcBdkN7lFBFtHax3LFGA4vvAGaZQ>
    <xme:FtfHZN7Ub2wsi0fvDTEMY5MQIcj-g49N3OQ8FFK-NwbHglmV9yw8mqe8scpAK776o
    Q6In_umPgCfgGk>
X-ME-Received: <xmr:FtfHZLdu5VxPP9LFk5kj-31lpjl0lQVxnrdRhpbw4_JYm1nkplk8t8AZ6ETL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:FtfHZBL6v7ZBn5sRjh4lf0o4OUiEdtpLoTPxOWVpzNRHx4gpkp4Rvg>
    <xmx:FtfHZAJqRasHSfqJtWMhcnqwMO4eWqRRLzGXEY_q5lw0AHja3Pc9Ag>
    <xmx:FtfHZCyLikAwP10YrYL1ODzhEWCDiylGBW9sBhXL86BsZQQewLf74Q>
    <xmx:F9fHZJpSEA89Uot61OR2cDpgJxb3ju4OYmh7WWo3NFi0rNwoQrvfrg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 11:45:25 -0400 (EDT)
Date: Mon, 31 Jul 2023 18:45:23 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Simon Horman <horms@kernel.org>
Cc: Vlad Buslov <vladbu@nvidia.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	amir.hanania@intel.com, jeffrey.t.kirsher@intel.com,
	john.fastabend@gmail.com
Subject: Re: [PATCH net] vlan: Fix VLAN 0 memory leak
Message-ID: <ZMfXExktiYeVEo/3@shredder>
References: <20230728163152.682078-1-vladbu@nvidia.com>
 <ZMaCB/Pek5c4baCn@shredder>
 <ZMeEU/Aqq0ljY8NE@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMeEU/Aqq0ljY8NE@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 11:52:19AM +0200, Simon Horman wrote:
> perhaps it would be worth including the information added
> by Ido above in the patch description. Not a hard requirement
> from my side, just an idea.

I agree (assuming my analysis is correct).

