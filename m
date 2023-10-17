Return-Path: <netdev+bounces-41826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80A7CBF97
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6DF1F22CD2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DA7405CA;
	Tue, 17 Oct 2023 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TJjwdefh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA13F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:39:02 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EABA2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:39:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso5240768f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535540; x=1698140340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WH7IhoHXk5YN5o7LNnUnU58viq6fOsGDKs+rY61D/ls=;
        b=TJjwdefhmjLS/DTC1kau/Ya5pMbNvUI0+gOZzS5gxW0vgqWn6AcwpGVk0n228MAY7A
         7jLPK4m8jR5iV9SN/vZWjneg9xWiD7agvMtT6ztNSd+zuGfBF3zT3mIJHzeUBnfs8jdW
         nHCiPTKzBH3H2axgcwQMMviSGTPbwC4Qkd5DZqL9wrTCoLmE4dpbJev3PaHCGme0HyXy
         3zN29o1khkxJq+qOC8kSMKGvzVdjXth31DAVFIcV0s7ESxUWVE8m8xgsis+N0LCwCW62
         emnFlB9YK3Dd+Y2mFDWrtLnElpKb6xMgpMY4khiSBzLSKZlYSuWHhchYYiKlk33HbGQG
         IXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535540; x=1698140340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH7IhoHXk5YN5o7LNnUnU58viq6fOsGDKs+rY61D/ls=;
        b=IJBK2XkGZkNuzDnalsAWn6xIelXTXlyF9jUVDxifhTBqA0oCUjtz3qybHycqI8DlMN
         KtbBCN0XlVkBydaerMfMJ79Zd2h7QnD6fRyp1hgmGSavmcRgC9hW0kS7dj0L9F5oux/W
         UVdn9zbtslfLyqTIs6pkcIIVHjKUHcbnyKm8WCYIjOW1r+gb4t8zOsVGEl33e3a8B7FJ
         XDBENkiS8mK1c+Ngizn6zpaVU34LfLw96I6oOR/9Y5py4cavhOTR/mRBqeFK8eAFo0b7
         AcOkT8VAt5DjGFol7uUsZHITj415n0BO35pkSgfG5pKDgex056d8ObHOFwKvwwHNB+0M
         Y+pg==
X-Gm-Message-State: AOJu0YxDCtRbrberNHRmtsxAsxzFD6pxWaKE8t7mqDCwsbHUXwfwNHkE
	sR766DU75Ka7pecJyViTkI3DiA==
X-Google-Smtp-Source: AGHT+IGY0xxEYv0+mdSkzmkeVTYAiUsHOmpYlfBWk54yMdhP3nRJYssTTqjYlSA5wlWwh1WBEJrT+Q==
X-Received: by 2002:adf:f608:0:b0:32d:b2dd:ee1c with SMTP id t8-20020adff608000000b0032db2ddee1cmr1520576wrp.5.1697535540041;
        Tue, 17 Oct 2023 02:39:00 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d62ce000000b0031779a6b451sm1258716wrv.83.2023.10.17.02.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:38:59 -0700 (PDT)
Message-ID: <443e62da-342d-620f-27df-4af0bd1f0e31@blackwall.org>
Date: Tue, 17 Oct 2023 12:38:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 6/8] bridge: fdb: support match on
 destination IP in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-7-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-7-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Extend "fdb flush" command to match fdb entries with a specific destination
> IP.
> 
> Example:
> $ bridge fdb flush dev vx10 dst 192.1.1.1
> This will flush all fdb entries pointing to vx10 with destination IP
> 192.1.1.1
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c      | 14 ++++++++++++--
>   man/man8/bridge.8 |  8 ++++++++
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



