Return-Path: <netdev+bounces-174995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FEA6204C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 23:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6485A463E9E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35141DA61D;
	Fri, 14 Mar 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0305XuJA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291B1953A9;
	Fri, 14 Mar 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991149; cv=none; b=AnD/sUKq88AijqqAJbWoeMIcx3KKW/bUxQUwSjn09yXcNyQynq9Yv6qA1+fG1I8H6sPj8ZMYfguZ2tXFpAyCbx44Qx5hjpoVfzzNrBlShraBMYrlR7GlnBL8SjeXsEp6sgeac7yKhIwDVCEt2BGcQNTjc3MnU3WUx4BQ6ORhqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991149; c=relaxed/simple;
	bh=ZVLdK11Lq3hOJ2AwZ/4yIqrekAVtkjZF3tElAiA+gIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka2+6SU9QbpdQVJQVNkl4Udon3uCCiOaqH+Z1iALNvnJiILFBZ9ZXG8tXsqrzNtl0JpGtlUTfKnZ4kxrPVmkfjfQ3xbtDZpIBNhQE0nSaKHF30L4UE43U6JJDkr86R0vX5IaG3wNwf7R3vGI87sDnQaKBGUmu5G5U0UetPHXPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0305XuJA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lPaccfJ0sEBvFjPYyS8PLhimTq5kEa5pqJCwOZtsTeE=; b=0305XuJAFlMgsafcUGGQRfctCU
	JdAoUkijrDOjSzQwqYtd9RcxWlj5Y9YLXBkmtaDZ1l3s/RQ64+yA3wQX4f+Zq5iBPQqb8ZdSG8xO+
	WWmljz5V6MrKGxY7vHEI9iQO9bsYiy2f2amyKmrZAurAeIzyaCgVv2RLe7ly1hTyizB62imBvfLKD
	BEWNlBDS6qyVnlY7GKB4eLnF7DtGuDWd/rC9TAd8dZkhGn3oxbsYkTncbLIT3jPpUec8j5/Ew3wUo
	kZ8jAKbm+tqiptaY41cVEf9FS28l4G3rFBwGNOFRZewEfCVRJJySpiptptcwEwYVSoiVwZUiGy+9h
	2WQQ5baw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41742)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ttDT7-0000vY-0X;
	Fri, 14 Mar 2025 22:25:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ttDT0-0006x5-2r;
	Fri, 14 Mar 2025 22:25:22 +0000
Date: Fri, 14 Mar 2025 22:25:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 07/13] net: mdio: regmap: add support for
 multiple valid addr
Message-ID: <Z9Ss0qrxCcEbyJY7@shell.armlinux.org.uk>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-8-ansuelsmth@gmail.com>
 <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>
 <67cdd3c9.df0a0220.1c827e.b244@mx.google.com>
 <0c6cb801-5592-4449-b776-a337161b3326@lunn.ch>
 <Z9SZRDykbTwvGW6S@shell.armlinux.org.uk>
 <67d49d64.050a0220.35694d.b7ab@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d49d64.050a0220.35694d.b7ab@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 14, 2025 at 10:19:29PM +0100, Christian Marangi wrote:
> On Fri, Mar 14, 2025 at 09:01:56PM +0000, Russell King (Oracle) wrote:
> > I'd prefer we didn't bring that abomination back. The detail about how
> > things are stored in regmap should be internal within regmap, and I
> > think it would be better to have an API presented that takes sensible
> > parameters, rather than something that's been encoded.
> 
> Well problem is that regmap_write and regmap_read will take max 2 value
> at the very end (reg and value) so it's really a matter of making the
> encoding part internal but encoding it can't be skipped.
> 
> You are suggesting to introduce additional API like
> 
> mdio_regmap_write(regmap, phy, addr, val);
> mdio_mmd_regmap_write(regmap, phy, mmd, addr, val);
> 
> And the encoding is done internally?

Yes, because littering drivers with the details of the conversion is
unreasonable.

> My concern is the decoding part from the .write/read_bits regmap OPs.
> I guess for that also some helper should be exposed (to keep the
> decoding/encoding internal to the driver and not expose the
> _abomination_)

Sadly, I don't think that's something we can get away from, but we
should make it _easy_ for people to get it right.

From what I remember from the days of shoe-horning C45 into the C22
MDIO API, encoding and/or decoding addresses was buggy because people
would use the wrong encoders and decoders.

For example, we had MDIO drivers using mdio_phy_id_is_c45() to test
whether the access being requested was C45 - mdio_phy_id_is_c45() is
for the _userspace_ MII API encoding (struct mii_ioctl_data), not the
kernel space. Kernel space used:

-#define MII_ADDR_C45 (1<<30)
-#define MII_DEVADDR_C45_SHIFT  16
-#define MII_REGADDR_C45_MASK   GENMASK(15, 0)

to encode into the register number argument vs the userspace encoding
into the phy_id member of struct mii_ioctl_data:

#define MDIO_PHY_ID_C45                 0x8000
#define MDIO_PHY_ID_PRTAD               0x03e0
#define MDIO_PHY_ID_DEVAD               0x001f

which is what the mdio_phy_id_*() accessors are using. The two
approaches are incompatible, and using the userspace one in a MDIO
driver wasn't going to work correctly - but people did it.

This is one of the reasons I hated the old MDIO API, and why we now
have separate C22 and C45 interfaces in the driver code.

This is exactly why I don't like reintroducing a new set of "massage
the package, mmd and address into some single integer representation"
and "decode a single integer into their respective parts" - we've
been here before, it's lead to problems because driver authors can't
grasp what the right approach is, and it results in bugs.

Given the history here, my personal opinion would be... if regmap can't
cope with MDIO devices having a three-part address without requiring
callers to flatten it first, and then have various regmap drivers
unflatten it, then regmap is unsuitable to be used with MDIO and ought
not be used.

So, this encoding/decoding is a problem that should be solved entirely
within regmap, and not spread out into users of regmap and drivers
behind regmap. Anything else is, IMHO, insane.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

