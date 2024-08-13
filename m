Return-Path: <netdev+bounces-118196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31180950F2C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD9B1F23449
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B61A76D5;
	Tue, 13 Aug 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EKWjyw6g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB417B433;
	Tue, 13 Aug 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584782; cv=none; b=KCpcCCYrdtriiGjr/qg0sEMedHQUKax6GNuTNJSFOh8p/cuWqPEDm0lCFyJQKpZoRfCleKHKxW8c6O0+KLqWJCUOCInk+wBuetOEef1FHPQBLHvbRxfzwhDwzpU4cbo1adlsroSznagGzFZksvhm0paywnJNNnnJ615Z444xYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584782; c=relaxed/simple;
	bh=LL67Qn5AcFOoxnqElfswr52Sz+rm6HzPth1c/jtLGe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwOjtsneZB7hKdNUzJ9xjT5yHtwW2SEQ5ozNPinoOVhQPUb1+MyZ4rI6jPQrIWAywDw93dnt00iaOhAwPDjgumE1IPUHDYMG7m5gjCMkH7P4Iyg0YXttDz1so6xs5rGXPya6lWIucq6zEaEyD7Oe+NYWx4y0RZoomRc1dz+S+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EKWjyw6g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0zHtH7S9/+nzyRBmhfYheqhQqQGzPuG4dr/VRiZTh44=; b=EKWjyw6g2EXx8NfidMDFp0xD5P
	kSbdCAjzRbUPWPfdP65kOEunr58lkEDR/aPocTZSQ/BNXqobshCwEclrx9KaNuDRz3mvKNw4UAqDj
	CmEE3ylxB3KfAlpN7RCanITFIm5yLomICJDnIFmZWxqrQn7kwJZtETYteKWs0a4JLgrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdz87-004iNs-Gi; Tue, 13 Aug 2024 23:32:35 +0200
Date: Tue, 13 Aug 2024 23:32:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marex@denx.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Message-ID: <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>

On Tue, Aug 13, 2024 at 09:14:34PM +0000, Tristram.Ha@microchip.com wrote:
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > >
> > > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> > >
> > > SFP is typically used so the default is 1.  The driver can detect
> > > 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> > > has to be explicitly set to 0 as driver cannot detect that
> > > configuration.
> > 
> > Could you explain this in more detail. Other SGMII blocks don't need
> > this. Why is this block special?
> > 
> > Has this anything to do with in-band signalling?
>  
> There are 2 ways to program the hardware registers so that the SGMII
> module can communicate with either 1000Base-T/LX/SX SFP or
> 10/100/1000Base-T SFP.  When a SFP is plugged in the driver can try to
> detect which type and if it thinks 10/100/1000Base-T SFP is used it
> changes the mode to 2 and program appropriately.

What should happen here is that phylink will read the SFP EEPROM and
determine what mode should be used. It will then tell the MAC or PCS
how to configure itself, 1000BaseX, or SGMII. Look at the
mac_link_up() callback, parameter interface.

	Andrew

