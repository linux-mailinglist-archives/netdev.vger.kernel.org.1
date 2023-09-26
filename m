Return-Path: <netdev+bounces-36271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7087AEB98
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D77641C2042A
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A726E20;
	Tue, 26 Sep 2023 11:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0C525E
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:39:26 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53346EB
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:39:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5043a01ee20so11582668e87.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695728363; x=1696333163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M/7yykiHRRlT31gWUmkabwEeLWgyFyD6tirZw5/WcM=;
        b=RfHKIjh1890yxF6CuZ4BUG10LJXiwk5nuWP1w5hdRYyKYifw327HXu8n1H7KPmnPtf
         aRUjcU99dhSJAI9/yvYQ30Cvx7GyipTlzfm6+NZAeJ+qom770xyjRAJinqii9InTMcq/
         UnoZ1RDQyk2HLYSdmr4VCrBfiyTmjoyN+HH7nHq+r5Q1w3ebEf6nKrzdELl44hkOSrj+
         3bfnHY1f30IwhVm534E3rt9SjXE1vJgtGeQxN3GpAWZxZDbYnwZ8ds8sC896kvwevZNh
         BoC1sSTC34qyZiBR6t9hm8BTG+0J/piko0sOBuAdqkxuPmIj02JV7sE68QA73uMKwn/g
         HjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695728363; x=1696333163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M/7yykiHRRlT31gWUmkabwEeLWgyFyD6tirZw5/WcM=;
        b=OPQrPntbqwqugxCqoWLo1zBL9lKoR/8iRqRwZ9weNFrtsFBBbGwDhoMnHHnB259Eoy
         Sjd4FqxFZYnd/ZnyY8HBcE1qLsEFBi0nVgPQ+TT/luOvgkyVx/mnaW8+uR3B6Jy5+vnY
         JqPW74q98gkOmXMtY5sRZADufCTaxStcKaWiVwA72FBOd/BgFbZQzecpOIbQW76pXX9d
         5IMG9tpdL39b1PDJ8UUGM09TREI4fArCRN+aIRH213tFRr4KeylndI2TK1Vu1b7trA0d
         ASYH45o5A2E/sN8qqABWFcLj8qjnFx7M53GNyvSGPLj0fdPpkOybXgHBp0tOeujO/2q3
         d04A==
X-Gm-Message-State: AOJu0YyLexfNCCzPGR4WR6OclPBPJH6SaLA0xPqKJmEJIfAi/pRJvBxY
	ugiWBTb5TZjNQjKgL7DczXw=
X-Google-Smtp-Source: AGHT+IEHUB7a112vmGAMr6+iCCj/LvIGcbVsKchJKLgmecYhKLY5F+gMi5LKoelRIEyP1BmAVLEBVw==
X-Received: by 2002:ac2:485c:0:b0:503:28cb:c072 with SMTP id 28-20020ac2485c000000b0050328cbc072mr7432041lfy.30.1695728363377;
        Tue, 26 Sep 2023 04:39:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id r27-20020ac25a5b000000b004fdd6b72bfdsm2160547lfn.117.2023.09.26.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:39:22 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:39:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, Jose.Abreu@synopsys.com, 
	linux@armlinux.org.uk, hkallweit1@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Raju

On Mon, Sep 25, 2023 at 01:21:42PM +0530, Raju Lakkaraju wrote:
> Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> Update the port mode and autonegotiation
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/pcs/pcs-xpcs.c | 31 +++++++++++++++++++++++++++++++
>  drivers/net/pcs/pcs-xpcs.h |  4 ++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 4dbc21f604f2..4f89dcedf0fc 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -1090,6 +1090,30 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
>  	return 0;
>  }
>  
> +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> +				    struct phylink_link_state *state)
> +{
> +	int sts, lpa;
> +
> +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);

> +	lpa = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_LP_BABL);
> +	if (sts < 0 || lpa < 0) {
> +		state->link = false;
> +		return sts;
> +	}

The HW manual says: "The host uses this page to know the link
partner's ability when the base page is received through Clause 37
auto-negotiation." Seeing xpcs_config_2500basex() disables
auto-negotiation and lpa value is unused anyway why do you even need
to read the LP_BABL register?

> +
> +	state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);

> +	state->an_complete = !!(sts & DW_VR_MII_MMD_STS_AN_CMPL);

Similarly AN is disabled in the xpcs_config_2500basex() method. Why do
you need the parsing above? It isn't supposed to indicate any useful
value since AN is disabled.

-Serge(y)

> +	if (!state->link)
> +		return 0;
> +
> +	state->speed = SPEED_2500;
> +	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> +	state->duplex = DUPLEX_FULL;
> +
> +	return 0;
> +}
> +
>  static void xpcs_get_state(struct phylink_pcs *pcs,
>  			   struct phylink_link_state *state)
>  {
> @@ -1127,6 +1151,13 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
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
> index 39a90417e535..92c838f4b251 100644
> --- a/drivers/net/pcs/pcs-xpcs.h
> +++ b/drivers/net/pcs/pcs-xpcs.h
> @@ -55,6 +55,10 @@
>  /* Clause 37 Defines */
>  /* VR MII MMD registers offsets */
>  #define DW_VR_MII_MMD_CTRL		0x0000
> +#define DW_VR_MII_MMD_STS		0x0001
> +#define DW_VR_MII_MMD_STS_LINK_STS	BIT(2)
> +#define DW_VR_MII_MMD_STS_AN_CMPL	BIT(5)
> +#define DW_VR_MII_MMD_LP_BABL		0x0005
>  #define DW_VR_MII_DIG_CTRL1		0x8000
>  #define DW_VR_MII_AN_CTRL		0x8001
>  #define DW_VR_MII_AN_INTR_STS		0x8002
> -- 
> 2.34.1
> 
> 

