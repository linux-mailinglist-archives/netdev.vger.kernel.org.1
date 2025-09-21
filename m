Return-Path: <netdev+bounces-225029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14BB8D751
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19B717B674
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE16191493;
	Sun, 21 Sep 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v94ZEOfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575F41A8F
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758442735; cv=none; b=UM1IIWTcEoBtitytmngUdYkwgjrHkdix9doBFiImjEMVkfYFUaQxaOpp+nSOOjYhkiUCzIQGQOpVAd3nQJQhCS9/IhTUhrHsIBYsMvU2kNkHzop/se+06Wt8Amh2O4np9AZqSX3Y2rAXbB64KeoJoWaJgRNv1hS9l1dpiGdkHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758442735; c=relaxed/simple;
	bh=vtY5e15LTNvGh/q95geOHZwGLMV0NFmIb74bfbGNUG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdlBLY9Qxft4LbAy4MC+pHOE+QsfX+uW3gaFVpgixQw06CjfsveZflWsx1EmHKaJA78QGaOgOFKdesaEMbPzTG+mlKgWEVXj9fvlULOVZyUvBoK8/0M5TmxWEJij03FaabL4TEoHnZXHcmDGwRJpcTpL8SCJixLr+boKyp038vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v94ZEOfv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9346A4E40D63;
	Sun, 21 Sep 2025 08:18:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5548260634;
	Sun, 21 Sep 2025 08:18:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99F40102F16BA;
	Sun, 21 Sep 2025 10:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758442723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5/G6O5FUTVtQEY7P6Smr7STvTHeR+ZZA8y7PHjfAhG8=;
	b=v94ZEOfv/eSm6hHf/TMgSl+AYC7WoPB5LLd5kvzmI9Aj4OZOINv/dQ7hpoWxWVaQ3KIZ6b
	oTPD0yjY7aPPUhQSMINSGSd2Ql2Lje4hveab90C1BKLk0p/AwsXDDrhH6BwoKX+4sdOVQT
	gtWT9DnJ+K3zfyZXWhTpbLeh3EiiWlSwDRG1EmOP/KJ/iDx5IA/xBRhKurYAJ/4e2X6rpR
	jghVGVJFjVWhpxg0JID8Slypkar/euj0DRbD8fr1e1gNNxe6bdxfAxR5vtuBZB6xVaZM+2
	gnSNgeRJ4v7kA5xzZJ9yXt3ELNcT7YwYfLbCVr/T2t62S2JjVnHEewNgCTZ+Yw==
Message-ID: <7267ac9c-bc6b-4f1d-a16b-e86f0566421d@bootlin.com>
Date: Sun, 21 Sep 2025 13:48:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] net: stmmac: socfpga: convert to use
 phy_interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
 <E1uytpV-00000006H2R-2nA6@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1uytpV-00000006H2R-2nA6@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 17/09/2025 20:42, Russell King (Oracle) wrote:
> dwmac-socfpga uses MII, RMII, GMII, RGMII, SGMII and 1000BASE-X
> interface modes, and supports the Lynx PCS. The Lynx PCS will only be
> used for SGMII and 1000BASE-X modes, with the MAC programmed to use
> GMII or MII mode to talk to the PCS. This suggests that the Synopsys
> optional dwmac PCS is not present.
> 
> None of the DTS files set "mac-mode", so mac_interface will be
> identical to phy_interface.
> 
> Convert dwmac-socfpga to use phy_interface when determining the
> interface mode rather than mac_interface.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I know this has been merged, but FWIW this looks good to me. sorry for 
not having had time to test this or the Marvell PTP stuff lately, I'm 
juggling between too many work and non-work related things and barely 
have time to work on phy_port :(

Thanks for this cleanup,

Maxime

