Return-Path: <netdev+bounces-103145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9656F906812
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534ED1F2165E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F613DDB5;
	Thu, 13 Jun 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OWpnC1CY"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71E3209;
	Thu, 13 Jun 2024 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269359; cv=none; b=ekJwa/QhfRvWqYx3O3mNlbq1Jnpu2W9q3AWrFwUKPTY3k074+F4Q90yUMUa9vlk1X/54TCWN+uhhSI0QCMO52ZRQ0p4c01OFRC9bQy9H95pjEEzXwVPCrth2UYA0XLhBweMaslfqYBlyZCNtUKUQVgkGOb7wPpS8/SghO1WCdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269359; c=relaxed/simple;
	bh=Pa8A117Grgh/veTNDXGqRrOb9XjpDr6HTfDCG0a28fc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OSO9llpAl+mbLQPL1E0Xn/otyTtM2EW4SaWmnsfZ7PZEo5FHSJj6D9dBkQzEYEMXnShdNUH5ij4huj0gRC7ZdqGZxSkdo3CxmXzvlIvcZ2sZit9ljF5TFProonVgGn3qpW04ZoTXUZ5bdMeWCaEDApaqbMm445ksaX7XHeym5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OWpnC1CY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718269309; x=1718874109; i=markus.elfring@web.de;
	bh=uJtL6qWDjplr/HYyz2rXRqMFn2028PH8YTE8yZ9+H+4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OWpnC1CY2ZUGW042DocoXibTmjsH4inarEWrx+5OlaNNGE6g05jqKUCrgXBsjlox
	 BLholm9v49aTu5Mdqc2bZnF0IvyO5oi82QrgDu2G1wUFGsHkqwCmvvz4VobcCp6Fr
	 x21u/SYjzOPnLZKBMDvgd/FxvVwOxY7lW+3K9+o7Zl9vblguQkgHJpx8YtPlB/quG
	 hkqSzfXtzxmAorm5eo/TLh+cLYeaSao6LQwmcOQ2obD16+IBl0MqLpYxrs1bVXzs9
	 b02+Xf0QCT74KNH0U5pV9Z58g989FOyZDfVUl+vzxxcyPFuH44NilrkN+5QudVQ4z
	 g/983Kz2VN26PWiDtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgub-1sXqJG3DRf-011M7l; Thu, 13
 Jun 2024 11:01:49 +0200
Message-ID: <bb0e9957-816e-4e36-b85c-6c5501e76a8a@web.de>
Date: Thu, 13 Jun 2024 11:01:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Justin Lai <justinlai0215@realtek.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Hariprasad Kelam <hkelam@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
 Larry Chiu <larry.chiu@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240607084321.7254-2-justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v20 01/13] rtase: Add pci table supported in this
 module
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240607084321.7254-2-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sweNL4w+HQnpZkpNAQYgqqTaOmGffVhbXOId8m2THQdgCz2PSub
 +vg4W6D4Hl+jedg36m5ngQjkzDm9kfm1cf6x3c4EfpyzVf3GKB3RNjt3e2QJOMMrgYqnpYE
 J613eV5lEVzdpwgOagHeWeD9p1BEkr2agDEW4g2t4KttkWRxbl9AmGm77q2eCymFDTnNDL7
 vh8yD+Oy3fl+yQQGl6oPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M4s3FoRaGaU=;JmwsZkCNwoB8ywQRkDaspQw/4V9
 Vc4m1GsRiEu3I6hLNeNVbTbTqzr9zZU263/oFIRJViVmzbOZHbiWTn9TuNcDVwDHiNa/9IZB9
 FgUvy8iqhjengsAhUOc4v5E/ZGnhn1bUdUgKZWVfhuEdvGpYD6pBs0vcTC+F1thOUq9GEt6i2
 LCRe3e4YPWeveynrkoBF/pkCAmLCAfEDFoXoV5GUUTe+OjKUEtFrxYrEdSNo5sAYNPHdyULwc
 OhptEaMbvHJUBcbuSgqjmXXYd3ND5CfWuilsxhlyMqpUqGEi8FgSlmkN7LC5pwNpPRZhh+cfR
 +kGKHTdgOOaoiSyyowjc1fthvSLvKJIp5UBhCJRRJVLeRq5YfGB0oEMX2c3bbFds7ljvlJLvI
 d5477V6QSUcv7Rj8QipBSAzem5SXaK+H35XS7WvUj5vb/ssj/UVEy4nBvrlA1/njOs8DtY6Iz
 DkcvNv7mG1wDjmJSY6f78PcrZjgmHBVa4CPOefyIBXPWOxecUydN4MhvReEnGFvZVhaV5RRa/
 Qol+oYfYpxAQC6JO/qqY+ZGdzjyOeVhpCy/6KQtHVnGoM9S7BqyoVXrl0pl1ti+glC06GKems
 IT254qrtt/3NDapeGlFYHOIPH1LgOb4LvEYkMg2j771P+ArnQoUFVrKm3r0t33MSreNxi+dnV
 CkHGAFDnYXQPihM3UIG4DXhrdSlaXr4E2w3KOC1a+UUKK/u6vc4EUCJwTT1bA73uToHwS9/cP
 8hJacodTtMGVsTiREAqsjFiUYyOnfY7uiw1aOyWAQFapk98OBb3ZczNDmd3M83FMWauuneEH5
 GS4ienTPvNPuB7lbNqYCytJUmRnGLV5KSVGVr/KIQPwto=

> Add pci table supported in this module, and implement pci_driver functio=
n
> to initialize this driver, remove this driver, or shutdown this driver.

Can a summary phrase like =E2=80=9CAdd support for a PCI table=E2=80=9D be=
 a bit nicer?


=E2=80=A6
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -0,0 +1,640 @@
=E2=80=A6
> +static int rtase_init_one(struct pci_dev *pdev,
> +			  const struct pci_device_id *ent)
> +{
=E2=80=A6
> +	/* identify chip attached to board */
> +	if (!rtase_check_mac_version_valid(tp)) {
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "unknown chip version, contact rtase "
> +				     "maintainers (see MAINTAINERS file)\n");
> +	}
=E2=80=A6

* May curly brackets be omitted here?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv6.10-rc3#n197

* Would you like to keep the message (from such string literals) in a sing=
le line?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv6.10-rc3#n116


=E2=80=A6
> +	dev->features |=3D NETIF_F_IP_CSUM;
> +	dev->features |=3D NETIF_F_HIGHDMA;
=E2=80=A6
> +	dev->hw_features |=3D NETIF_F_RXALL;
> +	dev->hw_features |=3D NETIF_F_RXFCS;
=E2=80=A6

How do you think about to reduce such assignment statements
(if all desired software options would be passed at once)?

Regards,
Markus

