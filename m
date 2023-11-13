Return-Path: <netdev+bounces-47306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C67E98AB
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F501C2091E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E95199C3;
	Mon, 13 Nov 2023 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QoziQmyx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685818629
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:15:05 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC010CF
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:15:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so6317418a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699866903; x=1700471703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATQWOVY+NYGK+ysV8U39DQEzFUWuwhnt4IPGU9xgKuI=;
        b=QoziQmyxSo1DpXgj5nLKc1KYg+It4xBNzPDM3+VyEbfKYMKqItXoiLL+8Pi08HJRSK
         OwiO69rMEW1JltDaoedz37GQWO0ta+8cXkgOMX3DZPtLwAiI9z9ZLsp4hRvRWUXFmy1S
         XEqcBHEDmpkrabfpBU+XtkEsukMdK8oYVW+fColaTa7qRGGPpiv4YsNUq6AH6AdkIz8E
         tryxAMQYGzrPqVgu3yDpoUbrsVvpaZ/XO5uJ3HBJubcOBuxO83uwbsxMna5bqEt4A+/g
         ANzmrlD6ss14AzDKWSD7BR64EiaFvgdC4XLS59UTYjFRikwPWYGKbZ50wjAfCuTc862t
         X8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699866903; x=1700471703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATQWOVY+NYGK+ysV8U39DQEzFUWuwhnt4IPGU9xgKuI=;
        b=lua6FBgKNWvAOMrxUDceDl3YjVWkteHFT7gxI4W0WOS49yi3gnYKENKWe63JbCt0hC
         VacoWkivy/8ArSqlbofDLeMEI99H9oMCPjFzA3GLRMySsG7nW2jjcDHVo7TysbO5gCjU
         RUZlje34uITWoQ8eRAUjxjQTcpJmAdGhukN2RnbU9Y1/y9Q7R7Xggj2NMrvK6PZoQzEH
         g5JWOVqUMWXGLTE5ZaVmaQ3fU2/3JEKnmYAWPgKpOfMLcFkpzsu6EoA0Ooy6ojiOuAeU
         gzckE+Tl+DvxM2BYkI8CbQd10f56ixZrP/U/2MIy5uUlk/m04k45ksktUsdsmq8W8wXl
         oCaw==
X-Gm-Message-State: AOJu0YzcOtkTVv/YC6/dYI5/YbiS26KVXBEFeczsDA9NcYUX+fS9Lzeb
	p7tAzyIKGw87wmAdQQNYstqN2Q==
X-Google-Smtp-Source: AGHT+IFMjrA741UDJs/N0fXzMe94jSScyIn5NieQCu4Z5yOR+3VsHhpPiLQjzftSxpWON3bNrwr5MQ==
X-Received: by 2002:a17:906:f29a:b0:9d5:7c41:ccf6 with SMTP id gu26-20020a170906f29a00b009d57c41ccf6mr4789229ejb.26.1699866903280;
        Mon, 13 Nov 2023 01:15:03 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id gr12-20020a170906e2cc00b009e6391123b6sm3667807ejb.50.2023.11.13.01.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:15:02 -0800 (PST)
Message-ID: <ff4e507b-98c8-3f68-0bbb-ea7047087d76@blackwall.org>
Date: Mon, 13 Nov 2023 11:15:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 01/10] net: bridge: add document for
 IFLA_BR enum
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-2-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> Add document for IFLA_BR enum so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   include/uapi/linux/if_link.h | 270 +++++++++++++++++++++++++++++++++++
>   1 file changed, 270 insertions(+)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 29ff80da2775..32d6980b78d1 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -461,6 +461,276 @@ enum in6_addr_gen_mode {
> +

unnecessary newline

>   enum {
>   	IFLA_BR_UNSPEC,
>   	IFLA_BR_FORWARD_DELAY,


