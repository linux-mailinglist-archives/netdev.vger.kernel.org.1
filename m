Return-Path: <netdev+bounces-38787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8327BC7BB
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769CF281F19
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267C1C6B3;
	Sat,  7 Oct 2023 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j5VEAikr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D53171B7
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 12:43:47 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A051B9
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 05:43:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a645e54806so532698166b.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696682623; x=1697287423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=na2vY5XLEnrO7gH6y+sjdtwNf+4ZNZ0a8e0ws8eV8qE=;
        b=j5VEAikrGDu7l77kdTuiREqeg9LETRr5xzQVWgmNXsqEyp44NfSiqeiER//mflyuI3
         yFovjRIp50qXU8m3nb1o8o/lXCHwaXz5H2oUbQQEcCyLbtKSvueRKRkGQ5eaFaGbw0jU
         WRlM9ZdG7+mNtiJV4DZHnLcaaJM67g8kv4j0VFx56URy7HDu/6dnqugXpu+Q+1inPVue
         1lZ8IRsZpVlx9+dF4k5wUNHBz7n879x80uB2ogBFIyvHzd69ExkurrKxXg1Qs8Ih6fr0
         kQJEybRjWGal4wIETtZCGm9O9Q3KaUH8HxW7sNL7c7ojrZC4d0m6TbSY9/tIZT4KQZub
         uGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682623; x=1697287423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na2vY5XLEnrO7gH6y+sjdtwNf+4ZNZ0a8e0ws8eV8qE=;
        b=brHoIcecEe/76mrIQqVumrvFCCH4rEgXFImi0+ijqUXNS6n0xclHa35zzWuEhHtxKl
         bvGNutsLEspROLZFf8h52XPkLcqxoj6GJG9K8+5C9q90JRKAsNCR9ZSMPQvLZ+ctiXYA
         0IfQDh2hDRtuzCTbBc6DgJPAfpyagQYYWJMysxgzwDFW+XRlxmY4e1EY69kQXnTCrfX1
         qkqdt/T4qRkp0Ep/a0YiTuTOGsDevXO7OFc+GdhwK3eTMijyEiJi1oAtvxHIiPsz+4L+
         HfYTF3t14c9fM+n2BLvibj8y6Vzpxjoya5Pj7WcQFb7Nk8a3qbr2tVMtIqJz3HnvVqBH
         UoLQ==
X-Gm-Message-State: AOJu0Yy6ct37zOm29A+wuZsQVVG7Y+yRK/vWJCDoY/raq2r8sNhQrWi5
	zpThI63s5qK832HkZHQBF+08hw==
X-Google-Smtp-Source: AGHT+IHUzBpKyHQ//GXMw4wBHyOHR8qGPe8RwHYoPBeFAap15usANcJ8hSk7h4eUFSkNnjdZ7mf5YQ==
X-Received: by 2002:a17:906:318f:b0:98e:26ae:9b07 with SMTP id 15-20020a170906318f00b0098e26ae9b07mr8749648ejy.35.1696682623495;
        Sat, 07 Oct 2023 05:43:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709061b4600b0098e2969ed44sm4185141ejg.45.2023.10.07.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:43:41 -0700 (PDT)
Date: Sat, 7 Oct 2023 14:43:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
	xiyou.wangcong@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, mleitner@redhat.com, vladbu@nvidia.com,
	simon.horman@corigine.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <ZSFSfPFXuvMC/max@nanopsycho>
References: <20231005184228.467845-1-victor@mojatatu.com>
 <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho>
 <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org>
 <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho>
 <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Oct 07, 2023 at 01:06:43PM CEST, jhs@mojatatu.com wrote:
>On Sat, Oct 7, 2023 at 6:20 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Sat, Oct 07, 2023 at 01:00:00AM CEST, jhs@mojatatu.com wrote:
>> >On Fri, Oct 6, 2023 at 6:25 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> >>
>> >> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
>> >> > > I don't understand the need for configuration less here. You don't have
>> >> > > it for the rest of the actions. Why this is special?
>> >>
>> >> +1, FWIW
>> >
>> >We dont have any rule that says all actions MUST have parameters ;->
>> >There is nothing speacial about any action that doesnt have a
>> >parameter.
>>
>> You are getting the configuration from the block/device the action is
>> attached to. Can you point me to another action doing that?
>
>We are entering a pedantic road i am afraid. If there is no existing
>action that has zero config then consider this one the first one. We

Nope, nothing pedantic about it. I was just curious if there's anything
out there I missed.


>use skb->metadata all the time as a source of information for actions,
>classifiers, qdiscs. If i dont need config i dont need to invent one

skb->metadata is something that is specific to a packet. That has
nothing to do with the actual configuration.


>just because, well, all other actions are using one or more config;->
>Your suggestion to specify an extra config to select a block - which
>may be different than the one the one packet on - is a useful
>feature(it just adds more code) but really should be optional. i.e if
>you dont specify a block id configuration then we pick the metadata
>one.

My primary point is, this should be mirred redirect to block instead of
what we currently have only for dev. That's it.



>
>> >If we can adequately cleanup mirred,  then we can put it there but
>> >certainly now we are adding more buttons to click on mirred. It may
>> >make sense to refactor the mirred code then reuse the refactored code
>> >in a new action.
>>
>> I don't understand why you need any new action. mirred redirect to block
>> instead of dev is exactly what you need. Isn't it?
>
>The actions have different meanings and lumping them together then
>selecting via a knob is not the right approach.
>There's shared code for sure. Infact the sending code was ripped from
>mirred so as not to touch the rest because like i said mirred has
>since grown a couple of horns and tails. In retrospect mirred should
>have been two actions with shared code - but it is too late to change
>now because it is very widely used. If someone like me was afraid of
>touching it is because there's a maintainance challenge. I consider it
>in the same zone as trying to restructure something in the skb.
>I agree mirroring to a group of ports with a simple config is a useful
>feature. Mirroring to a group via a tc block is simpler but adding a
>list of ports instead is more powerful. So this feature is useful to
>have in mirred - just the adding of yet one more button to say "skip
>this port" is my concern.

Why? Perhaps skb->iif could be used for check in the tx iteration.


>Lets see how the refactoring goes first then it will be clearer - it
>is a lot of delicate work - but you are right lets give it some love
>now.
>
>cheers,
>jamal
>
>
>>

