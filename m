Return-Path: <netdev+bounces-123151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7A963D96
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ED01F255A0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FF18786F;
	Thu, 29 Aug 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o7DR20Hj"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297714F130;
	Thu, 29 Aug 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917759; cv=none; b=rveIW5ONHVajWoiJnK3HY3XK7hccAX7bM72iDVZ1/AdOKZBHamWgVrvM1kjPMjBdbLE/4Me7A1PjSCreFKOxR8OYMrhRugnp7A5JTZblE2fayilFabDr2dYRIZp9ARCX/pGrGxCkKHu2iVp7KvxQAVfBLnqjEtV1GuJybchWOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917759; c=relaxed/simple;
	bh=e0yIcq32he+tbOuBFyLsPOBT2gF950RoRJa9IdctazQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jId5qVK4iFr0sB5aFXtV+gf9GXEeSAtWM6BqCijLTFkuDODYmgIZe6gt8MRtLXUZh4iW5v5DMKhF9w1xHNXp2iVxD7Qy5AgTMP2gp/vdI1+ziWLTklPU9qJDbmL9KUWD2gsEcAtTGebxCtdhsdCkiQ35002J6DDlXoTsg2ZYN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o7DR20Hj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93B811BF209;
	Thu, 29 Aug 2024 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724917754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/B+6n0mZlxv3Hh4twZ/ws0hIIISEcKuIO8fCbE38Uy8=;
	b=o7DR20HjmeFFG3XiV7cwZs3xvgw2qOw3zz9MwCOCwUik9R07tlfI+hTdjbeKXQOcSb0bXH
	2JcpiRDsoWV/746hgB3fB5ih90PwaqdwNNDn4ZElr8u8lpIyncwwUdllnRXkcyZCRaNH4g
	c+FDmwIoqAMlqsf3E/Yvq8nEk6h3UbbmUeaWSUcgda8WQonJ8MbapGfc3Nhlzuq+ASeln1
	QYxgN82a/+mksI2yLHBdLaWwYy9iqqWRKWrcKsXgSSp8M5NXTasFspr8vU4UkQA1lR7bDS
	HI0H06p3stcQKQZqoAOgTkpGQGdsbenens5qVKIMmiUjOuDbb7xz2f2vRvU/qg==
Date: Thu, 29 Aug 2024 09:49:10 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <linux@armlinux.org.uk>, <kuba@kernel.org>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
 <rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V4 4/5] net: lan743x: Migrate phylib to phylink
Message-ID: <20240829094910.28ccd6ca@device-28.home>
In-Reply-To: <20240829055132.79638-5-Raju.Lakkaraju@microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
	<20240829055132.79638-5-Raju.Lakkaraju@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Raju,

On Thu, 29 Aug 2024 11:21:31 +0530
Raju Lakkaraju <Raju.Lakkaraju@microchip.com> wrote:

> Migrate phy support from phylib to phylink.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

[...]

> +static void lan743x_phylink_disconnect(struct lan743x_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	struct phy_device *phydev = netdev->phydev;
> +
> +	phylink_stop(adapter->phylink);
> +	phylink_disconnect_phy(adapter->phylink);
> +
> +	if (phydev)
> +		if (phy_is_pseudo_fixed_link(phydev))
> +			fixed_phy_unregister(phydev);

You shouldn't manually deal with the fixed_phy when using phylink, it
handles fixed links already for you, without a PHY.

Thanks,

Maxime

