Return-Path: <netdev+bounces-229891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2548BE1D9D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915E44E2637
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033F2343B6;
	Thu, 16 Oct 2025 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wx1st7lI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A621A23B9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598247; cv=none; b=Wah1ZUYFDr5OEewEBzNJeEv7iKlaefCUxClBmcEmK50nKIbZyDSXv1f/GsgXvTWQi3sROZlmPn6HjF9FGvG6shYO8I3JIfPUTZbZ86kWINbrj9q2CEZETF4KiGcJqPlZUukAbspLVctiMvzh7jLNYdTrRjOMBirIOWymn1xxb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598247; c=relaxed/simple;
	bh=NRE7369t5hK6A0k7cDYAQJzZqc9T9pU2mwP7YkYi2G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWGSmNpUrf0lnc11gaX4CGnIX0Dk5LHdKGxXjB1OAelS8trAVyWh60zTumi2ZdGMojLSXHXsqRHAz83bn21NTryRAFzy0l2ONRwBiOXX4NEmITzrrmt93PimCX8awL9ltZB90G3B3FY0PFpT9xRwXEG8+7I9VTsZQroLJAzMGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wx1st7lI; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1FCEEC03B71;
	Thu, 16 Oct 2025 07:03:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C1636062C;
	Thu, 16 Oct 2025 07:04:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C887D102F229A;
	Thu, 16 Oct 2025 09:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760598241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EgwW0ArP1Xeb+OuDBxc0n1MTgi0tuz5Lo5UBvgrMi2Y=;
	b=Wx1st7lIJl/IIfm3alE87+k9DoScC+ITTNsxAUKKuQEgaGTYImMhig9VUTBDPghOMKpvYe
	r14AH2/hwAYAfIgT6y7u39Tnb2KBoCiRcVeoJz2o8eodfpoaFh+z0OstVwi9/2u9I0hY8j
	YBHsgvoZSFWSm8tFkwhM0vSTeD5PV/wbJDAxm6ocwFxtaindVc/+uAhoWgPERk2GtQB6SZ
	a46/SApA0VKOKY5zzA+a3Gnn/dYeYnbqzLm+55v1jX44GjCSy+oKD9E2IBx6PcMLPcFFqX
	9MGSXk6vmZpLpng9AmEtzsaqShRsJmQnEuS2DycgI9moygjf6RCYVHlCjo/xjQ==
Message-ID: <d47e6753-ed00-4380-b11a-75088e885a48@bootlin.com>
Date: Thu, 16 Oct 2025 09:03:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: stmmac: dwc-qos-eth: move MDIO bus
 locking into stmmac_mdio
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945J-0000000AmeJ-1GOb@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v945J-0000000AmeJ-1GOb@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

> Rather than dwc-qos-eth manipulating the MDIO bus lock directly, add
> helpers to the stmmac MDIO layer and use them in dwc-qos-eth. This
> improves my commit 87f43e6f06a2 ("net: stmmac: dwc-qos: calibrate tegra
> with mdio bus idle").
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


