Return-Path: <netdev+bounces-39643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32637C03BB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220241C20B80
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F92FE01;
	Tue, 10 Oct 2023 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SptY710o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE1EB8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:52:18 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C193
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:52:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1093928866b.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1696963936; x=1697568736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fC+gy/Dm+dXvJmy21Gr8CFVX6IcKgRTNBBmzaRa4Vs=;
        b=SptY710o1KRT/CGw1ENzERdQaPUUnch7nm+uZDZZ/FSPKEoobHBnQ7DjeSuYOyTygU
         ZMkCfVgJ/nfcaeqf3Y0rCcDCe3mLEz4a3vPWQeqb/wuAbJrxkwK4UNoEK73b3bZZQ40l
         abG2j26O0mViJQmUdu9AMlnEx9Zvb4RAGZ5liFUvbmSN3v8egc6ChF4bb9WVS8y34DMJ
         04iCevY5omeyvbskLfTGePCMNaVMBZwP4TkFP06zhir0B0lmmk2J1YUVMFbB6lmgyy+T
         GdIEnLiFfqyjmoT5Qo1oE5yvFJgURcYP6gvGR4aOY7DFq/AEDNJbNQ0kUZXXgL/K/EYh
         8jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963936; x=1697568736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fC+gy/Dm+dXvJmy21Gr8CFVX6IcKgRTNBBmzaRa4Vs=;
        b=XtniJWXqw1idcD1W9qnzMZz7ChIszD11xTN1/msnj/ReleK5pZ4ax7+y41VhUsfmmH
         MXCi7mfG8/P6ZImNv7N6c9Zg2rTbnFe7apR1vWcVxWThTOU8WQ57/2v79sbet3GKDRrG
         zGuQ7+9x3Cj2Zl1rXOjwWBfgcnQSZ9JcHOZq205s8e7uROAaHA8237ZbqrIxuF4Qx6yx
         g1+C8x/WFfu4+Dd08FKmxv8UjHVqphRDSGzdZnql6+X6xOZCjJ5RubBN5mPjyOFCsGQi
         a0mxpLqeMKsmnTxP12/fGDg1REOXdYmtr3sCDLeGM4FPZhdmeYSX6aVsFHn6fuLFTdV4
         niZA==
X-Gm-Message-State: AOJu0Yz0QhaNFbhrDiRwmGTfEkEKfKYJ2OxWaVOHnaCIivYLQeQoA5Y+
	+wtZbajbLMiRUT40bdqvqmo35Q==
X-Google-Smtp-Source: AGHT+IETN+aVMpyJvyFDHUDlNhtGnYcRle+ZFgO8QNPUfV21XlUHRW79QtF3JfFFloTVbPTtHOrhMQ==
X-Received: by 2002:a17:907:6c14:b0:9ae:588e:142 with SMTP id rl20-20020a1709076c1400b009ae588e0142mr16845281ejc.67.1696963935957;
        Tue, 10 Oct 2023 11:52:15 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906a28b00b009737b8d47b6sm8742127ejz.203.2023.10.10.11.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:52:15 -0700 (PDT)
Message-ID: <984c7455-bb9c-65cd-da7d-7eaab7b7ae5a@blackwall.org>
Date: Tue, 10 Oct 2023 21:52:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2] bridge: fdb: add an error print for unknown
 command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: mlxsw@nvidia.com, dsahern@gmail.com, stephen@networkplumber.org,
 roopa@nvidia.com
References: <20231010095750.2975206-1-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231010095750.2975206-1-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 12:57, Amit Cohen wrote:
> Commit 6e1ca489c5a2 ("bridge: fdb: add new flush command") added support
> for "bridge fdb flush" command. This commit did not handle unsupported
> keywords, they are just ignored.
> 
> Add an error print to notify the user when a keyword which is not supported
> is used. The kernel will be extended to support flush with VXLAN device,
> so new attributes will be supported (e.g., vni, port). When iproute-2 does
> not warn for unsupported keyword, user might think that the flush command
> works, although the iproute-2 version is too old and it does not send VXLAN
> attributes to the kernel.
> 
> Fixes: 6e1ca489c5a2 ("bridge: fdb: add new flush command")
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/bridge/fdb.c b/bridge/fdb.c
> index ae8f7b46..d7ef26fd 100644
> --- a/bridge/fdb.c
> +++ b/bridge/fdb.c
> @@ -761,9 +761,13 @@ static int fdb_flush(int argc, char **argv)
>   				duparg2("vlan", *argv);
>   			NEXT_ARG();
>   			vid = atoi(*argv);
> +		} else if (strcmp(*argv, "help") == 0) {
> +			NEXT_ARG();
>   		} else {
> -			if (strcmp(*argv, "help") == 0)
> -				NEXT_ARG();
> +			fprintf(stderr, "bridge fdb: unknown command \"%s\"?\n",
> +				*argv);
> +			usage();
> +			return -1;
>   		}
>   		argc--; argv++;
>   	}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

