Return-Path: <netdev+bounces-30767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F114A789012
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D501C20D42
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DE193A0;
	Fri, 25 Aug 2023 21:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389935CAC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:03:34 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0272114
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:03:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bcade59b24so977360a34.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692997412; x=1693602212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+58PCea9DjT3VKY1DE14dL9jyMDoZx4tcaEL9QU+kk=;
        b=H7Ovo1yKalS39HD39xLvRHPPhNZnEXNjFWFKx6V7z6Kyg0xjtcEkF7diURe/PFZNry
         481a04XhwSnnSx8LDq6OXZ7oIm34ar/H3UnUXx1NPsF0fYLTlk4+nvneEt9qMpy035DX
         auwA36xS7AjbnUcOTuSF687ptG6SNuBoNTvPHcKGdRUdCu3SaCjUz/WuhbTnQDoAburS
         m8dJCwAba7iRwHBVUxXJaNwWS5JD4wjk9YkzhtH2jmdVzF7Eu6STM98IioYemkOTb7ry
         Y49mjOm2Lyyk/02h5hOElgGPh6VJdM/k9qt62Jxy8F3BVNmBB7p9pZw6LYvuFhJ7wl6L
         dofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997412; x=1693602212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+58PCea9DjT3VKY1DE14dL9jyMDoZx4tcaEL9QU+kk=;
        b=JfRYhhs/8ciXNdR1G1Xc9mmFpyU+MTpZ9VFZ8yDyApZ9oJvCOnUc8rYVy2lXiHRAC1
         vHVJ4+tju3gilA/IEUF0JDqPVZ250yQjU0KNQC18rCmzHUooJXsvqqnQeaa3/Zu+190Y
         r3PfcU26SEtUfZ55WdwI0vFE5xoIC8TVS4eGHmd29q741rSU2/vf6bWvzq/K2DcGggYF
         1CyyEOCd810FR3Zy/3Nn/m6hiWXHfkeo0BnKMbnOmURWwgv8QV2wXqsO7WK3aSaXrqwK
         BviENxjogeC1wsHr1ifsIo9disdrMQwt27Aypk7MraZupsXXcMOMcVrWHK/M7biGTRsZ
         MyhQ==
X-Gm-Message-State: AOJu0YxUxqy3Sd2M1w7YGf8UqpPYz9J17E0uvsOVdz2NTEO8AdVCH40r
	jOi+ZIWqKyApKMJLdLHAD7MxCQ==
X-Google-Smtp-Source: AGHT+IF6Wd1pE1EGRYpFRZScxnrgqnSdhJpI7Ap33GBBY1Mh94n+SuAUdxFQZ/u60/EB00znmA/r8Q==
X-Received: by 2002:a05:6830:1e90:b0:6ab:27b5:d202 with SMTP id n16-20020a0568301e9000b006ab27b5d202mr6177800otr.37.1692997412463;
        Fri, 25 Aug 2023 14:03:32 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:f52f:b618:18ec:fcf4:1a2b? ([2804:7f1:e2c1:f52f:b618:18ec:fcf4:1a2b])
        by smtp.gmail.com with ESMTPSA id g3-20020a9d6483000000b006b881a6518esm1216803otl.10.2023.08.25.14.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 14:03:31 -0700 (PDT)
Message-ID: <b5146739-debb-4c55-820c-55a28478f9d8@mojatatu.com>
Date: Fri, 25 Aug 2023 18:03:27 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/4] selftests/tc-testing: add tests covering
 classid
Content-Language: en-US
To: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com
References: <20230825155148.659895-1-pctammela@mojatatu.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20230825155148.659895-1-pctammela@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/08/2023 12:51, Pedro Tammela wrote:
> Patches 1-3 add missing tests covering classid behaviour on tdc for cls_fw,
> cls_route and cls_fw. This behaviour was recently fixed by valis[0].
> 
> Patch 4 comes from the development done in the previous patches as it turns out
> cls_route never returns meaningful errors.
> 
> [0] https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com/
> 
> v1->v2: https://lore.kernel.org/all/20230818163544.351104-1-pctammela@mojatatu.com/
>     - Drop u32 updates
> 
> Pedro Tammela (4):
>    selftests/tc-testing: cls_fw: add tests for classid
>    selftest/tc-testing: cls_route: add tests for classid
>    selftest/tc-testing: cls_u32: add tests for classid
>    net/sched: cls_route: make netlink errors meaningful
> 
>   net/sched/cls_route.c                         | 27 +++++-----
>   .../tc-testing/tc-tests/filters/fw.json       | 49 +++++++++++++++++++
>   .../tc-testing/tc-tests/filters/route.json    | 25 ++++++++++
>   .../tc-testing/tc-tests/filters/u32.json      | 25 ++++++++++
>   4 files changed, 114 insertions(+), 12 deletions(-)
> 


For the series,

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

