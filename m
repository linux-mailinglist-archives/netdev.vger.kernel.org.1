Return-Path: <netdev+bounces-88064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1BB8A583C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67612282109
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AE82490;
	Mon, 15 Apr 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QaSYSZCO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78796823B5;
	Mon, 15 Apr 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200010; cv=none; b=OXcNZvCc1YwXUhfleW2MnSiIxFP/mela2jYk3CrYMvEYaH9RmLbXlDSm5zga1uOrNp9twPPyBvn20lZ/LBaafAfh+wRu3DakgJE1R7uPF7MBgJKzmiTucwsJYPu2pusB3SlAt80kaQeQXOqLpY4N4w12TwtlemeQG+7HrBSFw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200010; c=relaxed/simple;
	bh=Rh/r0/dCU0aySn8Z2qZpkchpRIy06trbHTQwkt6z/Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJQI8cXVnMAvkaHUkZhxTpL87gDUzXcog6oOgARiJg79lg46muY5iOJNbb+Am4ymUlpUhKtH51AgnulNOLAJ6rKP5lQHs4qt00vCM3gSJDuiGBD5GkvUV+1C0Vca2XZklwhO4TFtfGT8tVONdK6yVwLv/pD2fTOdXpgykKAfSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QaSYSZCO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IrIITJ6fXOHd05AgwEOvmTiGO5LrfxpkCtYVLEkHfT4=; b=QaSYSZCO+NvJ8GOK4I8biSuy9f
	Gfb5k783cHIaX1pGMVxvx/E6Y3czFNqNhcXlxLHMk+1JUeJdu4ilRLbLlVO+ZH8n8xk4U+uNnYd7P
	rKqbkS9byTPXU5citoFo40rw2Pr4dhEVBnxlG+K1U4qc4f9Ak+cH3cvhgDVb7OB2Mk9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwPa9-00D3mx-Is; Mon, 15 Apr 2024 18:53:25 +0200
Date: Mon, 15 Apr 2024 18:53:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <adc1ba25-16f0-4cf4-a1f0-bac8820cec2e@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104701.4772-5-fujita.tomonori@gmail.com>

> +const MDIO_MMD_PMAPMD: u8 = uapi::MDIO_MMD_PMAPMD as u8;
> +const MDIO_MMD_PCS: u8 = uapi::MDIO_MMD_PCS as u8;
> +const MDIO_MMD_PHYXS: u8 = uapi::MDIO_MMD_PHYXS as u8;

These probably belong somewhere else, where all Rust PHY drivers can
use them.

> +
> +struct PhyQT2025;
> +
> +#[vtable]
> +impl Driver for PhyQT2025 {
> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
> +
> +    fn config_init(dev: &mut phy::Device) -> Result<()> {
> +        let fw = Firmware::new(c_str!("qt2025-2.0.3.3.fw"), dev)?;
> +
> +        let phy_id = dev.c45_read(MDIO_MMD_PMAPMD, 0xd001)?;
> +        if (phy_id >> 8) & 0xff != 0xb3 {
> +            return Ok(());
> +        }

I'm guessing that is checking if the firmware has already been
downloaded? It would be good to add a comment about this. I also
wounder about the name phy_id? They are normally stored in registers
0x2 and 0x3, not 0xd001. What sort of ID is this?

> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0000)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC302, 0x4)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC319, 0x0038)?;
> +
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC31A, 0x0098)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0x0026, 0x0E00)?;
> +
> +        dev.c45_write(MDIO_MMD_PCS, 0x0027, 0x0893)?;
> +
> +        dev.c45_write(MDIO_MMD_PCS, 0x0028, 0xA528)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0x0029, 0x03)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC30A, 0x06E1)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0002)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0xE854, 0x00C0)?;

Some of these registers are partially documented in the
datasheet. e854 controls where the 8051 executes code from. If bit 6
is set, it executes from SRAM, if it is cleared, to runs the Boot
ROM. Bit 7 is not defined, but i guess it halts the 8051 when
set. Please add some const for these. C302 is setting the CPU clock
speed, c30A is about TX clock rate. Please try to document what you
can using information from the datasheet.

> +
> +        let mut j = 0x8000;
> +        let mut a = MDIO_MMD_PCS;
> +        for (i, val) in fw.data().iter().enumerate() {
> +            if i == 0x4000 {

Is this was C code, i would of said use SZ_16K, to give a hint this is
about reading the first 16K of the firmware. The device actually has
24K of SRAM, which gets mapped into two different C45 address spaces.
You should also add a check that the firmware does not have a total
size of > 24K. Never trust firmware blobs.

> +                a = MDIO_MMD_PHYXS;
> +                j = 0x8000;
> +            }
> +            dev.c45_write(a, j, (*val).into())?;
> +
> +            j += 1;
> +        }
> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
> +
> +        Ok(())
> +    }

  Andrew

