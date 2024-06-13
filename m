Return-Path: <netdev+bounces-103032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38190606D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63EAB21EAD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52107BE7F;
	Thu, 13 Jun 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3RG/+Qm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B612B83;
	Thu, 13 Jun 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242391; cv=none; b=LJzQ2wnaiapMVyb13OwnpKjEsykmLY8evavB60QAzAInhe9pIIG4xby2TG/t5r/7pbkfxF9zbYO3KOGkNRLsSWPkiI9kVyeS+NM30vpIAaIG9rWm6wmoyaSfpGuZ84Qast4TfMFtMzl8Q64qetfTMQIhTV+J3C+FhIUaK2X06LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242391; c=relaxed/simple;
	bh=MWyhtnST40YbbxnfAwXhylv+xDPKS43fpIQmIg3zRfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bia6OFGjVLN0IUtAIECFBISqPaaKqi0P9rOZGGhCOpJgZd10HMk1oFoa1tuz8Y17nQOgQ63XTTNahXxSXJDKCWdGWWKyTLTv7lsYIkWv+bP1H1hUPWYFOjpbzJ8iEYCvO77Fdwtfd0UoOmiRnMhfL6IHR2EoR+9KqL2tESL+rBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3RG/+Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360CEC116B1;
	Thu, 13 Jun 2024 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718242390;
	bh=MWyhtnST40YbbxnfAwXhylv+xDPKS43fpIQmIg3zRfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u3RG/+Qm0PoyYf3nxwJ+VxfzLwPHD1Jgst78ruQL5zHjKP6qDFM22E7ou7pzmq+di
	 /BeEYw0am4NOhQkdHMoVfqTBpEFngr9HGz0GY/msd5qd9ns2qJcFhqtGAut3QFYtgJ
	 UJUgNFShqug1imhOYfBh8RWRl4Q627tO7twZ4HN/RJ4qv3jy54Msu7qgcPFHkMCLI+
	 Uhjfb911Oezk4R/Pzg0WwjIIpItuifd2pDFFoLk4wUaZyqJJRoH+B8Qe/05bkYx9Ps
	 0ixAxX3IIrNAUz7Uf7OVxlwsAgOvjECeo5ogaFnoJtebiW9ItV/GdKiyLbk1zrgFhk
	 bF7IXpFM/rsGQ==
Date: Wed, 12 Jun 2024 18:33:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Message-ID: <20240612183309.01782254@kernel.org>
In-Reply-To: <20240611094233.865234-1-rengarajan.s@microchip.com>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 15:12:33 +0530 Rengarajan S wrote:
>  /* define external phy id */
>  #define	PHY_LAN8835			(0x0007C130)
> +#define PHY_LAN8841			(0x00221650)

For whatever reason the existing code uses a tab between define and its
name, so let's stick to that?

>  #define	PHY_KSZ9031RNX			(0x00221620)
>  
>  /* use ethtool to change the level for any given device */
> @@ -2327,6 +2328,13 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
>  			netdev_err(dev->net, "Failed to register fixup for PHY_LAN8835\n");
>  			return NULL;
>  		}
> +		/* external PHY fixup for LAN8841 */
> +		ret = phy_register_fixup_for_uid(PHY_LAN8841, 0xfffffff0,
> +						 lan8835_fixup);
> +		if (ret < 0) {
> +			netdev_err(dev->net, "Failed to register fixup for PHY_LAN8841\n");

Don't you have to unregister the previous fixup on the error path here?
In fact the existing error path for PHY_LAN8835 is missing an unregsiter
for PHY_KSZ9031RNX.

Could you please send a separate fix for that with a Fixes tag?

> +			return NULL;
> +		}

