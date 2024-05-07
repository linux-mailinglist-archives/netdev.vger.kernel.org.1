Return-Path: <netdev+bounces-93931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F048BDA38
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538A8282ABE
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E46A8AE;
	Tue,  7 May 2024 04:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DB6A8A7
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715056666; cv=none; b=ksbhykAnPLgMKPqx34dNPYNLApA8yK4C/8JUy8Wyk1rLSvivz9nKbhRjtaX7L274fb1CW3E+TH1A5zuzpkWyUOtsTcwsu1vuNuJrxIA0xz6Q37rZDCS8lYDi19Cb4qme4FSsJHMCE3ZuQ1tW4n0yUmqW0c/vDe3dYvt/zyLTfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715056666; c=relaxed/simple;
	bh=aT0c/mqPMZJlJvVQg+gBBzEWKmKlW36JzyIBfyetZd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlRqHMmPzYb5m6zKRzuXgsiPfNv9ooMpyJsHbXG0wNqss9vOKg3pgDIJkax8WGj3wEM6imTvFxijklrv+YCrQJOmYmgq3TiH1fwtj5KXMD/tlyYonUNapJ3vGYVyMldwBVD8cqunxLGMYtgnyr7LKIjkysTR4YiuLHPelF3bW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4CaA-0003Rb-AE; Tue, 07 May 2024 06:37:38 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4Ca8-00028P-Hp; Tue, 07 May 2024 06:37:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4Ca8-00GKQ6-1R;
	Tue, 07 May 2024 06:37:36 +0200
Date: Tue, 7 May 2024 06:37:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung.Huh@microchip.com
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	olteanv@gmail.com, Arun.Ramadoss@microchip.com,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	dsahern@kernel.org, horms@kernel.org, willemb@google.com,
	san@skov.dk
Subject: Re: [PATCH net-next v7 02/12] net: dsa: microchip: add IPV
 information support
Message-ID: <ZjmwEPS0BM0QJUc5@pengutronix.de>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
 <20240503131351.1969097-3-o.rempel@pengutronix.de>
 <BL0PR11MB29131C40E4B39B119F9891C2E71C2@BL0PR11MB2913.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR11MB29131C40E4B39B119F9891C2E71C2@BL0PR11MB2913.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Woojung,

On Mon, May 06, 2024 at 08:43:48PM +0000, Woojung.Huh@microchip.com wrote:
> Hi Oleksij,
> 
> Thanks for the patch and sorry about late comment on this.
> 
> I have a comment on the name of IPV (Internal Priority Value)
> IPV is added and used term in 802.1Qci PSFP
> (https://ieeexplore.ieee.org/document/8064221) and, merged into 802.1Q (from 802.1Q-2018)
> for another functions. 
> 
> Even it does similar operation holding temporal priority value internally (as it is named),
> because KSZ datasheet doesn't use the term of IPV (Internal Priority Value) and
> avoiding any confusion later when PSFP is in the Linux world,
> I would like to recommend a different name such as IPM (Internal Priority Mapping) than IPV.
> 
> How do you think?

Ok.

Do IPV in LAN9372 datasheet means, IPV 802.1Qci PSFP or IPM?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

