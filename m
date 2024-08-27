Return-Path: <netdev+bounces-122541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D8961A53
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6251C22FDB
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A56A1D54C6;
	Tue, 27 Aug 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+C/xiGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A01D45FA;
	Tue, 27 Aug 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800380; cv=none; b=Ypib2ky3eesFOvhJyolZlUSYFYXaQcl6knPCRUvxaRbqwi2kaBtIMXBjmAX3uIqfOhWCLaTznvkn8qBzY8REr4U3Q8Xt+/gN6PPug1wZpWKtKVuAoyYHBRQstwA+bz7nCsxPWzqi5ksYTzrFav02TpW8WvsUq8loLZMMTe5Xp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800380; c=relaxed/simple;
	bh=EwMNE/ZvzXPZjIoQokPpdZaOjFt3OkBn88FQhoc0ABQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSan5tMIssPoc2XOVYquSOneyTlMFQGFAsdcxenTsJA2o/q6DZQjJNvsHn7559vYaZHjMw/V9NKEouYdFse2xxsGaGQCTqRG73D84M2VkHlq+95G1zJR2kFF9uKX7SrwF6+YUYNYUdWjxFWetpDTO7C/rhaXJlVkieHvbU4zcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+C/xiGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F62C32786;
	Tue, 27 Aug 2024 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724800379;
	bh=EwMNE/ZvzXPZjIoQokPpdZaOjFt3OkBn88FQhoc0ABQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r+C/xiGtc4q1HGY9FCiQEGM8jQ+y/kTFkWikR2Hrjgw7BNaLyipbh4vMtrlvcRvRF
	 fmoZrwHSV3z6x9Py6RcZwtzqwNcB59JferUPv8o9wztpam1/jkz+M9XylKyqE1BcX1
	 jSxBAfANIAbDUHq5cgSsAuuz8t4mab1SD38jnJ5+HL08B+yTJt2R0fq77Fk9sflXfB
	 p8irNpKpguiNMMU5V7U2JPsWqYe0Y+HABZOcfwfbLTnHvxDsvDLkuZZFoN708gKUZL
	 DnQ2c3m+paUNNWY7vTGj58A1YXXnC75Zukbi6c66zFWKLraTpTFru3v7m14xltbUYQ
	 3WgeHDFMdNCVQ==
Date: Tue, 27 Aug 2024 16:12:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, p.zabel@pengutronix.de
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm
 api
Message-ID: <20240827161258.535f8835@kernel.org>
In-Reply-To: <20240826212205.187073-1-rosenp@gmail.com>
References: <20240826212205.187073-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 14:21:57 -0700 Rosen Penev wrote:
> Currently, the of variant is missing reset_control_put in error paths.
> The devm variant does not require it.
> 
> Allows removing mdio_reset from the struct as it is not used outside the
> function.

> @@ -683,6 +682,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>  	struct device *dev = &ag->pdev->dev;
>  	struct net_device *ndev = ag->ndev;
>  	static struct mii_bus *mii_bus;
> +	struct reset_control *mdio_reset;

nit: maintain the longest to shortest ordering of the variables
(sorted by line length not type length)

>  	struct device_node *np, *mnp;
>  	int err;
>  
> @@ -698,10 +698,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>  	if (!mii_bus)
>  		return -ENOMEM;
>  
> -	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");
> -	if (IS_ERR(ag->mdio_reset)) {
> +	mdio_reset = devm_reset_control_get_exclusive(dev, "mdio");
> +	if (IS_ERR(mdio_reset)) {
>  		netif_err(ag, probe, ndev, "Failed to get reset mdio.\n");
> -		return PTR_ERR(ag->mdio_reset);
> +		return PTR_ERR(mdio_reset);
>  	}
>  
>  	mii_bus->name = "ag71xx_mdio";
> @@ -712,10 +712,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>  	mii_bus->parent = dev;
>  	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
>  
> -	if (!IS_ERR(ag->mdio_reset)) {
> -		reset_control_assert(ag->mdio_reset);
> +	if (!IS_ERR(mdio_reset)) {

Are you planning to follow up to remove this check?
Would be nice to do that as second patch in the same series

> +		reset_control_assert(mdio_reset);
>  		msleep(100);
> -		reset_control_deassert(ag->mdio_reset);
> +		reset_control_deassert(mdio_reset);
>  		msleep(200);
>  	}
>  


