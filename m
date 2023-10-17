Return-Path: <netdev+bounces-41813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DAD7CBF56
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DCC281397
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE93FB1F;
	Tue, 17 Oct 2023 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="05MdoqEz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2861381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:29:45 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0110E3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:29:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so4399755f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534967; x=1698139767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8g2g7raXC6KSNLGw7ZLxZ1tqI+faJNv/2CAMfuJSXs=;
        b=05MdoqEzgAmS2fRVCPOQvzdl6W3fWE9INxXfevC9LGg/zikfBEjf6L5f8BhvXFCOOF
         YnhnAccJZK0AB4l9V7xqfnDz9xR9TCQPnFn9iiLTXI1TRdVzWanfRM2Y2yHsBwiMKdOI
         zMvU71pmIcjpWYSThTwcqqKy9fPPW/NijXHkzgmUEcuLcSGgB/l3LtCXsIwbtl3cAjDw
         Ucl8LoR2uJ9D+Lg9oIpSYv5sb7YoR2rkB95svrjJMGI8tkH+r0MwXou7ZDhHoZT46Ehb
         uH2hPHgH4lIVib0xvPab0mApOixhhi1+Y1i2d05DWa3jWjY44se+kaS2/SckBn7qt8Wu
         E7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534967; x=1698139767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8g2g7raXC6KSNLGw7ZLxZ1tqI+faJNv/2CAMfuJSXs=;
        b=sFr/XOTkuOx2nYIcMN8jV6nsn5uFSgCwXtZ+LlcUHFSH7TeOlSDexqUTg04/CrZf2g
         yhRjjOo/8x4ZFCoBr+7NHvBCbjhEYphHwY9h6RWA4E9UFqA84K6LsZtkS1QOPayVkYTw
         If//j0mQl92karjuZhTntwAubxp9SlNpx4A2TTFz9qtEQZmqnq80LITHkXtdBml2+W8j
         DP235PfYdI8n69Ra18oKwCGjb9b6H1Vwg+1PuLAiz20Tt1nfzfNsUh309RbwfRiGvRP5
         f5e1r4gAMxAlpNvuXpBfxNalq6b3zBAmCuf65DEC2VhfVv4OmZWDvRPkBIyqND2b6L2U
         qAfA==
X-Gm-Message-State: AOJu0YwVXmzrQorWSAxmOxouNwYl0+6PZQ5KjPgdoT2IUFJ+2X4FyFOd
	tCCqIlhAhZKO5Qeb7VeuC6+SjA==
X-Google-Smtp-Source: AGHT+IGSmLBaD2wKKHZq/x/+3etoHYcooCSNy25pi3pMScSaIE9OiBl3EKPIm9+JWEN8/QOBiLaVUg==
X-Received: by 2002:adf:f486:0:b0:32d:be57:795f with SMTP id l6-20020adff486000000b0032dbe57795fmr1484881wro.6.1697534967111;
        Tue, 17 Oct 2023 02:29:27 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b0032db430fb9bsm1233701wri.68.2023.10.17.02.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:29:26 -0700 (PDT)
Message-ID: <80dca841-6cfa-e176-431a-9800183ce986@blackwall.org>
Date: Tue, 17 Oct 2023 12:29:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 11/13] rtnetlink: Add MDB get support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-12-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-12-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Now that both the bridge and VXLAN drivers implement the MDB get net
> device operation, expose the functionality to user space by registering
> a handler for RTM_GETMDB messages. Derive the net device from the
> ifindex specified in the ancillary header and invoke its MDB get NDO.
> 
> Note that unlike other get handlers, the allocation of the skb
> containing the response is not performed in the common rtnetlink code as
> the size is variable and needs to be determined by the respective
> driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/core/rtnetlink.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 88 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



