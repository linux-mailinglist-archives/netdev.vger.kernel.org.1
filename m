Return-Path: <netdev+bounces-59420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549681ACAC
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D531C22EA8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644419D;
	Thu, 21 Dec 2023 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY7kfjsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D21843
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e30b28c1aso462397e87.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 18:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703126202; x=1703731002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WK24IycXOInYVKgF6uZXo3NQn/8pUfvRSPTixdneZIw=;
        b=HY7kfjsPZj82jd+WLXXUSKaFnqRK6zHxG/AXHE06aAL4t6WRuuhdU6rDXCE9KaTHvI
         oExyBb30tCpEnW0/BZDmphzN3qaviiZ0++cNL52CbRqLQWM9y3wGY6oWpv2r6t2wgqRb
         mVclMV9xJ1Pm3j9YaHUKY8RWD4dwymVYoZjVQR2DKKG0C3/2Wsbr6BBjKfybaKzgxX7J
         OJWu+gDhNtwIVNtXyidXMzGm6hdLo5ic8dpMBp/3tZNy4gOTaOsV6H0UuQOm/kHkAxLi
         Oqj70ah/til47Kh0kt0S97vgs5cNhMFGl34Ny5SAFJxBFLrY/p+NeMtqN5HCs2Ype0WP
         VMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126202; x=1703731002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK24IycXOInYVKgF6uZXo3NQn/8pUfvRSPTixdneZIw=;
        b=xLyJhHq2HI6DiaGtYiPhN+6Y1LnJetr+0eAZTIThHewQqQpI5jx2vv5CX1EgbvGjro
         GaxdzhPuT5DMTgLJyPg/DaOQJ/9kkLd+IP6tem5DN5L0KiSkpPgh8xUZduE3YSy5CXfP
         pvgpGaw+V+RbsQr+VhZPYYZylffdfvhys+0uR0W6Yb37trMMYyqoTK5Tcb6vfUf5n47q
         m/9cJoy+q0V1gvDLf9HY7PAmVKnbjVbmQmRVLl0rM/69J9hW/WQm58BJtooV+xOkYntS
         QhPrhlSlVp1XQmH2XkwxJAkEBnEQFEOucyVi1xC++oj77HahkfsaAh0JOGqkVIIbGtvl
         fJwA==
X-Gm-Message-State: AOJu0Yztjc8Ud1ds/skWPPyfL4jlsh/sUiE6GD6+/Huy6vj9+wVBnLOz
	oS1niK5FfXWYqnZPXNyVeDc=
X-Google-Smtp-Source: AGHT+IFlDNvLXVrRhAvl/oKREjYejjpQOgBUO5EVcMlNYHLecy8Z7fqTUDReIDeJoJwDSPPNGTnz9w==
X-Received: by 2002:ac2:485b:0:b0:50e:3e41:798e with SMTP id 27-20020ac2485b000000b0050e3e41798emr2535199lfy.111.1703126201516;
        Wed, 20 Dec 2023 18:36:41 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id t6-20020a199106000000b0050e3cb5cf15sm131556lfd.244.2023.12.20.18.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:36:41 -0800 (PST)
Date: Thu, 21 Dec 2023 05:36:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 9/9] net: stmmac: Disable coe for some
 Loongson GNET
Message-ID: <axkfpgoyf2pd76k25563uzd5hfb5gsfr5cqlumn2gezai5xblj@h455tdgbogdh>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <479a6614d1fc4285c02953bf1ca181fa56942fb6.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479a6614d1fc4285c02953bf1ca181fa56942fb6.1702990507.git.siyanteng@loongson.cn>

On Tue, Dec 19, 2023 at 10:28:19PM +0800, Yanteng Si wrote:
> Some chips of Loongson GNET does not support coe, so disable them.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 3724cf698de6..f211880925aa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -73,6 +73,11 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
>  		mac->desc = &ndesc_ops;
>  	}
>  
> +	if (priv->synopsys_id == DWLGMAC_CORE_1_00) {
> +		priv->plat->tx_coe = 0;
> +		priv->plat->rx_coe = STMMAC_RX_COE_NONE;
> +	}

Couldn't this be done in dwmac-loongson.c?

-Serge(y)

> +
>  	stmmac_dwmac_mode_quirk(priv);
>  	return 0;
>  }
> -- 
> 2.31.4
> 

