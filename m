Return-Path: <netdev+bounces-39294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7F7BEB8A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF65281261
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA63FB0F;
	Mon,  9 Oct 2023 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdZe5CdH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477863FB03;
	Mon,  9 Oct 2023 20:20:49 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B12D8;
	Mon,  9 Oct 2023 13:20:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5db4925f9so36272215ad.1;
        Mon, 09 Oct 2023 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696882847; x=1697487647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpg72YaeEbhD8qqGKD/9GLa/AWvasFLObLtVomu/POM=;
        b=VdZe5CdHkvR6WzRQjR0hXGBlcUGxVlT/RQ4j9kVnoRunQjCAe0/8soY7xdgvcPWruW
         lZuffhKfI5QD4/25n62nffNf1yaGdYBmBJ3UGGupj6TMlCjZiO1saSeRjs+n9/jFAofE
         Muje7U2HI0y70wB93dyNofVI4p3SNtfvJSKwZ7nA3ELYwxsbW8ZMEWYndOMkx7xYjc/j
         A6qWC1469o8EO5ute5M9j63rKqRJWlzGpAOUaI/JkePcTGpFe27n8IRkj1PVj9FtnNb4
         0Eb3TDo6wVyL0FhyZm2nt6WGLByVSWihtPrSaHRi97Goi7qmXvTHygOyg52K8o2oOlVh
         fqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882847; x=1697487647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpg72YaeEbhD8qqGKD/9GLa/AWvasFLObLtVomu/POM=;
        b=fW71pdTveOR1O60MLUmFDXtcIg8VD4QDeGDTG5drn2TqSZ9v5r590QWyEFGyjAOKRD
         HEqZRBzS4IwcfrqpXymUPhVVC9BUMUTVyhoXuADAWXJPZFclnrvgJZj9vmP9K+oTPeL2
         zgQEvwvdI7fxq/70e/rRVhuMvlPLqKFfp0xvzhqEZHy4vFwW0o4uHtcUx8wnAC3e8MiG
         7RC4OWhZ1+lT1LWzE8mOLRPMMX8NlO/Xji0T8PH6pst1El7woc4Etw6aSsPKiTDjmtNP
         xGCKP8YlNuirENMTDrhrQvKpHoHjrPfCsYjjnmavHyqOSK0rlAtXRhY5d+vQN9YsPnTR
         VxMA==
X-Gm-Message-State: AOJu0YxkQIIz9g6OLRgC3cfr6D754jHolBFeu34H+IN2cOn8GKRumuc/
	1WDOfOef4RUK/FrN4L0eaqU=
X-Google-Smtp-Source: AGHT+IHXSQqFwyjCffsAEU9BeiEBGB1exh4hMwYC5bQyXYsrHD8qEI50+FFMYhcbkR/s2GpQ6zMjlw==
X-Received: by 2002:a17:902:db11:b0:1c3:432f:9f69 with SMTP id m17-20020a170902db1100b001c3432f9f69mr23329345plx.23.1696882846684;
        Mon, 09 Oct 2023 13:20:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d11-20020a170902cecb00b001c73d829fb7sm10098259plg.15.2023.10.09.13.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:20:40 -0700 (PDT)
Message-ID: <995341e0-d2d7-451e-bd8b-0741cb98bcff@gmail.com>
Date: Mon, 9 Oct 2023 13:20:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine support
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git@amd.com
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 12:32, Radhey Shyam Pandey wrote:
> Add dmaengine framework to communicate with the xilinx DMAengine
> driver(AXIDMA).
> 
> Axi ethernet driver uses separate channels for transmit and receive.
> Add support for these channels to handle TX and RX with skb and
> appropriate callbacks. Also add axi ethernet core interrupt for
> dmaengine framework support.
> 
> The dmaengine framework was extended for metadata API support.
> However it still needs further enhancements to make it well suited for
> ethernet usecases. The ethernet features i.e ethtool set/get of DMA IP
> properties, ndo_poll_controller,(mentioned in TODO) are not supported
> and it requires follow-up discussions.
> 
> dmaengine support has a dependency on xilinx_dma as it uses
> xilinx_vdma_channel_set_config() API to reset the DMA IP
> which internally reset MAC prior to accessing MDIO.
> 
> Benchmark with netperf:
> 
> xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t TCP_STREAM
> MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
> to 192.168.10.20 () port 0 AF_INET
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 131072  16384  16384    10.03     915.55
> 
> xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t UDP_STREAM
> MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
> to 192.168.10.20 () port 0 AF_INET
> Socket  Message  Elapsed      Messages
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
> 
> 212992   65507   10.00       18192      0     953.35
> 212992           10.00       18192            953.35
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
[snip]
>   /**
>    * axienet_tx_poll - Invoked once a transmit is completed by the
>    * Axi DMA Tx channel.
> @@ -911,7 +1036,43 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   	if (!lp->use_dmaengine)
>   		return axienet_start_xmit_legacy(skb, ndev);
>   	else
> -		return NETDEV_TX_BUSY;
> +		return axienet_start_xmit_dmaengine(skb, ndev);

Did not notice this before, but should consider using a separate set of 
net_device_ops with a different ndo_start_xmit() implementation, rather 
than add another layer of indirection here.
-- 
Florian


