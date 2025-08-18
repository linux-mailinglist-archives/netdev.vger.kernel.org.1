Return-Path: <netdev+bounces-214501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A44B29EA1
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE79A189F496
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D870330F814;
	Mon, 18 Aug 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="fhd+aRR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M35/EaaG"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9727E060
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511185; cv=none; b=m+xRqt1XEBpqfTG8OSPF5I+QVzApzBsbDEWP/kQHGAUncqgKRtoBSXGEP7YMIy8zwuJQgVJC3D4hab/tcAYpOxIgEvBbT/CNRBd2zqTtGkEF2W+dZe/SW8eHgM3hnYqelO/UAdCBcjrwQew6hWFqtfbBmOAUqvTTqkW64OnepN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511185; c=relaxed/simple;
	bh=twwPGYS1pbbNbuwI6/Ok6z1KZmaKvAG11JMwUXega2A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NnSXV+qXAUVcQubuMmKDwiNXCaL8nzWhFuYJNS/qhcv99Fr8XZQOeuW0h+y4fVbw3TQ1RqRHcDLdvBH0BR19vMAAjxI4ICn50bQMuiExq/R9h7h/4LY+CR/umlQ112s0Xa5xmLgTaY5Tgtjz1TICB7oFPLNBTptQYbDo8j4uOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=fhd+aRR2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M35/EaaG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86D6C140013C;
	Mon, 18 Aug 2025 05:59:42 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-01.internal (MEProxy); Mon, 18 Aug 2025 05:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1755511182; x=1755597582; bh=vscckBoxHZW6gSP7SrE9QcCOjCZtgpxE
	DeAcTbH1FEg=; b=fhd+aRR22pgq+BmJG7af6D8wpREpiF5rWNjOmSWiKXdr+UBH
	F6dGf12xgEDJnSwYF5WiiN0crR4FJ41KAW8TTcRunK7W9HXOm6LjBlVf2NGIFs9x
	tSvxUr8461L5I2ATt5EkyHUyNH71yj8mN9guFe2BXdPmmZwEoaMohWXe9DZhA7N2
	MmNsARtLGPO466yUk0EiuJTNeIrso84VtZznrp9Go9Mc28VeGAKyq8Gm+qqWslGn
	C46g4dHV1RXA9Io6l2KYXE8aSSub0c12x3WOwUvOYQkF79nccS0K8DWZlkpUS0sT
	vB12hEB9Uo8evtMT+4NT89a21wOHwxropYNXgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755511182; x=
	1755597582; bh=vscckBoxHZW6gSP7SrE9QcCOjCZtgpxEDeAcTbH1FEg=; b=M
	35/EaaGURVdgmi0tZFgfhTZg+sRG3h5w6pOvOtiyQWR24iRlXwrcqNxPE9mtzoY9
	JRLjojs4pu5aDMxWA1kiLOI4kf6FIrqB03rIswkq8T8Z/H/TBNEVIiApIQ3a+j7u
	z1xe7YLOCwC2dt98dD3TRolNkYZ715DJlMcjzenWaQ2R7IEjE6Nace7hUXYybPp2
	MgAscISay2kZndK1wuN6ByfE7ZJyqKp1SHwz6OD4rDFcShJJmrptqiLSQYbX08P6
	21lxkKMJ+0o/2n6FBNBSmnQ6yS/WE9lWbStl1p96/eXSnGli58jw6qYl23M+hJzH
	30oUYkqNg7UM2lLTAG62w==
X-ME-Sender: <xms:jfmiaLO1f_Hpfr9DaG3Xw4Pcg84qQzlzR4n8_9-gatKsdAYCClHSGg>
    <xme:jfmiaF9LmZOXSSRm1q8tuy3zuJ4GXFh7J4dI-U7YVXb_XX9gv49S58a2lJTdPjAKe
    yj3yrlxJneGcuXLjWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdforghthhgvficuofgtuehrihguvgdfuceomhgrthhtseht
    rhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpefgvdegkeejheffhe
    eileehveffteelkeevgfffleduffetvdekhfeiudevtdffheenucffohhmrghinheprghr
    mhhlihhnuhigrdhorhhgrdhukhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrg
    hrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehl
    vggvmhhhuhhishdrihhnfhhopdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:jfmiaHOlOKxuSzdQ0svgfN9o9qIve7Gvhp4KcdThGkeMI48Z_AEM2g>
    <xmx:jfmiaNdW2htAXvd7wz5zjEv-I2tZK7AqygrlSfR0MKqz8qrHqddvpw>
    <xmx:jfmiaMtN0QtHA0aPXaWlnXG5CC-2rlHnmsUHuNxhZOuzZ50dfFCzvQ>
    <xmx:jfmiaGk-PApM0bPrnSW-KMuPigpnWUHIxUWZW2oaqR-wYK30rAS3pw>
    <xmx:jvmiaFD6HKi7_EHdWzI5Jiy9LwKSTwYkpLBersIKOkgq06SeTxom4cvh>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B592A15C008C; Mon, 18 Aug 2025 05:59:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUKiri1zhdSZ
Date: Mon, 18 Aug 2025 19:59:21 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 "Thorsten Leemhuis" <regressions@leemhuis.info>
Message-Id: <681ec035-65f5-4aba-a448-cdb589fa5161@app.fastmail.com>
In-Reply-To: <aJtvE_yDGDyAfA5s@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
 <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
 <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
 <2d709754-3d4a-4803-b86f-9efa2a6bf655@app.fastmail.com>
 <6455123a-6785-4173-b145-3a1a3eb48175@leemhuis.info>
 <aJtvE_yDGDyAfA5s@shell.armlinux.org.uk>
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Russell,

On Wed, Aug 13, 2025, at 2:42 AM, Russell King (Oracle) wrote:

> 
> Yes, the reminder was sent during July when I wasn't looking at email,
> and as you can imagine, if I spend three weeks on vacation, I am _not_
> going to catch up with that pile of email - if I were, there'd be no
> point taking vacation because the mental effort would be just the same
> as having no vacation.
> 
No problem. I was not sure if you were on vacation or not.

> I have been debating whether we should actually do something like this,
> especially given the issues with 2500base-X:
> 
> -       if (!phylink_validate_pcs_inband_autoneg(pl, interface,
> -                                                config.advertising)) {
> -               phylink_err(pl, "autoneg setting not compatible with PCS");
> -               return -EINVAL;
> +       while (!phylink_validate_pcs_inband_autoneg(pl, interface,
> +                                                   config.advertising)) {
> +               if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +                             config.advertising)) {
> +                       phylink_err(pl, "autoneg setting is not compatible with PCS");
> +                       return -EINVAL;
> +               }
> +
> +               __clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
>         }
> 

I have just given this version a quick test with (at 10G only, I have not tested 1 or 2.5G configs), and it seems to work.

My board doesn't natively support 2.5G (due to a component in the signal path) but I can modify a board to work with 2.5G if testing these GPON or other imitator modules is helpful to you.

> which turns it into something generic - but my problem with that is..
> what if the module (e.g. a GPON module immitating a fibre module)
> requires Autoneg but the PCS doesn't support Autoneg for the selected
> interface mode.
> 

Many Thanks,
Matt

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

