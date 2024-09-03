Return-Path: <netdev+bounces-124417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4096958D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9F1C23298
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4971DAC56;
	Tue,  3 Sep 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhitfezH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26441CE6F0;
	Tue,  3 Sep 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348659; cv=none; b=jHRTLef+J3LKc9HDPxPO6ICitwE0y7s8n1vSpNy5AASW/lg3/mRiWrsqZqHQeR+J3adgwrTz8JOfINIzJ+XWeThP8sZEqwe0xlArNI8JxRPLPMa3B/j6EBbHABiRHVWKlYfw3lKCpZjMXbspPG7Ov+WbLxvQcHOG1ZHXhM2NIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348659; c=relaxed/simple;
	bh=/RR2jr1KMQXxUfxuXcD3zaZtecL2ksrKcjhHyOpf0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWJzMjAh148xUuL7KZ0NPSlZxH9+UDEhEYNnBNnNAGaYsC3BWKp6yKxtA5k6+dz8/0viDxFmd2gmLc9q1wTA5GWFGFomNSQc9SZ/kt1mAkm+1PeqUxvFe+MifKfqAdmJlx2YonKSzQwv9o0vDJRIt9I+ov7EcVoR/43b6WM68tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhitfezH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2E7C4CEC8;
	Tue,  3 Sep 2024 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725348659;
	bh=/RR2jr1KMQXxUfxuXcD3zaZtecL2ksrKcjhHyOpf0fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhitfezHixV6WCukmGc4VnWzssY6DFst2DXsNBsGTdpx4eNrt1Hc/l62iauhtZnUJ
	 RlSnAQS+gM7jLnrsqnQd/eki088//7fF7Gs6miYJsIpf74ck5y4z/1flAatH/UVQME
	 NZo1KQjDRqOudNyMicarVanmPZPimX2a1AkxDBFREWtqlZATxOjRStSKn5Hni+2Jkr
	 jZeNgLwbicrxiVts5qL2vSCS46810QKURTwCe8xUQTpofg938Xi6D97zTaJTgN4Pdo
	 sMiLaT4TJpuIr1zjaoBpA5wpucWGVD9AOhYRn6dglnMS6U2IAF67jVWhbGME6BAfCz
	 Xc+oIlzh86awA==
Date: Tue, 3 Sep 2024 08:30:54 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ramon.nordin.rodriguez@ferroamp.se,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Message-ID: <20240903073054.GO23170@kernel.org>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902143458.601578-6-Parthiban.Veerasooran@microchip.com>

On Mon, Sep 02, 2024 at 08:04:56PM +0530, Parthiban Veerasooran wrote:
> This patch adds support for LAN8670/1/2 Rev.C1 as per the latest
> configuration note AN1699 released (Revision E (DS60001699F - June 2024))
> https://www.microchip.com/en-us/application-notes/an1699
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

...

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c

...

> @@ -290,6 +291,58 @@ static int lan867x_check_reset_complete(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int lan867x_revc1_config_init(struct phy_device *phydev)
> +{
> +	s8 offsets[2];
> +	int ret;
> +
> +	ret = lan867x_check_reset_complete(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = lan865x_generate_cfg_offsets(phydev, offsets);
> +	if (ret)
> +		return ret;
> +
> +	/* LAN867x Rev.C1 configuration settings are equal to the first 9
> +	 * configuration settings and all the sqi fixup settings from LAN865x
> +	 * Rev.B0/B1. So the same fixup registers and values from LAN865x
> +	 * Rev.B0/B1 are used for LAN867x Rev.C1 to avoid duplication.
> +	 * Refer the below links for the comparision.

nit: comparison

     Flagged by checkpatch.pl --codespell

> +	 * https://www.microchip.com/en-us/application-notes/an1760
> +	 * Revision F (DS60001760G - June 2024)
> +	 * https://www.microchip.com/en-us/application-notes/an1699
> +	 * Revision E (DS60001699F - June 2024)
> +	 */

