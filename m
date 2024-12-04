Return-Path: <netdev+bounces-149064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B289E3F30
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99034285845
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA120FA83;
	Wed,  4 Dec 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TSY6ZaN4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325E4A28;
	Wed,  4 Dec 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328178; cv=none; b=Ml8Q05pq+GG5gtHH1Vf9z1N4bNhsm7JDC5fpkjc8MSpBxYricTgEpet2q1qkC1Z+VHV7VpI5fblSB6JxM0yTlAHM/1MLyJYlQ74Nxp8Kx9oV5KXcMo0q3dTgLZP9mIQUQHyMJZ4Ha8tVrmPnNMPhHJ/LzIc1+A651s/SJWjbMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328178; c=relaxed/simple;
	bh=+e0Wy/bV+lBXIIc4XkW9w/5HmbBF37Y9AxpSIciXuL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvNEK/cdx1X1ZiXLhWfaaAo5pB45Yya7+wORxIvQKAojozziaH/yl2RGHu7RKgVKFks5RrYpfiu1rc1uaFVeZ2PyrwT8oMKwhiZiacobRbCi2tangkprxbjTOCzq9Cdr3fGxZV4ns8r4mUudeagmMj3hfhGsguFXO5txjyRlM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TSY6ZaN4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DlNOvKDRxlXlMOHtVxI2eG/srB8x2ClFQSY9zsll75c=; b=TSY6ZaN4o1vOZZbrR2zaT5rxqC
	fn7tKlaCpX1LC03MdUUtHZ1zX4vsZtSgaqWdLBg0auCyJF4Da4eVKndkp3jlU7EbwAat4cntvXz4P
	BgM8fy1NjKM2bZY83EIN5k8gkOsFhl9ikrHLt3ctCFwGB2dKdtTXU+4PA4A68bXMY5hU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIrpu-00FECE-LL; Wed, 04 Dec 2024 17:02:46 +0100
Date: Wed, 4 Dec 2024 17:02:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya.Koppera@microchip.com
Cc: Arun.Ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
 <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
 <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>

> > How many different PTP implementations does Microchip have?
> > 
> > I see mscc_ptp.c, lan743x_ptp.c, lan966x_ptp.c and sparx5_ptp.c. Plus this
> > one.
> > 
> 
> These are MAC specific PTP. The library that we implemented is for PHYs.

And the difference is? Marvell has one PTP implementation they use in
the PHYs and MACs in Ethernet switches. The basic core is the same,
with different wrappers around it.

> > Does Microchip keep reinventing the wheel? Or can this library be used in
> > place of any of these? 
> 

> As there are no register similarities between these implementations,
> we cannot use this library for the above mentioned MAC PTPs.

> 
> >And how many more ptp implementations will
> > microchip have in the future? Maybe MICROCHIP_PHYPTP is too generic,
> > maybe you should leave space for the next PTP implementation?

> Microchip plan is to use this PTP IP in future PHYs. Hence this phy
> library will be reused in future PHYs.

And future MACs? 

And has Microchip finial decided not to keep reinventing the wheel,
and there will never be a new PHY implementation? I ask, because what
would its KCONFIG symbol be?

	Andrew

