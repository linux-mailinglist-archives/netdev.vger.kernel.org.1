Return-Path: <netdev+bounces-22938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8653C76A1D1
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11F0281602
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D991DDEA;
	Mon, 31 Jul 2023 20:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88591DDE8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:23:51 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D31728
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:23:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso12429639f.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690835026; x=1691439826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGlGpw5Q9q73Ldn1HOpDYO0OQxBN9y2wWaW04aAn3Sk=;
        b=Tzp6pkj2CuiwN5T1cb6RwqAagJWZcZvIWhojOmZqsie7v+OMp3a42BkMHG4DsZYbKG
         JX6vDuwGJ0pF1vlwG8N+kns4UsUCyfy1wrYHeeJ6XSiLVu7AEcyYPIusG4cwY3hIs11d
         qk1xcXcs7N34m6JIPDF+z3ZnMXQObG47f0meQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835026; x=1691439826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGlGpw5Q9q73Ldn1HOpDYO0OQxBN9y2wWaW04aAn3Sk=;
        b=bLvzrZMa40CgQFIqNt7ocjo6dKFo8vLixGKtt4OXS22WMlWtGp8ghaqoHyFOLwLJQm
         vfGfBIbae8qzgwAqV2h9KIq6Plydq/itT5lfCsrhwQ6+Mw9Sc8toSQqjHip0mDRQZQgs
         7hvnGbUyP+k5R9wSUK66CuenXOJEe68sWlOpvkCyfSzna5VIYpAteEeArriS11ThKZ6J
         QhfvCOLhXfCPZP2RgLnU02N8mH8Ocy142VSeIbPYNUVFYByn8tsN8J8j0QwbRSx2+fkY
         RQ9SKGGCT+IxcuzXfBQn5hNyxUW0HElZSUYg4n56ybAeC6g4gqVbYj0sPgGY+mdaqYOy
         j4Yg==
X-Gm-Message-State: ABy/qLY0dbEy6itfQh0Hp7KVQMOdaO4wKxZI1P2/OJe/z1au6yy3pBJr
	UM8j2I3PhcRCLpePS6Jxuel68w==
X-Google-Smtp-Source: APBJJlGgAux994dW83HtYTYpLYqmK0Zrk10pegL7O2Y8RxVDCrof5T1fCXszRhNuvGJTRoXVR7UiwQ==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr8761031iof.0.1690835026049;
        Mon, 31 Jul 2023 13:23:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j12-20020a02cb0c000000b004290985a1efsm3239825jap.43.2023.07.31.13.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 13:23:45 -0700 (PDT)
Message-ID: <1471f593-1ff5-902a-a045-9241feda7bd0@linuxfoundation.org>
Date: Mon, 31 Jul 2023 14:23:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] selftests:connector: Fix input argument error
 paths to skip
Content-Language: en-US
To: shuah@kernel.org, Liam.Howlett@oracle.com, anjali.k.kulkarni@oracle.com,
 kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230729002403.4278-1-skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230729002403.4278-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/23 18:24, Shuah Khan wrote:
> Fix input argument parsing paths to skip from their error legs.
> This fix helps to avoid false test failure reports without running
> the test.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> v2: Removed root check based on Anjali's review comments.
> Add netdev to RESEND
> 
>   tools/testing/selftests/connector/proc_filter.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
> index 4fe8c6763fd8..4a825b997666 100644
> --- a/tools/testing/selftests/connector/proc_filter.c
> +++ b/tools/testing/selftests/connector/proc_filter.c
> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>   
>   	if (argc > 2) {
>   		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
> -		exit(1);
> +		exit(KSFT_SKIP);
>   	}
>   
>   	if (argc == 2) {
> @@ -256,7 +256,7 @@ int main(int argc, char *argv[])
>   			filter = 1;
>   		} else {
>   			printf("Valid option : -f (for filter feature)\n");
> -			exit(1);
> +			exit(KSFT_SKIP);
>   		}
>   	}
>   

Hi Jakub,

I sent v2 for patch 3 in the series. Do you want me to send the
entire series again with this revised 3rd patch.

thanks,
-- Shuah


