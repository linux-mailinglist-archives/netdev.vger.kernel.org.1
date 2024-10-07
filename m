Return-Path: <netdev+bounces-132581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E49923D7
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 07:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D21C2219F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2AE13A40D;
	Mon,  7 Oct 2024 05:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214C101C4
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278154; cv=none; b=u1mitoVdoe145TKGnE8r7h2eCr4EOIRupUbkgYabAkA82fx2EX6f90GGXEF2I0/bii29vQqu+mjKgREUOq+Tpm73Z5yDnArrPronud0o1gUgg02R1zV0ImS6+zYrR9g2g+GJfaSa+SKSIwSSHOpmgj7CFcqkBvmp1iSgx/3uHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278154; c=relaxed/simple;
	bh=9so6lN5/t0+Y9t0klCmPZB2QfktB7FCjnuGZfNWmkZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtibkIVf17SuyU+JzsMbxBgXJew1flhw+kwEMbk6+mEar0nQFJ4LRn4T2+GvYyRDOqskjzbjXUoBbKTrXT+LFIwxpmn9386d4mdh2iZ0/+99gbtAaroX6/LdS6ntRsGTOjek1ggWcjv5MIP/jJJ55lNQVwDyJatzZK6dYAu+XqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sxg5V-0006HC-Sr; Mon, 07 Oct 2024 07:15:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sxg5T-0003KR-UZ; Mon, 07 Oct 2024 07:15:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sxg5T-00G32z-2i;
	Mon, 07 Oct 2024 07:15:15 +0200
Date: Mon, 7 Oct 2024 07:15:15 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Divya.Koppera@microchip.com,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, f.fainelli@gmail.com, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <ZwNuY02MNN5LDI_F@pengutronix.de>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-2-o.rempel@pengutronix.de>
 <CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
 <a11860cc-5804-4a15-9603-624406a29dba@lunn.ch>
 <Zv6XOXveg-dU_t8V@pengutronix.de>
 <19207165-1708-4717-9883-19d914aea5c3@lunn.ch>
 <20241004095154.5810afbf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004095154.5810afbf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Oct 04, 2024 at 09:51:54AM -0700, Jakub Kicinski wrote:
> On Thu, 3 Oct 2024 19:05:58 +0200 Andrew Lunn wrote:
> > > 802.3 use "Multiport device" for "preferred master" and "single-port device"
> > > for "preferred slave". We decided to use other wording back in the past
> > > to avoid confusing and align it with forced master/slave configurations.   
> > 
> > ethtool is preferred, so it would be more consistent with preferred
> > 
> > [Shrug]
> 
> IIUC we have two weak preferences for "preferred"?
> LMK if I misunderstood.

Ahm... yes :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

