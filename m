Return-Path: <netdev+bounces-29001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD6781602
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EA7281DE4
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40391367;
	Sat, 19 Aug 2023 00:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E8362
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:27:54 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E906C3A96
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:27:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso978036a91.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692404872; x=1693009672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4y78t2PcfVSI0uWqT7L6YaeE7wD8324eeatoLlTQQzc=;
        b=N2HNm6QF5i8Fs1LsdtLl2KDnXOx/ntWTLjvJLgdtMXHnJ3+FgJdKN3FFkmpi9cBgKi
         hW/ke8rE2pvdZeBlBoLY+krJE1MTNto+UO47Gc4zYxisMciHkQdqZCG+k8LGdm1cJB+7
         FWE1oaVpbz7uJNHah2muTa0g+hZtK4Bmztzt2lYjjZ6276Doni7JhWFfLFnZFu5cO0tW
         txcjyHnNoFToJOhPk5vswB8idE1lZ8wwBypYoNvcGCCgtasQFp1SPFOezoa9ku3+JcnI
         fyRCQgzO8tBjVghGiUHlPlx8spq3QsP2x/PbcdyEHzmIrW2IOIP5FoFXKzwXAGwjWzSZ
         CzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692404872; x=1693009672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y78t2PcfVSI0uWqT7L6YaeE7wD8324eeatoLlTQQzc=;
        b=kw76c+UbkPxD9sskM410K2xgxqlDW4DA7i0HGJPDsosoyGUJL2R3wPRJrt7eaWaB6S
         Ypm7wxIum+mlmyWGVT+l1Z5KQqPVnO3L/jdHSFIsfE1iM7VFcl4hQ8tR5kBKq478rs0i
         OHhSqrWzfq0lZwCCarqZpPa0xMOuYYQ5l9zno7Wlm4gOB9/tn+QFyTPgyVfoUU2z15OA
         6x4tTMuqf7k0JLIrfIV1O9yfoy06mF6gKbvjtA+XySbPZdTkGWynoGQU+1JS4ft13zT8
         +MM7O2akRltl6nhkyFjkkKtbyq4O1J8SY0P9BiaeVCBo17KHddfptzjeKVOUWKazMaos
         ryNQ==
X-Gm-Message-State: AOJu0YwMy9ZgUl50CRUXw9OHnNwa4CIbZ9mBTV4jTCgFppoiJB9TktBE
	AyAu1bbWsbZGK7rZI+f1Wb8=
X-Google-Smtp-Source: AGHT+IHX8QqyuIJLRdKddWdaY2bpTXYeHX1EN6t2ksVkV3VMKqUwV2zPeqnedaHxcIAPI883+ueiTQ==
X-Received: by 2002:a17:90a:8d0a:b0:26b:1269:d801 with SMTP id c10-20020a17090a8d0a00b0026b1269d801mr635567pjo.14.1692404872187;
        Fri, 18 Aug 2023 17:27:52 -0700 (PDT)
Received: from [10.69.40.148] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c1d200b001b9be3b94e5sm2328841plc.303.2023.08.18.17.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 17:27:51 -0700 (PDT)
Message-ID: <0ae6118c-59e1-4b9d-b4a7-270c69390f37@gmail.com>
Date: Fri, 18 Aug 2023 17:27:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] net: bcmgenet: Return PTR_ERR() for
 fixed_phy_register()
To: Ruan Jinjie <ruanjinjie@huawei.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
References: <20230818070707.3670245-1-ruanjinjie@huawei.com>
 <20230818070707.3670245-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20230818070707.3670245-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/2023 12:07 AM, Ruan Jinjie wrote:
> fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
> etc, in addition to -ENODEV. The Best practice is to return these
> error codes with PTR_ERR().
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v3:
> - Split the return value check into another patch set.
> - Update the commit title and message.
> ---
>   drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Doug Berger <opendmb@gmail.com>


