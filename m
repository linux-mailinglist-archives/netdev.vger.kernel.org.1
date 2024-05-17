Return-Path: <netdev+bounces-96988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C68C8918
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638C11C2198B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DBC69D3C;
	Fri, 17 May 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rfv23b5/"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB56A325;
	Fri, 17 May 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958843; cv=none; b=rndg24dPB31N4lAHtKA56uRrw4tiLPNvkVCD/h83ZQ3Q/Bvo2tUtiK7jCjy4MF44jsunfOJ4Maa87l+MiY3eHwcIXR7vTLKnqgkBmBth1K399iKXWLLybtsy6XCyelU+8b9+RirUPmBrvwTn2qKFmkLf9OrM5rqhT15lBupaRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958843; c=relaxed/simple;
	bh=b8BwasW2wpCf4km+OXto+ewclPGsdKNXI2hXEUZMm0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2h7EiSS6t+ASdLbWt7WhecClg/Uok9Ct6JxISKNhXHkzx52RiKsIy2MwSvYXSuLuDJgsTGTS9FB1sJJWDwx275Pj6Ix4NiaIYsTI28OVYK2+y4gtD/m/qOR4wJs++eOzaSblp+WxQtI8FhpFxPjSztOldY0H06OSf3Qpf6BJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rfv23b5/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38FFB60002;
	Fri, 17 May 2024 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715958839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8BwasW2wpCf4km+OXto+ewclPGsdKNXI2hXEUZMm0A=;
	b=Rfv23b5/HdsOhMcx0s8aGcPQZPDazt8vsyoqc1HVwsEWkgD7QsHCkXUp/hsJolTx32HXDr
	NSebq+qYhnpRRCOySs6eOlQkM+CrAw2moMP3BBXw/KbQQFRH/PcBvGwNpllONCMXTyPv43
	/ikugNzujeqdwwfml8K9UIbYhbRw3ebrLd5mhL+LkqSfVUtqxvZ/vdQwfD31cBp/vAxMPd
	zwd0/2KeqkLvbWWAFIefkrzez32LFsWwNpUABYm3Y92ORlo0lBlS/qYs4uCrjUeAo+J3RE
	EZENFmsFgrxTmWszoMVPooFz21zlPxz3hXSolzwl04lEuaVY/gMeHu1OyhxmiQ==
Date: Fri, 17 May 2024 17:13:55 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Alexandra Winter
 <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v12 00/13] net: Make timestamping selectable
Message-ID: <20240517171355.0a46ad53@kmaincent-XPS-13-7390>
In-Reply-To: <20240501190925.34c76ada@kernel.org>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
	<20240501190925.34c76ada@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 1 May 2024 19:09:25 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 30 Apr 2024 17:49:43 +0200 Kory Maincent wrote:
> > Up until now, there was no way to let the user select the hardware
> > PTP provider at which time stamping occurs. The stack assumed that PHY =
time
> > stamping is always preferred, but some MAC/PHY combinations were buggy.
> >=20
> > This series updates the default MAC/PHY default timestamping and aims to
> > allow the user to select the desired hwtstamp provider administratively=
. =20
>=20
> Looks like there's a linking problem starting with patch 9. On a quick
> look the functions from a module are now called by build-in code.

Indeed I have issues in the patch series when building PTP core as module.
Will fix it. Thanks.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

