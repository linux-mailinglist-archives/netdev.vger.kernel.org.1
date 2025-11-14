Return-Path: <netdev+bounces-238618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6CC5C05A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82CD6358693
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818072FDC49;
	Fri, 14 Nov 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZC7toC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB82FDC44
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109495; cv=none; b=Gy9h7odrkb+7+881SUAWOQ3Yi9D3Gkbrz5RThARA6yYxl0d3Crz+ALow2mFYsDjxf84zX88QMoGPU71i58awGPEP6wjWNeWo9N5IRPw46p3hVNNcBsneYxYRCiJfLTXIJtbKlPjn/2kyfCxp9z913U9lNLs6WHSUiFT6Y1Iri2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109495; c=relaxed/simple;
	bh=HUbRvNbwLGMVb29G6380NZEGcoLvDiar+ddcbsKCNlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmqXmSzdJTUQ0ok3lVnv89usl6G4rBoM6VcVEZ41MSdUJ1n8COquJ4ZtI7jS99qqtak/r7tRHg0NohCzQbHobu/RvnkllA+O6UWg0ih92GRkijsmR7E0DUASMcs3NmzpMfWmgExj4EbKNSLPAbSX3z2a5p/NYewORiO+Wy6y7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZC7toC6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0B28C4E41654;
	Fri, 14 Nov 2025 08:38:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B33746060E;
	Fri, 14 Nov 2025 08:38:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08885102F29CE;
	Fri, 14 Nov 2025 09:38:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763109490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZOwdHp5qj4PtdRGnvU022mJuMI2lgUDgwxHA0Hz3vt8=;
	b=kZC7toC6audgfeq+ECKL49O6cMtmjQGMSMcDpvw3YaVU2x9zPu1uawKw8sNFi1Rxb6GZRV
	y59kusswQ104ISpiA9NJYipUGvERfNpjpy/CKFJdM3El/by0G2m6YoLMnKRYIFe38e1ryY
	RuJecFqCoZYYddliAwykxSryEvuAPn+hF0o8xDVXVwFxMlZ9qHbHbNZlfLvqp58UaGeplM
	j7BxhaR6eomgbW1jdyaJLcidLvXQJ9yZdF9nzq07iqR3xgUlIDqVXWznIjavl5LyHi2/jE
	zrD9OPteqaWzer3u0gGwjwYm6y/SB/ZlcgyAHjsBtQwvhM+lu/bnJGVaJLMZUw==
Message-ID: <2d9b6ac9-0154-4cd9-8e08-a6aeb5c09709@bootlin.com>
Date: Fri, 14 Nov 2025 09:38:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
To: Wei Fang <wei.fang@nxp.com>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, eric@nelint.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251114052808.1129942-1-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251114052808.1129942-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 14/11/2025 06:28, Wei Fang wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link.
> 
> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

I agree with the fact that these used to be set, and it's no longer the
case since the blamed commit. My bad

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phylink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 9d7799ea1c17..918244308215 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -637,6 +637,9 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
>  
>  static void phylink_fill_fixedlink_supported(unsigned long *supported)
>  {
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);


