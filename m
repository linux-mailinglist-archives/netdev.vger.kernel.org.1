Return-Path: <netdev+bounces-100518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43A8FAFF6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486A71F23123
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAB1448C9;
	Tue,  4 Jun 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oSmGiUO3"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807F38B;
	Tue,  4 Jun 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497549; cv=none; b=ijLf8/u8Gjy6dthZbIJsHBKRttYl8+UrbRZtYzT7M9675btpVDYRTNPuQBK55MgMNmkWGPbCzdRWCduA6ZhPjamY3E39SVaP6f4/cI2BtdeRMLagc37fO/IJ7VmjJoisQ4mYTKw0BJpjssf7gGQ5OU3GU1AEmikhCpxCYAO44Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497549; c=relaxed/simple;
	bh=bL3qxldcAX8+IkHQP2f9EmkyBJIVsOIIqdAw9DSsXA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgpYSF8/YgBf1YhfLPnSN6rJPiWlrG3Xx1zMkIy0QzIseGEyiiRfnvbhkt70o5pOx7FclQskaW8HYveegZtGFCMaema6uC3preD7+5hnuwPW/znYbI48O+gYgHu4ICLMioQ4ONnmXPX3v6wP7drpfRNG19Nty/FoI3HIO75cKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oSmGiUO3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E50001BF20E;
	Tue,  4 Jun 2024 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bL3qxldcAX8+IkHQP2f9EmkyBJIVsOIIqdAw9DSsXA0=;
	b=oSmGiUO3/xVMBccibnbiS2E5jpMtnRTV4iZxoMRTUZSwxdA/QZBuNYjUEDxc6kYPrpoLx4
	hZCpdob1UDptoziJCTgvZjw6wfARrxbFEQZ0iR+lJgA58XG5pVi2twM8PQrKKVP8tXlYUJ
	uzDrLeWjdBVuAAJ2NA7gwDzA8OTNxy8OpZEIKkiDVTZs9A6kTFawofjjZLiXoG5n9Yk2wG
	3uetPeuZ5qLF6YUiFS+151X/6eV16wGbQzjw4e54F8TKygBhLg9JYsNx7R6i0ec2+bzZsn
	e5t9ole8oX6CmVD2WrFAvXGVbDSHGE9GEPg89fIuDlDcsywdl9jZEPDp7ku6HA==
Date: Tue, 4 Jun 2024 12:38:59 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Alexandra Winter
 <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v14 00/14] net: Make timestamping selectable
Message-ID: <20240604123859.6fb08d2e@kmaincent-XPS-13-7390>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-bfb4632429db@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-bfb4632429db@bootlin.com>
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

On Tue, 04 Jun 2024 12:36:00 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Up until now, there was no way to let the user select the hardware
> PTP provider at which time stamping occurs. The stack assumed that PHY ti=
me
> stamping is always preferred, but some MAC/PHY combinations were buggy.
>=20
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired hwtstamp provider administratively.

I got an issue with my connection. I will resent it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

