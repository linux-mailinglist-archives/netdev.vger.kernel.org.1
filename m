Return-Path: <netdev+bounces-35430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEA7A97AB
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2A32821C5
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C46168DF;
	Thu, 21 Sep 2023 17:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E971199DD
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:56 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F9A5C2
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:05:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E7EEE32009ED;
	Thu, 21 Sep 2023 08:09:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Sep 2023 08:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695298168; x=1695384568; bh=j9l1iUgC0pIY3
	8j8kkS173GVTz7E0Zg5FtYlimNdc1Q=; b=BXAL3cftBayzpsqFv5k/MafAFDkzx
	kVCen8ISvlHaatt0bZVZ2+L4HGXWrIS8j4t6BjYaPHDYC3YMecCkVp7eo6KI/nAZ
	mGHdVBvyEw891k9zrRe1P4c1lhQZTmbokmYunY07TVO12NT4KoOt+Usd15znsdXP
	PMA+bDPT+VbSZi7eOzDUQf46Yx+dS6s96AInMBL39VoJewulTJrv0yu2aEBJRLpF
	Cpi0k3x83kU/zLqM82mr1QgUMsQsc7iFsTJxxSGlK5IBhQPl92Bq5F5ql7NaKCvl
	c5eBH81J0GAkNvGEFcNICuzoxniqcP1bJye8dsMbneKnttYsPdr1C5pSg==
X-ME-Sender: <xms:dzIMZSTSw7SdZ2UBHffbazOgIFm845w2n-IyG3_ubigZg9ti5T6hPg>
    <xme:dzIMZXztUh_wWECxbEXQViqezawi6hGzu4y8bATC8QLBqPD-rKWAd--0laZ5LFmqr
    xCOS--XMcRpmyY>
X-ME-Received: <xmr:dzIMZf3dXEVkADZpr_VYjaW3GUb7WJjf3BWy9MaL2LYphIhse451uFfT2AlKr6XvX1GFvs2N8870cKM8MMq4oTwEIRrlHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:dzIMZeA-G0jyHdSfj_prP2gpjCxADQzGREbk96nwy0vOAi8q8o5SKw>
    <xmx:dzIMZbjJ2qAZmnAdyytAK6ETnDrnwbWSRU6ZXoqFJk_Tnp-pNxTfIA>
    <xmx:dzIMZarP6RSCDKzFKlCByun-w0NDQqtUEH5lNcjE33wqEKJKYamOCg>
    <xmx:eDIMZYvAWGkhr3urUbRkdPa93kpMf4AcMTK04i59Yd2wN_EX9Jo0jQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 08:09:26 -0400 (EDT)
Date: Thu, 21 Sep 2023 15:09:22 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"idosch@nvidia.com" <idosch@nvidia.com>
Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Message-ID: <ZQwycrJW5nhXu0TF@shredder>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
 <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZOsNhgd3ZxXEaEA5@shredder>
 <MW4PR11MB57766C3B9C05C94F51630251FDE7A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZO9dhzhK+psufXqS@shredder>
 <MW4PR11MB5776601FD7C2C577C78576A3FDE4A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZQB1HcpTsB2Sf6Co@shredder>
 <MW4PR11MB5776FD835D06ED08B07D3FD6FDF6A@MW4PR11MB5776.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB5776FD835D06ED08B07D3FD6FDF6A@MW4PR11MB5776.namprd11.prod.outlook.com>

On Fri, Sep 15, 2023 at 01:15:01PM +0000, Drewek, Wojciech wrote:
> In ice driver port split works per device not per port. According to
> /Documentation/networking/devlink/ice.rst, section "Port split":
> 	The "ice" driver supports port splitting only for port 0, as the FW has
> 	a predefined set of available port split options for the whole device.
> And if you look at available port options (same file) you'll see that in case of "Split count" 1
> only quad 1 is working. And in case of "Split count" 2 the second quad might be used. So, if we
> increase max_pwr in the first quad in case of "Split count" 1 and then switch to "Split count" 2,
> the second quad might end up with no link (because it will have decreased max_pwr).

But there's also an option where the second cage isn't actually used.
Anyway, my suggestion is to allow user space to set / get the max power
using ethtool and give user space visibility about link down reason via
the ethtool extended state.

