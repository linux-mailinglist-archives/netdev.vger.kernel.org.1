Return-Path: <netdev+bounces-133603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B39966D4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B211F21344
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764A158DB1;
	Wed,  9 Oct 2024 10:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4618E74D
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468968; cv=none; b=RhCUt/Co320dlO0aRUm2QByUADs4U304usGL2z7UtxkP9r1wp+8ckvVXlEFdbTNJb01Tw4bhQlpRjCoTMeqr/s3wAKiuPMve1/QlZ11Ag8Xp7JDHhAlSC3ZlU3zcB2ivcpktgb/j6wlu4HDIgefOGcgWnNgC7F2uOdJs41OJXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468968; c=relaxed/simple;
	bh=0eimK0Ie+sE2DLqpiXqX1l42nk9HuNAsOPrgHj/pl5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gkx3QpPeh4GQwQ2jxOcsjgdccVOwVb09fRtjrP+cjXlTLpccz82dyokGjWXMefphpLQCLhE50XjLN15Tj/U6DSKBPSF+0rrzMEIVVm5vNOxFMjDXNdacCZPFJDe4cdutqrcf/QZWicPrcascorvJR8HyONccHnp3sy1DwwNDZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTjK-000804-O1; Wed, 09 Oct 2024 12:15:42 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTjK-000a0y-8g; Wed, 09 Oct 2024 12:15:42 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTjK-0006wK-0X;
	Wed, 09 Oct 2024 12:15:42 +0200
Message-ID: <1bd631cc78a40ad75866b834e43682e103c20f5e.camel@pengutronix.de>
Subject: Re: [PATCH v7 4/6] reset: mchp: sparx5: Add MCHP_LAN966X_PCI
 dependency
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
Date: Wed, 09 Oct 2024 12:15:42 +0200
In-Reply-To: <20241003081647.642468-5-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
	 <20241003081647.642468-5-herve.codina@bootlin.com>
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

On Do, 2024-10-03 at 10:16 +0200, Herve Codina wrote:
> The sparx5 reset controller depends on the SPARX5 architecture or the
> LAN966x SoC.
>=20
> This reset controller can be used by the LAN966x PCI device and so it
> needs to be available when the LAN966x PCI device is enabled.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

