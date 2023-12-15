Return-Path: <netdev+bounces-57996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C21814C1D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E476C1C22FCF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F5381DD;
	Fri, 15 Dec 2023 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DJ9e7+sf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67339FC3;
	Fri, 15 Dec 2023 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ubkWsYpV4BWzzyphoro0gLj1g3jOZKtwuoxzD7eTew=; b=DJ9e7+sfL3xQjeVhIpkR5qck79
	jb2u17HR6IwzrVfyfpQxuZuiXdXag1N3ANpkRX2DDAp9CwIWiEuj+0QBoK97C3buJtkB/axaNTaZH
	uqarP5S7B8q48ZO0QPSUAatxHUbTAWv7Lng2QO6dWsmEP1yPwZvAetXTfxIfL25jybtee6ragopnn
	rbovznOgw7dV3/kFwEndcojVTfZ7JuhDeyHnW0uXt3REnRkNjlUdhWfyrCIf5MMPRLWnCblvORMtB
	oloN4h7cUnDnqlQ1lDtJw13gwk1YFR/93T8QCyGSN6pJWtFUs0Gm9BF02hdiVUzPoqrOpCAaBQSoF
	jNWVEiDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33866)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEAU9-0002rv-0s;
	Fri, 15 Dec 2023 15:52:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEAUB-0003k3-6j; Fri, 15 Dec 2023 15:52:23 +0000
Date: Fri, 15 Dec 2023 15:52:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <ZXx2N85XNeugFtPa@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-2-tobias@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 09:14:39PM +0100, Tobias Waldekranz wrote:
> +	MV_PMA_BOOT_PRGS_MASK	= 0x0006,
> +	MV_PMA_BOOT_PRGS_INIT	= 0x0000,
> +	MV_PMA_BOOT_PRGS_WAIT	= 0x0002,
> +	MV_PMA_BOOT_PRGS_CSUM	= 0x0004,
> +	MV_PMA_BOOT_PRGS_JRAM	= 0x0006,

You only seem to use PRGS_WAIT, the rest seem unused.

> +struct mv3310_fw_hdr {
> +	struct {
> +		u32 size;
> +		u32 addr;
> +		u16 csum;
> +	} __packed data;

It's probably better to get rid of this embedded struct and just place
the members in the parent struct (although csum woul dneed to be
renamed).

> +
> +	u8 flags;
> +#define MV3310_FW_HDR_DATA_ONLY BIT(6)
> +
> +	u8 port_skip;
> +	u32 next_hdr;
> +	u16 csum;
> +
> +	u8 pad[14];
> +} __packed;
> +
> +static int mv3310_load_fw_sect(struct phy_device *phydev,
> +			       const struct mv3310_fw_hdr *hdr, const u8 *data)
> +{
> +	int err = 0;
> +	size_t i;
> +	u16 csum;
> +
> +	dev_dbg(&phydev->mdio.dev, "Loading %u byte %s section at 0x%08x\n",
> +		hdr->data.size,
> +		(hdr->flags & MV3310_FW_HDR_DATA_ONLY) ? "data" : "executable",
> +		hdr->data.addr);
> +
> +	for (i = 0, csum = 0; i < hdr->data.size; i++)
> +		csum += data[i];
> +
> +	if ((u16)~csum != hdr->data.csum) {
> +		dev_err(&phydev->mdio.dev, "Corrupt section data\n");
> +		return -EINVAL;
> +	}
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	/* Any existing checksum is cleared by a read */
> +	__phy_read_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_CSUM);
> +
> +	__phy_write_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_ADDR_LOW,  hdr->data.addr & 0xffff);
> +	__phy_write_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_ADDR_HIGH, hdr->data.addr >> 16);
> +
> +	for (i = 0; i < hdr->data.size; i += 2) {
> +		__phy_write_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_DATA,
> +				(data[i + 1] << 8) | data[i]);
> +	}
> +
> +	csum = __phy_read_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_CSUM);
> +	if ((u16)~csum != hdr->data.csum) {
> +		dev_err(&phydev->mdio.dev, "Download failed\n");
> +		err = -EIO;
> +		goto unlock;
> +	}
> +
> +	if (hdr->flags & MV3310_FW_HDR_DATA_ONLY)
> +		goto unlock;
> +
> +	__phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MV_PMA_BOOT, 0, MV_PMA_BOOT_APP_LOADED);
> +	mdelay(200);
> +	if (!(__phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MV_PMA_BOOT) & MV_PMA_BOOT_APP_STARTED)) {
> +		dev_err(&phydev->mdio.dev, "Application did not startup\n");
> +		err = -ENODEV;
> +	}

I'm confused why this is done here - after each section in the firmware
file, rather than having loaded all sections in the firmware file and
only then starting the application. Surely if there's multiple sections
that we're going to load, we want to load _all_ sections before starting
the application?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

