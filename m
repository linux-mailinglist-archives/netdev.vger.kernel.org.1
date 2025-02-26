Return-Path: <netdev+bounces-169864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE20A460D9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF6917AA48
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885D21D5B6;
	Wed, 26 Feb 2025 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M+EF2Q0a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088A21D3F0;
	Wed, 26 Feb 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576403; cv=none; b=sFvkdM8Mb7NFypvAZyvvWLTvoCyC2lHbxVw33bovhAik6OzECa3RL89Pw9+vbTBJxr3L91IcHlntZQzSvv8nEwrHImD1sK2HVydhK7l+CXb/bSbzRRuC9P66BM8EyYf4SBSGiKR0PhFr2UCKE6KL8WnsA7wWeIPaMEOLCXbmZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576403; c=relaxed/simple;
	bh=DSExusSrJg5dEQz0ahM4rRJoxL+q1ToKc/UiFPZKQ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoO+5xFMFTf+aCDdAcbARiKrJ78eFKlDEeLgp4UW/b1J+/SF//KDiLIUVMHDEQruPvWTTSevCbxvQ1wRyiBANBcFegg9DixU7C0j0Fq/Nb83r9zwwfktj1P6rZrdfdzQfWh0mC5ryDM2yYoGIM1KOqMK7u6UjKmgVRcH7eDVhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M+EF2Q0a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4Ozf+7Q+exXjohkxtJs5vNdrBo5Sdnc0Ag2Lz0YxhzU=; b=M+EF2Q0a0WRuAPx96YN4gdGAGD
	cJUEFVSoVUXpcau6Rel+vg9J8OcLm3W6FCG3VX49WlwcmMK+wDwM5029xr9hVdseTQlMBv03A/9c6
	Ra8Y8UvoFAx2/26RJRc/TNFA4IE7Sv4X42AgVaTgv8D9VZm6l33vh2vPiIqBo8ug1Skg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnHQW-000GS9-6o; Wed, 26 Feb 2025 14:26:16 +0100
Date: Wed, 26 Feb 2025 14:26:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Message-ID: <8bc68f1a-5abd-478c-9b9d-2c8baa6bb36a@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
 <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
 <Z7X5Dta3oUgmhnmk@makrotopia.org>
 <ff96f5d38e089fdd76294265f33d7230c573ba69.camel@mediatek.com>
 <176f8fe1-f4cf-4bbd-9aea-5f407cef8ac5@lunn.ch>
 <c5728ec30db963c97b6e292b51e73e2c075d1757.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5728ec30db963c97b6e292b51e73e2c075d1757.camel@mediatek.com>

> So I guess I can do the following according to the previous discussion:
> 1) Reserve a memory region in mt7988.dtsi
> reserved-memory {
> 	#address-cells = <2>;
> 	#size-celss = <2>;
> 	ranges;
> 
> 	/* 0x0f0100000~0x0f1f0024 are specific for built-in 2.5Gphy.
> 	 * In this range, it includes "PMB_FW_BASE"(0x0f100000)
> 	 * and "MCU_CSR_BASE"(0x0f0f0000)
> 	 */
> 	i2p5g: i2p5g@0f100000 {
> 		reg = <0 0x0f010000 0 0x1e0024>;
> 		no-map;
> 	};
> };

Do you even need these? I assume this is in the IO space, not DRAM. So
the kernel is not going to use it by default. That is why you need to
specifically ioremap() it.

> 2) Since PHYs don't use compatibles, hardcode address in mtk-2p5ge.c:
> /* MTK_ prefix means that the macro is used for both MT7988 & MT7987*/
> #define MTK_2P5GPHY_PMB_FW_BASE		(0x0f100000)
> #define MT7988_2P5GE_PMB_FW_LEN		(0x20000)
> #define MT7987_2P5GE_PMB_FW_LEN		(0x18000)
> #define MTK_2P5GPHY_MCU_CSR_BASE	(0x0f0f0000)
> #define MTK_2P5GPHY_MCU_CSR_LEN		(0x20)
> 
> /* On MT7987, we separate firmware bin to 2 files and total size
>  * is decreased from 128KB(mediatek/mt7988/i2p5ge-phy-pmb.bin) to
>  * 96KB(mediatek/mt7987/i2p5ge-phy-pmb.bin)+
>  * 28KB(mediatek/mt7987/i2p5ge-phy-DSPBitTb.bin)
>  * And i2p5ge-phy-DSPBitTb.bin will be loaded to
>  * MT7987_2P5GE_XBZ_PMA_RX_BASE
>  */
> #define MT7987_2P5GE_XBZ_PMA_RX_BASE	(0x0f080000)
> #define MT7987_2P5GE_XBZ_PMA_RX_LEN	(0x5228)
> #define MT7987_2P5GE_DSPBITTB_SIZE	(0x7000)
> 
> /* MT7987 requires these base addresses to manipulate some
>  * registers before loading firmware.
>  */
> #define MT7987_2P5GE_APB_BASE		(0x11c30000)
> #define MT7987_2P5GE_APB_LEN		(0x9c)
> #define MT7987_2P5GE_PMD_REG_BASE	(0x0f010000)
> #define MT7987_2P5GE_PMD_REG_LEN	(0x210)
> #define MT7987_2P5GE_XBZ_PCS_REG_BASE	(0x0f030000)
> #define MT7987_2P5GE_XBZ_PCS_REG_LEN	(0x844)

Should the PCS registers actually be in the PCS driver, not the PHY
driver? Hard to say until we know what these registers actually are.

> #define MT7987_2P5GE_CHIP_SCU_BASE	(0x0f0cf800)
> #define MT7987_2P5GE_CHIP_SCU_LEN	(0x12c)
> 
> static int mt7988_2p5ge_phy_load_fw(struct phy_device *phydev)
> {
> 	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> 	void __iomem *mcu_csr_base, *pmb_addr;
> 	struct device *dev = &phydev->mdio.dev;
> 	const struct firmware *fw;
> 	int ret, i;
> 	u32 reg;
> 
> 	if (priv->fw_loaded)
> 		return 0;
> 
> 	pmb_addr = ioremap(MTK_2P5GPHY_PMB_FW_BASE,
> 			   MT7988_2P5GE_PMB_FW_LEN);
> 	if (!pmb_addr)
> 		return -ENOMEM;
> 	mcu_csr_base = ioremap(MTK_2P5GPHY_MCU_CSR_BASE,
> 			       MTK_2P5GPHY_MCU_CSR_LEN);
> 	if (!mcu_csr_base) {
> 		ret = -ENOMEM;
> 		goto free_pmb;
> 	}
> ...
> free:
> 	iounmap(mcu_csr_base);
> free_pmb:
> 	iounmap(pmb_addr);
> ...
> }

This looks O.K. It is basically what we did before device tree was
used.

	Andrew

