Return-Path: <netdev+bounces-209613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394B5B100AB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A1587175
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41E221703;
	Thu, 24 Jul 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="symZN1B6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FC1F560B;
	Thu, 24 Jul 2025 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338522; cv=none; b=nwj4He67Z+jD2KfZAZPpCN2JUPm2K/7BDoBRlqPTIngzEZG51ELeTIacw8t+lycZHhH+/QQIyCia+kfI1tFQjPETuUQ4Pashb+5eY7oVxtUdsI5aQb/3CGEYzSQ4VDebjxNpzNBHklwImpTDTRAHSjQPkUNWAYUNRqxRTjnen3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338522; c=relaxed/simple;
	bh=Uh8lQN9GbPQGeUNxI7LlPDsbWZ2JZPCBacT5BVDI2T0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPrF5IOMqfeCFm/Pe6FprpAZTaLA8/opHE2jjSpGuz60bSQxlZz1jtDr5gKeLXNqKisgT+CfCvW2P1X/rDTr5kR4adOS4+1f8Kfh285aMK7I8zRKIGl3LFp7idMDOSk0FPoo+ab75TCa1z6j/0xSFWuus5ZEIEhk/ECNxFXr6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=symZN1B6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753338520; x=1784874520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uh8lQN9GbPQGeUNxI7LlPDsbWZ2JZPCBacT5BVDI2T0=;
  b=symZN1B63HFeJauyloJ7k58oLf5NCr83Aw37pcFw338HiA1LhK+MdrA+
   PyGjSijGB4qJaqXy7lhJYbgFawgrUnKHwXchKq93P9bYMX4js5O+NLk4L
   XEf7KkpHcxYLzdjmN4ZQYMjKioYhcrCoKWFoTuJSA+xUAUtVM93SfH81p
   Qr84U9vkaYJpr7O2iGA9ZcA7iFL/7Sv/LVVNxUmJo7uq5ePHZsLslDryO
   cyTuK3B6OEme6LjI3nbvHColzTZca9uClomRbJfUGPRkiLHf5qCznBSFE
   UI6E+yv/036XXMRmVUCdl9laJ4+gV8o5oiPAFij/1REEHsl3xGEeNjw71
   g==;
X-CSE-ConnectionGUID: 9I9A0w6fSUe70PKc57BN9A==
X-CSE-MsgGUID: /7k3MEXYSRuedrBm6qxN5Q==
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="49666171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2025 23:28:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 23 Jul 2025 23:27:58 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 23 Jul 2025 23:27:57 -0700
Date: Thu, 24 Jul 2025 08:25:05 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <20250724062505.bl6mme4j3iuvvut7@DEN-DL-M31836.microchip.com>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
 <aIB0VYLqcBKVtAmU@pengutronix.de>
 <20250723090145.o2kq4vxcjrih54rt@DEN-DL-M31836.microchip.com>
 <aIC944gcYkfFsIRD@pengutronix.de>
 <d4bbca28-5ba9-403a-8389-da712602af68@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d4bbca28-5ba9-403a-8389-da712602af68@lunn.ch>

The 07/23/2025 16:28, Andrew Lunn wrote:

Hi,

> 
> > # FLF Behavior (Immediate Failure)
> > An FLF-enabled PHY is designed to report link instability almost
> > immediately (~1 ms). Instead of trying to recover silently, it
> > immediately reports a hard link failure to the operating system.
> >
> > # The Disadvantage in a Single-Link System
> >
> > For a system with only one link, this "fail-fast" approach can be a
> > disadvantage. Consider a short, recoverable noise burst:
> >
> > - Without FLF: The PHY uses its 750 ms grace period to recover. The
> > link stays up, and the service interruption is limited to brief packet
> > loss.
> >
> > - With FLF: The PHY reports "link down" after ~1 ms. The operating
> > system tears down the network interface. Even if the hardware recovers
> > quickly, the OS has to bring the interface back up, re-run DHCP, and
> > re-establish all application connections. This system-level recovery
> > often takes much longer than the original glitch.
> >
> > In short, FLF can turn a minor, recoverable physical-layer glitch into a
> > more disruptive, longer-lasting outage at the application level when
> > there is no backup link to switch to.
> 
> Fast link down can be a useful feature to have, but the PHY should
> default to what 802.3 says. There is however:
> 
> ETHTOOL_PHY_FAST_LINK_DOWN
> 
> which two drivers support.

OK, by default the FLF support will not be enabled and then in a
different patch I will allow to configure the FLF using
ETHTOOL_PHY_FAST_LINK_DOWN.


> 
>         Andrew

-- 
/Horatiu

