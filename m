Return-Path: <netdev+bounces-33262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B304579D388
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEE91C20DE7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67F18AFA;
	Tue, 12 Sep 2023 14:26:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80595377
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:26:44 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DB310D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:26:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 777D43200989;
	Tue, 12 Sep 2023 10:26:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 10:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1694528802; x=1694615202; bh=A9Yxufzp7Uv3QFjrOPYY9Pejoi6vmjb+Oe0
	p0j5+f/c=; b=lTpEgsYcdZVr1G1p2Li7c1yhtCDgJDTxT75VEApComjwkjteP9u
	aYkEa/imoyVhDiFvfdxU4OlWbSyOfvc1vEvboLKCvzYta9xn6WOECzMIp5LPAMj3
	xCIXhO72YObCXju5oGyO6X9Q8099dy559fiQ5LSuX/GekiDrf25xAnmyG8ByKcfu
	bYOx+fnVbTTUkWf+7MGdvy80PmctyZW1rSS9eWr6/GBOPQduX/tkOW6yvwYSO5nb
	ZVikgGKBdKUoaG6kqrDSDggUEImioAE5Ov/gMQbC4HUKoFKMjCcdvw1jzSIwIjwe
	vtgHNDn0zSI/IBee7OkafwKUvlLcMuEaikQ==
X-ME-Sender: <xms:IXUAZX-XUeuGskZ4UJ3d3N-Bd7GsMPqyByASEHpDVJ51uQ-zeNxmXg>
    <xme:IXUAZTu345JkSFUtUDI0QClydELkYJzqaL2UPrVmeikxq2GchjI_YIDjVNxBztNGM
    XkGZd3SvuXeIHI>
X-ME-Received: <xmr:IXUAZVBeWC21p5Y2_Z0tkq8J9YH0Z5BA6SC1gte24FJtgXMeZ6TCJ8enXJZJY1SroGvJ-W9RGF1FrwDvKk3VXvA0EsAiDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetieevjefgffffkeeivdegfeeivddugfefveeugedvgfetueefveeluedt
    gfelteenucffohhmrghinhepnhhvihguihgrrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:IXUAZTd0_0nzNlzdWHAc0pGH-dzAr8NK2wFsSJSM2ngR1_CwdKNfWQ>
    <xmx:IXUAZcOpJRWv7PtTNvox8Sg6U97x_Zfumm98VXXoSdZ0LGPzPs7kFA>
    <xmx:IXUAZVkWOfI2TD_hDFp91EAGjkRzx-kYzkzjtoMZ3PTik_n5lyagYw>
    <xmx:InUAZRqOwhV1ZdacHBIF0MVFoZ_0K2tZhFU_heHQbsqeNok1rEAUmA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 10:26:40 -0400 (EDT)
Date: Tue, 12 Sep 2023 17:26:37 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"idosch@nvidia.com" <idosch@nvidia.com>
Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Message-ID: <ZQB1HcpTsB2Sf6Co@shredder>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
 <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZOsNhgd3ZxXEaEA5@shredder>
 <MW4PR11MB57766C3B9C05C94F51630251FDE7A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZO9dhzhK+psufXqS@shredder>
 <MW4PR11MB5776601FD7C2C577C78576A3FDE4A@MW4PR11MB5776.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR11MB5776601FD7C2C577C78576A3FDE4A@MW4PR11MB5776.namprd11.prod.outlook.com>

On Fri, Sep 01, 2023 at 01:34:04PM +0000, Drewek, Wojciech wrote:
> 
> 
> > -----Original Message-----
> > From: Ido Schimmel <idosch@idosch.org>
> > Sent: środa, 30 sierpnia 2023 17:17
> > To: Drewek, Wojciech <wojciech.drewek@intel.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> > idosch@nvidia.com
> > Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
> > 
> > On Tue, Aug 29, 2023 at 09:12:22AM +0000, Drewek, Wojciech wrote:
> > > In some cases users are trying to use media with power exceeding max
> > allowed value.
> > > Port split require system reboot so it feels natural to me to restore default
> > settings.
> > 
> > I don't believe it's the kernel's responsibility to undo changes done by
> > external tools. Given that the tool is able to change this setting, I
> > assume it can also restore it back to default.
> 
> I agree with that, but we can end up with no link if we don't restore
> default settings. Let me explain how.
> 
> > 
> > Moreover, it doesn't sound like port split won't work without this
> > change, so placing this change there only because we assume that a
> > reboot will follow seems random.
> 
> After port split, we might end up with no link in one of the ports.
> In dual port card if we increase max pwr on the 1st cage the 2nd one
> will have max pwr decreased automatically. This might be useful if we have port
> option with count 1, the second cage is not used in this case. If we then split and
> use two ports now, the second port will use second cage which has decreased max pwr, default module
> used there will not work.

Not sure I understand how it's related to port split. You have a dual
port card with two netdevs (e.g., eth0 and eth1) and two cages. You used
some tool to increase the max power on the first cage which means that
the second cage will have its max power decreased. Now you split the
first port:

# devlink port split eth0 count 2

eth0s0 and eth0s1 correspond to the first cage. Why are they affected by
the second cage?

I have a feeling we mean different things by "port split". As far as I'm
concerned, you split a port in order to connect a splitter cable to the
cage. For example:
https://network.nvidia.com/related-docs/prod_cables/PB_MCP7H50-Vxxxyzz_200GbE_QSFP56_to_2x100GbE_QSFP56_DAC.pdf

> 
> So, should we leave the restoration of the default settings to the user?

Let's first clear up the above. BTW, if a port doesn't come up because
of power issues you can try communicating it to user space using
'ETHTOOL_LINK_EXT_STATE_POWER_BUDGET_EXCEEDED'.

> 
> > 
> > I think the best way forward is to extend ethtool as was already
> > suggested. It should allow you to avoid the split brain situation where
> > the hardware is configured by both the kernel and an external tool.
> 
> I'll try to follow up with the ethtool extension.

