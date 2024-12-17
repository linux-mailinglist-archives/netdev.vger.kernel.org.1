Return-Path: <netdev+bounces-152656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C729F5117
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCE188BC00
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4D81F76AC;
	Tue, 17 Dec 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7H91zBU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046791F76A3;
	Tue, 17 Dec 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453134; cv=none; b=bXyBhUoBwJ00fAHgKgfmZSR3JFPUyY05i4CpO8seiVlyoj8ns9YM2AgK63tX+x9hlbmnxoUjZVjKeQLJx2jbaGmeFOSoE1G6NUpjFrGvKiXkZfyrOxgzrlwEdBewuyluAYFbLYJGIEFUkVC1DH4wW6CZ0W/NOw4SPlb3k4PKIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453134; c=relaxed/simple;
	bh=NXCDV/TEsO/tkTQikUC6ICuqE+1kO8I/+7YqK4yleGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erUMYhawVllm5gQ+Dien4PishSXs6VkJUPNxxr6rVcNNnv9xux0WzgbBHuCVdFEkQfTVpB7wRc9dd2Jy4kUukb4gJpw0IXRmIxapTfkZDanAQ3I0CjNJ2wwRyqysNgVpaQBPyP2Ky7kpB5lGI6a6qk4qCloUyyBqzZQwIbIHjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7H91zBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F382C4CED7;
	Tue, 17 Dec 2024 16:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734453133;
	bh=NXCDV/TEsO/tkTQikUC6ICuqE+1kO8I/+7YqK4yleGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7H91zBULR+20rclvPa6by87g7IVtdG+2/FlrROgeg91Ie3UJnr2sM4xQK6WrqROh
	 U6KRzGEtwutUrNDY1WT2u4gWanxaiKJfdjzoC5q/maa2IX/NUo8pKmLxHAwPBnXhu0
	 2fRlSj+5dPK9AS83Bymb+8roJ91Uh+AKxoC/jVzmW/rZRDc2IZjUxyxS2MaJqedrjf
	 RaAqHwFUGs+N58HXbImJVR6oqjSIvUQ/HirIeqN2lsDphwnPNBSOur6agOagXML3FX
	 fsexXvF4LY37kn9fyiY3oEaRCL5YCT2co1+eEuJJ89V6hU8YTnhxEFyS/3fLt3gANK
	 /HN4EzmHlnWvA==
Date: Tue, 17 Dec 2024 16:32:08 +0000
From: Simon Horman <horms@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <20241217163208.GT780307@kernel.org>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>

On Tue, Dec 17, 2024 at 10:16:03AM +0100, Dimitri Fedrau wrote:
> The DP83822 supports up to three configurable Light Emitting Diode (LED)
> pins: LED_0, LED_1 (GPIO1), COL (GPIO2) and RX_D3 (GPIO3). Several
> functions can be multiplexed onto the LEDs for different modes of
> operation. LED_0 and COL (GPIO2) use the MLED function. MLED can be routed
> to only one of these two pins at a time. Add minimal LED controller driver
> supporting the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/net/phy/dp83822.c | 271 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 269 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c

...

> +static int dp83822_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				      unsigned long rules)
> +{
> +	int mode;
> +
> +	mode = dp83822_led_mode(index, rules);
> +	if (mode < 0)
> +		return mode;
> +
> +	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      MII_DP83822_MLEDCR, DP83822_MLEDCR_CFG,
> +				      FIELD_PREP(DP83822_MLEDCR_CFG, mode));

...

> +}
> +
> +static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				      unsigned long *rules)
> +{
> +	int val;
> +
> +	if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {

Hi Dimitri,

As per the condition near the top of dp83822_led_hw_control_set(), should
this be:

	if (index == DP83822_LED_INDEX_LED_0 ||
	    index == DP83822_LED_INDEX_COL_GPIO2) {

Flagged by W=1 + -Wno-error build with clang-19.

 drivers/net/phy/dp83822.c:1029:39: note: use '|' for a bitwise operation
  1029 |         if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
       |                                              ^~
       |

...

