Return-Path: <netdev+bounces-145212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2669CDB34
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A9EB22382
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4E18CBEC;
	Fri, 15 Nov 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="APVQaXVj"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C36188CD8;
	Fri, 15 Nov 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661986; cv=none; b=e13/q+dbS2JqazEIBhghxj+ESdzOCpLJx3I8Jgv0CdHM9CR4DpWH7jVlo1oSywwzb+u9CiUgOahLOGRiYZIPbe0mSY+k62+vXYMI9xu+qwwLj+B1oTo3PVibeT1aIlNnY69gmSwBCFV/XbhI/cGE89bTRYzqsO1PyJXZUOAHOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661986; c=relaxed/simple;
	bh=QsI/3Ha5rhxQCj1sLq7ej0Wjb7E9/WTx/ofKg1hjq/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNFbQSI5nyEiE/F6ZFbJDTPOuVP4rK8r3+E/R41tBH0MxyJ564iVPUBLxFMqSjVJNLH9VlZbo9J0xjUcdRB0cz1ZqVwVfcJr3doIWshh9vf71la67h3pXI2C8/4o4U9/rpBk4jPWAxXdTeJm4DRKfOZoC51wlV+2up/ay2UMyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=APVQaXVj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBB591C000A;
	Fri, 15 Nov 2024 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731661981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tCKgsw5mO3MHwzTtn95V8anwpIV8qQqwPzP1acmtXQ=;
	b=APVQaXVjo/LSYd4+xRqmFl1A9WBWKDlAY1a9/agm4vbBS3KaoxD8ikVoIpRrwIwTmy80n7
	ThId5bX78yYvD9yD90A+O05zV77U96jV22rR+KShYZPADaddte5vpti6H5IYBvORI/8nCF
	Z8z37D0FGNraVvBCiThYmrk9T1Woyk99cKt7kbQicq+J2xjJguh93vt3BvZRdi9EfKOI+O
	2WqO7clzSL+zUnAtzS9S+AVjDXPDIeChP29wy3pZCesTXL0oxssPvpXizjVzI8EzhK2kg1
	KFFuXx8fwk8Kmw4MRzM8Gkkh2W/9/T4uY3GyGHpt5RjC/etOSdtS6Zlz44+EGg==
Date: Fri, 15 Nov 2024 10:12:56 +0100
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
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20241115101256.34300900@kmaincent-XPS-13-7390>
In-Reply-To: <20241114173906.71e9e6fb@kernel.org>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
	<20241111150609.2b0425f6@kernel.org>
	<20241112111232.1637f814@kmaincent-XPS-13-7390>
	<20241112182226.2a6c8bab@kernel.org>
	<20241113113808.4f8c5a0b@kmaincent-XPS-13-7390>
	<20241113163925.7b3bd3d9@kernel.org>
	<20241114114610.1eb4a5da@kmaincent-XPS-13-7390>
	<20241114173906.71e9e6fb@kernel.org>
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

On Thu, 14 Nov 2024 17:39:06 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 14 Nov 2024 11:46:10 +0100 Kory Maincent wrote:
>  [...] =20
> > >=20
> > > In net_device? Yes, I think so.   =20
> > =20
> > Also as the "user" is not described in the ptp_clock structure the only=
 way
> > to find it is to roll through all the PTP of the concerned net device
> > topology. This find ptp loop will not be in the hotpath but only when
> > getting the tsinfo of a PHC or changing the current PHC. Is it ok for y=
ou? =20
>=20
> I think so :) We need to be able to figure out if it's the MAC PHC
> quickly, because MAC timestamping can be high rate. But IIUC PHY
> timestamping will usually involve async work and slow buses, so
> walking all PHYs of a netdev should be fine. Especially that 99%
> of the time there will only be one. Hope I understood the question..

Yes, thanks for the confirmation.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

