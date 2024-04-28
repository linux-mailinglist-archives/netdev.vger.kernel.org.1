Return-Path: <netdev+bounces-92002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C68B4C1D
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A2C281A63
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6916E61D;
	Sun, 28 Apr 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GOg3ME0z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09A1C32;
	Sun, 28 Apr 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714313941; cv=none; b=dpizvktWWvwvoOMxVHxiCZ8lfO1ZJ1X4CoRbcNqiJRIy8qC9A1LR8zOByhsFEIoXQb46yREhHeij7W6xNmaG0rGZ7fif9V6HjMjC5h4wlhZxEqStksOfFi0pXGbbjvpwsaPYZhWEpW8P6W7fm6ffXSDSrWWf6Sfjv4m7zlMIo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714313941; c=relaxed/simple;
	bh=JbWX6i63EYM5psOXDzYgilWhkDBrAtxvEknNfrhURvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jReCmNBn2Ge0dw2Dfq8bx2CEKpChOMvfYx8cv4oNQtGAcwbyUc3aihsD1+Pvlxmck8c9R5Y51XBTUGoUNZCTrOcZV0zrtwXL6dDrqOzJT1sbYo43Lf0UgCFgTdfX0EjTdNv/v9x5PoUVvd68yQhxxJwlRi64ykrvrONxrgymcag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GOg3ME0z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j6mO3t3hnXaOiB5ZOyq1t92l086TzpvYq+MdS6plQWk=; b=GOg3ME0zdqZ2wRfYjLhv72GDsS
	QX6SQfH3KClLIVVi9Hzd8OZdGlRsAg+zPs7VzTZB46j9ii3g0TZU3PTtIEkdSupe7QBNOTre7J66T
	EmNrxiOxOvMxlMuR87WP1xfEgb2+N5op8rmRmUIsyomN95x+YHyAjONt2+PzryHBqGv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s15MV-00EBuz-MR; Sun, 28 Apr 2024 16:18:39 +0200
Date: Sun, 28 Apr 2024 16:18:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <23f8b4a1-97fd-4d24-9486-3319d432d6e2@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
 <e89272b1-7780-4a91-888d-27ae7242f881@lunn.ch>
 <Zi1o0SilOZ5gWMlT@builder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi1o0SilOZ5gWMlT@builder>

> but just compatible = "lan8650" does not work.

The device tree binding says that is valid, so this needs fixing.

Maybe copy max1111.c in hwmon:

static const struct spi_device_id max1111_ids[] = {
        { "max1110", max1110 },
        { "max1111", max1111 },
        { "max1112", max1112 },
        { "max1113", max1113 },
        { },
};
MODULE_DEVICE_TABLE(spi, max1111_ids);

static struct spi_driver max1111_driver = {
        .driver         = {
                .name   = "max1111",
        },
        .id_table       = max1111_ids,
        .probe          = max1111_probe,
        .remove         = max1111_remove,
};

Interestingly, there is no compatible table. So the device tree
binding probably should change, not require two compatibles for
lan8651.

	Andrew

