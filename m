Return-Path: <netdev+bounces-41823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6C7CBF91
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3AD1B20F3D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3F405C4;
	Tue, 17 Oct 2023 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qlMWVsL7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6E3F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:38:29 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FAFD
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:38:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso3088315e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535506; x=1698140306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqCV5LqZDY4T30FG9NmOwtVcZeBjFLF9lkkidQOM+jY=;
        b=qlMWVsL7VL0jxScFwUCRTFtgN82YH7ll0lY+OTq27AVDcTfNH5laC3pkXQB9IGYRzn
         Db0IK7Z0nRxKPaWE+s2qSbRYSMWdRHzdrAWvaiFOr4ShMCCI64Bvh3XvyCFkqtJWiHWJ
         x+HBM7Bdxoab3/CimdfhwfKjqy7Dw7yZVKKGGGGp11EC5UpykSr23HcpaJVBzBqHwWHl
         j/zmsmfbDu+3evhqgYAe9x9m99yV/1VbVieBMJHnbUSdZFGjieHHV+aBGYR6VxK7E1cA
         4PhEwSPs2Pwlb/b3zonw3VJuY1pFXXI4eDNoVdxySDx4kWtSBucySBWRHohDO9IPONXg
         k8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535506; x=1698140306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqCV5LqZDY4T30FG9NmOwtVcZeBjFLF9lkkidQOM+jY=;
        b=bsxDvi6zr1xMZ6Gymh4n6+JRsduFMSV8o1h2t2PRw3sF4zlqmPxW1VD7/63nLsg9C3
         VCdtU0vW90xSrONMdr4jY2WAT0J7BBNbI45kkYimXcuG5gHTbLRu0NyO09vzG/dp0ZMp
         a/gBlpnH+0h3lcoGlp28o//lm2ZdVm6/nqOLADXPkrRqGwR9vjYK/bGk0ml6OmbRSL2h
         6tfNgJ4/T3EE6ueUVjIXro9K14+BMAixDpkQUw91Kr8hPLgm39XwOWOt5xjDz8n+NdRl
         vjiiSqGw8dgfjvqxUa+H9SMPhRIuIm8JYEI0FY2X3PIX6iW74LGYdjLHbtvtppSO3Kqc
         yZMA==
X-Gm-Message-State: AOJu0YzlPX2DAVjEbUKmbnUQBy0TO+i+Ir3KEkv5ZZsfLAVGfvmQ64el
	hP+uypocUKYnaI9YtIz5/jYVcQ==
X-Google-Smtp-Source: AGHT+IHgOnXtOhJbynk+xCHDf9BYs89rMvwnySxvRuVZGp3aBrsgU/YVYkaSKX/rbcTvp/3Cec4rsA==
X-Received: by 2002:a05:600c:1d26:b0:406:7021:7d8 with SMTP id l38-20020a05600c1d2600b00406702107d8mr1299777wms.20.1697535506116;
        Tue, 17 Oct 2023 02:38:26 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b004064741f855sm1388778wmo.47.2023.10.17.02.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:38:25 -0700 (PDT)
Message-ID: <5ca6538a-044f-f7f6-65c7-e7c02b720554@blackwall.org>
Date: Tue, 17 Oct 2023 12:38:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 5/8] bridge: fdb: support match on
 destination port in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-6-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-6-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Extend "fdb flush" command to match fdb entries with a specific destination
> port.
> 
> Example:
> $ bridge fdb flush dev vx10 port 1111
> This will flush all fdb entries pointing to vx10 with destination port
> 1111.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c      | 21 ++++++++++++++++++++-
>   man/man8/bridge.8 |  8 ++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



