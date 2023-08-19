Return-Path: <netdev+bounces-29146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A24781B72
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 02:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61642810CA
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 00:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D52373;
	Sun, 20 Aug 2023 00:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3D371
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 00:10:59 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21298B47B1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:48:12 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c4d67f493bso1460897fac.2
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692478091; x=1693082891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZC9muy4Qf8GFbM47XVqmc7sf/s/1vI2vvllKEeduqfg=;
        b=fGmshBSq3fBsE4ZLRd3mlcUXCvrpQp8ekWYYMcrtAOye+RyRSFxpEPWoBqba6ggV1P
         hBOPxwFuFqynknEs/Q7BlZ7f/364zt1ONPIJpmAxX1OtQxMS0NzMQlcUu64tFKn9dkZ4
         apObhOUuzTBs1yAlVlv8TQMebmRbbgtLIe2LE4gUTr3U6WEDk4PeXP9q4mVIcOi4e8Oh
         VhbUpfwDNCmM+G2VtR+3fi1k8VFLTIrFA5JBZbt+WLly3W2cDOotZGubaxNr9a52vAFb
         5EM1sLo6PGl5als3ONurC3awou96FrC8U1iFPKdWwToiNV+O0AZkhqvpAuT8Hpyua057
         QAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692478091; x=1693082891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC9muy4Qf8GFbM47XVqmc7sf/s/1vI2vvllKEeduqfg=;
        b=K2/WqdkIQz6ALIzeJ1VBO/dddw0a1x24t+3OVoVnJNnnsAMWsUC0j1UQnaXLN1Gh4k
         3fonkPpumOYbz6C7Nkzg6dlTVL2DIS0Mbg4VB85nSnFhVtZfEdwa+DcdKOxxZdhCEJG0
         9P2qi5F8oBJq28T6L+KmjIPwoiBK264mJh0ni1UPXlQCPcqhKQT/7xLHAD+z/kHmao+m
         GXjDZhy62w7qkdAheJuvLAT/uH2fh5DFRwSy46b8pNBOJ09c7f0OS+ZnSO+z/KEAg2hY
         pOzztP2xrOZT62spGFhfWLxrEyeWPdfgDzwl392+fVXl7yFjr/1A3CLg/YvrQXqT14hZ
         +tBg==
X-Gm-Message-State: AOJu0YwAJ1Ego4eyLDjZ4ogh4Ty7am4zN6oQu/LHP+/vdCoxtjhlHNYh
	D3Dc/zOxOFM3nVqgtEzp/kZMOaawaPKlVb2DTnk=
X-Google-Smtp-Source: AGHT+IGIqRmGznVj5n3Vw54SVl7wxw7PX6qUQfnTCl58LMsK56x5iYOt3fTihcB50b50kMe1EmeC/w==
X-Received: by 2002:a05:6870:4154:b0:1bb:c0ee:5536 with SMTP id r20-20020a056870415400b001bbc0ee5536mr3943067oad.47.1692478091242;
        Sat, 19 Aug 2023 13:48:11 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:675b:d4b6:8d9b:4260? ([2804:14d:5c5e:44fb:675b:d4b6:8d9b:4260])
        by smtp.gmail.com with ESMTPSA id q2-20020a9d7c82000000b006b89dafb721sm2006510otn.78.2023.08.19.13.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 13:48:10 -0700 (PDT)
Message-ID: <d95d8cfb-365d-619e-f987-b97fea02514d@mojatatu.com>
Date: Sat, 19 Aug 2023 17:48:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 5/5] selftests/tc-testing: cls_u32: update tests
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, shaozhengchao@huawei.com,
 victor@mojatatu.com
References: <20230818163544.351104-1-pctammela@mojatatu.com>
 <20230818163544.351104-6-pctammela@mojatatu.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230818163544.351104-6-pctammela@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18/08/2023 13:35, Pedro Tammela wrote:
> Update the u32 tests to conform to the new syntax of a terminal flowid
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>   .../selftests/tc-testing/tc-tests/filters/u32.json     | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index ddc7c355be0a..d4b4c767d6c9 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -15,7 +15,7 @@
>           "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip src 127.0.0.1/32 flowid 1:1 action ok",
>           "expExitCode": "0",
>           "verifyCmd": "$TC filter show dev $DEV1 ingress",
> -        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:1.*match 7f000001/ffffffff at 12)",
> +        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 \\*flowid 1:1.*match 7f000001/ffffffff at 12)",
>           "matchCount": "3",
>           "teardown": [
>               "$TC qdisc del dev $DEV1 ingress"
> @@ -60,7 +60,7 @@
>           "cmdUnderTest": "$TC filter replace dev $DEV1 ingress protocol ip prio 1 u32 match ip src 127.0.0.2/32 indev notexist20 flowid 1:2 action ok",
>           "expExitCode": "2",
>           "verifyCmd": "$TC filter show dev $DEV1 ingress",
> -        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:3.*match 7f000003/ffffffff at 12)",
> +        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 \\*flowid 1:3.*match 7f000003/ffffffff at 12)",
>           "matchCount": "3",
>           "teardown": [
>               "$TC qdisc del dev $DEV1 ingress"
> @@ -196,7 +196,7 @@
>           "cmdUnderTest": "$TC filter replace dev $DEV1 ingress protocol ip prio 98 u32 ht 43:1 match tcp src 23 FFFF classid 1:4",
>           "expExitCode": "2",
>           "verifyCmd": "$TC filter show dev $DEV1 ingress",
> -        "matchPattern": "filter protocol ip pref 99 u32 chain (0[ ]+$|0 fh (43|800): ht divisor 1|0 fh 43::800 order 2048 key ht 43 bkt 0 flowid 1:3.*match 00160000/ffff0000 at nexthdr\\+0)",
> +        "matchPattern": "filter protocol ip pref 99 u32 chain (0[ ]+$|0 fh (43|800): ht divisor 1|0 fh 43::800 order 2048 key ht 43 bkt 0 \\*flowid 1:3.*match 00160000/ffff0000 at nexthdr\\+0)",
>           "matchCount": "4",
>           "teardown": [
>               "$TC qdisc del dev $DEV1 ingress"
> @@ -219,7 +219,7 @@
>           "cmdUnderTest": "bash -c \"for mask in ff ffff ffffff ffffffff ff00ff ff0000ff ffff00ff; do $TC filter add dev $DEV1 ingress prio 99 u32 ht 1: sample u32 0x10203040 \\$mask match u8 0 0 classid 1:1; done\"",
>           "expExitCode": "0",
>           "verifyCmd": "$TC filter show dev $DEV1 ingress",
> -        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 40 flowid 1:1",
> +        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 40 \\*flowid 1:1",
>           "matchCount": "7",
>           "teardown": [
>               "$TC qdisc del dev $DEV1 ingress"
> @@ -242,7 +242,7 @@
>           "cmdUnderTest": "bash -c \"for mask in 70 f0 ff0 fff0 ff00f0; do $TC filter add dev $DEV1 ingress prio 99 u32 ht 1: sample u32 0x10203040 \\$mask match u8 0 0 classid 1:1; done\"",
>           "expExitCode": "0",
>           "verifyCmd": "$TC filter show dev $DEV1 ingress",
> -        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 4 flowid 1:1",
> +        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 4 \\*flowid 1:1",
>           "matchCount": "5",
>           "teardown": [
>               "$TC qdisc del dev $DEV1 ingress"

Uh-oh, seems like this is broken again in iproute2-next.
Will double check...
-- 
pw-bot: cr


