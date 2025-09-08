Return-Path: <netdev+bounces-220699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB2B4836E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 06:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3652F189C7A7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 04:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7A221264;
	Mon,  8 Sep 2025 04:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C83221FD4
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307140; cv=none; b=S4TZrnmYdKqpB8sliNYGdStNyQ+5yULfkqV7DVS6Pe0R5iS/iRSEeJZi8oaVcfELv9XCU+8RY6lxaq7CV0UdH190gxWqnoVK23iUCqFijA19uhyXDDUS6z6fsP6UlXvFu4ECaiMTV1LjY/11KotEx7dq0Co0TnA+qw8KimsvnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307140; c=relaxed/simple;
	bh=vSKC/kmQeqND3A2rQlChRNGe1FptQNXba+tF78DaMzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNLRP30MNExhpX7mUGC5RoRcmvdLwtIae8Q7WWOewPddDZpcEXDe1FpzF8S+VadNRGlRS/p5XRDE3Vf9lEwWQcHyYZ5BdLKqM8MWQD6CaRtKvS6gST2kJrh55xd+ommeAVaweWBUqhdqnrKoKtcYkcmGU9qYw1XBgJWEvM0uDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvTqu-0006ng-7X; Mon, 08 Sep 2025 06:51:40 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvTqq-000Bt9-2g;
	Mon, 08 Sep 2025 06:51:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvTqq-00Bi0F-2A;
	Mon, 08 Sep 2025 06:51:36 +0200
Date: Mon, 8 Sep 2025 06:51:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gfuchedgi@gmail.com, Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
Message-ID: <aL5g2JtIpupAeoDz@pengutronix.de>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sun, Sep 07, 2025 at 09:06:25AM -0700, Guenter Roeck wrote:
> +Cc: pse-pd maintainers and netdev mailing list
> 
> On 9/4/25 10:33, Gregory Fuchedgi via B4 Relay wrote:
> > This patch series introduces per-port device tree configuration with poe
> > class restrictions. Also adds optional reset/shutdown gpios.
> > 
> > Tested with hw poe tester:
> >   - Auto mode tested with no per-port DT settings as well as explicit port
> >     DT ti,class=4. Tested that no IRQ is required in this case.
> >   - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ required.
> >   - Tested current cut-offs in Semi-Auto mode.
> >   - On/off by default setting tested for both Auto and Semi-Auto modes.
> >   - Tested fully disabling the ports in DT.
> >   - Tested with both reset and ti,ports-shutdown gpios defined, as well as
> >     with reset only, as well as with neither reset nor shutdown.
> > 
> > Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> 
> This entire series makes me more and more unhappy. It is not the responsibility
> of the hardware monitoring subsystem to control power. The hardware monitoring
> subsystem is for monitoring, not for control.
> 
> Please consider adding a driver for this chip to the pse-pd subsystem
> (drivers/net/pse-pd). As it turns out, that subsystem already supports
> tps23881. This is a similar chip which even has a similar register set.
> 
> This driver could then be modified to be an auxiliary driver of that driver.
> Alternatively, we could drop this driver entirely since the pse-pd subsystem
> registers the chips it supports as regulator which has its own means to handle
> telemetry.
> 
> Thanks,
> Guenter

Yes, Guenter is right. This driver belongs to the pse-pd framework.

Best Regards,
Oleksik
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

