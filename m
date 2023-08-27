Return-Path: <netdev+bounces-30901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D1C789C4D
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29C32810E5
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCC2115;
	Sun, 27 Aug 2023 08:47:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337E20EC
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 08:47:10 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7F6BF
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 01:47:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id BD0F632004ED;
	Sun, 27 Aug 2023 04:47:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 27 Aug 2023 04:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1693126027; x=1693212427; bh=d8FxgVYyitRM8
	+FI5tRdQWjZeyVKzL9XUtF8zxAtM9k=; b=WIOhGrO6WGufry9FnWJtQqotIZo68
	FaCg1EczRd7BUGhN9NCa/rh4EHokxV6U1nHZ0DiIsJwAnSPTyNnwAamScGEml7bu
	8FjtUC74wqhyGEZIiioohwnlQ6VZqgm8N3f5OJWRT7BRxf8parpqSBC/MIMw3iR6
	lPKbJcGfx3n4XCQr6qwoqSfoiZmbKw/8jEwQhye014n3sCwTK1Szw/ZokXES2wQ0
	2aesc8+WZpChaaELtw3udnnSrhksPWQOTnSOGEuEZwv7N2dE9Boco6i3GZDcaQjG
	JVA5KHLBrgGfR1Vp/AmedGLIRLRbKgsJ1kY5YqlzBLyA+IQeYd/W12DtA==
X-ME-Sender: <xms:ig3rZNEZqBSUOnaDcOJnVt5FXMXjVv16i1g1uZMuM0cKuEyKWHMlPg>
    <xme:ig3rZCXgZiVLdkYX-P5gi7lw91_1i2Mc8zhRZAaYWr1rwMSq2LsuhBNycsxirNyM4
    Gq-dmn4gU51vZ0>
X-ME-Received: <xmr:ig3rZPIFqwlw0fQ-Guzv2Oq0YmQo0dcYa3TWYv0lLft9qFxOkl1tQ2fqIQzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefvddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:ig3rZDFgJGHZBAgc58CdDSjCUDqEi-bItv-8yPV42ayYSZqIEKEO_w>
    <xmx:ig3rZDW_WHI0sgSxUJ9k6-PD5N1ngdSez_B9-i2BAFww3G49av3ZVA>
    <xmx:ig3rZOOjVScexY_hyG53QeQ5mkwzzo5fVAaYoq6mdfD2WL1hSvmrWA>
    <xmx:iw3rZOSCS9WtpdsN17KxwDkdMTSO8R7SB9QwWRjibbc0npdENb94lQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 04:47:06 -0400 (EDT)
Date: Sun, 27 Aug 2023 11:47:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"idosch@nvidia.com" <idosch@nvidia.com>
Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Message-ID: <ZOsNhgd3ZxXEaEA5@shredder>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
 <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 11:01:07AM +0000, Drewek, Wojciech wrote:
> CC: Ido
> 
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: czwartek, 24 sierpnia 2023 17:32
> > To: Drewek, Wojciech <wojciech.drewek@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
> > 
> > On Thu, 24 Aug 2023 10:54:59 +0200 Wojciech Drewek wrote:
> > > NVM module called "Cage Max Power override" allows to
> > > change max power in the cage. This can be achieved
> > > using external tools. The responsibility of the ice driver is to
> > > go back to the default settings whenever port split is done.
> > > This is achieved by clearing Override Enable bit in the
> > > NVM module. Override of the max power is disabled so the
> > > default value will be used.
> > 
> > Can you say more? We have ETHTOOL_MSG_MODULE_GET / SET, sounds like
> > something we could quite easily get ethtool to support?
> 
> So you're suggesting that ethtool could support setting the maximum power in the cage? 
> Something like:
>  - new "--set-module" parameter called "power-max"
>  - new "--get-module" parameters: "power-max-allowed", "power-min-allowed" indicating limitations reported by the HW.
> 
> About the patch itself, it's only about restoration of the default settings upon port split. Those might be overwritten by 
> Intel's external tools.

Can you please explain why this setting needs to be changed in the first
place and why it needs to be restored to the default on port split?

