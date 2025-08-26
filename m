Return-Path: <netdev+bounces-216907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E29B35EF3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0052A16A14B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7029ACC0;
	Tue, 26 Aug 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jVghTZE8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169D393DF2;
	Tue, 26 Aug 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210557; cv=none; b=BQLM97Wc0qFkZovmVnWn+G14PkRjZ4gW3wZ9WoCbD/AuxHn+YpycPGsYC+q90mKBSUkCqb6Wp16+VOb+kYb3DMQtojiCc/9IP2aoCgy/wtOH9DU1zBEGir1gaumXsypG022n8QdMbVIa1vDLorwrGVOQZrscSEWimnvkWv/v07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210557; c=relaxed/simple;
	bh=wbl6yjohVEHks2t3QFevZb8pAERYhcc8Vu8Ci1A4Er4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq/PZcrogB+xHmCh94melfmursghL1szkjiQ0B47CQLIXlQ5aCd/c3sTIsdjMH6PTXV3EuFkkMy4PcMd4yROm5X3VlmR7QNcVOtqA3azNm42B2tZBGYrfc37odqKZdMXFumPm7oo0lJjiU6rEAy+VJM37QY4HRknvx2KKFEGmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jVghTZE8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VkQ3IUe3MTv81pl2iURU52BXuGLBKddet8SzqQ3GLSk=; b=jVghTZE8tODbQCGiJirakhoxn0
	r/WwPkBNY+5jG53kqv53d2WdIdWMOkKrccVcp6Pl0K4H+WIIU54Sr6Zx7JfYVt0kN/CP97wrSox0t
	A5f9SJTDFGK8ueD+OdJADK5WHd+2uNzKnCYphtwjot5RkmlosVhAXzEKx0BmppQhpVaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqsaV-0065Qd-Mi; Tue, 26 Aug 2025 14:15:43 +0200
Date: Tue, 26 Aug 2025 14:15:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <6952fd42-f0b1-4509-a91e-b2e43436a873@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
 <20250825212357.3acgen2qezuy533y@skbuf>
 <CAAXyoMOVY7EvY9CtAphWcZrfNpz+JuUXcTf3M79FSYkbLSTvhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMOVY7EvY9CtAphWcZrfNpz+JuUXcTf3M79FSYkbLSTvhg@mail.gmail.com>

> > > +static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
> > > +{
> > > +     struct device *dev = to_device(priv);
> > > +     u32 val;
> > > +     int res;
> > > +
> > > +     res = yt921x_smi_read(priv, YT921X_FDB_RESULT, &val);
> > > +     if (res)
> > > +             return res;
> > > +     if ((val & YT921X_FDB_RESULT_DONE) == 0) {
> > > +             yt921x_smi_release(priv);
> >
> > yuck, why is it ok to release the SMI lock here? What's the point of the
> > lock in the first place?
> >
> 
> It's the bus lock, not the driver lock. We need to release the bus
> lock when we want to sleep.

Why do you need to release the lock when you sleep? It is not a
spinlock, you can sleep while holding it. How do you prevent other fdb
operations running in parallel if you don't hold the lock?

> > > +static int
> > > +yt921x_dsa_get_eeprom(struct dsa_switch *ds, struct ethtool_eeprom *eeprom,
> > > +                   u8 *data)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +     unsigned int i = 0;
> > > +     int res;
> > > +
> > > +     yt921x_smi_acquire(priv);
> > > +     do {
> > > +             res = yt921x_edata_wait(priv);
> > > +             if (res)
> > > +                     break;
> > > +             for (; i < eeprom->len; i++) {
> > > +                     unsigned int offset = eeprom->offset + i;
> > > +
> > > +                     res = yt921x_edata_read_cont(priv, offset, &data[i]);
> > > +                     if (res)
> > > +                             break;
> > > +             }
> > > +     } while (0);
> > > +     yt921x_smi_release(priv);
> > > +
> > > +     eeprom->len = i;
> > > +     return res;
> >
> > What is contained in this EEPROM?
> >
> 
> No description, sorry.

Even if you don't have a detailed description, can you tell us what it
can be used for?

The Marvell switches have a little application specific language which
allows you to write values into any register, and poll waiting for
events. It allows you to setup some aspects of the switch without
software. Using it is not a good idea, because DSA has no idea what
the EEPROM has done, and it could invalidate the assumptions about
reset default values.

In theory it is also possible to put code in the EEPROM for the Z80.
But i've never seen that does, probably because nobody combines DSA
with using the Z80.

> > I guess you got this snippet from mv88e6xxx_mdios_register(), which is
> > different from your case because it is an old driver which has to
> > support older device trees, before conventions changed.
> >
> > Please only register the internal MDIO bus if it is present in the
> > device tree. This simplifies the driver and dt-bindings by having a
> > single way of describing ports with internal PHYs. Also, remove the
> > ds->user_mii_bus assignment after you do that.
> >
> 
> How to access internal PHYs without registering the internal MDIO bus?

phy-handle in each port nodes pointing to the PHY. This is standard
Ethernet DT. It just makes it more verbose.

> > > +     /* chip */
> > > +     .get_eeprom_len         = yt921x_dsa_get_eeprom_len,
> > > +     .get_eeprom             = yt921x_dsa_get_eeprom,
> > > +     .preferred_default_local_cpu_port       = yt921x_dsa_preferred_default_local_cpu_port,
> > > +     .conduit_state_change   = yt921x_dsa_conduit_state_change,
> > > +     .setup                  = yt921x_dsa_setup,
> >
> > No STP state handling?
> >
> 
> Support for (M)STP was suggested for a future series in previous reviews.

It is a pretty important feature to have, otherwise your network dies
in a broadcast storm when there are loops. I personally would of added
STP before VLANS. So please don't wait too long with this feature.

> > > +/******** debug ********/
> > > +
> > > +static ssize_t
> > > +reg_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +     struct yt921x_priv *priv = dev_get_drvdata(dev);
> > > +
> > > +     if (!priv->reg_valid)
> > > +             return sprintf(buf, "0x%x: -\n", priv->reg_addr);
> > > +
> > > +     return sprintf(buf, "0x%x: 0x%08x\n", priv->reg_addr, priv->reg_val);
> > > +}
> > > +
> > > +/* Convenience sysfs attribute to read/write switch internal registers, since
> > > + * user-space tools cannot gain exclusive access to the device, which is
> > > + * required for any register operations.
> > > + */
> > > +static ssize_t
> > > +reg_store(struct device *dev, struct device_attribute *attr,
> > > +       const char *buf, size_t count)
> >
> > NACK for exposing a sysfs which allows user space to modify switch
> > registers without the driver updating its internal state.
> >
> > For reading -- also not so sure. There are many higher-level debug
> > interfaces which you should prefer implementing before resorting to raw
> > register reads. If there's any latching register in hardware, user space
> > can mess it up. What use case do you have?
> >
> 
> It is not possible to debug the device without a register sysfs, see
> previous replies for why we need to lock the bus (but not necessarily
> the MDIO bus). And if they are to modify switch registers, that's what
> they want.
> 
> So it's also kind of development leftover, but if anyone wants to
> improve the driver, they would come up with pretty the same debug
> solution as this, thus I consider it useful in the future. If that
> effort is still not appreciated, it might be wrapped inside a #ifdef
> DEBUG block so it will not be enabled to end users.

Write access in any form is definitely NACK.

For read access, please look at mv88e6xxx devlink regions, and
https://github.com/lunn/mv88e6xxx_dump

	Andrew

