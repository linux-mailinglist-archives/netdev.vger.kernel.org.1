Return-Path: <netdev+bounces-41829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E017CBFB5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E932281671
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D20405D9;
	Tue, 17 Oct 2023 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="lR1lDhVS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793393F4D1
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:41:29 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0A187
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:41:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40806e4106dso2003375e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535686; x=1698140486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1HhjSFJ3PcXQuOnajVqbB+EruV5a4SO5sIW1LuSBTE=;
        b=lR1lDhVSYR0YcXZMNehKGexSafwCCOODFIB2FcHpWYNAjt+sBRivdcwg0BUc5S32aH
         mwss3/C/0eQ/kx0Sldt37GHGJTFVzKxpnfq5U8HnqPQim9a0zySgc3uHGalxlPmP3i+k
         DziZ1CC/LKqMuoklqj1+PJbIGejq2jkS7y4xR9CSRpDOmsC3WIOJZRSkVQsvYlr//VZ0
         zfjLCIf6cEOr2EIJeB/qd1tGztXt2SukoU9ZqjItUxno9PaOF1S1EgmwXSwf5ojFxAum
         sAfbodzywWWNCY2BMpiQzyGJSqHb085ZXc5L5dEB9XvMw7w7BlXnBSIiyqwefpkyQ095
         Bh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535686; x=1698140486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1HhjSFJ3PcXQuOnajVqbB+EruV5a4SO5sIW1LuSBTE=;
        b=pPU6fkvXlx0txmbGx9vSR/uy5D2rsQShPWgZq0G4U2EANMEO+2cldQ9q8i0gXr5U6H
         NB1mLwnPiRx3tfyIrV/MCoVp10iIG8mqKYscGCCZ7NN96tEgy2kAuhhrNCaWdKGYwVMJ
         opJIVsfdCMdHxSiyZ1t63wjYidrnpbgszmGnqr+IlnDLcsamQOC4lizkeyPe9J8Sm4FM
         yZJ4W3mb1mwWakM1+B6pjfSmGN/j49wMvCDWJ2vA5yS2z+rJ4l6KfS2ILNTdZVUO6qXv
         c0vck1R/3CrLwBaR189ivAy/yJsrZxnZl0aHIRGlrhiDioWGOrv4Mzf57ES7dnoTXOCz
         khkA==
X-Gm-Message-State: AOJu0YzZuMCmyC19oWKDxa0ENqibCg+r9b+TRtPehYvMy4grN2vA8Mr2
	H9ZeoUGjEQRMkdberP6QjHU8IQ==
X-Google-Smtp-Source: AGHT+IGaj8hYNwU3ROY6IbiYLG3Pom+cp0Ac5uomcY/fsuNGmWSxNDCGTLtVJy1Q0cHFPbw/h7N5YA==
X-Received: by 2002:a05:600c:a47:b0:401:b92f:eec5 with SMTP id c7-20020a05600c0a4700b00401b92feec5mr1209058wmq.9.1697535686013;
        Tue, 17 Oct 2023 02:41:26 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b004065e235417sm9255615wmk.21.2023.10.17.02.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:41:25 -0700 (PDT)
Message-ID: <3f6f13c7-f8aa-c60f-49f2-fe22d3777f23@blackwall.org>
Date: Tue, 17 Oct 2023 12:41:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 8/8] man: bridge: add a note about using
 'master' and 'self' with flush
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-9-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-9-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> When 'master' and 'self' keywords are used, the command will be handled
> by the driver of the device itself and by the driver that the device is
> master on. For VXLAN, such command will be handled by VXLAN driver and by
> bridge driver in case that the VXLAN is master on a bridge.
> 
> The bridge driver and VXLAN driver do not support the same arguments for
> flush command, for example - "vlan" is supported by bridge and not by
> VXLAN and "vni" is supported by VXLAN and not by bridge.
> 
> The following command returns an error:
> $ bridge fdb flush dev vx10 vlan 1 self master
> Error: Unsupported attribute.
> 
> This error comes from the VXLAN driver, which does not support flush by
> VLAN, but this command is handled by bridge driver, so entries in bridge
> are flushed even though user gets an error.
> 
> Note in the man page that such command is not recommended, instead, user
> should run flush command twice - once with 'self' and once with 'master',
> and each one with the supported attributes.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   man/man8/bridge.8 | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index f76bf96b..ee6f2260 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -943,6 +943,11 @@ command can also be used on the bridge device itself. The flag is set by default
>   .B master
>   if the specified network device is a port that belongs to a master device
>   such as a bridge, the operation is fulfilled by the master device's driver.
> +Flush with both 'master' and 'self' is not recommended with attributes that are
> +not supported by all devices (e.g., vlan, vni). Such command will be handled by
> +bridge or VXLAN driver, but will return an error from the driver that does not
> +support the attribute. Instead, run flush twice - once with 'self' and once
> +with 'master', and each one with the supported attributes.
>   
>   .TP
>   .B [no]permanent

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


