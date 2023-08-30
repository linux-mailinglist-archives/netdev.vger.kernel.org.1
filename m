Return-Path: <netdev+bounces-31423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388C78D6E1
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ACC1C2040F
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E06FC3;
	Wed, 30 Aug 2023 15:17:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EE5398
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:17:34 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B701A3
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:17:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id DED465C0109;
	Wed, 30 Aug 2023 11:17:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 30 Aug 2023 11:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1693408652; x=1693495052; bh=0qPtmyyUpQSLN
	Odgbtpe33Gx+tXIvgjJ/8JvU5B4E+8=; b=tO8IWeumdcaoWkBD1zxdBSwvMjxxP
	PHIEn/o6KClMduHCafpD68S7ggy5J1waZd0ekscD0ItsBl4qPfE7EzlTacdcqCF/
	20VBZ7ybnIlF+YU058eza/9QPlzh4KNs6WLCSnik040m1haqRaof4lEIgM9CpC9X
	bMi7KmumX9JQrgS4YlotjofumsgNDBd6zBKbEjmoI3GK6EfIxu/COrjrSPBRQwqr
	7ET7GyXZRr6uBAiPTtv9fpjTeXeoirTwWNSvx0VqYBNjtRw/+LwaP+V2mCjvFjS6
	Uce4ivRaFX2+uO522UwCaTybnCSOdKm2KlqN2hjHSxK6OQPQgOPDL/mzg==
X-ME-Sender: <xms:jF3vZIkHtnLIbFo7RMw-xnlSYf7YexHD0LXn8vdaZ01OZF48QbE2jg>
    <xme:jF3vZH1niGrB2mgdOCFyOFhWQiBcsfvCZzqQfZe03bEiouAcbZSz305wRiLqcJjSB
    I6j2oB-mOQxvA8>
X-ME-Received: <xmr:jF3vZGq2qq05iDOMBPAvaA5I7oXNqkNkwwSklxDiHR3iAmxRFThNG9eGkAVrq79YGgHsrdhwXx80blx4Ow5O_KO2Q3FQ9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:jF3vZElTLqxkzcP3fRz7EpT_YibOm0OC5r5Fq6RKCVjY70yrp5q1wA>
    <xmx:jF3vZG3QHECtkvV2wVpAZnprlz6FbpOjwben01RgQFotwGZgz8KNiA>
    <xmx:jF3vZLtI6Vo_fbfAGHSWVaSq3pzRilwpHBxr9Z0hxPwKw9wD9SUtgg>
    <xmx:jF3vZLzq7SnSLB-vxY9e5fU-fcULJK6TyEZefztmgvjEu7gIYRS8yw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 11:17:31 -0400 (EDT)
Date: Wed, 30 Aug 2023 18:17:27 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"idosch@nvidia.com" <idosch@nvidia.com>
Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Message-ID: <ZO9dhzhK+psufXqS@shredder>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
 <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZOsNhgd3ZxXEaEA5@shredder>
 <MW4PR11MB57766C3B9C05C94F51630251FDE7A@MW4PR11MB5776.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB57766C3B9C05C94F51630251FDE7A@MW4PR11MB5776.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 09:12:22AM +0000, Drewek, Wojciech wrote:
> In some cases users are trying to use media with power exceeding max allowed value.
> Port split require system reboot so it feels natural to me to restore default settings.

I don't believe it's the kernel's responsibility to undo changes done by
external tools. Given that the tool is able to change this setting, I
assume it can also restore it back to default.

Moreover, it doesn't sound like port split won't work without this
change, so placing this change there only because we assume that a
reboot will follow seems random.

I think the best way forward is to extend ethtool as was already
suggested. It should allow you to avoid the split brain situation where
the hardware is configured by both the kernel and an external tool.

