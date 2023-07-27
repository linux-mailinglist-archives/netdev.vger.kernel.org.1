Return-Path: <netdev+bounces-21926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAF7654D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA11C2162A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AFB171BF;
	Thu, 27 Jul 2023 13:22:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DF1640A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:22:27 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6AF2726
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:22:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 74F4A5C00A3;
	Thu, 27 Jul 2023 09:22:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 27 Jul 2023 09:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690464143; x=1690550543; bh=pPCYJppTrdV8d
	FEm0IGwrlqT+dDnZZfEAbszc2zRvwk=; b=REEIDKBeTYUSnqXn2JMNy1L5l6skj
	qXjXYM/yy9fTxNsVOzD2C3xGydnPidhEbVuSnVWud2p9mT0nooUH6K73Z6CZhAOH
	nhEllbNSKk884lX678Vc14U9OXFn7NRMqEy+g3Q3al/9kmPE2snIiISR4gbtwM1Q
	y+djz2jR7K6ROVMD9/oNgzaDZzrgaWHjFiUrAtx7H9n84CE8YeUgGiLSU9lLqUxm
	kdxd3f7HKkdcG0UGRZPLUT7v12YzPZ+ujZ/+VEXNlJEs3+rng6fYQT/lFJHHN327
	24N4AkPUgDdjZeNLXZj9oZZXJJf5798SHwOS/aRuIVnZRkZACQ0kTNtYA==
X-ME-Sender: <xms:j2_CZO3-C7xGXJt-phPFIm8soZJPnviFiWYBFtgjeHx4x51NZndNSA>
    <xme:j2_CZBGVlqiCbS7EWBPL068ja8YpFEcvlfmpyq3vaNUIDP8N82o0ao8LpF1YKCQHv
    jU-yxCRFIp5xN8>
X-ME-Received: <xmr:j2_CZG4WFzM9P3ldiMTL-foF9LUmmpVy6_c7gO3IzeRHYoZieQ8nyuuSiPduF5u001B_JowOnvc3ckYJAV4OdWgDqGM3kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:j2_CZP3MRtUoQuX8_tmL1i8jo8tdtfpwo7QHltR8AXzqSwXngnG6Hg>
    <xmx:j2_CZBFa0AbZwvb2I4OPXbjsKqzeROozVPvgXeeUXyqTZCbUP9bK-A>
    <xmx:j2_CZI87NF6jVQ-M71xCIPGS7VsWtvLfJXotvijFeqfiMM3y_OE5kA>
    <xmx:j2_CZENTG6VO-ruFnxuSVEjmiS5spc3sSlFvUGSW7brjiSUiC8ya0A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 09:22:22 -0400 (EDT)
Date: Thu, 27 Jul 2023 16:22:18 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
Subject: Re: [iproute2,v2] bridge: link: allow filtering on bridge name
Message-ID: <ZMJvirvFkyPWn1qr@shredder>
References: <20230726072507.4104996-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726072507.4104996-1-nico.escande@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 09:25:07AM +0200, Nicolas Escande wrote:
> When using 'brige link show' we can either dump all links enslaved to any bridge
> (called without arg ) or display a single link (called with dev arg).
> However there is no way to dummp all links of a single bridge.
> 
> To do so, this adds new optional 'master XXX' arg to 'bridge link show' command.
> usage: bridge link show master br0
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  bridge/link.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Please update the man page as well

