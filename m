Return-Path: <netdev+bounces-25564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15D774BD6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182CE1C20FB1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3611641C;
	Tue,  8 Aug 2023 20:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F51B7F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:58:11 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4545FD7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 13:58:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso51745775e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691528289; x=1692133089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNCC7hf2Aq954pB0NHRb4lV6ZiBfbV3cbsRhVb23nMs=;
        b=ZEyhCfaOIfP94XlwjBPBsIPVTFN6lehZ7FN72+ta2bXd7U5wT2xo8u9vEHKwN1HWzd
         dPI/YmALgl4cOzj39DgUsZe6mYP5u5sG0JovQleIfP6RMqIj3tInQuy7E4PgXil2Q+ZM
         Z69YvZnu8C/p6i2zAt+W+fz2v/hVo/JoJbSk21Xbzf0FzVvlepHpmxJN48fSpn/8C5rx
         X0u0p5mfBB6h2x4dQ/V4f9e4y1lS8jAdT1DiEh4oQr0V8eYAuw8dBPJ2HcuiiXB00F4s
         Sb8l2i2s/hEVRiGW+mEnzS+wLjJcB2AU7gh0vwpR3dogvJFtLSBvYTxUujkix/rlsogU
         BKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528289; x=1692133089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNCC7hf2Aq954pB0NHRb4lV6ZiBfbV3cbsRhVb23nMs=;
        b=dm2UJDUtlVC8iAnXTJ0LSSQl/apjBaIAlzEuPC4pNwC/qfzPOWKWNsBgG311XZFq5B
         0VU/j5aE0JeGh3fmhiUhJy2t3dYy4Wu/Ooat2HsKedYwXXlksvR9Xdv/4efNl+QOvnhU
         7ZfA9m71iYaaZluvFyXJjXeiE+GfPUywD1n+M9acqLKFdNB2tvPlynYPiPOvbvmGE+n2
         xl9g4lKV7OkkqemLA5ITlWNWRm0sYRjZvj4FQ4ZeCBcnV53+PTqbidCa/iOkkqeHiIqg
         40TCaBMhcPwNMaRNA0FTOP/q9MEYAcY5O5f3+mPpSewhbt9BD+rvELQGrUHvnT3wb9N2
         DXKQ==
X-Gm-Message-State: AOJu0Yy7GfiiKB1ApyxjevAgPCTD7JWs8yIKhsp5KQ2JrpACqxnRTLn6
	NPWX5yupv3RNXYbadNByfumTtUejplk=
X-Google-Smtp-Source: AGHT+IHFmW+Ny05FFhRpId9nbe6XBPJkWLqHzxsS68OTTHoxjFGSXcSL0S7O4Q6iwDvET5dmN5Skuw==
X-Received: by 2002:a05:600c:247:b0:3fe:34c2:654b with SMTP id 7-20020a05600c024700b003fe34c2654bmr758789wmj.14.1691528288667;
        Tue, 08 Aug 2023 13:58:08 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003fc01f7b415sm19072027wmh.39.2023.08.08.13.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 13:58:08 -0700 (PDT)
Message-ID: <bb5ec7f9-6170-1608-745f-363d3ad19cc5@gmail.com>
Date: Tue, 8 Aug 2023 23:58:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: tls: set MSG_SPLICE_PAGES consistently
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Tariq Toukan <tariqt@nvidia.com>, borisp@nvidia.com,
 john.fastabend@gmail.com, dhowells@redhat.com
References: <20230808180917.1243540-1-kuba@kernel.org>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230808180917.1243540-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 08/08/2023 21:09, Jakub Kicinski wrote:
> We used to change the flags for the last segment, because
> non-last segments had the MSG_SENDPAGE_NOTLAST flag set.
> That flag is no longer a thing so remove the setting.
> 
> Since flags most likely don't have MSG_SPLICE_PAGES set
> this avoids passing parts of the sg as splice and parts
> as non-splice. Before commit under Fixes we'd have called
> tcp_sendpage() which would add the MSG_SPLICE_PAGES.
> 
> Why this leads to trouble remains unclear but Tariq
> reports hitting the WARN_ON(!sendpage_ok()) due to
> page refcount of 0.
> 
> Fixes: e117dcfd646e ("tls: Inline do_tcp_sendpages()")
> Reported-by: Tariq Toukan <tariqt@nvidia.com>
> Link: https://lore.kernel.org/all/4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: borisp@nvidia.com
> CC: john.fastabend@gmail.com
> CC: dhowells@redhat.com
> ---
>   net/tls/tls_main.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 7dbb8cd8f809..f550c84f3408 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -139,9 +139,6 @@ int tls_push_sg(struct sock *sk,
>   
>   	ctx->splicing_pages = true;
>   	while (1) {
> -		if (sg_is_last(sg))
> -			msg.msg_flags = flags;
> -
>   		/* is sending application-limited? */
>   		tcp_rate_check_app_limited(sk);
>   		p = sg_page(sg);


Thanks for your patch.
Tested-by: Tariq Toukan <tariqt@nvidia.com>


