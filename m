Return-Path: <netdev+bounces-143812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9299C4485
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E7C281366
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5B19F104;
	Mon, 11 Nov 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLrWznS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92064450EE;
	Mon, 11 Nov 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348461; cv=none; b=r3amWYJYe/Nwd8Rq1wR4+K/64H9R3ONPilQUjF88SEAlE8bbRtv4T3RH6BUICh07E4fC0PuKgzK1IMbovaGPnqU6X4/svJUa+NyMGXfE4Y8hREeQbN4571zh550Lgyod2DWk2Jh5WSnvgJ1H1UJHcfERWSyt9nX2mBSIhUVwIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348461; c=relaxed/simple;
	bh=rz4JHvcpgUzoCljEvliRrSBJ/fDr9DB9pzrSRJJa8X8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3NIChsCKUIdJ4rkaRr8kiajEfmYu2HeXA9VEgmKxcuk/6azHXfR038B4m3ygoRZVkQu/S2WZ7HgEOZzcn2gXD2z60YxlRwoU88QC2iR27cxr+fSe8+SDd7qbaDUSvStn7wWfxnSg3m9ZkP0lSog0ClLLFyeQocMybY7oAUkV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLrWznS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F34C4CECF;
	Mon, 11 Nov 2024 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348461;
	bh=rz4JHvcpgUzoCljEvliRrSBJ/fDr9DB9pzrSRJJa8X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLrWznS3/AOW/laYSuQkuDfnnGbqDsv/JPyjNjuj5Lmdz0s0gCjOt9Eqo8nRKwe/b
	 eUsOHUtvPPoylUKjZvYgeXlmHMRh/q7v6Tl7tCu8Bk/GBIsdmSjeXxVPUhJayksZ/Z
	 JtzOm8i+gBpQcqJ4BtXnOVTEmCrvVStwjLS73jAam+wd6aBgpGW+Rn4XwR2yjbhbpi
	 maACW9ZWBiwzSxXA2DIEVcdM/acCNNWqf8FrW1feTYqF/bzNNVCMQifgzSS2hYmhVG
	 OpuLp+v0NJ9VXIuFifT4Jt9BT+Iy0HKg7PwpTJetWDaV5i85ea6DZ/3+H0kRDIjYNA
	 YssDU2IpAvi0g==
Date: Mon, 11 Nov 2024 10:07:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: phy: Makefile: Add makefile
 support for ptp in Microchip phys
Message-ID: <20241111100739.362264fc@kernel.org>
In-Reply-To: <20241111125833.13143-5-divya.koppera@microchip.com>
References: <20241111125833.13143-1-divya.koppera@microchip.com>
	<20241111125833.13143-5-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 18:28:32 +0530 Divya Koppera wrote:
> Add makefile support for ptp library.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v1 -> v2
> - No changes
> ---
>  drivers/net/phy/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 90f886844381..58a4a2953930 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
>  obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
>  obj-$(CONFIG_MICREL_PHY)	+= micrel.o
>  obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
> +obj-$(CONFIG_MICROCHIP_PHYPTP) += microchip_ptp.o
>  obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
>  obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
>  obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/

sparse complains:

drivers/net/phy/microchip_ptp.c:615:30: warning: cast from restricted __be16

