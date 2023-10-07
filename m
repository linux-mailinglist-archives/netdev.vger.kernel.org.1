Return-Path: <netdev+bounces-38812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287137BC947
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F55F1C2091E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F5171DA;
	Sat,  7 Oct 2023 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nvfbNH84"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB35235
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 17:20:59 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CA83
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:20:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5041cc983f9so3812099e87.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696699255; x=1697304055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAV1TK4ukdxCby7GZZf6Ucu0GRecoHpJD6LvNLRSE50=;
        b=nvfbNH84yZr522iwjcMzta+IGRIvoCXvru/YhcJZlHYwvXcBD5/UoFVdziJa8HBA2v
         ZcuWYdesiU9fk4YlxsiFay6KstvLL99JS6rhqncDqL1IJlbDVYO6TBTKUGwV7/Q0XI9y
         UBVbmdcSfNgXiRf/SxZ1St0hInts2/mFcrBOI/VinYie7TZGq2uMoQdsGdtNHkBT+HvJ
         v94cQKzg75yBq1NRlB5s31rpGWHTBXf8tsw2N6SvK5K1V3DbGNG/x76S20h4G40lLsx4
         QQcFSfgwgANBHU3Pu+1ES2/WBJO1jdREEJdl7/TsKXYNKSDQu5LNOHvJ0gkLUnzgrnlR
         XXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696699255; x=1697304055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAV1TK4ukdxCby7GZZf6Ucu0GRecoHpJD6LvNLRSE50=;
        b=dIU6BX66xLVVKJNgJGCeTS88QMXqS5f76L9M6upbHIOoJysiG8ocYgkygnJmdK6NTD
         fHE696HSYrdrSVSHYYTtooX8b7Bb+l50MKExhsPXJjZ1DYjvDWe4nk1USajqTXNkOqlX
         JTaEQ7576fsx6UkFhC9i1AiNP6Hd31oN86tMD3OeDlTi5NIeB9O7vo+KDM0yLYGqcoeq
         qrm8AiT3jOn4C47E9gqE2Dm42/1qteNwWutUzbXkwNlYW/A/oU3YMAL6AdO8Ut141IEw
         Hx3ihZnNYeRtnpQMGRCWcm4bAZyTiDzgnrmQTnby5nJMtOXvpbLVumOR0qxXWLqV3MHm
         bVew==
X-Gm-Message-State: AOJu0YyoUgPrY1b3sgtr9WDG+havSY/MNM2NeVU39f0CIvBrEh8sstP0
	CAl9JvNHLIiX9w7A1cg7iit/zg==
X-Google-Smtp-Source: AGHT+IH6lACWm7UlIhc0NxXu7aDryAb0EkSo9/yulcF31fzXf+z94hk73rG6YW1OE6xtIBjntJmhFg==
X-Received: by 2002:a19:c217:0:b0:504:7e12:4846 with SMTP id l23-20020a19c217000000b005047e124846mr9059163lfc.30.1696699254791;
        Sat, 07 Oct 2023 10:20:54 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ce24-20020a170906b25800b0098669cc16b2sm4479202ejb.83.2023.10.07.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 10:20:53 -0700 (PDT)
Date: Sat, 7 Oct 2023 19:20:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
	xiyou.wangcong@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, mleitner@redhat.com, vladbu@nvidia.com,
	simon.horman@corigine.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <ZSGTdA/5WkVI7lvQ@nanopsycho>
References: <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho>
 <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org>
 <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho>
 <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
 <ZSFSfPFXuvMC/max@nanopsycho>
 <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Oct 07, 2023 at 04:09:15PM CEST, jhs@mojatatu.com wrote:
>On Sat, Oct 7, 2023 at 8:43 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Sat, Oct 07, 2023 at 01:06:43PM CEST, jhs@mojatatu.com wrote:
>> >On Sat, Oct 7, 2023 at 6:20 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Sat, Oct 07, 2023 at 01:00:00AM CEST, jhs@mojatatu.com wrote:
>> >> >On Fri, Oct 6, 2023 at 6:25 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> >> >>
>> >> >> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
>> >> >> > > I don't understand the need for configuration less here. You don't have
>> >> >> > > it for the rest of the actions. Why this is special?
>> >> >>
>> >> >> +1, FWIW
>> >> >
>> >> >We dont have any rule that says all actions MUST have parameters ;->
>> >> >There is nothing speacial about any action that doesnt have a
>> >> >parameter.
>> >>
>> >> You are getting the configuration from the block/device the action is
>> >> attached to. Can you point me to another action doing that?
>> >
>> >We are entering a pedantic road i am afraid. If there is no existing
>> >action that has zero config then consider this one the first one. We
>>
>> Nope, nothing pedantic about it. I was just curious if there's anything
>> out there I missed.
>>
>
>Not sure if you noticed in the patch: the blockid on which the skb
>arrived on is now available in the tc_cb[] so when it shows up at the
>action we can just use it.

I see, but does it has to be? I don't think so with the solution I'm
proposing.


>
>>
>> >use skb->metadata all the time as a source of information for actions,
>> >classifiers, qdiscs. If i dont need config i dont need to invent one
>>
>> skb->metadata is something that is specific to a packet. That has
>> nothing to do with the actual configuration.
>
>Essentially we turned blockid into skb metadata. A user specifying
>configuration of a different blockid is certainly useful. My point is
>we can have both worlds: when such a user config is missing we'll
>assume a default which happens to be in the skb.
>
>>
>> >just because, well, all other actions are using one or more config;->
>> >Your suggestion to specify an extra config to select a block - which
>> >may be different than the one the one packet on - is a useful
>> >feature(it just adds more code) but really should be optional. i.e if
>> >you dont specify a block id configuration then we pick the metadata
>> >one.
>>
>> My primary point is, this should be mirred redirect to block instead of
>> what we currently have only for dev. That's it.
>
>Agreed (and such a feature should be added regardless of this action).
>The tc block provides a simple abstraction, but do you think it is
>enough? Alternative is to use a list of ports given to mirred: it
>allows us to group ports from different tc blocks or even just a
>subset of what is in a tc block - but it will require a lot more code
>to express such functionality.

Again, you attach filter to either dev or block. If you extend mirred
redirect to accept the same 2 types of target, I think it would be best.


>
>>
>>
>> >
>> >> >If we can adequately cleanup mirred,  then we can put it there but
>> >> >certainly now we are adding more buttons to click on mirred. It may
>> >> >make sense to refactor the mirred code then reuse the refactored code
>> >> >in a new action.
>> >>
>> >> I don't understand why you need any new action. mirred redirect to block
>> >> instead of dev is exactly what you need. Isn't it?
>> >
>> >The actions have different meanings and lumping them together then
>> >selecting via a knob is not the right approach.
>> >There's shared code for sure. Infact the sending code was ripped from
>> >mirred so as not to touch the rest because like i said mirred has
>> >since grown a couple of horns and tails. In retrospect mirred should
>> >have been two actions with shared code - but it is too late to change
>> >now because it is very widely used. If someone like me was afraid of
>> >touching it is because there's a maintainance challenge. I consider it
>> >in the same zone as trying to restructure something in the skb.
>> >I agree mirroring to a group of ports with a simple config is a useful
>> >feature. Mirroring to a group via a tc block is simpler but adding a
>> >list of ports instead is more powerful. So this feature is useful to
>> >have in mirred - just the adding of yet one more button to say "skip
>> >this port" is my concern.
>>
>> Why? Perhaps skb->iif could be used for check in the tx iteration.
>>
>
>We use skb->dev->ifindex to find the exception. Is iif better?.

iif contains ifindex of the actual ingress device. So if the netdev is
part of bond for example, this still contains the original ifindex.
So I buess that this depends on what you need. Looks to me that
skb->dev->ifindex would be probaly better. It contains the netdev that
the filter is attached on, right?


>Jiri - but why does this have to be part of mirred::mirror? I am
>asking the same question of why mirror and redirect have to be part
>mirred instead of separate actions.

You have to maintain the backwards compatibility. Currently mirred is
one action right? Does not matter how you do it in kernel, user should
not tell any difference.


>
>cheers,
>jamal

