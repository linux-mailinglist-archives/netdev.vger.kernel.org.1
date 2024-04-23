Return-Path: <netdev+bounces-90573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B68AE8B0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04C61C21796
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B613699C;
	Tue, 23 Apr 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hjmpF9ik"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408FD135414
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880361; cv=none; b=BE/+x/9gT894id10Xr+RUHKgHJBWsdkzmz0wjKUQZhv1GgT+FpkL5NzVfz3e1388F4J+HvO7kafoOIZh+Uz2MaWGT3vJd6bNE0MedN2xCGVr3GN6NzTIUv/t5jnLQyqkTEzGTpDkm/sDfNPbbKUMiyj4tmgAfZE2jLexUHZawfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880361; c=relaxed/simple;
	bh=1f05Qsh8Ljb0/jJ0FtIm0xYHmsbePwte8R64rrhdYDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzTSf96dIogt4ShwvMib76mOxWAcrdUNF5W/aTdbU+0pC76C1ymG2H9hVXCiY61A40lTZmUhkNd7EuE6FJwZLHk/gVOmQUNryde/DVUL88SArFS0V99QTbprhxpdfLzMTVnipfSEvUL8trm35cZdSx9w/4qwS/LiBaKt+YFxwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hjmpF9ik; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mg7yxgtaZwXMv5NGO9djHwkxtI66DiPFFqU7S9JvK1M=; b=hjmpF9ikFdLESXKXiWjnjDlDXp
	fsCO/HnlkCBYxn/1C29MDVnEgmfPuwPu6YZQxQxVjqxgKJLV50nc33nV6UoP3y3+3zfUUY2AlGAf6
	A3qFM1M1gG9/z/je3vHXIyRoF0aKK+zosdeE+1tjq6udVZcyHzRsB2oaix24iIMSSCGk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzGZX-00Dibg-VZ; Tue, 23 Apr 2024 15:52:35 +0200
Date: Tue, 23 Apr 2024 15:52:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: netdev@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: Beaglebone Ethernet Probe Failure In 6.8+
Message-ID: <c11817a2-d743-4c27-a129-dd644c23110f@lunn.ch>
References: <Zh/tyozk1n0cFv+l@euler>
 <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
 <Zicyc0pj3g7/MemK@euler>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zicyc0pj3g7/MemK@euler>

On Mon, Apr 22, 2024 at 11:00:51PM -0500, Colin Foster wrote:
> Hi Andrew L,
> 
> (I CC'd Andrew Hanley, original author, for visibility)
> 
> On Wed, Apr 17, 2024 at 09:30:58PM +0200, Andrew Lunn wrote:
> > On Wed, Apr 17, 2024 at 10:42:02AM -0500, Colin Foster wrote:
> > > Hello,
> > > 
> > > I'm chasing down an issue in recent kernels. My setup is slightly
> > > unconventional: a BBB with ETH0 as a CPU port to a DSA switch that is
> > > controlled by SPI. I'll have hardware next week, but think it is worth
> > > getting a discussion going.
> > > 
> > > The commit in question is commit df16c1c51d81 ("net: phy: mdio_device:
> > > Reset device only when necessary"). This seems to cause a probe error of
> > > the MDIO device. A dump_stack was added where the reset is skipped.
> > > 
> > > SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> > 
> > Can you confirm this EIO is this one:
> > 
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/davinci_mdio.c#L440
> 
> Yes, I can confirm this is the EIO.
> 
> > 
> > It would be good to check the value of USERACCESS_ACK, and what the
> > datasheet says about it.
> 
> The register value is 0x0020ffff

The 0xffff is the value read from the bus. That probably means the PHY
did not answer, although it could legitimately return 0xffff to a
read. More important is bit 29: "Acknowledge. This bit is set if the
PHY acknowledged the read transaction." It is 0, so it thinks the PHY
did not respond.

> The patch I threw in:
> 
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -437,7 +437,10 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
>                         break;
> 
>                 reg = readl(&data->regs->user[0].access);
> +               printk("davinci mdio reg is 0x%08x\n", reg);
>                 ret = (reg & USERACCESS_ACK) ? (reg & USERACCESS_DATA) : -EIO;
> +               if (ret == -EIO)
> +                   printk("ret is this EIO\n");
>                 break;
>         }
> 
> 
> The print:
> 
> [    1.537767] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6, bus freq 1000000
> [    1.538111] davinci mdio reg is 0x20400007

This is a read of register 2, and the register has value 0x0007

> [    1.538372] davinci mdio reg is 0x2060c0f1

This is a read of register 3, and the register has value 0xc0f1.

These are the ID registers, and match SMSC LAN8710/LAN8720.

> [    1.549523] davinci mdio reg is 0x03a0ffff

Register 0x1d. Not one of the standard registers. I don't know what is
happening here.

> [    1.549551] ret is this EIO
> [    1.549806] davinci mdio reg is 0x0020ffff

Register 1, basic mode status register.

> [    1.549821] ret is this EIO

In these two last transactions, the ACK bit is not set.

> [    1.550471] SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> [    1.550592] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
> 
> Without the mdiodev->reset_state patch, I see the following:
> 
> [    1.537817] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6, bus freq 1000000
> [    1.538165] davinci mdio reg is 0x20400007
> [    1.538426] davinci mdio reg is 0x2060c0f1

Same as above.

> [    1.558442] davinci mdio reg is 0x23a00090
> [    1.558717] davinci mdio reg is 0x20207809
> [    1.559681] davinci mdio reg is 0x21c0ffff

In all these cases, we see the ACK bit set. 

So the PHY is responding to registers 2 and 3, the ID registers. But
it seems to be failing to respond to other registers. At a guess, i
would say it is still coming out of reset. Does the datasheet for the
LAN8710/LAN8720 say anything about how long a reset takes? Can you get
a logic analyser onto the reset line and MDIO bus and see how
different the timing is? It might be you need to add some delay values
to the reset in DT.

   Andrew

