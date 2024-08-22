Return-Path: <netdev+bounces-121099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0895BAF3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFBE1C2341A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13D1CCB58;
	Thu, 22 Aug 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ok2rBrKj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAB1CCB5E;
	Thu, 22 Aug 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341774; cv=none; b=GVCamRsjquG6OnQRuBDjo6PqG6INBcGpfBom+wfzsYTvlDC6EkZ6wXOsj1QyuOH7zNFEMNrEv3q+y+WyPttlFovHyRzZklAmA9IxC4iDh2sv4I4xSgzPqdmwj7oPhZa8/sNwrWI2OIeZ+8QMXaSAfxilQ5eClvJ86W+gxz+cZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341774; c=relaxed/simple;
	bh=XJsBXiTafS3oLLeKqpRuQE1ZszRn8hHrPyv8ICmmUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbleEiYPY6w0EnfiWOf/cswv+HWdNPqxzKDTlIObFWjhwPGpofn+vROtK7j1IV/7tqDLzP4cu4lrfGjndZO/bJOD//VYCUsBRX56M6IQmwzRbp+TKlXuZlTQnK6RVP6yDeEhNf022FoiE3RukjnItKtkPdU7pyygnTlCmniPw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ok2rBrKj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pHlkyzIWh4hwezalW5SguitFaW5UqUJzRSKfUy7wdko=; b=Ok2rBrKjVNH/cWCK6uRBE5EnkD
	rH1NcI0D83t8YTcY+7S8+cO+Ge02bsdJczmXE4dR4PsgBAHZ7AymGctQnKCByGfqMimZeKpXICJUL
	1R0/k27lpWl7WBoSb+JvovOFGaQtAhYNfuxkzDqdb3JwE9TSfkRLhY2r58Cx269dzz4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shA3u-005RZa-FD; Thu, 22 Aug 2024 17:49:22 +0200
Date: Thu, 22 Aug 2024 17:49:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] phy: Add defines for standardized PHY
 generic counters
Message-ID: <5e21ea4b-aae1-40aa-9865-7e48b1971a13@lunn.ch>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822115939.1387015-3-o.rempel@pengutronix.de>

On Thu, Aug 22, 2024 at 01:59:38PM +0200, Oleksij Rempel wrote:
> Introduce a set of defines for generic PHY-specific counters.
> These defines provide standardized names for commonly
> tracked statistics across different PHY drivers, ensuring consistency in
> how these metrics are reported:
> 
> - `PHY_TX_PKT_COUNT`: Transmit packet count.
> - `PHY_RX_PKT_COUNT`: Receive packet count.
> - `PHY_TX_ERR_COUNT`: Transmit error count.
> - `PHY_RX_ERR_COUNT`: Receive error count.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

