Return-Path: <netdev+bounces-41822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091727CBF8E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B981F28160A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA01405C2;
	Tue, 17 Oct 2023 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="sR0D+O9t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C753F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:37:30 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8DE8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:37:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40566f8a093so53002845e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535447; x=1698140247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPUrZUF5Q/DCNe2WyNuLEnoxMZ3K9cyLrdR/uHXKkQ4=;
        b=sR0D+O9taO7FUQOpQaNe18qjObKR6v9XbdoUc0uquhktSVISkl/cTs+i5n1jlqM0s5
         3Gnuw+ArH5/Xo1o1KnweugUoWQdaZXJRxaMQ0HKczy8m2Rtghy1PB2akoEeNrDivug/Y
         Qt8HrZnbqEM3/q0ROCdAZ2Y8X2WHeyNL2cuFAFpRj7rNj3cseTsIEl9OzCSYwNbwFdVH
         jZGibMkQLBP/PnTxkplsnzxRPGnZkfmA1qGkUOpOsiW4KbLi8g0k+IHv81BdFZqhemFK
         gdEnlcHNDfn4zfsjBXLNdcW+XusPuz4R9yUnhcivqvmBh7VkzMPQvkptu8koG/rtBOoK
         fPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535447; x=1698140247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPUrZUF5Q/DCNe2WyNuLEnoxMZ3K9cyLrdR/uHXKkQ4=;
        b=UeJngBhJ4xF5K1P9KxMilhPwIUGnEB/fU69srBXp83n7xVKgMxvDMUlfZ2gvSaPVBa
         EbL2Dromxhh5rXEyGzXVzPWktziobHuKAgWn7fVZGQ0PzvA6n6/Z2NeF+se8XBIECu4G
         2A7H3zoSBrV0RWh6IuFaFtz+p4myPY8MQ0fcp8myFmMRD2ANZr9H+QPC8D5hQYoegXpY
         g+YT1pR2gZ6lndNbDoKTn8jnb7pj4fdwKYquQDNaAA87qWT/H11mKIbtE3aCFJBLANa8
         ZmpKZfcbjLHVqZ1eV05hCYv/JHGcsNc81QVni0Azzi7tUbO+9MnpUIvWWqrzBggscKbK
         R0Mg==
X-Gm-Message-State: AOJu0Yzqz1Qhp12VJ9rdnQX3jkXUDxPrsIeYgBubbAUDmUW19ix3jVCM
	zCjUhbcPGhoFsDQ/vPTdfha0I7DDi1Ts9i8ab/t90pE615g=
X-Google-Smtp-Source: AGHT+IHP3qJ2f4swA2qOW030ZXNE21T7Q7l6DaKfzT30Yb6Y5UQBQD2y8B5oh10LX0RXUGR5z/VzMA==
X-Received: by 2002:a05:600c:5486:b0:407:6120:cdec with SMTP id iv6-20020a05600c548600b004076120cdecmr1257026wmb.38.1697535447567;
        Tue, 17 Oct 2023 02:37:27 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c304400b003fe15ac0934sm389812wmh.1.2023.10.17.02.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:37:27 -0700 (PDT)
Message-ID: <56eb459b-6dbd-6654-9135-6ccdcb73649e@blackwall.org>
Date: Tue, 17 Oct 2023 12:37:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 4/8] bridge: fdb: support match on
 destination VNI in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-5-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-5-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Extend "fdb flush" command to match fdb entries with a specific destination
> VNI.
> 
> Example:
> $ bridge fdb flush dev vx10 vni 1000
> This will flush all fdb entries pointing to vx10 with destination VNI 1000.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c      | 11 ++++++++++-
>   man/man8/bridge.8 |  8 ++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



