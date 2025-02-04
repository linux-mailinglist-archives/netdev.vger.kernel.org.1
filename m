Return-Path: <netdev+bounces-162525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6345A272F4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878AA7A2202
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F120E000;
	Tue,  4 Feb 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F6kU6UJd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E325A651
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674800; cv=none; b=R1zOEI/YuQYO2daHRSVW0rHxyrRYhBQWxSp62yFjtvzA13lx8fD1efFXj3p33yYbKpJoZk97smb1AN6Z7llzaFv3DKK/pkMvh9sOMn9DRhUVU7RSJgEqhp/vTqTO7DH81EGUfO3ICHcXmICrPcv1yplAxPRocJTkwT5j8H9yKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674800; c=relaxed/simple;
	bh=nQj8zz12V9saZ3Z/1810KMjbSF8xypz0+3qZ5kXEuYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYYeLop7morQ6nRyJZ5TFdNzKkS4MOwAKsDcphpSmpscJgvLkoBKt3Btfec/ICBkhDOX7VxHWwZGeT+3ckQsFSGa54sgv7bVvW79ZblnY4ifd9GnJoA2crD9ock7aqrJVHFeOmoN/ge6SDnKFV7Z6A3j76pwxggxUVYcU8rbdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F6kU6UJd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7kvRpsoMUseBM90OfHI2sGyIB7Ahtn78oVt4lWl1cLc=; b=F6kU6UJdONcnDQ/sgYaIJRsUZM
	svX+G/KNUK08reHT4iml3dM15Nn3obz0o7YAA5qV9mngCIkyV4xwTvGHUDlv9kRJvB73Gi1aVY/Wd
	J8s4RHSgJQjfD51VAucwN4RsbaDR7e6GPqashC4ax9+HeR/B7uKr9sBjDUDKQIpapJgc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfIjq-00ArBZ-UD; Tue, 04 Feb 2025 14:13:14 +0100
Date: Tue, 4 Feb 2025 14:13:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: DT options for DSA user port with internal PHY
Message-ID: <8eb8885f-2307-4ad4-9302-8423ba4db67d@lunn.ch>
References: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>

On Tue, Feb 04, 2025 at 09:30:23AM +0100, Frieder Schrempf wrote:
> Hi,
> 
> I'm using a KSZ9477 and I'm configuring the DSA user ports in the
> devicetree.
> 
> Due to the hardware implementation I need to use some options that
> currently seem to be unsupported by the driver.
> 
> First the user ports are physically limited to a maximum speed of
> 100MBit/s. As the MAC and the PHYs are capable of 1G, this also what
> gets advertised during autoneg.
> 
> Second the LEDs controlled by the PHY need to be handled in "Single
> Mode" instead of "Dual Mode".
> 
> Usually on an external PHY that gets probed separately, I could use
> "max-speed" and "micrel,led-mode" to achieve this.
> 
> But for the KSZ9477 the PHYs are not probed but instead hooked into the
> switch driver and from the PHY driver I don't seem to have any way to
> access the DT node for the DSA user port.
> 
> What would be the proper way to implement this? Any ideas?

The normal way to do this is add an mdio node, and use phy-handle in
the ports to point to the PHY on the MDIO bus. The PHY are then probed
in the usual ways, and you can have DT properties.

	Andrew

