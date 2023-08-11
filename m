Return-Path: <netdev+bounces-26721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B970778A88
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7065A1C20CFA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69A6AA1;
	Fri, 11 Aug 2023 10:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA863C3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:01:46 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804DC2D66
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:01:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so2263980a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1691748104; x=1692352904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQHY9UG55J+wb0+yWlgj7OFouiQtRrKvLbZqsrBAxIk=;
        b=Vyx8AoDMH904hxVZ/imQw1cOXrDHtZZ2tXgjlsFpnEJom0vUmS3Efis7rooSezH+yg
         8YcnHlH5lOqYJBqEMVu/zflxev9qoogeyTSuApmrzWERrONRVT8ngLg9EWNL1wG0LAFz
         4OIPdaxBHNacN5zHSLbsNs93uLzlu6fP1rKR9MIbgJdRJZAIoL4kcigODBu/OfHY3Eek
         SwlwthTFZes/Z+jkcHl3vMBd474rhhSC1pwZlXmlhaIU7ae72whsTRzPr5Nzk36Z1+R6
         0BS1YiX1O6wIfuQfR1Dhim1wJOkMDefCHoKfW9YG0C2Rup7mf5ym2aEhLCM8MUUzSQGD
         jwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691748104; x=1692352904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQHY9UG55J+wb0+yWlgj7OFouiQtRrKvLbZqsrBAxIk=;
        b=Cs8iEYEn5lqGZ8iYBVrGsIaKrz3ovJR4KE0B0c2J9bMwgV4uyfPkqZJZHDqiyu7Gec
         oJS8NIs/f5NqC5dG9nUyyTXn215txJnLK6Dfngx/Ru2C1EB5IvUpAQnQBwZuMi/ESee+
         rJhyU2VlHgvXH+8O2U3AlRRrV89FxVX2aLOsf5c4Hl/bPpDBZhzCiRHhtt8XIVcMMgxa
         2f87SoorZtrFcanxI3Y4G9v+lK6DeBi/XAZSjkGTZ6i3oCUw98F6PKxP5Na+Rg7w7KHs
         Jklze3eSiol0YrocnnhLvBzsxxKPIfbfnJqRWxzz6mpO/MpAXsKhJKfG72o559q9fml7
         XnOA==
X-Gm-Message-State: AOJu0YyDIoFv52j5yO/uLNAT867WVQxH+lVk6cF30RCvuD/30VFMUVvA
	o4WNulEorqc2Y1i6n/xzOtGhWA==
X-Google-Smtp-Source: AGHT+IHv2udGQ0zfe+fmDYdfWER6dhXcYEv20n/WlH4/Q1P2C16bcodSbmBpuTUfOhqrJvPY5kdC0Q==
X-Received: by 2002:a17:907:2724:b0:993:d536:3cb7 with SMTP id d4-20020a170907272400b00993d5363cb7mr1216227ejl.11.1691748103898;
        Fri, 11 Aug 2023 03:01:43 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090798c500b00982d0563b11sm2030688ejc.197.2023.08.11.03.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 03:01:43 -0700 (PDT)
Message-ID: <95802373-c46a-c998-39af-b2d9ce685626@blackwall.org>
Date: Fri, 11 Aug 2023 13:01:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 2/2] vxlan: Use helper functions to update stats
Content-Language: en-US
To: Li Zetao <lizetao1@huawei.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, jbenc@redhat.com,
 gavinl@nvidia.com, wsa+renesas@sang-engineering.com, vladimir@nikishkin.pw
Cc: netdev@vger.kernel.org
References: <20230810085642.3781460-1-lizetao1@huawei.com>
 <20230810085642.3781460-3-lizetao1@huawei.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230810085642.3781460-3-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 11:56, Li Zetao wrote:
> Use the helper functions dev_sw_netstats_rx_add() and
> dev_sw_netstats_tx_add() to update stats, which helps to
> provide code readability.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



