Return-Path: <netdev+bounces-191880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4EABD906
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EC8163B3A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2A22D4E7;
	Tue, 20 May 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uyyF6WXa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC01D435F;
	Tue, 20 May 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746645; cv=none; b=Bdl1eZnX5xS/ybFaj/MlsSYBtNBXFrKllGVFZe3ga99M50jTSBk6IOtI9OkHDYZGqfSKei7H1ry2Lg+jxtV4JM7jEu6K+WXdtIjo53hnc8RLukLFTWTPYdhJxjlkrCUI9I/kxpN3ykHeRw/ILrNUJ3t5Sl31d8DWPQXz4xDcx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746645; c=relaxed/simple;
	bh=xjcsDn8Pb0XQOzvhBZ6YontXS5HX+UgcU0pwJ+Ol8+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm/DE4ffGbwAb2rRvdUvakPKiGbdie8GgrFmBawg3ptLUoFLTvI/0yHN5OF1RcH7RYDtzLEjQTz16T5bTCR29/oAgbLLkiezcjUClDhWzDn8XvQuMVuQdEXYzxMZnzZZElGWHciW7zAqjpO6P94nMlMCV5olPLGJPk5h+iYtNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uyyF6WXa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7lnb2fa3B6bnU+waKuD8VYR7+DTkGppt/6P7VJxp6SY=; b=uyyF6WXaICTXt3hbiOkMjahne/
	NmJdwwH+J8CKt4Uj5zFcKkkUYbkhLaXONqoZkWi1EOFDwq46fTGSUla+ghkVsXy2QT+hZgAHo0AFB
	tuYtLdtYubpe5ffZfMJzM9JgvilB5+B21S5OtBK4x2yQFYULPkHcTTmSFPrcGdiWVYPg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHMjw-00D7mw-JM; Tue, 20 May 2025 15:10:40 +0200
Date: Tue, 20 May 2025 15:10:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: stefano.radaelli21@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH net-next v4] net: phy: add driver for MaxLinear MxL86110
 PHY
Message-ID: <c8a05994-367f-42a4-8464-c0a0ea3bc748@lunn.ch>
References: <20250520124521.440639-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520124521.440639-1-stefano.radaelli21@gmail.com>

On Tue, May 20, 2025 at 02:45:18PM +0200, stefano.radaelli21@gmail.com wrote:
> From: Stefano Radaelli <stefano.radaelli21@gmail.com>
> 
> Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-power,
> cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pair
> copper, compliant with IEEE 802.3.
> 
> The driver implements basic features such as:
> - Device initialization
> - RGMII interface timing configuration
> - Wake-on-LAN support
> - LED initialization and control via /sys/class/leds
> 
> This driver has been tested on multiple Variscite boards, including:
> - VAR-SOM-MX93 (i.MX93)
> - VAR-SOM-MX8M-PLUS (i.MX8MP)
> 
> Example boot log showing driver probe:
> [    7.692101] imx-dwmac 428a0000.ethernet eth0:
>         PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=POLL)
> 
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

