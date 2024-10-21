Return-Path: <netdev+bounces-137533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227A9A6D86
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D190E1F21BE1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6A537F8;
	Mon, 21 Oct 2024 15:02:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635F46447
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522978; cv=none; b=b+2Ka2dxfOuwdJDmmvis7qZpu2onp8qgUVuajj96vbgrHfQ09VtN7kZuFa7cWpCfnvoz+NdTNnbyutK1JSyzLJgm83wzIstUMt/8pKzfCVGHEB0iRJxk4XY0MT7ogbePmeSiFBYfwyaojcCOwI/xMkz0WSwIYBkEoJp0mb7JirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522978; c=relaxed/simple;
	bh=4QR0dzeIZVGa4RUzjY0+2JEeA1HBDNYiBXB6f3WnsEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIfIpwUj8RHvzYwRWW6v+jWeU6R74XbwcLc7tXGcnIFKcTu2tfjHDh2stZvBqx8jY1H/XKELNETUax31XijBiaqoX95JwTV5ROdUOezruozFhiT6XHvs5yjVA1htMlrHnmo+JATi7NCPPjqMqO+aT3Gvsjte4qa9eit6VsHqI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t2tvO-0007bh-B3; Mon, 21 Oct 2024 17:02:26 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t2tvM-000iMa-1g;
	Mon, 21 Oct 2024 17:02:24 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t2tvM-000J6d-1K;
	Mon, 21 Oct 2024 17:02:24 +0200
Message-ID: <f85a263ed5290fc999d04521f4e70f4c698d9bd3.camel@pengutronix.de>
Subject: Re: [PATCH v10 0/6] Add support for the LAN966x PCI device using a
 DT overlay
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Simon
 Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>,  Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew
 Lunn <andrew@lunn.ch>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Mon, 21 Oct 2024 17:02:24 +0200
In-Reply-To: <20241021164135.494c8ff6@bootlin.com>
References: <20241014124636.24221-1-herve.codina@bootlin.com>
	 <20241021164135.494c8ff6@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Herv=C3=A9,

On Mo, 2024-10-21 at 16:41 +0200, Herve Codina wrote:
> Hi Greg, Philip, Maintainers,
>=20
> On Mon, 14 Oct 2024 14:46:29 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
>=20
> > Hi,
> >=20
> > This series adds support for the LAN966x chip when used as a PCI
> > device.
> >=20
> ...
>=20
> All patches have received an 'Acked-by' and I didn't receive any
> feedback on this v10.
>
> Is there anything that blocks the whole series merge?
>=20
> Let me know if I need to do something else to have the series applied.

Not that I am aware of. If there are no objections, I'll interpret the
Acked-bys on patch 1 as permission to merge the whole series into
reset/next.

regards
Philipp

