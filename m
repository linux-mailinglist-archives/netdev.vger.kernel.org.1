Return-Path: <netdev+bounces-242490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 400DAC90A63
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E263334DC57
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3E263C91;
	Fri, 28 Nov 2025 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBv4P6YE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B1AD24;
	Fri, 28 Nov 2025 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764297858; cv=none; b=q72NdgarAI3S2uTlA7RRIqqhIMzZTcdvANFEDQrUt4ZeW/65VrFVviqgpR3hGW5ueSoB+UzMUiCPpx2d8sD2Eyh1Kr2hyFqWo1OnwPHKKS9/XKhowm9q9zF8eKlTACNejrEZOGO2f3vPstyR/Nf5q5MdezfeCKKDPePuNLeYa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764297858; c=relaxed/simple;
	bh=nLHUstwbyhlKTbyIqYbAaM0jP+HDId+R2uwQTF60KNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LABH5Plu4OtMkoOzvNyNd05MU4rQl1TC57hdKQtuh9CXFkUntjDw8tMVYJxWFJKc+FS3R4bn0utze3wBVxxZvAv3j/D3ZHkM9qgV4YoD7aAqKGZzHKD+UTaNhVVyEzGK13bnIArcZPyPw9FAK0/BJmhpjxv8Xu1AGra1pyUvgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBv4P6YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16ECC4CEF8;
	Fri, 28 Nov 2025 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764297858;
	bh=nLHUstwbyhlKTbyIqYbAaM0jP+HDId+R2uwQTF60KNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBv4P6YEN7LETZBiKLl304BnjWPEigxZ8hcquEJ1mWU9Put2Eh9gR11DU1t/lNrBv
	 P2v7yTeXJXQAY8XOsejofrUrcoT6fw4dwqa6Klu+TNpJb5fXqbLfa3HqvuqpHu9pQ6
	 4+/j+IHIQ2hreWanXXW/CMTrNyY6ByNyK9ANWAWqbiqQJ4csWLd7UklIiUKmDw9z1y
	 65F2/Ekl4CFMk3RLUlrpytFLatWqKBgtn7KTsuINhZhp/9s8cFxA42FTYRgAxNkKsG
	 voFPik3B/nES4Pva4QX5MTThmNCkfXQP6nbw2WmevCoTOUNtUOs+7ENjfoHZ2UsBGC
	 TwuLmLn95sT5A==
Date: Thu, 27 Nov 2025 18:44:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: <piergiorgio.beruto@gmail.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Message-ID: <20251127184417.203c643e@kernel.org>
In-Reply-To: <20251126104955.61215-2-parthiban.veerasooran@microchip.com>
References: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
	<20251126104955.61215-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 16:19:54 +0530 Parthiban Veerasooran wrote:
>  /**
>   * struct phy_device - An instance of a PHY
>   *
> @@ -772,6 +796,8 @@ struct phy_device {
>  	/* MACsec management functions */
>  	const struct macsec_ops *macsec_ops;
>  #endif
> +
> +	struct phy_oatc14_sqi_capability oatc14_sqi_capability;

kdoc sayeth:

include/linux/phy.h:800 struct member 'oatc14_sqi_capability' not described in 'phy_device'
-- 
pw-bot: cr

