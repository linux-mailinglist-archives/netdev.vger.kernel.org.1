Return-Path: <netdev+bounces-31299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA978CBAC
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 20:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27131C209E8
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 18:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3418010;
	Tue, 29 Aug 2023 18:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7A17751
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 18:04:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3B311B
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wt0UnUry4s4o90X62ska/PMsqYR2EM6/9OuKNIxueCs=; b=yTpYR5xeVghn5gSN99htQZvmVO
	qHwxKYRILOePK6heTLD79vjVHZEaNgC+/Gm/qRu2X4pHrGtM92zWVzcuFAsxH6m5C1wech30FVXQW
	qKDxXaBFa5zeauHVcgQGTYqTZKEODgiA2UftJuagDeBhgrn3Jt3QCVrWrys5DvCD8Ri8g+99STkyl
	eoxwktQOIxzuW9r3aMV4uClRJakFEdTY73iCM6rordM1IJEEBuzQpwojkNo2rAWhlD+I/f4nknLms
	YS5G+5Z/K9H960jW54borRvtudOkc3s/5NYNYOxHHoYFqEtad7og36YmzuxD5slwWZJo/F/3G8fdz
	cd7hNJew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57786)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qb34Z-0000pD-20;
	Tue, 29 Aug 2023 19:04:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qb34X-0004qr-4Z; Tue, 29 Aug 2023 19:04:13 +0100
Date: Tue, 29 Aug 2023 19:04:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	netdev@vger.kernel.org, simonebortolin@hack-gpon.org,
	nanomad@hack-gpon.org, Federico Cappon <dududede371@gmail.com>,
	lorenzo@kernel.org, ftp21@ftp21.eu, pierto88@hack-gpon.org,
	hitech95@hack-gpon.org, davem@davemloft.net, andrew@lunn.ch,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	pabeni@redhat.com, nbd@nbd.name
Subject: Re: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed
 single-mac devices (XOR RJ/SFP)
Message-ID: <ZO4zHdeeMFGqCx3d@shell.armlinux.org.uk>
References: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
 <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
 <ZO4sw2gOQjn1GXDg@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO4sw2gOQjn1GXDg@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 06:37:07PM +0100, Daniel Golle wrote:
> Another thing which came to my mind is the existing port field in
> many ethtool ops which could be either PORT_TP or PORT_FIBRE to
> destinguish the TP PHY from the SFP at least for xLINKSETTINGS.

However, PORT_TP also gets used for RJ45 SFPs, so that doesn't
distinguish between a built-in PHY and a SFP PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

