Return-Path: <netdev+bounces-107596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637BE91BA4F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03138B23ABA
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998314C584;
	Fri, 28 Jun 2024 08:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79241768E1
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564338; cv=none; b=YdJjhzqn5sJeTu+IMEm6awvPQ4/3hXmYcLjY5LhAWcl8K1ZrZ+psH8w+OoyCTKboAV8LzXRpuqEXgq1ZT5vd0dpuL2a+aJ7nT97ID5w7csju1w4doEEKqc2CQ/7ComLAQ5lerDhGgJDJdHI4ClYSZ6nt96tvFdw9usVKaIZBK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564338; c=relaxed/simple;
	bh=HUK9t6IwbqH4zhux55AQIqg47Wp5pY7xxlu8OvECrRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gk0mpg2vUm8gUfmVu2TyebmVrD3Y6IxsnR+s3NHD5aluTuSlywh6Q4gSQDRgXeaIYTznKtbHDrZcQOB0nsa1T4ppgW7pIpyxeveJsKn1fLtRgkEIS6ZYyglfrx/xsyQQ5xOcsiyll1FQnTP8UkVW447NCcZg9E2NecJyfitXLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sN7ES-0000YT-VT; Fri, 28 Jun 2024 10:45:25 +0200
Message-ID: <d9bdcc0cd504df1ddc19012f9d23a90d0a76b294.camel@pengutronix.de>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: lan937x: disable
 VPHY output
From: Lucas Stach <l.stach@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>, Oleksij Rempel
	 <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, kernel@pengutronix.de, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 UNGLinuxDriver@microchip.com
Date: Fri, 28 Jun 2024 10:45:24 +0200
In-Reply-To: <20240627223818.655p2c34dp6ynxnq@skbuf>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
	 <20240627123911.227480-4-o.rempel@pengutronix.de>
	 <20240627223818.655p2c34dp6ynxnq@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Am Freitag, dem 28.06.2024 um 01:38 +0300 schrieb Vladimir Oltean:
> On Thu, Jun 27, 2024 at 02:39:11PM +0200, Oleksij Rempel wrote:
> > The VPHY is a compatibility functionality to be able to attach network
> > drivers without fixed-link support to the switch, which generally
> > should not be needed with linux network drivers.
>=20
> Sorry, I don't have much to base my judgement upon. I did search for the
> "VPHY" string and found it to be accessed in the dev_ops->r_phy() and
> dev_ops->w_phy() implementations, suggesting that it is more than just
> that? These methods are used for accessing the registers of the embedded
> PHYs for user ports. I don't see what is the connection with RGMII on
> the CPU port.

There is a bit of a mixup with the names here. The VPHY (as in virtual
PHY) is a emulated PHY register space accessible via MDIO to allow
operating systems that don't support the concept of direct MAC to MAC
connections to work with the switch. However, it is buggy and the
emulated auto-negotiation does the wrong thing for RGMII interfaces. As
this part isn't needed for Linux we disable it with this patch, or to
be precise the VPHY itself isn't disabled, but rather the result of the
VPHY state machine isn't allowed to override explicit link
configurations in other registers anymore.

The VPHY used by the driver to access the registers of real PHYs is
described in the datasheet like this:

"Direct access to the PHY registers via SPI requires a reduced SPI_CLK
frequency. This is due to the latency incurred from clock crossings
from the internal bus and into the PHY. To avoid a degradation of
SPI_CLK, an indirect mechanism has been added to the VPHY for accessing
the PHY registers via Indirect Address Register, Indirect Data
Register, and Indirect Control Register."

This mechanism is located in the VPHY register range, but otherwise has
nothing to do with the VPHY state machine and is also not affected by
this patch.

Regards,
Lucas

