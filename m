Return-Path: <netdev+bounces-41820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493947CBF89
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3881C20A10
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD73FB2E;
	Tue, 17 Oct 2023 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="v8ef7E2Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7C3F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:34:52 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B8E8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:34:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9338e4695so71131121fa.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535289; x=1698140089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Luo9wr24H4AGCwJOTFfUcS8sRYYgRVeO3qF+A+b57H0=;
        b=v8ef7E2Qti3wq8ZDBRdItq0GTMw62Is/3iICKRnjQ32l9AHu+xdAsFjdoyrmQ6ScZs
         etCA3r8RQAcIecjksfpksHI/+LAoGOGtB0KU0B7B/qaaFv7O8UA79SPtrk83PQF3/tTG
         XX8nq2spN2KqBsPyeXeEB7+kezb3IdE0P7Ac/6YGM/R4LIYdwL5YYg6FWocQGaWrh8Wx
         HK5roPOa9hcNxHbJsPzpfOPGnagJeKo952vZ5v7xKZYBw36RlEcRe7B6eWblhC6jsHEy
         UoYO3PzvTvtVMZAh8wkTfLlBdZV6Pd2Irf08nb1ppBOQRz/EK9nG+zToD3yVrgyAG8z2
         mJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535289; x=1698140089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Luo9wr24H4AGCwJOTFfUcS8sRYYgRVeO3qF+A+b57H0=;
        b=ftDCbR6SGzc33zwsUE5VKhPbT08ndEoqXtsFxlVPO9TEUEzKxODNO7hjCFG3cqhgKJ
         YlHPoFEhDDCTPnwRrRqi1lFgznQGtocwijE8f9IWo6OHnQK/BSOaNw6xsU9DVKdZtw2H
         nr426RyguJElAleyJLBfptNbQysCBpDanV8sEJr04/9HNkgkfCVUEIQnKOIrhZFsfSA8
         Iyr6VxoaujQsqlZobXEru3fMIoc/R2mYuCPBJIswgtjQ2qSluEsDIdv9EQp2Cf7zgHMw
         wBGx1jPd1YB0wgVoie8BHrlZD+B+ivzhxBwMWbfeuRTjuD9IGYOh4lRopNUPcPQ/QuNB
         jpfQ==
X-Gm-Message-State: AOJu0YzzI4hoKU6jfUFyBLbGAzisDTRExwNKUwIEZVQAEfxhPiIVtmSk
	Or1OafS5jPXzcNKX2CxD2e6DSg==
X-Google-Smtp-Source: AGHT+IH369O90a2nkpnkWZW0IT/l8cBkC3IQ4wwb+DbFRdFmsGrzXk+g82XQvybJIc+V7a7aU/UJuw==
X-Received: by 2002:a05:651c:388:b0:2bf:f6f6:9fd9 with SMTP id e8-20020a05651c038800b002bff6f69fd9mr1147687ljp.0.1697535288994;
        Tue, 17 Oct 2023 02:34:48 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003fc16ee2864sm1380687wms.48.2023.10.17.02.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:34:48 -0700 (PDT)
Message-ID: <3eb7d43c-2d61-6710-c41b-751b5a0480f3@blackwall.org>
Date: Tue, 17 Oct 2023 12:34:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 2/8] bridge: fdb: support match on source
 VNI in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-3-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-3-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Extend "fdb flush" command to match fdb entries with a specific source VNI.
> 
> Example:
> $ bridge fdb flush dev vx10 src_vni 1000
> This will flush all fdb entries pointing to vx10 with source VNI 1000.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c      | 12 +++++++++++-
>   man/man8/bridge.8 |  8 ++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



