Return-Path: <netdev+bounces-126446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464AC9712AC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727231C22504
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6721B1D76;
	Mon,  9 Sep 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym9j8qI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082114B94A;
	Mon,  9 Sep 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872147; cv=none; b=CqVbufSYQYua7si2WyT7uPbN0djYhRxR6WA2Jm0jxNcY9xscklyHcTyt3ufnnt/BH//MyjD0xR4vKoox30/RNj2PBCd6WoDVo5h+qXkqRMnrHDvWxiOVyR15QtlqXfl9r0sgcBCvyr4Pr9qvgWWAbgyRcylB37gRdSDg9ajd6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872147; c=relaxed/simple;
	bh=e4aVb+sNmgYBf09msxQwgK2NAZ3FFz0XQ4u9sLpYhFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/InieUGSzrHRtnj4vbzmzEcSEk9TdiUx8eWgutyAEuyR/8wwpbw5wISTjml19NS7bXDe5X6VMdmPXvvTWfwVhIr0w1walPAgrM8lqV9zZ4JzMCIhIaq6w6e+DwxBg167l6GVjdwFEzx6hieEx/3vIv1lqZ5GukZA09/qwPiCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym9j8qI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A100BC4CEC5;
	Mon,  9 Sep 2024 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872146;
	bh=e4aVb+sNmgYBf09msxQwgK2NAZ3FFz0XQ4u9sLpYhFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ym9j8qI7l6W5G2EENS+PrKEYzzRj9tIWk4Qe4wlGLFke+dkRhr7gSbxUywWEo0cAd
	 A5g0QXrH1OzRrgkdxKrqDskrD6VLOfIOWGNUM9YWWT5yKujfYpKMPZhVumr157xCKx
	 swIcA2CCiRnlps2N9XIcEQghQ8m9SVG0qZRVL5WSnG02z2FjT9qHcCQqP6lM7z7LS8
	 h0THfKUxmEtQU5cc3GTI4eldZMCJo4ztTFaL1S0+XrNj4qzlcZwR7cgn7KKbI3fnIY
	 r7y3NtNxKV5s6Y+zlzaxiIgvTVA/CaIylsLEDDaS72HNbY1It0LNnGD+s1KUjP3Xno
	 ZCFvaceBDbjZg==
Date: Mon, 9 Sep 2024 09:55:42 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com,
	mail@david-bauer.net
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
Message-ID: <20240909085542.GV2097826@kernel.org>
References: <20240908213554.11979-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908213554.11979-1-rosenp@gmail.com>

On Sun, Sep 08, 2024 at 02:35:54PM -0700, Rosen Penev wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 634049c83ebe..9755ec947029 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
>  		priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
>  
>  	err = of_get_ethdev_address(np, dev);
> +	if (err == -EPROBE_DEFER)
> +		return err;

To avoid leaking resources, I think this should be:

		goto err_grp_init;

Flagged by Smatch.

>  	if (err) {
>  		eth_hw_addr_random(dev);
>  		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);

-- 
pw-bot: cr

