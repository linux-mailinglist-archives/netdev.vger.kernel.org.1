Return-Path: <netdev+bounces-208971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E18B0DD9D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE6E1C85F19
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D22EFDAF;
	Tue, 22 Jul 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JllzPbi4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B882EF669;
	Tue, 22 Jul 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193253; cv=none; b=nHmGMgZQYCuwgLAg3LtCcwetgkcnihvt2IWew/9p/4WnhKwXX74GELdRqQhbSQ9p6+HAwceGGjVk4iMhYv3XFFizt6IBN6U3JUOPNXTM2mT1mYynHgq9V4Uc1Tti/yi4Odfn1WyyOMg7GtzUSdVeznUnGwrUaO3CHrLxpUpTVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193253; c=relaxed/simple;
	bh=Fci52zCniads1pZgwQqYte9RMpREgblARps7U5z6BDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV6z0EK8fvBfPicINyY9YoxIlyWLP8Z+GRoz8KWzjavJKjvYk9AAfz9e1YtSW6dxU/kyN2AyLR0EC/liKQnG19wstn6lyn2g9IwcGOyOeNWI3c4GizzNXYXoo07oNRZmoK43J7Z9MLV0QG2CbgCxyZycB2kLXnn/yfWrRLGohU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JllzPbi4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0jFu8sOPMkZ/eXw6Hxbm9Ofc0OdtdvCKlqxK+F5dq+o=; b=JllzPbi4165KOYJ2nX+VJKqDBQ
	lWhb1tCON1TGIfIOosVj0nG3GP2UA5+/uXuYkTUGckTMi9dwwtCcSR3gGXBtwymADInPsmN2p6uk7
	Pp8KHRCREAg1Wt2aOR6rPdoYn8bZA6zmotNFJ0JtXCk/l0OJbrM/h85Q4W4q5rPLvrSM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueDeN-002TOt-AW; Tue, 22 Jul 2025 16:07:23 +0200
Date: Tue, 22 Jul 2025 16:07:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com,
	jszhang@kernel.org, jan.petrous@oss.nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	boon.khai.ng@altera.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet
 driver
Message-ID: <28a48738-af05-41a4-be4c-5ca9ec2071d3@lunn.ch>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
 <c212c50e-52ae-4330-8e67-792e83ab29e4@lunn.ch>
 <7ccc507d.34b1.1980d6a26c0.Coremail.lizhi2@eswincomputing.com>
 <e734f2fd-b96f-4981-9f00-a94f3fd03213@lunn.ch>
 <6c5f12cd.37b0.1982ada38e5.Coremail.lizhi2@eswincomputing.com>
 <6b3c8130-77f0-4266-b1ed-2de80e0113b0@lunn.ch>
 <006c01dbfafb$3a99e0e0$afcda2a0$@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006c01dbfafb$3a99e0e0$afcda2a0$@eswincomputing.com>

> In v2, `eswin,dly-param-xxx` is used to configure all delay registers via
> device tree, including RXCLK and TXCLK. Based on the latest discussion,
> this approach in the next version:
> - The delay configuration for RXCLK and TXCLK will be handled using the
>  standard DT properties `rx-internal-delay-ps` and `tx-internal-delay-ps`.
> - The remaining delay configuration (e.g., for RXD0-4, TXD0-4, RXDV) will
>  continue to use the vendor-specific `eswin,dly-param-xxx` properties.
> - If the standard delay properties are not specified in DT, a default of 0
> ps
>  will be assumed.

Please keep the RGMII standard in mind. All it says is that there
should be a 2ns delay between the data and the clock signal. It is
also quite generous on the range of delays which should actually
work. It says nothing about being able to configure that delay. And it
definitely says nothing about being able to configure each individual
single.

You hardware has a lot of flexibility, but none of if should actually
be needed, if you follow the standard.

So phy-mode = "rgmii-id"; should be all you need for most boards.
Everything else should be optional, with sensible defaults.

	Andrew

