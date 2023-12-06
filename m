Return-Path: <netdev+bounces-54614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF826807A1D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE6628247E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728EC6AB9C;
	Wed,  6 Dec 2023 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TklWwHAK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D26D68
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CI7IhPS6723BZ9Eb0v2Hektw61YBoSiCEz3USJXm/Io=; b=TklWwHAKJ9s17ssb1nmi3LBYaY
	hsU+LggHhUIpf+QRhPay5KMuwqg2EEWIId7gu0lNvDWvNs3pYYpkzARN52LIrJaWPZf/qYhKwYMbo
	cTELfwr8dwGX3Fr3lu5BtyasSZlCN+feaaWeuF4SVThCRGvYtF9BawjEnrOPqXByLQ1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAz7G-002Fdo-2M; Wed, 06 Dec 2023 22:07:34 +0100
Date: Wed, 6 Dec 2023 22:07:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Smulski <michal.smulski@ooma.com>
Cc: Tobias Waldekranz <tobias@waldekranz.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for
 6393X
Message-ID: <0e2cb20b-3be7-4f33-aef1-170967ba7e85@lunn.ch>
References: <20231205221359.3926018-1-tobias@waldekranz.com>
 <PH7PR14MB6163EE62811682A3927F79AAE384A@PH7PR14MB6163.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR14MB6163EE62811682A3927F79AAE384A@PH7PR14MB6163.namprd14.prod.outlook.com>

On Wed, Dec 06, 2023 at 08:37:50PM +0000, Michal Smulski wrote:
> I confirm that applying this patch to net-next tree works (and it is required) on my hardware.
> 
> Here is log from the kernel running on the actual hardware:
> [   49.818070] mv88e6085 0x0000000008b96000:02: switch 0x1920 detected: Marvell 88E6191X, revision 0
> [   50.429506] mv88e6085 0x0000000008b96000:02: configuring for inband/usxgmii link mode
> [   50.509099] mv88e6085 0x0000000008b96000:02 p1 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:01] driver [Marvell 88E6393 Family] (irq=388)
> [   50.577062] mv88e6085 0x0000000008b96000:02 p2 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:02] driver [Marvell 88E6393 Family] (irq=389)
> [   50.635256] mv88e6085 0x0000000008b96000:02: Link is Up - 10Gbps/Full - flow control off
> [   50.641109] mv88e6085 0x0000000008b96000:02 p3 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:03] driver [Marvell 88E6393 Family] (irq=391)
> [   50.697091] mv88e6085 0x0000000008b96000:02 p4 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:04] driver [Marvell 88E6393 Family] (irq=392)
> [   50.725072] mv88e6085 0x0000000008b96000:02 p5 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:05] driver [Marvell 88E6393 Family] (irq=393)
> [   50.753074] mv88e6085 0x0000000008b96000:02 p6 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:06] driver [Marvell 88E6393 Family] (irq=394)
> [   50.781085] mv88e6085 0x0000000008b96000:02 p7 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:07] driver [Marvell 88E6393 Family] (irq=395)
> [   50.809080] mv88e6085 0x0000000008b96000:02 p8 (uninitialized): PHY [!soc!mdio@8b96000!switch0@2!mdio:08] driver [Marvell 88E6393 Family] (irq=396)
> [   50.815677] DSA: tree 0 setup
> [  170.719608] fsl_dpaa2_eth dpni.3 eth1: configuring for inband/usxgmii link mode
> [  170.735697] fsl_dpaa2_eth dpni.3 eth1: Link is Up - 10Gbps/Full - flow control off
> [  170.813015] mv88e6085 0x0000000008b96000:02 p8: configuring for phy/gmii link mode
> [  170.913510] mv88e6085 0x0000000008b96000:02 p7: configuring for phy/gmii link mode
> [  171.014155] mv88e6085 0x0000000008b96000:02 p6: configuring for phy/gmii link mode
> [  171.119832] mv88e6085 0x0000000008b96000:02 p5: configuring for phy/gmii link mode
> [  171.230594] mv88e6085 0x0000000008b96000:02 p4: configuring for phy/gmii link mode
> [  171.346344] mv88e6085 0x0000000008b96000:02 p3: configuring for phy/gmii link mode
> [  171.472394] mv88e6085 0x0000000008b96000:02 p2: configuring for phy/gmii link mode
> [  171.594045] mv88e6085 0x0000000008b96000:02 p1: configuring for phy/gmii link mode
> [  969.248179] mv88e6085 0x0000000008b96000:02 p8: Link is Up - 1Gbps/Full - flow control rx/tx
> [ 1089.691582] mv88e6085 0x0000000008b96000:02 p8: Link is Down
> [ 1452.761369] mv88e6085 0x0000000008b96000:02 p8: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> 
> Michal

Hi Michal

Would you mind adding a Tested-by:

See https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

    Andrew

