Return-Path: <netdev+bounces-251265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE9D3B749
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1431300294C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5C2D5A19;
	Mon, 19 Jan 2026 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTyNkqIc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F7259CB2;
	Mon, 19 Jan 2026 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851020; cv=none; b=KBiM25GFHepj1DLYjSr37d9jHbcQJpfyRMpIPzKv5lOm8+jsSN6GIyxmU9DN+KiRaCQlMb5TIf+CRTN3Nanp/RpOVSPlnuUtirUG0IOt3G7b5FtLZxWBu2zPmA8invE302pEz5AuXTb4dqnV+4IxVJyD87X6IURFK1QXII/vOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851020; c=relaxed/simple;
	bh=NEwyMfauQZ4L5qrKMy2WyZk2sEGKvX5geU1vcuLBWVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReyGORhfNCeJEIMhm8E25pZcmi4MbHNj48Ju0g+DzRbP6FRkHU1/QjfjmBj4XRpDi8VHo/Fbt9BME8EBS1axyDPeFRCa4a6OqUJ5I9AfTHDiAOWNbYgFq1DNUm6g8ajGuhJiMPhP3NgLXGHm+dEk04jnolbmWC8nY3fdx/EoHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTyNkqIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A89FC116C6;
	Mon, 19 Jan 2026 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851019;
	bh=NEwyMfauQZ4L5qrKMy2WyZk2sEGKvX5geU1vcuLBWVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTyNkqIc2jARmsKluDC4kFT14Y+E5w1T2KCabAZ0u8Ei2F8Y2RAVvN8VTULb24xPu
	 7vPdozuNmCHAONk/FHEufycTzqODo8wHudakkOBVnYPkIzzZ4WKmbMqoUuZ0CUuuAR
	 x61BhoPIMPX99qmrzya88CuRsP/jnCOt6QVzQTHoB07OVKtWsXlAwvIfR3gnCTmnJL
	 cFETSktM47meov2BtqR+qiazYB61TqxjrwDnwqif+mg5e1jjlSNDd9iQkUg23CY8Lz
	 QHJgHmycu3/oznle/lN7RtsgZdTMTsMWQj6/nARwl1csJP44fG9tVc4t1lgBv41bUV
	 CdRZJhscv0t7Q==
Date: Mon, 19 Jan 2026 11:30:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mikhail Anikin
 <mikhail.anikin@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Message-ID: <20260119113018.48da59a2@kernel.org>
In-Reply-To: <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
	<20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 16:07:38 +0200 Josua Mayer wrote:
> @@ -247,6 +247,7 @@ static void sfp_module_parse_support(struct sfp_bus *bus,
>  	case SFF8024_ECC_100GBASE_LR4_25GBASE_LR:
>  	case SFF8024_ECC_100GBASE_ER4_25GBASE_ER:
>  		phylink_set(modes, 100000baseLR4_ER4_Full);
> +		phylink_set(modes, 25000baseLR_Full);

I _think_ the discussion here concluded that the patch is insufficient 
/ DoA? Either way, I wanted to relay that AI code review points out
we may also want to set __set_bit(PHY_INTERFACE_MODE_25GBASER,
interfaces) here:

https://netdev-ai.bots.linux.dev/ai-review.html?id=c91c0f54-56d5-4356-89cd-b57cbb289495

