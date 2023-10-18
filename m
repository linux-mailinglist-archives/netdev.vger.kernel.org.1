Return-Path: <netdev+bounces-42302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C077CE1E1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A84281DA3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116E374CA;
	Wed, 18 Oct 2023 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shgO2+N8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B6347D0
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DAFC433C8;
	Wed, 18 Oct 2023 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644617;
	bh=8D6Mjx5HFMPwEn9XL6mieDVD+lT588WBKWdC6XGHrnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shgO2+N8GgVc7Petwc6ErYY0k2eL+MtZuC9k7+aEL0ZOxi2suAlAWhsZsMBU900jz
	 2KgH2DDmgl4RCf+0y6y9cU9xK8X4A6a7NrhDiCGPDOS8aPrnFX7sR1RxM8upleqU7N
	 9DuyqJf0/MMNNZGoB/sxkDgMl+Amg88UV27qJmT/hEcLsuY90OKjCs5pPeC4yxzXXd
	 yV4bojQ7omxw6PntwDnfjMUFY+SMWcYdwiluu24aSgJ3SXsYPFd/nXWnBB0y7c9fX/
	 QVDrRik6h1yixfmqpCYUynWKJJlxiEXoBThf6G2muoyrDGL2BSP0tBaJTy9qBGunEJ
	 HPnr93c3VGuqA==
Date: Wed, 18 Oct 2023 17:56:53 +0200
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231018155653.GS1940501@kernel.org>
References: <20231017233536.426704-1-florian.fainelli@broadcom.com>
 <20231017233536.426704-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017233536.426704-3-florian.fainelli@broadcom.com>

On Tue, Oct 17, 2023 at 04:35:36PM -0700, Florian Fainelli wrote:
> This preserves the existing IFLA_DSA_MASTER which is part of the uAPI
> and creates an alias named IFLA_DSA_CONDUIT.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

...

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index fac351a93aed..30ef80aff033 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1392,7 +1392,9 @@ enum {
>  
>  enum {
>  	IFLA_DSA_UNSPEC,
> -	IFLA_DSA_MASTER,
> +	IFLA_DSA_CONDUIT,
> +	/* Deprecated, use IFLA_DSA_CONDUIT insted */

nit: instead

> +	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
>  	__IFLA_DSA_MAX,
>  };
>  

...


