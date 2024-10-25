Return-Path: <netdev+bounces-139149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BBE9B0706
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2274B25482
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B215C14F;
	Fri, 25 Oct 2024 15:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA3155C8C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868498; cv=none; b=kMBUI/FW1WVHHyjMlabOhgGCAKbABzNimxnuaJ6epJ+ZemoCcalF1QZh/iV8KoMz4++QSJV3rK33yEatrSsA9T+hXC37ayIzDaYd8HLQzOWBRIhO1Vncc4mWdU2RUbxknK7uyFUxqjHlotEgW7rviSirCuN+MNJSbF0FqYN578M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868498; c=relaxed/simple;
	bh=MK8FmZ6v+rcXgKNtPVRZS0A6wZdsPejcW85w6PXCsUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOp2XU5gPpInImRyhLMof8Qfor0ZihbK5Pb0BG4xD0nkoTLDNeNXzcNcv9rFKona+bdZ0uGLeApc4e/wB8omk5ioagCWbbnMUj+NTgqY5aohlMQP8aDmYGKjsmOgSwYEQDuS8j4sIMQSaikg14884Ku/CW3HmmNmprhW+c5WSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t4LoS-00021o-0L; Fri, 25 Oct 2024 17:01:16 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4LoQ-000Nwq-3C;
	Fri, 25 Oct 2024 17:01:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4LoQ-00D1P8-2s;
	Fri, 25 Oct 2024 17:01:14 +0200
Date: Fri, 25 Oct 2024 17:01:14 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: ltc4296-1: add driver support
Message-ID: <Zxuyuj6sLMwRLTFn@pengutronix.de>
References: <20241025115624.21835-1-antoniu.miclaus@analog.com>
 <20241025115624.21835-3-antoniu.miclaus@analog.com>
 <6955c8b6-58df-4b1a-bdd6-759de3d3c46b@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6955c8b6-58df-4b1a-bdd6-759de3d3c46b@roeck-us.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Guenter,

On Fri, Oct 25, 2024 at 07:22:08AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On 10/25/24 04:56, Antoniu Miclaus wrote:
> > Add support for LTC4296-1 is an IEEE 802.3cg-compliant,
> > five port, single-pair power over Ethernet (SPoE), power
> > sourcing equipment (PSE) controller.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> 
> ...
> 
> > +	hwmon_dev = devm_hwmon_device_register_with_groups(&spi->dev,
> > +							   spi->modalias,
> > +							   st, ltc4296_1_groups);
> 
> New drivers must use the the with_info() hardware monitoring API.
> 
> The API use is inappropriate: _enable attributes are supposed to enable
> monitoring, not a power source. The hardware monitoring subsystem is
> responsible for hardware _monitoring_, not control. It can be tied to
> the regulator subsystem, but even that seems to be be inappropriate here.
> I think the driver should probably reside in drivers/net/pse-pd/.
> That doesn't mean it can not support hardware monitoring, but that
> isn't really the chip's primary functionality.
> 
> Yes, I see that we already have ti,tps23861 in the hardware monitoring
> subsystem, but that may be just as wrong.
> 
> I am copying the PSE subsystem maintainers and mailing list for advice.

Thank you! Yes, the PSE subsystem is the proper location for this chip.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

