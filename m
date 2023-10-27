Return-Path: <netdev+bounces-44718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900967D95EF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A5B210BF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD01803D;
	Fri, 27 Oct 2023 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg8oaErw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3417995
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 11:04:22 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E6F1B5;
	Fri, 27 Oct 2023 04:04:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507ad511315so2854580e87.0;
        Fri, 27 Oct 2023 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698404658; x=1699009458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHVhkrUd2pzwpv7HO715+G75TZMOXop3CMteyY7H2pM=;
        b=gg8oaErwJxuLUr47k6gTjL3U6tjUtVGYoYvTCO3jdhRvO6J7GX/D4bNA1NwFXeLuo2
         KfvcmM7E3kCgZAS3Q9jQ1OOkCHxBlYJhXyB31pYH+fNQ7JlbTv5sWpMIDdDgCCUX5jiC
         6smK8DTLu3GZoKddFhVVAogGYEnlPkkmsSO1xWATItlGFmdcRm1g02q7Zg1fs8+hIQy6
         UElbVoqFNMgoZbRTOWVzJoLt8I2oL7VKBcfMomlHiYdAWrIhihyRom8f6K5x8XuYr/Dn
         gebWoJxLwnuuwIdZppUNI37v0nmLNQPoAPMVnKuZamZShr2DgrhpyPqWy7G0RcQMFiE+
         PS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698404658; x=1699009458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHVhkrUd2pzwpv7HO715+G75TZMOXop3CMteyY7H2pM=;
        b=HkaP4LSHKXPWurF4j3xGumXjD/kR8hLcd6jLI/Spq16N8YiTN1Nvl+GGilk2l0Fgha
         PhwXSGxFuGwBDzYEfrdOOMLv1ZOC68iHqkdtsxFNq6QNqHopxPKg2e43MEK6idBgoJAi
         Thh8dHy0XmnBCEHLwmJyXadiLCCLs31GKFM/DkX+gXI1WarPgTfmr04zS3lmP6vqHiRY
         LK1g92rliD3M9Byg2PLW2qy++gd+73pEXR84p1yrqpeQWvO90SXoRqJiyebunucP8KG3
         7g4+y9MB2ZR/mIQAu9ao+Uc7aaGVtWIjP/FZ4HLgi7isTKVdDkiQPSvnG/izH09nM4qu
         fMeg==
X-Gm-Message-State: AOJu0YzstuvNZ4YaBdA4+awYjoiUReog8rkGeP4Zl8/lpUrnP1PtOHrH
	n2lkIz659XLDxyURjhln+yI=
X-Google-Smtp-Source: AGHT+IEtb4zx4ZsRBKWIqJrw273/BIGGksFXKsh47T9w3Ng/1nC9ZgEn7KXE2+09nod7XzvF0QFwWg==
X-Received: by 2002:a05:6512:3b10:b0:507:96a3:596d with SMTP id f16-20020a0565123b1000b0050796a3596dmr1678382lfv.49.1698404657652;
        Fri, 27 Oct 2023 04:04:17 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q4-20020a0565123a8400b00507a3b8b008sm235755lfu.112.2023.10.27.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:04:17 -0700 (PDT)
Date: Fri, 27 Oct 2023 14:04:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch, 
	Jose.Abreu@synopsys.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ghpmbmfjps24x7xvojk4gbkl55wjcuufd4v6mz6ws5htv35g2b@ugqsbet7t73p>
References: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>

Cc += Russell

* It's a good practice to add all the reviewers to Cc in the new patch
* revisions.

On Fri, Oct 27, 2023 at 10:13:06AM +0530, Raju Lakkaraju wrote:
> Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

With a nitpick below clarified, feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> ---
>  drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
>  drivers/net/pcs/pcs-xpcs.h |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 4dbc21f604f2..31f0beba638a 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -1090,6 +1090,28 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
>  	return 0;
>  }
>  
> +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> +				    struct phylink_link_state *state)
> +{
> +	int ret;
> +
> +	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> +	if (ret < 0) {
> +		state->link = 0;
> +		return ret;
> +	}
> +
> +	state->link = !!(ret & DW_VR_MII_MMD_STS_LINK_STS);
> +	if (!state->link)
> +		return 0;
> +
> +	state->speed = SPEED_2500;

> +	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;

Why is it '|=' instead of just '='? Is it possible to have the 'pause'
field having some additional flags set which would be required to
preserve?

-Serge(y)

> +	state->duplex = DUPLEX_FULL;
> +
> +	return 0;
> +}
> +
>  static void xpcs_get_state(struct phylink_pcs *pcs,
>  			   struct phylink_link_state *state)
>  {
> @@ -1127,6 +1149,13 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
>  			       ERR_PTR(ret));
>  		}
>  		break;
> +	case DW_2500BASEX:
> +		ret = xpcs_get_state_2500basex(xpcs, state);
> +		if (ret) {
> +			pr_err("xpcs_get_state_2500basex returned %pe\n",
> +			       ERR_PTR(ret));
> +		}
> +		break;
>  	default:
>  		return;
>  	}
> diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
> index 39a90417e535..96c36b32ca99 100644
> --- a/drivers/net/pcs/pcs-xpcs.h
> +++ b/drivers/net/pcs/pcs-xpcs.h
> @@ -55,6 +55,8 @@
>  /* Clause 37 Defines */
>  /* VR MII MMD registers offsets */
>  #define DW_VR_MII_MMD_CTRL		0x0000
> +#define DW_VR_MII_MMD_STS		0x0001
> +#define DW_VR_MII_MMD_STS_LINK_STS	BIT(2)
>  #define DW_VR_MII_DIG_CTRL1		0x8000
>  #define DW_VR_MII_AN_CTRL		0x8001
>  #define DW_VR_MII_AN_INTR_STS		0x8002
> -- 
> 2.34.1
> 

