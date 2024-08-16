Return-Path: <netdev+bounces-119047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A020A953EC4
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF43B24BD2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74117BA1;
	Fri, 16 Aug 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C5L/x9eL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A429CEC;
	Fri, 16 Aug 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770576; cv=none; b=Cf1/DFYctE4BhqD4xln7vw3Ybomj/khoQU3SsKxAuPs3zCnUYehn1GLINXzZ+oQSp2u55+sx8Qr/2t97Rj3nLfwqOx+FvksGZdGhls9qhn5FgTAAH7Qzf2Et6gdJ3Dh1vRdiM95kwzIzOtFDaVIlnMl/r8w5Rcpv+UN8SRJj1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770576; c=relaxed/simple;
	bh=Tg/lJR8GjLeXQ7Bu+bOxz02RC+jvCzoEK23yjTbs4RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3yGPJ6xvFGnFcGu8Q3d0RTo8LKAAoQIsMSIL/BtROubL1u4kcJ/qhEtfnUdQJt/Xz/tT7W7QeWO1iYSVgO59lmFg5kTDvXfyEqya5wOe3XTfnzLAmBwP6y0PfHYFKiqxbrTd/0I6g7mnso8d3ULmeVAWRYyxt608cXp9xmFw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C5L/x9eL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MBD3Zc+izpQo2xbgefhhtee5KH9AgmMTO8RzRtDfI+A=; b=C5L/x9eLleLvD0IxVPNCP2FiNN
	N+WVImt91raIyGhuwvK3EudFwLiQ9lBGuBT4PuaAgX1KzoEoAKZSTqvOfNU9pv7ZEvf6EZXNHtWV0
	JHGmUP/zyRRW7x5nL8sRvam8J6gf83ljSjwNZeCm7TSRHeS5gC8mDfg7utuR4AwO2X1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1selT9-004t0w-6G; Fri, 16 Aug 2024 03:09:31 +0200
Date: Fri, 16 Aug 2024 03:09:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 4/6] rust: net::phy unified read/write API
 for C22 and C45 registers
Message-ID: <82db7404-4665-4563-8011-6d2d5e9c2685@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-5-fujita.tomonori@gmail.com>

> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! PHY register interfaces.
> +//!
> +//! This module provides support for accessing PHY registers via Ethernet
> +//! management interface clause 22 and 45, as defined in IEEE 802.3.

Here we need to be very careful. The word `via` in the sentence above
means we are talking about the access mechanism, c22 transfers, or c45
transfers. A PHY driver should not care about the transfer mechanism,
it should just care about the register in the C22 or C45 register
namespace.

> +impl Register for C22 {
> +    fn read(&self, dev: &mut Device) -> Result<u16> {
> +        let phydev = dev.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
> +        // So it's just an FFI call, open code of `phy_read()` with a valid `phy_device` pointer
> +        // `phydev`.
> +        let ret = unsafe {
> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, self.0.into())
> +        };
> +        to_result(ret)?;
> +        Ok(ret as u16)
> +    }
> +
> +    fn write(&self, dev: &mut Device, val: u16) -> Result {
> +        let phydev = dev.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
> +        // So it's just an FFI call, open code of `phy_write()` with a valid `phy_device` pointer
> +        // `phydev`.
> +        to_result(unsafe {
> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, self.0.into(), val)
> +        })

These two are O.K. You have to use C22 bus transfers to access the C22
register namespace.

> +impl Register for C45 {
> +    fn read(&self, dev: &mut Device) -> Result<u16> {
> +        let phydev = dev.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
> +        // So it's just an FFI call.
> +        let ret =
> +            unsafe { bindings::phy_read_mmd(phydev, self.devad.0.into(), self.regnum.into()) };
> +        to_result(ret)?;
> +        Ok(ret as u16)
> +    }
> +
> +    fn write(&self, dev: &mut Device, val: u16) -> Result {
> +        let phydev = dev.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
> +        // So it's just an FFI call.
> +        to_result(unsafe {
> +            bindings::phy_write_mmd(phydev, self.devad.0.into(), self.regnum.into(), val)
> +        })
> +    }

And these are also O.K. There are two mechanisms to access the C45
register namespace. By calling phy_write_mmd()/phy_write_mmd() you are
leaving it upto the core to decide which mechanism to use. The driver
itself does not care.

So the problem is with the comment above. It would be better to say
something like:

This module provides support for accessing PHY registers in the
Ethernet management interface clauses 22 and 45 register namespaces, as
defined in IEEE 802.3.

Dropping the via, and adding register namespace should make it clear
we are talking about the registers themselves, not how you access
them.


    Andrew

---
pw-bot: cr

