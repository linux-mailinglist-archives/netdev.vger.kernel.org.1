Return-Path: <netdev+bounces-30199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4109786575
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6465128142B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB315A7;
	Thu, 24 Aug 2023 02:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954C193
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE55C433C7;
	Thu, 24 Aug 2023 02:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692844499;
	bh=XjxrkSsQ/Ror3FyVT2R08gl6DNDs2DU+FO1FT6wHawE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qlEkFLwG6Wa+uMJh8Gi2q8otS75ifb24FveBqIEZAL5hJLk0oMF9P9qgBagCrZVfo
	 PUIrtDyjWo6P8rkyvFK9VYy0JvpROzhTZLGD0KmLHDTcUFzh0jAaAAlzkvkErIsjfv
	 hABDGKjDFVKq9iH65hrG6lq5D/gg0ZLeIziYV5q63s3/Fo2uwKTIx8iURNw/l2b4U4
	 Qj1e2oaqVaZR0/UUTz20OUTnCOmMvSDw1R6zUmiPSBoYarLdW9cNlA6AMOZAc3rzKq
	 dPBRdCeJ8FwY+ZFMSforxAH0qM7eHIGbFgVTJAG+B0vR0v5f9inNepjOywASLOf8cR
	 tKY1TIBAruxxA==
Date: Wed, 23 Aug 2023 19:34:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Feiyang Chen
 <chenfeiyang@loongson.cn>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/9] net: stmmac: use phylink_limit_mac_speed()
Message-ID: <20230823193457.35052bf8@kernel.org>
In-Reply-To: <E1qYWSO-005fXx-6w@rmk-PC.armlinux.org.uk>
References: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
	<E1qYWSO-005fXx-6w@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 19:50:24 +0100 Russell King (Oracle) wrote:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index b51cf92392d2..0d7354955d62 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -440,7 +440,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed)
>  
>  	for (i = 0; i < ARRAY_SIZE(phylink_caps_params) &&
>  		    phylink_caps_params[i].speed > max_speed; i++)
> -		config->mac_speed &= ~phylink_caps_params.mask;
> +		config->mac_capabilities &= ~phylink_caps_params[i].mask;
>  }
>  EXPORT_SYMBOL_GPL(phylink_limit_mac_speed);

This chunk belongs to patch 1?
-- 
pw-bot: cr

