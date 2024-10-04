Return-Path: <netdev+bounces-132007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1C99020D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F94D1F2378F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447D1586F2;
	Fri,  4 Oct 2024 11:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D87155C96
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041331; cv=none; b=SwR5LvLm8VNb5tONlmvlV6c//S3QC/Eh1bu8040InwQPkFVFqKui+JZdXxNJWzOjDZYC6K72/kfwPb1tEeMVg6qY+gGlJfLj+G2nILTPTM/BBMWvEdAlBCb3A1hvC2VEbmEwpNypFEteTSTjOZS32FOBkWWFbKOhZum9jtpAsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041331; c=relaxed/simple;
	bh=TMCTua+WSh+xta2fTLxp7TAvOG3Qg5iX+WemrbYBX/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAhg9NTTx4Ln/MVtKlKpBwGjbsCyUHpvDBgf8qR4XLXKhpKbobxLM0kzRULuAsMujYlOeC/lyzo373f46naQ3UHhEH5PCdL2WCOZcmKOTYRpPAzq+zW7tWYcNG+08EAi6LKGXa5CMIZyk+MFT5rZEW4cWQDZDhKkfmaMwZSwf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swgU2-0005Pf-UB; Fri, 04 Oct 2024 13:28:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swgU0-003YgO-WE; Fri, 04 Oct 2024 13:28:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swgU0-00Ag87-2r;
	Fri, 04 Oct 2024 13:28:28 +0200
Date: Fri, 4 Oct 2024 13:28:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Divya.Koppera@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, f.fainelli@gmail.com,
	maxime.chevallier@bootlin.com, kory.maincent@bootlin.com,
	lukma@denx.de, corbet@lwn.net, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
Message-ID: <Zv_RXMRn83Tshf0H@pengutronix.de>
References: <20241003060602.1008593-1-o.rempel@pengutronix.de>
 <CO1PR11MB477100FB112A842674009A1AE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO1PR11MB477100FB112A842674009A1AE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Divya,

On Thu, Oct 03, 2024 at 10:00:21AM +0000, Divya.Koppera@microchip.com wrote:
> Hi @Oleksij Rempel<mailto:o.rempel@pengutronix.de>,
> 
> 
....
> 
> > +  - **Advertised auto-negotiation**:
> 
> > +
> 
> > +    - For **SPE** links (except **10BaseT1L**), this will be **No**.
> 
> 
> 
> May be to generalize statement for T1 phys, I would suggest it should be referred as "Yes" in case of auto-negotiation is enabled, "No" if auto-negotiation is disabled.
> 
> 
> 
> We are submitting patches for lan887x(100/1000BaseT1) and soon we will add support for auto-negotiation as well.

Ah, I see. Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

