Return-Path: <netdev+bounces-31291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9978C8B4
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB581C20A55
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1D17ADD;
	Tue, 29 Aug 2023 15:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351017AB1
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 15:38:59 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB4DB0
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fH3PfuguXkwfWmHOA9duvRS+IsaQEEKD/06zIAKBZxs=; b=0OobooI8mcuUtTPp1Flk4iZjMc
	HHZ+Hn9/8tZXNF4PSL6z8riTcBQYmugAn5+2wHUd5Cl8YNWsjy6A1koy3c3DMhm9Yez232JzNcpOs
	T6Z2k594viDD+0q8O1/untc0lQ1n1qPSAleYooHNbdLm7WT0bfGoVtCDFYS2+ZViMKz68Sj1SKjdT
	gHH9Y1ZdBxr68FwVVzNPc+1DDRFPVKDEdT7mFXiz+JAWf+T5Acb+MPQ6KojsdivqUEmoYhZwUD468
	yyVdkKPSYa7LigDzWkvBVlqhHGlnQR+RNTvLc+6Kigrt5DuVAXOlA4R0MDBSVyxEuUoFLKlS+pu/M
	650SoV/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43720)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qb0no-0000gE-0Q;
	Tue, 29 Aug 2023 16:38:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qb0ni-0004l9-Qn; Tue, 29 Aug 2023 16:38:42 +0100
Date: Tue, 29 Aug 2023 16:38:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Cc: netdev@vger.kernel.org, simonebortolin@hack-gpon.org,
	nanomad@hack-gpon.org, Federico Cappon <dududede371@gmail.com>,
	daniel@makrotopia.org, lorenzo@kernel.org, ftp21@ftp21.eu,
	pierto88@hack-gpon.org, hitech95@hack-gpon.org, davem@davemloft.net,
	andrew@lunn.ch, edumazet@google.com, hkallweit1@gmail.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name
Subject: Re: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed
 single-mac devices (XOR RJ/SFP)
Message-ID: <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
References: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 05:12:48PM +0200, Nicolò Veronese wrote:
> Hi,
> 
> I and some folks in CC are working to properly port all the
>  functions of a Zyxel ex5601-t0 to OpenWrt.
> 
> The manufacturer decided to use a single SerDes connected
>  to both an SPF cage and an RJ45 phy. A simple GPIO is
>  used to control a 2 Channel 2:1 MUX to switch the two SGMII pairs
>  between the RJ45 and the SFP.
> 
>   ┌─────┐  ┌──────┐   ┌─────────┐
>   │     │  │      │   │         │
>   │     │  │      ├───┤ SFP     │
>   │     │  │      │   └─────────┘
>   │     │  │      │
>   │ MAC ├──┤ MUX  │   ┌─────────┐
>   │     │  │      │   │         │
>   │     │  │      │   │ RJ45    │
>   │     │  │      ├───┤ 2.5G PHY│
>   │     │  │      │   │         │
>   └─────┘  └───▲──┘   └─────────┘
>                │
>   MUX-GPIO ────┘

This is do-able in software, but is far from a good idea.

Yes, it would be possible to "disconnect" the RJ45 PHY from the netdev,
and switch to the SFP and back again. It would be relatively easy for
phylink to do that. What phylink would need to do is to keep track of
the SFP PHY and netdev-native PHY independently, and multiplex between
the two. It would also have to manage the netdev->phydev pointer.
Any changes to this must be done under the rtnl lock.

So technically it's possible. However, there is no notification to
userspace when such a change may occur. There's also the issue that
userspace may be in the process of issuing ethtool commands that are
affecting one of the PHYs. While holding the rtnl lock will block
those calls, a change between the PHY and e.g. a PHY on the SFP
would cause the ethtool command to target a different PHY from what
was the original target.

To solve that sanely, every PHY-based ethtool probably needs a way
to specify which PHY the command is intended for, but then there's
the question of how userspace users react to that - because it's
likely more than just modifying the ethtool utility, ethtool
commands are probably used from many programs.

IMHO, it needs a bit of thought beyond "what can we do to support a
mux".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

