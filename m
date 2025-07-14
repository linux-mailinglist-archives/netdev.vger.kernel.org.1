Return-Path: <netdev+bounces-206683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2FB040E2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6217716504A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6A253B56;
	Mon, 14 Jul 2025 14:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD325332E;
	Mon, 14 Jul 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501757; cv=none; b=PHlcKwHPNnXtsGeL7pLUcUQBCKzbzySTThMgIM9zKtpXopJ2MzDXs/yzk1S24b91A2JuM1T4/S8n0HespBVjmZnzVnRqiiV0pmjdxi4s548wI0wJXQk5ANhwbAMMREgGwa7LRUI0wS0p+sOFEGWCtHW12+LqAtaOxZZkEJdAmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501757; c=relaxed/simple;
	bh=DfZSxMlKQHM8fVTPHG4G5K6/3qK7daDUPfpkAU+xVcM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=RvwgdnjHt5E1WA44mSb/iCpSlxi/xiWn0NcFttTGNz1+P8FNTafaqpInxRInaDS8Ay907MIfjU4qBbT86ePhE9NT3g7Oe/GWUi8XBF0D6jd3nfmMOKgqQiXKVU0e+PUfkYs4Ce0w22hpuJXulAIuV6rzthzl4e7LRa/cKS4QlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (ip-109-42-113-167.web.vodafone.de [109.42.113.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 1D7C22F7;
	Mon, 14 Jul 2025 16:02:24 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 16:02:23 +0200
Message-Id: <DBBU0QGILT7C.33TZQUPDJU81O@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay
Cc: "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Andy Whitcroft" <apw@canonical.com>, "Dwaipayan Ray"
 <dwaipayanray1@gmail.com>, "Lukas Bulwahn" <lukas.bulwahn@gmail.com>, "Joe
 Perches" <joe@perches.com>, "Jonathan Corbet" <corbet@lwn.net>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, "Roger Quadros" <rogerq@kernel.org>, "Tero
 Kristo" <kristo@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux@ew.tq-group.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.16.0
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com> <DBBOW776RS0Z.1UZDHR9MGX26P@kernel.org> <fa3688c0-3b01-49fb-9c16-eeea66748876@lunn.ch>
In-Reply-To: <fa3688c0-3b01-49fb-9c16-eeea66748876@lunn.ch>

Hi,

On Mon Jul 14, 2025 at 3:09 PM CEST, Andrew Lunn wrote:
> On Mon, Jul 14, 2025 at 12:01:22PM +0200, Michael Walle wrote:
> > On Tue Jun 24, 2025 at 12:53 PM CEST, Matthias Schiffer wrote:
> > > All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> > > mode must be fixed up to account for this.
> > >
> > > Modes that claim to a delay on the PCB can't actually work. Warn peop=
le
> > > to update their Device Trees if one of the unsupported modes is speci=
fied.
> > >
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >=20
> > For whatever reason, this patch is breaking network on our board
> > (just transmission). We have rgmii-id in our devicetree which is now
> > modified to be just rgmii-rxid. The board has a TI AM67A (J722S) with a
> > Broadcom BCM54210E PHY. I'm not sure, if AM67A MAC doesn't add any
> > delay or if it's too small. I'll need to ask around if there are any
> > measurements but my colleague doing the measurements is on holiday
> > at the moment.
>
> I agree, we need to see if this is a AM65 vs AM67 issue. rgmii-id
> would be correct if the MAC is not adding delays.
>
> Do you have access to the datasheets for both? Can you do a side by
> side comparison for the section which describes the fixed TX delay?

The datasheets and TRMs of the SoC are public of the SoC. According
to the AM67A TRM the delay should be 1.2ns if I'm reading it
correctly. The BCM PHY requires a setup time of -0.9ns (min). So, is
should work (?), but it doesn't. I'm also not aware of any routing
skew between the signals. But as I said, I'll have to check with my
colleague next week.

-michael

