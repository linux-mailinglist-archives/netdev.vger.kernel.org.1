Return-Path: <netdev+bounces-41716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F587CBC06
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4FAB20FC0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDF1802E;
	Tue, 17 Oct 2023 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFMlXOcX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3990154AD
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:08:55 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086FD107
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:08:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d81864e3fso4341814f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697526532; x=1698131332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SMTzyUYfH68EFfxexPez2GjT/770kAsTojVH/zwF7M=;
        b=DFMlXOcXSz3oDqJRtGCmshZ2j8yI7GgkPaL8jJCTTor2XlPNYeGVXdfwEdwF2mz4CD
         Z5l0B+pxd4N8QI4cUfrfM+VHawOldbahWI0pSP/f4kba5dLRRrGuJEtLy9WNRMT5JzZ6
         FBLn5oChc5tw2m3JB4vS/w83Cm1Kp94Zd0mEqipoNjajw+T0I3zlU1Tap5WkBMaUwiSI
         Yk/riBpqEQaN/D+KL/QN3wTA/lM71ZD9fM0DID+tGpElf8oAhQe2ESWM+ll/KWjJb6dY
         YGD+9hfY/Ez2KqoTy76K3LrVJbsoehEypezihP7pTVUmroA/h9Bhyr1O27T4n7/S6506
         j5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697526532; x=1698131332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SMTzyUYfH68EFfxexPez2GjT/770kAsTojVH/zwF7M=;
        b=w/HJRVAFUjgqCYFfHelaX7sqmj6me3eBfaLhxfsoIkemnO2kr6zBLvY6+kBXF411xF
         fs6FtXYLL1Es9I37m2XG9kmkG+LrBU7OKW07YG7I+2kcojZJyLmT/vJFt2sGxrBHZEWM
         yOuiYYGJGGRlhGLEIxdGO3W00/Lqj/IF/ipBhuLmudL9O7TB90bs1PwUjQ7Iypw9AdxP
         NTIerjyFMjPYWVxHKT9xO/s76T9v5yo41XJ1V5SEjbzRiS/XyAeJQnriONIHUr0HbBud
         /eaMyRDLsxPOU/OeYl7BWgZJNcVnLL2ATlEV+07o4xCdSPk4CM+B15YopIYD8jpz64/0
         2SiQ==
X-Gm-Message-State: AOJu0YyjfqKs3cUbCByM8ZucDRQMzsBzQk7hjRghGaJli3vJ5Ufpn4NK
	IoPT20xUaZ7HsslBWX3VJx2q9Ti1vBI=
X-Google-Smtp-Source: AGHT+IEHT2yYnme9zoF6piudmYc2wE9aY9JRGh619lyf957U7b7+RfHBVvnb/R4KUTKGicJTv5DCmg==
X-Received: by 2002:a05:6000:508:b0:32c:d7e6:4054 with SMTP id a8-20020a056000050800b0032cd7e64054mr1120817wrf.53.1697526532159;
        Tue, 17 Oct 2023 00:08:52 -0700 (PDT)
Received: from [192.168.0.101] ([77.126.80.27])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b0032ce54bacb1sm1009268wrr.0.2023.10.17.00.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 00:08:51 -0700 (PDT)
Message-ID: <3ace1e75-c0a5-4473-848d-91f9ac0a8f9c@gmail.com>
Date: Tue, 17 Oct 2023 10:08:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/14] tls: also use init_prot_info in
 tls_set_device_offload
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 ranro@nvidia.com, samiram@nvidia.com, drort@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, gal@nvidia.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <cover.1696596130.git.sd@queasysnail.net>
 <6da95c0d469415ee62cc23ce72227f8d058400bc.1696596130.git.sd@queasysnail.net>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <6da95c0d469415ee62cc23ce72227f8d058400bc.1696596130.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 09/10/2023 23:50, Sabrina Dubroca wrote:
> Most values are shared. Nonce size turns out to be equal to IV size
> for all offloadable ciphers.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>   net/tls/tls.h        |  4 ++++
>   net/tls/tls_device.c | 14 ++++----------
>   net/tls/tls_sw.c     | 14 ++++++++++----
>   3 files changed, 18 insertions(+), 14 deletions(-)
> 

Hi,

FYI, we caught some new failures in kTLS device-offload traffic, 
bisected to this patch.
We're trying to collect more info and analyze...

Regards,
Tariq

