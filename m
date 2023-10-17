Return-Path: <netdev+bounces-41924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6EC7CC3AE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9988281A03
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A141E5C;
	Tue, 17 Oct 2023 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="eaZDdfTM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99304EBE
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:54:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347D0EA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:54:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083740f92dso1875235e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697547238; x=1698152038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvhnFhY6jRq7As9QTgPwWGYuZx6v1/acm7BwwDYyHoU=;
        b=eaZDdfTMNudDpus7roWJvn9IuZGernho2EUBfCRzA+ZzsK/mG4RvLjyE7/AC9WmwYp
         d3diTjWYWNX7WuOEqOZzPhvg3Mjd11vYaVn/GP+Z8V7YUd5bQpCkiocmCGHgqXI2QE1l
         1WlSV2Ep6I4iGE7fBSPS0TyeGF4JAftp1TUkdP8MPMMrgrKkk52sIDIYSyjY03tpwuVD
         H4zQlHthhsADvmgAvSpYTS+39eZmmFR3PMvHZQAXVOc+CLHwvGipa0SR01cv1RjPCD3n
         0n3XnYdn93kQnzn71/ZIvUKBBGUdKpDdjQftmP4nO0LJPXmceuRv2o/yVa6mUk0pZ5ZH
         fNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547238; x=1698152038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvhnFhY6jRq7As9QTgPwWGYuZx6v1/acm7BwwDYyHoU=;
        b=Y9NVPyJE6fPHKw+kWTfI+PCmBjdoIIQhm0BaOHtrNzPjTMeZRvPJWuV+mv9Jppf2Eh
         l+RIScDyQPpfA0R31wUaG93rdwqRTQNdmWlUR+2vLD6GBo0ImMC3XYhO97alDDkKRdIC
         ETSA3KOzu9cDa0KG/xKBZSuEanmm7SaN3bC0ePpvViKldG28VvrBfpbe4HsPZZ+R9H0e
         RihcAQr7x+LuuZyyhLctmfEDhYPLYrVrJY6LrrZ+EifsReMDMj4Om72sSYoUXB/GkwIZ
         Z40I9tg16zFrE5/l6WUsF901pUIkNoytij0KcdM3eTyKZ9ojLZgCLsP88uDEbvtt4VmA
         BLDw==
X-Gm-Message-State: AOJu0YwLWWLu6riXj/8ZwxuJ8R7XT9VSLYe8kzBRlsbUr9Hfco4y9G8J
	XU5rJ+hP4uB9AS3kNoNTIFg+WEtoUoaxYGPWhLdF2WWYNls=
X-Google-Smtp-Source: AGHT+IGWjgLwabCV1jCL7s4w8lZkFDRJYEBd6Q6GeMNsNp4Q9bKMlTw33NApfLeCfO7jq+BOLFlbDQ==
X-Received: by 2002:a05:600c:41d6:b0:405:3251:47a1 with SMTP id t22-20020a05600c41d600b00405325147a1mr1574221wmh.40.1697547238402;
        Tue, 17 Oct 2023 05:53:58 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00405391f485fsm1816809wmq.41.2023.10.17.05.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 05:53:58 -0700 (PDT)
Message-ID: <62c1a0d0-5a0e-bc3a-7f42-eda3b5062b96@blackwall.org>
Date: Tue, 17 Oct 2023 15:53:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next v2 3/8] bridge: fdb: support match on
 nexthop ID in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017105532.3563683-1-amcohen@nvidia.com>
 <20231017105532.3563683-4-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017105532.3563683-4-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 13:55, Amit Cohen wrote:
> Extend "fdb flush" command to match fdb entries with a specific nexthop ID.
> 
> Example:
> $ bridge fdb flush dev vx10 nhid 2
> This will flush all fdb entries pointing to vx10 with nexthop ID 2.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      	* Print 'nhid' instead of 'id' in the error
>      	* Use capital letters for 'ECMP' in man page
> 
>   bridge/fdb.c      | 10 +++++++++-
>   man/man8/bridge.8 |  7 +++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



