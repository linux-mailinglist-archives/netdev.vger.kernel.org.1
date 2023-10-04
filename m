Return-Path: <netdev+bounces-38062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E17B8DC1
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 345A72817AF
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2A224C4;
	Wed,  4 Oct 2023 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cadyVwEi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E52219E9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:00:13 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CECAB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:00:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c87e55a6baso1156335ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696449608; x=1697054408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ap9v2/olcKGyDJBva73j5fNeLRwk/nHTTkPfYp92Z2w=;
        b=cadyVwEikhzIducOaWVRBIJFZ1eQw7a3sVbQWajefy9g2SqryOvJYE9rnOwxE5v6uF
         wdY6lWNW6aoLHvr1ygVN1e1jobH/wqhILuXdCPARMLH4fjIyBB4+gFTKZiFOyhKQ27lH
         a0En1Ae0E6bhXT5jCEbQgVVOA2EelFdNM2bS4lslBD1xJ9EJpmvIgyKFy1p/ncedc7CI
         ddklrpJKI13dGQkYipyWAJcln7yQBB5acO5+B1/qt9w2UMB0iKWFmoEcrUqJx/DpbgFT
         AEVhNOu8N81dVyJms70ljZJZB+m9SCGcWGpne4MenhjrSxjD9ZgKna6bjtn3Bv1wdM9m
         5zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449608; x=1697054408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap9v2/olcKGyDJBva73j5fNeLRwk/nHTTkPfYp92Z2w=;
        b=Xx0Vxnu9B4oLN5tNVGTwxU2g/icRpX4OGaaqehbBZbtutJGTDyzEEug/59hSg+MP1r
         Z4Prv8SwpL91OQpKEaedG6qowEk8nlYb72OYvwdEA+9VnO4ko2LTgoqYMlaNR07J1om9
         QCyDE4BaQ35okvId5x+/LSfwhRM52Bted2GLUpyA+YW+5I/vqM+gWoR8K89ZHFHRSW/5
         xOCXfX9uXQjElTEV6qTyB7n9/aRjg+PVCeiRQma/3Yv34G5GzY6f5gXFsQ5xG86oxm8d
         EOWaWYoaII1VgxsZemHxMa4GaMP9pciZzW+b936GRS6eq94roAJ0D2XoXSDLAcv8NZw0
         KU7g==
X-Gm-Message-State: AOJu0YxmWZlWzBAPHzZAXlJQISjqYxqLJzLRfKuWkrcBqQVH+uIkrbkx
	Mp3jnE+adV6sCGFBmISbiQ79Rv6l9MQ=
X-Google-Smtp-Source: AGHT+IHYC4jt43Gfku5aZSNDpR07NTDay27HY62vg6gt6GiG9D1S0+ovBRiEpFsdKaryVQlPB403FA==
X-Received: by 2002:a17:902:db04:b0:1c6:2acc:62f3 with SMTP id m4-20020a170902db0400b001c62acc62f3mr4249797plx.9.1696449607653;
        Wed, 04 Oct 2023 13:00:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d1-20020a170902b70100b001c5de06f13bsm4113787pls.226.2023.10.04.13.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:00:07 -0700 (PDT)
Message-ID: <643c55ca-4eca-4dfc-9176-cf46c2504057@gmail.com>
Date: Wed, 4 Oct 2023 13:00:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
Content-Language: en-US
To: Shenwei Wang <shenwei.wang@nxp.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev,
 Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
References: <20231004195442.414766-1-shenwei.wang@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231004195442.414766-1-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/23 12:54, Shenwei Wang wrote:
> Some i.MX SoCs like the i.mx8mq support adjusting the frequency of the
> DDR, AHB, and AXI buses based on system loading. If the dwmac interface
> in the driver does not request a HIGH frequency, it can significantly
> degrade performance when the system switches to a lower frequency to
> conserve power.
> 
> For example, on an i.MX8MQ EVK board, the throughput dropped to around
> 100Mbit/s on a 1Gbit connection:
> 
>      [ ID] Interval           Transfer     Bitrate
>      [  5]   0.00-10.00  sec   117 MBytes  97.9 Mbits/sec
> 
> However, throughput can return to expected levels after its driver requests
> the high frequency mode. Requesting high frequency in the dwmac driver is
> essential to maintain full throughput when the i.MX SoC adjusts bus speeds
> for power savings.
> 
> Signed-off-by: Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Tested-by: Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>

I assume that you cannot go full dynamic and adjust the bus frequency 
based upon the negotiated link speed? There may be a need to adjust the 
bus frequency prior to starting any DMA transfers, otherwise dynamic 
frequency scaling of the bus may cause all sorts of issues?

Regardless of the answer:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


