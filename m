Return-Path: <netdev+bounces-42341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDF7CE5D3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7021281BD9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9B3FE3D;
	Wed, 18 Oct 2023 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccn/f5GY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D4C14F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:04:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798D10F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697652268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNX9ozbgtkYe/902nvplA8K4eAYG6mgmEEowb1wlWxM=;
	b=ccn/f5GYzHK3l3plpy8J7oRAqQEM5Vx4IrKEcYDliacufV7OGcV8rWu7swIqnbaj4gO594
	Z7whkrQMJxgPJH9plqpPhP5wwv6VNaVXQULU/G0oM6/32uksg0rL0yBRNt1ttrsA2PY2rZ
	HBBfHkOjt2/3vn4r+jEyqH0aMub6+tc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-LUayS5WOPIuYM7-7_t8Cdg-1; Wed, 18 Oct 2023 14:04:26 -0400
X-MC-Unique: LUayS5WOPIuYM7-7_t8Cdg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d155fc53eso83082246d6.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652266; x=1698257066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNX9ozbgtkYe/902nvplA8K4eAYG6mgmEEowb1wlWxM=;
        b=b4Y+Ywq6j653PyefsuCj4glJ+SzdY0bsY4K8EYQIs9KtiEhRwMAuXC1SMmL7B4pi2Q
         AD4szmT/+rj7p1QUKgvJvfI1n4a+VtbphyckzVettfrXw8garJe2gx0dRIbRC8xTXcu9
         Fjfo86K1xnDAmli50zsDO0bZK+3WNQki78uk3402MK5+ZOOroUGr9eSYzxL5h9VwaFGK
         4D4LOG4Q98BkFf5ULfQOahU44wcgFc8RbuOT7iMKsCZB29l4WEFxZODZGiC/216opOuV
         PvOnunaoX/Wm7/Eoapx5EnSt7CksnMmp/aagm0wAD9gMyaAdLawk1e6RkSY2MRp+tRmv
         yXDw==
X-Gm-Message-State: AOJu0Yzuu+ap5QmJErhzsBXYdKEjjj+Q3m/cpeIno/9G6L5kpkgQAzZe
	O/hUrhhiosAREz/fgGkyfcTlBfudNJMBTg0EpmO7hpno6fI3aKPG17I56NlEG34A2Boh5eFoSbp
	btHhSd64kd2PNwMtg
X-Received: by 2002:a05:6214:d6f:b0:66d:2eb6:f3f6 with SMTP id 15-20020a0562140d6f00b0066d2eb6f3f6mr6947765qvs.32.1697652266312;
        Wed, 18 Oct 2023 11:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7r9g/qf8M8D2pt4ix0jigNXIfJ7i7p7JdUBou8gXLcKPUUtGgDEa3SJxF8BWKbyqCqnVUHw==
X-Received: by 2002:a05:6214:d6f:b0:66d:2eb6:f3f6 with SMTP id 15-20020a0562140d6f00b0066d2eb6f3f6mr6947734qvs.32.1697652266044;
        Wed, 18 Oct 2023 11:04:26 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p5-20020a0cfd85000000b0065b2f4dd300sm127154qvr.90.2023.10.18.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:04:25 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:04:23 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	patchwork-jzi@pengutronix.de, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	vee.khee.wong@linux.intel.com, tee.min.tan@intel.com, rmk+kernel@armlinux.org.uk, 
	bartosz.golaszewski@linaro.org, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/5] net: stmmac: simplify debug message on
 stmmac_enable()
Message-ID: <vkf6xerp5o7owkvvlbxvd6hkzaj7mml6yutrpaxyowcryh3nlu@qeourmcxk5x3>
References: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v2-1-51d5f56542d7@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v2-1-51d5f56542d7@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 09:09:53AM +0200, Johannes Zink wrote:
> Simplify the netdev_dbg() call in stmmac_enable() in order to reduce code
> duplication. No functional change.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> 
> ---
> 
> Changelog:
> 
> v1 -> v2: no changes
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 1be06b96c35f..f110b91af9bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -203,14 +203,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>  			/* Enable External snapshot trigger */
>  			acr_value |= priv->plat->ext_snapshot_num;
>  			acr_value |= PTP_ACR_ATSFC;
> -			netdev_dbg(priv->dev, "Auxiliary Snapshot %d enabled.\n",
> -				   priv->plat->ext_snapshot_num >>
> -				   PTP_ACR_ATSEN_SHIFT);
> -		} else {
> -			netdev_dbg(priv->dev, "Auxiliary Snapshot %d disabled.\n",
> -				   priv->plat->ext_snapshot_num >>
> -				   PTP_ACR_ATSEN_SHIFT);
>  		}
> +		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
> +			   priv->plat->ext_snapshot_num >> PTP_ACR_ATSEN_SHIFT,
> +			   on ? "enabled" : "disabled");
>  		writel(acr_value, ptpaddr + PTP_ACR);
>  		mutex_unlock(&priv->aux_ts_lock);
>  		/* wait for auxts fifo clear to finish */
> 
> -- 
> 2.39.2
> 


