Return-Path: <netdev+bounces-31841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AC4790B41
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB611C20823
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7417ED;
	Sun,  3 Sep 2023 08:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835917EC
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 08:38:19 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E69CD
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 01:38:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso523472a12.1
        for <netdev@vger.kernel.org>; Sun, 03 Sep 2023 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1693730296; x=1694335096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbbCADn6qVo4++0ODqx3/gIn04Tf4kByZXe5yzyZxUM=;
        b=VNxdGpF4Ry2ttsMb5vW/DLAQ388HKKaP4ZaGQEAlMcn2wabHv+7sfvlCVOr3Ubrxmx
         kCPDELFUi47ks/B5Drc1QOrWkHGVGzlgNG5E858eUqHj0cHWNi6UgSmjmhroWye9dYGs
         hkjtVyKCTZtdOvtgwWRiRF+0OeDSSD8V+sXQ0et8Z3DCY4cInajE08bEcTsZT183/QIC
         e61wMlHlKs2k5Nf/Wx4zFwRq0pCBmu5vNulYGoI8txD2orEU2CRJAfhn9X+H5K49CmJL
         sdeQSBRpvj36UIOBDPnJAWaC7BnjdTdEnXTRgkCrOOP3T/3jUplBVG0gd+zXK6JpSRWu
         jOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693730296; x=1694335096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbbCADn6qVo4++0ODqx3/gIn04Tf4kByZXe5yzyZxUM=;
        b=MDzyL0NpziYVxVUfW5GlhpMGeSV4rumfkfms6gdsYpVykcPExKNzr/LcVDWKnPcVuP
         q/K3bXbRrnBT80IZTv60j6EnDastIm6tZfqsLrGXf6WTuvd7iS7M/Fw9ocAxFiXDq861
         3tZoS6N7aec+dBtfa7CHJVZ+4irz7mCezOstgPfVYv4KKyny5kKjW6Msz9PWi0ZeaxZl
         HqvHq62Es5+It9hIYZeuk3trqAlNpO5fn1vv8itJlfSj/ry5CF/NtzktWkEJZ8D35G4m
         Z86fU6I9nFAz4hFwPY8IgqmWaxde8WpfPy8xiTYtLeUwJfd8TOdozCYtsUCPGXF9PhU0
         hmXw==
X-Gm-Message-State: AOJu0YwAJQG2Lzp+0r7JLHka3y8YRyoCE57EW72fTfSFgXPcEygM8I4t
	CmX7JgfFnU8JnUyptMfKJtcstw==
X-Google-Smtp-Source: AGHT+IEeybhfr5z4O/FN4tJJELkxeqP1Pgf+GZ9LeCvf2q04yQRT3voNHGAp5nKMeaUW54dmsz6u3g==
X-Received: by 2002:aa7:df82:0:b0:52a:1c3c:2ecc with SMTP id b2-20020aa7df82000000b0052a1c3c2eccmr4910403edy.25.1693730296609;
        Sun, 03 Sep 2023 01:38:16 -0700 (PDT)
Received: from [192.168.0.103] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id d26-20020a50fb1a000000b0052574ef0da1sm4278942edq.28.2023.09.03.01.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 01:38:16 -0700 (PDT)
Message-ID: <d9439db7-5d1e-5a2d-399c-884e8661c0b9@blackwall.org>
Date: Sun, 3 Sep 2023 11:38:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2] iplink_bridge: fix incorrect root id dump
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ido Schimmel <idosch@nvidia.com>
References: <20230901080226.424931-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230901080226.424931-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/1/23 11:02, Hangbin Liu wrote:
> Fix the typo when dump root_id.
> 
> Fixes: 70dfb0b8836d ("iplink: bridge: export bridge_id and designated_root")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   ip/iplink_bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 7e4e62c81c0c..462075295308 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -499,7 +499,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   	if (tb[IFLA_BR_ROOT_ID]) {
>   		char root_id[32];
>   
> -		br_dump_bridge_id(RTA_DATA(tb[IFLA_BR_BRIDGE_ID]), root_id,
> +		br_dump_bridge_id(RTA_DATA(tb[IFLA_BR_ROOT_ID]), root_id,
>   				  sizeof(root_id));
>   		print_string(PRINT_ANY,
>   			     "root_id",

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


