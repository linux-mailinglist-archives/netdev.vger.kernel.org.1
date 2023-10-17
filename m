Return-Path: <netdev+bounces-41953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0077CC6DB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAC71C20859
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4243AB8;
	Tue, 17 Oct 2023 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Nhja8BHc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A46405C8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:55:00 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60138A5B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:54:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ac87af634aso2477146a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697554465; x=1698159265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWWTZnBVIZTe4ofDfw2r1CM+hodCfZ095WrXM2I86aA=;
        b=Nhja8BHcmdRP3LKvG2shWW2TcDWH4JuX6S8qZ8yxvL2ObvNjAN/j6lcztiALdeWfvU
         HS5tJ7FLP7noK11kFzTTWONt3TZjA73bLb51YpbQ7FoR3OxkZzvjDhJzO+WXCdhhj7AC
         oMdwDYxgb11i/3wZjRIg6y+lL/en3J6X6KG/GRbhPmreAUoMTf/TvRFRZDDJWtiR/uqh
         GY7iRrIQ3/wbu1P4GcCoI39LSc0qihfE7wv78FhdY6G3hb4JVnPKJmkoT6vqwWWVtjmK
         q+tXeMqpmRrT9dt2HCggf5Vgl2MVwEBC8lQxPNdhyGA3S6FFg/kGCcvW3Rkyp/Ctl+KS
         aPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554465; x=1698159265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWWTZnBVIZTe4ofDfw2r1CM+hodCfZ095WrXM2I86aA=;
        b=uJWWsgBErIqBVOQUURLaE/9TFaGQXMjBJDOqqZb7yCmPb7J1bt2dBBBRC1Rgqe+teS
         +7yB+CyB0EL2Rh6MpYbg7u051DUMFLMwGa9kSblwhBDvsmITqQUor9veZSDsed1DrX1L
         1ebftiuMUKekSWQsc3o545CHoPqedVcSBId08efp+HB3/XllMCEGeUoCxwZoD4DvwJoY
         7/nw84g4gCOO0BgWF4IxpJvDjPLYnGmy6VqE5uB6s0cXJ/YhGUJevpovUCLlKCkAEeys
         9CTOxfvO+21bt67RA0HaDsxxuc3M7uC02WYFnKzv4QT8Y8QPShsaGjZe9/YY1F6hpDAl
         RFyg==
X-Gm-Message-State: AOJu0YzcIjQPyXJgLdjDufwZ3bAVKCU1SZ7nXVVlrPxpb8SLL7dLLWlD
	B9rhD/LTSQ6F3YiznaTT3k6bH+ZKoxd6ZhsESZ2NaQ==
X-Google-Smtp-Source: AGHT+IHKi1ptjbhQrWNr/7yJvCw2b3J4HArSVyS3RhAPbeKT9U34wDkjpX/utVKvMoawnUmBwUeX3A==
X-Received: by 2002:a17:90a:c251:b0:274:9409:bbca with SMTP id d17-20020a17090ac25100b002749409bbcamr2181998pjx.3.1697554464795;
        Tue, 17 Oct 2023 07:54:24 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:8ef5:7647:6178:de4e? ([2804:14d:5c5e:44fb:8ef5:7647:6178:de4e])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b0027758c7f585sm1546213pja.52.2023.10.17.07.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:54:24 -0700 (PDT)
Message-ID: <61900f67-0432-4967-8ab0-c4766beaabb8@mojatatu.com>
Date: Tue, 17 Oct 2023 11:54:20 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: tc-testing: add dummy and veth to
 minimum config
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231016180222.3065160-1-pctammela@mojatatu.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231016180222.3065160-1-pctammela@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/10/2023 15:02, Pedro Tammela wrote:
> Dummy and VETH are heavily used by tdc. Make sure CI builds using
> tc-testing/config pick them up.
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>   tools/testing/selftests/tc-testing/config | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
> index 5aa8705751f0..cf3ff04dfcb2 100644
> --- a/tools/testing/selftests/tc-testing/config
> +++ b/tools/testing/selftests/tc-testing/config
> @@ -1,3 +1,10 @@
> +#
> +# Network
> +#
> +
> +CONFIG_DUMMY=y
> +CONFIG_VETH=y
> +
>   #
>   # Core Netfilter Configuration
>   #

I will include this change in a bigger series today.

--
pw-bot: cr

