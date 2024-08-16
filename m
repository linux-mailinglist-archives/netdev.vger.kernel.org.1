Return-Path: <netdev+bounces-119054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0DE953F0A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63891F24136
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4121F937;
	Fri, 16 Aug 2024 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kJbsMwMH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90161E515;
	Fri, 16 Aug 2024 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772716; cv=none; b=CyiaawOaNzlg7gmpeQkv94p5CYFnb3ethPBvYyw1HfaUfkkg3LLSFultDta9IPnRVI2RGbIN7oqvfxd/BiDDeEh/yZHp/sS2J1Yde5wkcl9FFldq1WlhOI/6SDyYLdjqMtDajz0Hg8cU+X1gsRpuLZiM+P5PQ4rb4L3uTzRncxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772716; c=relaxed/simple;
	bh=AdvMryl6jBiNkZ7VRREtcROcphQN5lq8hj5nSWl+xwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eabOgm7vpxqUEReGHCbFO44I2ht5xzHs2BEn/Eq3qqNzW7ecOuIIUxIvwnZYReYPaC2AaVefXTS0WPuxeb0lamI06lEBKSR6ucSpLbaMMTH6ngVHCAw15tgrt76Y0b9U1yV2bBmwTKd99kYqC25ZC5pKDD3friC4lTsYljFUGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kJbsMwMH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LMZ/H1f7EOgQSnMvzNXmSFFbE5G3GwsE9SktaoTmTpU=; b=kJbsMwMHJF842YbnZUGjRpyyQ3
	sjozCqZsG0H7A7wbpPvgLSodBvSJe65KwudSXL1VVQSzK+OnNmgNKt+NxNNxvTg2R3ZX1SiOy5EWb
	mvWiekp1l4JJB0tPv3Qo4pvcWE4mQgVOiGAYwufVoJNDOAU9drQOLYsmHgtLusyNshbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sem1d-004tDC-PQ; Fri, 16 Aug 2024 03:45:09 +0200
Date: Fri, 16 Aug 2024 03:45:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <0675cff9-5502-43e4-87ee-97d2e35d72da@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-7-fujita.tomonori@gmail.com>

> +#[vtable]
> +impl Driver for PhyQT2025 {
> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
> +
> +    fn probe(dev: &mut phy::Device) -> Result<()> {
> +        // The hardware is configurable?
> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
> +        if (hw_id >> 8) & 0xff != 0xb3 {
> +            return Ok(());
> +        }

I don't understand this bit of code. At a guess, if the upper bytes of
that register is not 0xb3, the firmware has already been loaded into
the device?

> +
> +        // The 8051 will remain in the reset state.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
> +        // Configure the 8051 clock frequency.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
> +        // Non loopback mode.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
> +        // Global control bit to select between LAN and WAN (WIS) mode.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;

802.3 says:

3.38 through 3.4110/25GBASE-R PCS test pattern seed B ????

> +        // Configure transmit and recovered clock.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1)?;
> +        // The 8051 will finish the reset state.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0002)?;
> +        // The 8051 will start running from the boot ROM.
> +        dev.write(C45::new(Mmd::PCS, 0xE854), 0x00C0)?;
> +
> +        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
> +        if fw.data().len() > SZ_16K + SZ_8K {
> +            return Err(code::EFBIG);
> +        }
> +
> +        // The 24kB of program memory space is accessible by MDIO.
> +        // The first 16kB of memory is located in the address range 3.8000h - 3.BFFFh.
> +        // The next 8kB of memory is located at 4.8000h - 4.9FFFh.
> +        let mut j = SZ_32K;
> +        for (i, val) in fw.data().iter().enumerate() {
> +            if i == SZ_16K {
> +                j = SZ_32K;
> +            }
> +
> +            let mmd = if i < SZ_16K { Mmd::PCS } else { Mmd::PHYXS };
> +            dev.write(
> +                C45::new(mmd, j as u16),
> +                <u8 as Into<u16>>::into(*val).to_le(),

This is well past my level of Rust. I assume fw.data is a collection
of bytes, and you enumerate it as bytes. A byte has no endiannes, so
why do you need to convert it to little endian?

	Andrew

