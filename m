Return-Path: <netdev+bounces-152189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98759F303F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6ADE7A366E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DF205AB6;
	Mon, 16 Dec 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AvEz7mgn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F22046BA;
	Mon, 16 Dec 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351108; cv=none; b=pj4P5w3M3lvVy1wU8J88DdH7zbwbUvbZt/118EoMfXuU+LJlK2BTrQK27gLhgEW4rfId9u41OWEkd5xqBu2P19+7aYkaM2Y6dwsvFprokA8bzVmsE6c6d/xmsWFqLf0QWmS4EtkmFEU/Xy9tDmRppxs5gpIOo4YPkiD8trqEdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351108; c=relaxed/simple;
	bh=/uPilcPPSkM0vFf7CZp7ih66ufLi2xO3rEUxtf1Dzh8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL1OCaJAeWJBNtdgde+HvQJrhMFQOHccyam4h0gEchk0QgMrS7Wws85zjVMbgM3KXeCPSmQ+/tgevq2oZ/ZM3atxoKOz6aaBvBN8adzPcDPK1tKLUKds71uWtv31mFoUq4VGrkFJjIM9/zsK6S0ZexP0oZcfPGoJsUPMXzRX4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AvEz7mgn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734351107; x=1765887107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/uPilcPPSkM0vFf7CZp7ih66ufLi2xO3rEUxtf1Dzh8=;
  b=AvEz7mgnA8QDnTyvXhbj1cgm6Q5mMzmXV9oVNBYa/sswpoxsZYQ3KL2h
   SoyeFFrqaTMsxhgvmY8uiqWwaALZ5Sp/UO9dDMDYaKDTlVoyBtv/U3ikP
   LYii1QTG4orh3IPOwKWxY8ITcbuu8iTQ2H4o/RdAMUd1TvRo+QOGlKdrt
   b39bFs3wX/D+bsnPLEw/uvyRP9v6XT5gfaDmsfbclsUyLX7Fqbxt5a3T8
   p0vUJULK3bzp1nvQT2bE9jW+SIHKFUMYqnd4EMIkgfMyxUYbIqt2UkyGQ
   Rbapm9WxOjQO1k1q2QQWc4nfmFRL+4dTl6bIKaTxm3JF8Kge1EffKxYIz
   Q==;
X-CSE-ConnectionGUID: pK+G4L7kQ0aeZKZcimCaNA==
X-CSE-MsgGUID: AxFEMPyOT+abSUdbeMU9OQ==
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="35580346"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2024 05:11:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Dec 2024 05:10:44 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 16 Dec 2024 05:10:41 -0700
Date: Mon, 16 Dec 2024 12:10:40 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <jacob.e.keller@intel.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
Subject: Re: [PATCH net-next v4 6/9] net: sparx5: verify RGMII speeds
Message-ID: <20241216121040.2dpxb7mv6h3u3r42@DEN-DL-M70577>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
 <20241213-sparx5-lan969x-switch-driver-4-v4-6-d1a72c9c4714@microchip.com>
 <Z1yPq6OEziTNjWHK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1yPq6OEziTNjWHK@shell.armlinux.org.uk>

> On Fri, Dec 13, 2024 at 02:41:05PM +0100, Daniel Machon wrote:
> > When doing a port config, we verify the port speed against the PHY mode
> > and supported speeds of that PHY mode. Add checks for the four RGMII phy
> > modes: RGMII, RGMII_ID, RGMII_TXID and RGMII_RXID.
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> You do realise that phylink knows what speeds each interface supports
> (see phylink_get_capabilities()) and restricts the media advertisement
> to ensure that ethtool link modes that can't be supported by the MAC
> capabilities and set of interfaces that would be used are not
> advertised.
> 
> This should mean none of your verification ever triggers. If it does,
> then I'd like to know about it.

Yes, I agree. Having an extra look at phylink, these checks should not trigger
at all.

As it is, the default switch case is to throw an error, so without this
addition, the sparx5_port_verify_speed() function will fail when the PHY mode
is any of RGMII{_ID,_TXID,_RXID}. This patch just follows the established
pattern of adding the new PHY mode and checking the speed. TBH, I think that
all the checks in this function can be removed entirely, but that is something
I would like to verify and follow up on in a separate series, if that is OK? 

Thanks.

/Daniel


