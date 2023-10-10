Return-Path: <netdev+bounces-39642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A737C03B9
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6432E281AB1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CA2FE0C;
	Tue, 10 Oct 2023 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="WzNDpeJb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDD2FE01
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:50:52 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0094
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:50:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso10599560a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1696963849; x=1697568649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gwxmekZJHXGMm97urkxFALVTBAcR9EJxHGti0iGF1E=;
        b=WzNDpeJboKlSg4nbDM6Kn9X/FZd0Mw+iklHeoIBMQqrs52iNDf0NgUg7JHUCWN12ri
         TzbAEqyPEB+jSTyzlaeh/C6u+wWZs8lodJZNx+SF8uyRzwUJ3M6XotfZ+FCJwNWpBkSY
         SrxfTJeZjgXPQ3L7AUq6s4dRc2wPSwkNv2VWdqOT0JPhmmG65IHp51MT+4vZ/nbpMsx6
         2Ykf2OAHYss+EKV6XMouLqS9ldJxUypZi8NBy3bBmRtIp7MCQ3X8TzUueI2adkPKOaEK
         Z6Cbtsq7y50MrD2WDr3jxEIFV7uRiGSKAnMeSiRNw6qg4AgiIvA1Vizj/HZ9NNWqjKpb
         OpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963849; x=1697568649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gwxmekZJHXGMm97urkxFALVTBAcR9EJxHGti0iGF1E=;
        b=A6pLM+T5W8/s4V34KGFar9hnTeGT0u6B8PI/98BfWml4NtQ4WinEWepI1XFuv/XiLi
         v763IlSN1PjPctenrrdbbJXE+2vbDiQv2y5LcZQvux2Nhtev4O+ZZASqc7LX6vfsgV74
         2bNSGGkQtpybc4EwyxQNqtQTXHc5QMF8PkiBGG+OZo1IOPgcHYMUnolGoQH9usUDcHNa
         0ozZf3iy+T5gmkurEpyAocQWt4pyo1G6275zIUOJsivEDBPP2naj7TbYFpy4+Jjw7MCr
         GP2IDTy/5N4pBpXCzjRsGxQHeanrDS0jS5xHhw66Jmm8/Q6Y74F5QTGJpLvY4pZz+3TE
         cOoA==
X-Gm-Message-State: AOJu0Yx9iuIaZS8h2uQ6hw79OOMQjsvvqKm9iWPvdoYx99Wzv1bVmNif
	+jJ3mPbeokAXHorykMiEjhAy7g==
X-Google-Smtp-Source: AGHT+IHrAowWJlFlabG6aYlY6Zdd0ztf2Dg4p0C675+6jMf7XUJ/dVtAnJOOBpOTMtL0KnCILEZUuw==
X-Received: by 2002:aa7:d996:0:b0:522:2d1b:5a38 with SMTP id u22-20020aa7d996000000b005222d1b5a38mr17428012eds.10.1696963848854;
        Tue, 10 Oct 2023 11:50:48 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c411000000b0053635409213sm8044249edq.34.2023.10.10.11.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:50:48 -0700 (PDT)
Message-ID: <4bf848f2-94a6-d941-645b-42309def1900@blackwall.org>
Date: Tue, 10 Oct 2023 21:50:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 00/11] Extend VXLAN driver to support FDB
 flushing
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: mlxsw@nvidia.com, idosch@nvidia.com, kuba@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, roopa@nvidia.com, shuah@kernel.org,
 pabeni@redhat.com, bridge@lists.linux-foundation.org,
 linux-kselftest@vger.kernel.org
References: <20231009100618.2911374-1-amcohen@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 13:06, Amit Cohen wrote:
> The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
> support for FDB flushing in bridge driver. Extend VXLAN driver to support
> FDB flushing also. Add support for filtering by fields which are relevant
> for VXLAN FDBs:
> * Source VNI
> * Nexthop ID
> * 'router' flag
> * Destination VNI
> * Destination Port
> * Destination IP
> 
> Without this set, flush for VXLAN device fails:
> $ bridge fdb flush dev vx10
> RTNETLINK answers: Operation not supported
> 
> With this set, such flush works with the relevant arguments, for example:
> $ bridge fdb flush dev vx10 vni 5000 dst 193.2.2.1
> < flush all vx10 entries with VNI 5000 and destination IP 193.2.2.1>
> 
> Some preparations are required, handle them before adding flushing support
> in VXLAN driver. See more details in commit messages.
> 
> Patch set overview:
> Patch #1 prepares flush policy to be used by VXLAN driver
> Patches #2-#3 are preparations in VXLAN driver
> Patch #4 adds an initial support for flushing in VXLAN driver
> Patches #5-#9 add support for filtering by several attributes
> Patch #10 adds a test for FDB flush with VXLAN
> Patch #11 extends the test to check FDB flush with bridge
> 
> Amit Cohen (11):
>    net: Handle bulk delete policy in bridge driver
>    vxlan: vxlan_core: Make vxlan_flush() more generic for future use
>    vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by
>      default
>    vxlan: vxlan_core: Add support for FDB flush
>    vxlan: vxlan_core: Support FDB flushing by source VNI
>    vxlan: vxlan_core: Support FDB flushing by nexthop ID
>    vxlan: vxlan_core: Support FDB flushing by destination VNI
>    vxlan: vxlan_core: Support FDB flushing by destination port
>    vxlan: vxlan_core: Support FDB flushing by destination IP
>    selftests: Add test cases for FDB flush with VXLAN device
>    selftests: fdb_flush: Add test cases for FDB flush with bridge device
> 
>   drivers/net/vxlan/vxlan_core.c           | 207 +++++-
>   include/linux/netdevice.h                |   8 +-
>   net/bridge/br_fdb.c                      |  29 +-
>   net/bridge/br_private.h                  |   3 +-
>   net/core/rtnetlink.c                     |  27 +-
>   tools/testing/selftests/net/Makefile     |   1 +
>   tools/testing/selftests/net/fdb_flush.sh | 812 +++++++++++++++++++++++
>   7 files changed, 1049 insertions(+), 38 deletions(-)
>   create mode 100755 tools/testing/selftests/net/fdb_flush.sh
> 

Nice use of the flush api. :)
The set looks good to me. For the set:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

