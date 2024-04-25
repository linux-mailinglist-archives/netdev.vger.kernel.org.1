Return-Path: <netdev+bounces-91338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616568B2430
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 16:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F71E286A66
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D457149DF3;
	Thu, 25 Apr 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MA4pUD2D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA0149C67
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055879; cv=none; b=jhm/lW4hSfnYMH+wTAW5Gewvty6U3sFjnocEWcokXis5i6xsV5+SW8YASvBQWuiECLM4kXM1vVnnp6kvMmvq5S4Syw08mj1UnTVAZ/KpLmJR5NHi1E2pmPzhniY+z1Djb8rybkGg68iVKw4q32cQ6qWfnZfU1FAkrDaIi/GLe4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055879; c=relaxed/simple;
	bh=ksH1Xn6cPLBIQdCf65Mpov8brbTdyI92F4gG2sg2rtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgEF+ekLlYSX60Sb7zW8LYj32jR4tTKRfzcpymWFEwG7/Wf4vOdfKRfwCkF/lKXlPUxfIqMH1b9EdXs9h0EtjAEgJ5VnBEjd+4MVCD7Smve2X/Lip3sinTlHZwCISASUHeHHuvPGAs8LBbJVx+/YAJArGRw6mS7k8iqOJq9/blU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MA4pUD2D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dkg2/qKdzqysjwcWwlg8GZGbYBy6RT4mU/Vj44IrJ7E=; b=MA
	4pUD2DEM2mH8aMKMRfqEU1LBE9K9aRiS6hqa+lXVlbOVFJWvLh/yNlaWz6mQGeip128PCVBokctqs
	WuhNrse2bUKdgnaQNSDHCc5NexbelN+QiaSRkQM1fysjoYD/MEQKO+xSNSFLqvkSBI0oPSe8Di7Dh
	6t/JF41m6sCwzx8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s00EU-00Dzch-LK; Thu, 25 Apr 2024 16:37:54 +0200
Date: Thu, 25 Apr 2024 16:37:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] net: tn40xx: add PHYLIB support
Message-ID: <eeeabc11-89ec-449a-95f8-679872d694fe@lunn.ch>
References: <7c20aefa-d93b-41e2-9a23-97782926369d@lunn.ch>
 <20240416.211926.560322866915632259.fujita.tomonori@gmail.com>
 <daf9400f-c7e0-4f76-9a8d-977d9f82758a@lunn.ch>
 <20240425.102428.2029676913045396941.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425.102428.2029676913045396941.fujita.tomonori@gmail.com>

> I updated the code to use phylink and posted v2. At least seems that
> it works with 10G SFP+ as before.
> 
> I suppose that more changes are necessary for full support. For
> example, with 1G SFP inserted, the MAC driver has to configure the
> hardware for 1G. I'll investigate once I get 1G SFP.
> 
> Note that the original driver supports only 10G SFP+.

This is where the Rust PHY driver gets more interesting.

A PHY which is being used as a media converter needs to support a few
additional things. The marvel10g driver is a good example to follow
for some things. Look at mv3310_sfp_ops.

But there is more to it than that. phylink assumes it has access to
the i2c bus the module is on. The datasheet for the QT2025, shows a
couple of diagrams how an SFP is connected to it. The QT2025 has an
I2C bus which should be connected to the SFP cage. So you need to
export this I2C bus master in the PHY driver. So a Rust I2C bus
driver. Has anybody done that yet? However, it is not clear from my
reading of the datasheet if you get true access to the I2C bus. It
says:

XFP/SFP+ Module Access through MDIO

The MDIO interface can be used to access an XFP or
SFP+ module. The XFP/SFP+ module 2-wire interface
must be connected to the UC_SCL and UC_SDA clock
and data lines. The XFP module address is 1010000,
while the SFP+ module uses memory at addresses
1010000 and 1010001. The entire module address
space will be automatically read upon powerup, reset
or module hotplug by detection of the MOD_ABS
signal. A 400ms delay is observed before upload to
allow the module to initialize.
The memory at module address 1010000 is mapped to
MDIO register range 3.D000 - 3.D0FFh. Read/write
access to the module memory is controlled by MDIO
register 3.D100h. This applies to both module types.

The memory at module address 1010001 is mapped to
MDIO register range 1.8007 - 1.8106h. No read/write
access to the module memory is provided.

DOM Memory Access
The SFP+ DOM memory (A2) is mapped to MDIO
registers 1.8007-1.8106h (the NVR address space) or
alternatively to 1.A000-1.A0FF (this is firmware load
dependent; it may be configurable). If mapped to
1.A000-1.A0FF, DOM-related alarms in the SFP+
module will feed into the LASI alarm tree (see “Link
Alarm Status Interrupt Pin (LASI)” on page 74 for
details).

Later firmware versions implement a DOM periodic
polling feature, where the DOM memory is read at
every 1s. Optical alarms will then automatically alert
the host system through the LASI interrupt pins. Only a
subset of registers containing dynamically changing
values are polled on each update. Consult AMCC for
details on this feature.

So i guess you are going to need to fake the I2C bus, mapping I2C
transfer requests into MDIO reads of the mapped memory.

Additionally, phylink expects a few GPIO for Los of Signal, TX Enable,
TX Fault, etc. The PHY has these, so the PHY driver needs to export a
GPIO driver.

And then you need some glue, to bring all the parts together. The
wangxun Ethernet driver has mostly solved this, so you can take
inspiration from there.

You picked an interesting device to add Rust support for.

	Andrew

