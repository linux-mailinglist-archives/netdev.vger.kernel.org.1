Return-Path: <netdev+bounces-88005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A48A52F8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C176E1F22AC0
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120D674422;
	Mon, 15 Apr 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DDdrXqdb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF9757E4;
	Mon, 15 Apr 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190820; cv=none; b=XFPFNNTlUk/cQAHfgQcPsHxIpG3H+USreu4uwbSS66oBSZjo2BPKmfaPdfqb3iRGcs0OoMkXJYoB0nr+PC2PcfJ7UnC1PBAYneVVJJsYchzmZ/1whqdNd7A/t7dgUOm2L6tXl/I3PbvBs5bAGhUApLzguZo2ve80DB7b0spZk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190820; c=relaxed/simple;
	bh=DB+wKIghJsG01+WF97RgjuS7cJliGqMTntLYVzdVb0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqdwmJXwhL50zupbu17y8bpr8aJlPkI+Aje5YjPtMXtSKdGCIqVGjog7naq+S2VPOnh0T/0jEky8lIrn3p9R7UhjTmKxjFvZ/oe4rWO1O6ivwBJqgTmFBandDO+WuZ7upVgRuF0IZi/1ZQAaem6rc/c5zK/a8/VZqBrQY4n6P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DDdrXqdb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lSbObex15wOwgO7da4ym39y3O/1y80iGBehBgnC+1gE=; b=DDdrXqdbwir/2TzR3+XlxaC6jl
	W5sna3A77bv1WYPIRWO4Xyhudb/WMpNJYdHTo67yQG8lc0OxInV6zKwZ0RNpDFSqqxMDuzamzsMxR
	sOybOq/moTbqsMuKNxrjXeBxYSizAhmWnhI7kVaUHvpYUXfdBcI9kWSfr9dQmE29lKbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwNBw-00D31b-2F; Mon, 15 Apr 2024 16:20:16 +0200
Date: Mon, 15 Apr 2024 16:20:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104701.4772-3-fujita.tomonori@gmail.com>

On Mon, Apr 15, 2024 at 07:46:59PM +0900, FUJITA Tomonori wrote:
> This patch adds the following helper functions for Clause 45:
> 
> - mdiobus_c45_read
> - mdiobus_c45_write
> - genphy_c45_read_status

We need to be very careful here, and try to avoid an issue we have in
the phylib core, if possible. C45 is a mix of two different things:

* The C45 MDIO bus protocol
* The C45 registers

You can access C45 registers using the C45 bus protocol. You can also
access C45 registers using C45 over C22. So there are two access
mechanisms to the C45 registers.

A PHY driver just wants to access C45 registers. It should not care
about what access mechanism is used, be it C45 bus protocol, or C45
over C22.

> +    /// Reads a given C45 PHY register.
> +    /// This function reads a hardware register and updates the stats so takes `&mut self`.
> +    pub fn c45_read(&mut self, devad: u8, regnum: u16) -> Result<u16> {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So it's just an FFI call.
> +        let ret = unsafe {
> +            bindings::mdiobus_c45_read(
> +                (*phydev).mdio.bus,
> +                (*phydev).mdio.addr,
> +                devad as i32,
> +                regnum.into(),
> +            )

So you have wrapped the C function mdiobus_c45_read(). This is going
to do a C45 bus protocol read. For this to work, the MDIO bus master
needs to support C45 bus protocol, and the PHY also needs to support
the C45 bus protocol. Not all MDIO bus masters and PHY devices
do. Some will need to use C45 over C22.

A PHY driver should know if a PHY device supports C45 bus protocol,
and if it supports C45 over C22. However, i PHY driver has no idea
what the bus master supports.

In phylib, we have a poorly defined phydev->is_c45. Its current
meaning is: "The device was found using the C45 bus protocol, not C22
protocol". One of the things phylib core then uses is_c45 for it to
direct the C functions phy_read_mmd() and phy_write_mmd() to perform a
C45 bus protocol access if true. If it is false, C45 over C22 is
performed instead. As a result, if a PHY is discovered using C22, C45
register access is then performed using C45 over C22, even thought the
PHY and bus might support C45 bus protocol. is_c45 is also used in
other places, e.g. to trigger auto-negotiation using C45 registers,
not C22 registers.

In summary, the C API is a bit of a mess.

For the Rust API we have two sensible choices:

1) It is the same mess as the C API, so hopefully one day we will fix
   both at the same time.

2) We define a different API which correctly separate C45 bus access
   from C45 registers.

How you currently defined the Rust API is neither of these.

       Andrew

