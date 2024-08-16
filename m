Return-Path: <netdev+bounces-119307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CD955203
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0011C20F2D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0497C13A24A;
	Fri, 16 Aug 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="brQutFfx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314C8063C;
	Fri, 16 Aug 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841229; cv=none; b=N4cc6OLetpPQg9+pO6I9XGUc8NDjPbFVmHfFWF2vkxrH4jGosRBH1uvDBOJgOr1E7g77pRi2C9HEq1Qke3aqLKY2oNbHtSyY4sxrY9GD6WfMy8BS175akacXQCmCPkF8B7MnPMyFdgnCVqt3wAygWfMhdxADnI3CL/CqBY71jxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841229; c=relaxed/simple;
	bh=JZfHiz1tB38rMW9olGjsTLFDdVnBPmmfwFoUIW2rIm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYyBeA3Gu6iL5k1NhBn0Cge8DnVJhNldRPD0leJXHX0pLMe6UYXzkCwzu+5Ar/SpsNRTpz+DIyMYviE0ro3YtqAfcbAjuqnJJ40/PJoeG4V2yx3IYRRDZWQPZacug8aYxfvmqxBJkmekxCECxOvNB7xt30f1plqwtUhtTQOxosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=brQutFfx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aOP2LMJeFmr80roGNiJdWxr3mEBBBuA/8/eNBaXhU4g=; b=brQutFfxYC7tP1HnYn+HCkKg7v
	dieym8XOM2rnbEifOr0M7/CsszAK/aA9W8hFOENVE2QN45gDelnlyN13NHg+tjbR8rVWxLJrljWPv
	Nnyj9LIFvTdnilP67NOVkOKXq67bPrMbLb9v1/lb7ZOGl221YgIQbSoPB1ZvGuHt+OEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf3qi-004xlV-1N; Fri, 16 Aug 2024 22:47:04 +0200
Date: Fri, 16 Aug 2024 22:47:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <ec02de97-2521-4897-9076-cabb8f057c8b@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-7-fujita.tomonori@gmail.com>
 <0675cff9-5502-43e4-87ee-97d2e35d72da@lunn.ch>
 <20240816.061710.793938744815241582.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816.061710.793938744815241582.fujita.tomonori@gmail.com>

On Fri, Aug 16, 2024 at 06:17:10AM +0000, FUJITA Tomonori wrote:
> On Fri, 16 Aug 2024 03:45:09 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> +#[vtable]
> >> +impl Driver for PhyQT2025 {
> >> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
> >> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
> >> +
> >> +    fn probe(dev: &mut phy::Device) -> Result<()> {
> >> +        // The hardware is configurable?
> >> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
> >> +        if (hw_id >> 8) & 0xff != 0xb3 {
> >> +            return Ok(());
> >> +        }
> > 
> > I don't understand this bit of code. At a guess, if the upper bytes of
> > that register is not 0xb3, the firmware has already been loaded into
> > the device?
> 
> I've just added debug code and found that the upper bytes of the
> register is 0xb3 even after loading the firmware.
> 
> I checked the original code again and found that if the bytes isn't
> 0xb3, the driver initialization fails. I guess that the probe should
> return an error here (ENODEV?). 

O.K. Maybe add a comment that the vendor driver does this, but we have
no idea why.

> 
> >> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
> >> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
> >> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
> >> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
> > 
> > 802.3 says:
> > 
> > 3.38 through 3.4110/25GBASE-R PCS test pattern seed B ????
> 
> Yeah, strange. But I can't find any hints on them in the datasheet or
> the original code.

Seems unlikely it is seeding anything. So i guess they have reused the
registers for something else. This is actually a bit odd, because all
the other registers are in the ranges reserved for vendor usage.

If these were legitimate register usage, i would of suggested adding
#define to include/uapi/linux/mdio.h for them.

	Andrew

