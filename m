Return-Path: <netdev+bounces-13172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2FB73A89E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F70D1C20AAB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332C4206A5;
	Thu, 22 Jun 2023 18:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA11F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:54:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1BB9B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687460072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcFPpQeDwI/GvuqShemurkup3+TWysI+P7nO7FR3o9o=;
	b=e9cttiuUsk6BSEyz7R+CBGaLOlvoa6Ljo+gzGhfdoBpYi7+oAN8EK1n3AEIdLAmVy6/0ze
	SvyQLwWhUvfvc8p29x9FEu2dTg6YgkLGElYaWCL47+vUZhptX8iWGXSwmhxMRA2yphlSRR
	rqBEDHTBROVNIlb1dVx2dbQFnp2J2O4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-2r4ro2zkMAGgyXqXyMVnKQ-1; Thu, 22 Jun 2023 14:54:30 -0400
X-MC-Unique: 2r4ro2zkMAGgyXqXyMVnKQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b29075c28eso6215723a34.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460068; x=1690052068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcFPpQeDwI/GvuqShemurkup3+TWysI+P7nO7FR3o9o=;
        b=DOOndagnJrOr0BASWUr++lLPH4XcE3zcxvuxfbkoxI7kx2yrEzgbAmtol5hECcSfDz
         ybfyZX5ae12ZzeAtoGiSxeUAnLQI3Cp/j0BYd0BT2QEhLuVyfgZ57baTBcSpcCZBKFf6
         idwfBjLBthZg+sl3BnsAZDhL0MnXfoTsor4yizcv+JHlzaDGird7pooLjz6y6x0FRcWf
         NnglxRUX7TIoTghQN/wLW00T652uEplY4HwiiFhItlzEBBIt2DQ/5DNCfurqJ0qXrORn
         XtwDBBGN7jlKmyjiSUkP1TTXpoBeFP86Lb40G4+xXZnt04lig3Xn1gNktar6I481xj81
         Qjdg==
X-Gm-Message-State: AC+VfDwAIXZohs6FZ1gRxTOTDPfTvQsPcLDn6J/J92IXJN5fJD9j+r32
	Xwy3sbqpuo1u3aTiKWjE06OhqqHzuSDvQcbsQBpI4YCl9+wwyPWOaIKmJf+Q96OL+PZ9xS+gBm3
	3mSpi4f+fNKE/oU9q
X-Received: by 2002:a9d:7985:0:b0:6b4:27e8:fb3e with SMTP id h5-20020a9d7985000000b006b427e8fb3emr14096447otm.27.1687460068405;
        Thu, 22 Jun 2023 11:54:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uPvTcOIYG9gzSLYiwB8j1p2qMb9rwBj1K/JGUAcjwcI3+cPgyeiiPBlkDDEg+NeB7FiW5CA==
X-Received: by 2002:a9d:7985:0:b0:6b4:27e8:fb3e with SMTP id h5-20020a9d7985000000b006b427e8fb3emr14096429otm.27.1687460068144;
        Thu, 22 Jun 2023 11:54:28 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id d19-20020a056830139300b006ac98aae2d3sm3137110otq.40.2023.06.22.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:54:27 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:54:25 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net] net: stmmac: fix double serdes powerdown
Message-ID: <20230622185425.vfewm2qgxqpndfyf@halaney-x13s>
References: <20230621135537.376649-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621135537.376649-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 03:55:37PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
> stmmac_open/release") correctly added a call to the serdes_powerdown()
> callback to stmmac_release() but did not remove the one from
> stmmac_remove() which leads to a doubled call to serdes_powerdown().
> 
> This can lead to all kinds of problems: in the case of the qcom ethqos
> driver, it caused an unbalanced regulator disable splat.
> 
> Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 10e8a5606ba6..4727f7be4f86 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7461,12 +7461,6 @@ void stmmac_dvr_remove(struct device *dev)
>  	netif_carrier_off(ndev);
>  	unregister_netdev(ndev);
>  
> -	/* Serdes power down needs to happen after VLAN filter
> -	 * is deleted that is triggered by unregister_netdev().
> -	 */
> -	if (priv->plat->serdes_powerdown)
> -		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
> -
>  #ifdef CONFIG_DEBUG_FS
>  	stmmac_exit_fs(ndev);
>  #endif
> -- 
> 2.39.2
> 


