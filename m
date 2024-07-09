Return-Path: <netdev+bounces-110244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AB92B94A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E231F25276
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B17158D7C;
	Tue,  9 Jul 2024 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7/qy3OE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCC1586F2;
	Tue,  9 Jul 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527558; cv=none; b=oDz3AXagGLg/47I6BtP/6uCwn+/AjSizwFpdvaHNHhRUs/E6Tkf6fA7F6Syfy7myqskQm/mjbAR67PxiQXiH0Sk3QTbqa08EaDGeMYpd4MQcQYRk3EJo7Vx+gswULnIPw0Rg2uYq1RUDYhpLCLTWpKoXDqUsOK6oHe/h+DvAvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527558; c=relaxed/simple;
	bh=5LbmztMs8SCDwgQsx5qMePs0alzgD0OUw78IukuMvCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRtzyx4LjvsNx0inQIudGur04Ls5ULjyLTF2XIqH70exeSiOVBg38GMPEwPIh34Pbgaipixn8QbDrjR2EXpQceHHfoZZhYV4nLGBtZz4nzyr+eGZ4oq5RAUKfvCMOEuvcP4LZlG6dlEZ6hCtHpfOs26CEPmiZlQe5HhkEHcHEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7/qy3OE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA37C32786;
	Tue,  9 Jul 2024 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720527557;
	bh=5LbmztMs8SCDwgQsx5qMePs0alzgD0OUw78IukuMvCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7/qy3OEtAeRYF/2dLTpiAmiaX+A+HiREcY0QocSVcOKdqDCBLvyz50ZYMXwdnBi3
	 934B+Xi5EDGC1ImxdyRk0J9TL5eTxioVnTcj5hTV/uxi9+tLxzjTUJckDkrFdPHts9
	 k0wkUY14Khv69/3txvniTiboZa1crJmq68Kwz9rkz5plFqbJM5o9PgNBa7rbEuQqxK
	 1zShtmYkAKzcikciOLS4RbUfRQzVVgdOs+6agMd/URXQRkiqRPTyLSqEXn82sF61sq
	 8vSQYpM97P1ZqUWrlIgw5jJlBDp4p/cnmZ8RuXcj38zkwxAcJbBBzu+DhcrvVCs9wS
	 b8kqyS9UncxHA==
Date: Tue, 9 Jul 2024 13:19:13 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83td510: add cable testing
 support
Message-ID: <20240709121913.GJ346094@kernel.org>
References: <20240708140542.2424824-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708140542.2424824-1-o.rempel@pengutronix.de>

On Mon, Jul 08, 2024 at 04:05:42PM +0200, Oleksij Rempel wrote:
> Implement the TDR test procedure as described in "Application Note
> DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.
> 
> The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
> cable length was 5 meters more for each 20 meters of actual cable length.
> For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
> showed as 50 meters. Since other parts of the diagnostics provided by this
> PHY (e.g., Active Link Cable Diagnostics) require accurate cable
> characterization to provide proper results, this tuning can be implemented
> in a separate patch/interface.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/dp83td510.c | 158 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c

...

> +/**
> + * dp83td510_cable_test_get_status - Get the status of the cable test for the
> + *                                   DP83TD510 PHY.
> + * @phydev: Pointer to the phy_device structure.
> + * @finished: Pointer to a boolean that indicates whether the test is finished.
> + *
> + * The function sets the @finished flag to true if the test is complete, and
> + * returns 0 on success or a negative error code on failure.

Hi Oleksij,

Please consider documenting the return value using a "Return:" or
"Returns:" section in this Kernel doc.

Flagged by: kernel-doc -none -Wall

> + */
> +static int dp83td510_cable_test_get_status(struct phy_device *phydev,
> +					   bool *finished)

...

