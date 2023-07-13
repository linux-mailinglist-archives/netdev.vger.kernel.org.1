Return-Path: <netdev+bounces-17397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC3751713
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D3281B50
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF614691;
	Thu, 13 Jul 2023 04:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F030468C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:01:36 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A41FEE;
	Wed, 12 Jul 2023 21:01:35 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-783549ef058so5415539f.2;
        Wed, 12 Jul 2023 21:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689220895; x=1691812895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvPz7QR4JAXFGgXXDMeNE/CMKbeqWBOzgEw9n9EVFQA=;
        b=H8Ow31fiU+lKIWVElyRQWRVpN3jIJR1uvEN3V861sGwZFeC/9bFFv4dClFALae5Gjt
         pGiCoBJs82lnzvKerYHsMRC6bbbM4pZcYraORrTAGlwskaSsgY52+XQgY42aTJyPFEy/
         wQNXBYrBSldYwJQLYQ34EjSrORoQMsdLZcj6mDf3UCxUlQcb5EmYERO5tfvp5zW+Rplh
         ql1gU7VcRYNqjGoSapoMB4WStH76zn51APNCfyVLiwI7ksq1ZEW2oDj+FDstZwlcPMqQ
         A2mawokCOmwrAC5a6ayMANrWYDfo1/UtuQQGf4EGJOJXOadvlLpb/I0TbstPTV3Zq5pj
         Motw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689220895; x=1691812895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvPz7QR4JAXFGgXXDMeNE/CMKbeqWBOzgEw9n9EVFQA=;
        b=l72IaPsZYssYruGdkeJM8vFzDSgO4xgWoZYz4PbAjLn4E5d6lWtsJXe23gUzP9b9Rp
         yjwUaNsyfH/8Kv2J0u0BOkgtf8u4mHmxyy46V4BeOQvF1mRkmwv2DLKwHbWyX8Teapci
         TFLb4+XxSTLZyxSrGn1NGi3ZBv/XG8rQoRF56ExdO9ZRZG1myiclGBiCYYgBof5LN/mo
         FYxhLoJNpfNDa6mrdLQVDArDwiZj3HQtlEMevtyoXAPTPiGBuE+4DDVIxtcWLHjqv884
         uUyt+5GKeoQsS6rlmM0ZqpbcUR2oJVuIIij6Z/UbvqohUi2thalwNdPm1ZMrp+X8opOH
         5kuQ==
X-Gm-Message-State: ABy/qLaJQHLlJpjC3+cnP765XJBWV+yejrWgROHzWq0x7HQRJLvX+7nA
	5cLKVnUJJyst5eZxPuNxpK8=
X-Google-Smtp-Source: APBJJlFj1jDXbQHKFiTJHha1oQdNMVJ9Lju/CX0tSIFc1uUeBxHA4roZHmZmQ3YpcfOZ5B9YBOzJsQ==
X-Received: by 2002:a5e:a719:0:b0:786:fff8:13c2 with SMTP id b25-20020a5ea719000000b00786fff813c2mr701931iod.11.1689220894970;
        Wed, 12 Jul 2023 21:01:34 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:980b:bc27:a3dd:be78? ([2601:282:800:7ed0:980b:bc27:a3dd:be78])
        by smtp.googlemail.com with ESMTPSA id j21-20020a02a695000000b0042bb296863asm1583706jam.56.2023.07.12.21.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 21:01:34 -0700 (PDT)
Message-ID: <6b374e37-68b3-346a-a6b7-212640e9c868@gmail.com>
Date: Wed, 12 Jul 2023 22:01:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Netdev <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, jonathanh@nvidia.com, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, Qingfang DENG <qingfang.deng@siflower.com.cn>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, YOSHIFUJI Hideaki
 <yoshfuji@linux-ipv6.org>, Masahide NAKAMURA <nakam@linux-ipv6.org>,
 Ville Nuorvala <vnuorval@tcs.hut.fi>, Arnd Bergmann <arnd@arndb.de>,
 Pavel Machek <pavel@denx.de>
References: <20230709203826.141774942@linuxfoundation.org>
 <CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com>
 <20230711201506.25cc464d@kernel.org> <ZK5k7YnVA39sSXOv@duo.ucw.cz>
 <CA+G9fYvEJgcNhvJk6pvdQOkaS_+x105ZgSM1BVvYy0RRW+1TvA@mail.gmail.com>
 <20230712110240.2b232f84@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230712110240.2b232f84@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/12/23 12:02 PM, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 18:41:46 +0530 Naresh Kamboju wrote:
>> That is the commit id from stable-rc tree.
>>
>> I have re-tested the reported issues multiple times and
>> it seems that it is intermittently reproducible.
>> Following list of links shows kernel crashes while testing
>> selftest net pmtu.sh
>>
>> 1)
>> Unable to handle kernel paging request at virtual address
>> https://lkft.validation.linaro.org/scheduler/job/6579624#L4648
>>
>>
>> 2)
>> include/net/neighbour.h:302 suspicious rcu_dereference_check() usage!
>>
>> https://lkft.validation.linaro.org/scheduler/job/6579625#L7500
>> https://lkft.validation.linaro.org/scheduler/job/6579626#L7509
>> https://lkft.validation.linaro.org/scheduler/job/6579622#L7537
>> https://lkft.validation.linaro.org/scheduler/job/6579623#L7469
> 
> Nothing jumps out at me.
> 
> David, any ideas?

No. Since it is a selftest in the linux repo, any chance for a git
bisect based on that one test?

