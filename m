Return-Path: <netdev+bounces-215489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED422B2ECB8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11594188AEBB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A02BF017;
	Thu, 21 Aug 2025 04:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701E23A564
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750270; cv=none; b=Fjmf+hMd0jSxayC7alO2meXXpRQ9FMDLISl/xUtxp/Hk6s8T5NyUnwVPtUh5OVgOIDFgiBgyPtuxSD/uVMDQLlZOL+Z8Io5gPRCUbkzsO5qZ0Dg4mH52tA+c3UyUcf77sB4LyI4I58jHKL7+mJv1vTuuqquGaCLug6k5DlX0aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750270; c=relaxed/simple;
	bh=FnPAcNFU8zPBbmw/p356FXVqrBzY4y7BG59zjo96mmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdVY+Uac9GUf4otrZq0thj2OwMJol+DjY/WWbGr5VR6fWoFvAoct/lAZEgq4u3nqR/H70Ti9uUaYlUkd7EVZpIzFdqyV3jQvdjQUpaFUuoxCjk/NHc1mmRJLVZumP4avJONtU7uiU5mtEUeDSDOBbsUfJNTaw625rIFhOjTZ4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uowqZ-0005UK-S7; Thu, 21 Aug 2025 06:24:19 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uowqZ-001M4N-0a;
	Thu, 21 Aug 2025 06:24:19 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uowqZ-007ub5-0F;
	Thu, 21 Aug 2025 06:24:19 +0200
Date: Thu, 21 Aug 2025 06:24:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Dent Project <dentproject@linuxfoundation.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool v3 2/3] ethtool: pse-pd: Add PSE priority support
Message-ID: <aKafc9yAiMPoNNTx@pengutronix.de>
References: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
 <20250820-b4-feature_poe_pw_budget-v3-2-c3d57362c086@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820-b4-feature_poe_pw_budget-v3-2-c3d57362c086@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 20, 2025 at 11:07:33AM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for PSE (Power Sourcing Equipment) priority management:
> - Add priority configuration parameter (prio) for port priority management
> - Display power domain index, maximum priority, and current priority
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you! 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

