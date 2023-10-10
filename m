Return-Path: <netdev+bounces-39451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDF7BF494
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60869280CF7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05CCFBEC;
	Tue, 10 Oct 2023 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hidxkvKY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9CD295
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:41:16 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC992
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:41:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d82bea507so382242a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696923673; x=1697528473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvCbRZYcIVKWCnIaqaQ2xIVxQYMHrabU/uflHgvkT2o=;
        b=hidxkvKYVuAz2QefqKV+v/YFWHvgxYk/nVshiHYdP5R23p34d6q4hhFPhDOn/wD6Vh
         if9TQpQcf5BrX1Dpr4AIIj13GXYuamvcz4Rz26Br2U/d5kmeSETokDpbhBmJiWknxPOR
         GRqKvvFegCGeKUK7l2RqKPug1zYNRM3U1PAXkKq2wuhfeJQZykj1ac3wy9BLteM1ds4B
         e6JG+y4xMnJMFi0Cuy2P3ve/kBUCTKPg7p3dVSNMF/RQEnqgljY6XoZhw8l+dADagCqg
         EIqclBhUSbHOXZJP8hWYpaD7lhqtrtMjs0NIm42Sv1URPtA5YiDSgWh4AQDi/hzrLwxx
         huyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696923673; x=1697528473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvCbRZYcIVKWCnIaqaQ2xIVxQYMHrabU/uflHgvkT2o=;
        b=eDzja5hULi6+30rOSGeRukxgvC/4SeA0HEDxPeenm08iThRjZE97ooFZZsuQ+klHl/
         j03UjsKAvhBW8wdOwdyyvY8YXT1R0j58lxYGZlILYCr7t8AG8Grn7dv69QbVCc+OphR0
         8RmA7vthpAit+zZract+aU1S3pdXCfYYOVtMPwG+BY5njpU+CrH+g+HYAL5rhQxdh2Vl
         KarjtVO5C8Q4sTgh5tf5GwZeyzMYbmXWzL/Taj3UIsDRaNmpu3e+o9TVk+OiqqqwNVch
         1xIDoZXHct0ctgHWPSaNmkOSoA9xS2irPxENG7VFkJc2rnnnvdB/4RsyQyi7DGhD6glw
         +jVg==
X-Gm-Message-State: AOJu0Yzm/JtMV9SAkWpArC8fKj29tjl2wO80Uk5HYeckd/gtxU+jcKlj
	khL+7yed0QqM+Yse6Qu427Jllw==
X-Google-Smtp-Source: AGHT+IH0HjQv4OA1HGD8kfjpmis3avuFKI5IIE3Hiosm5jLT3mDjDNJtWEXyRmYaU3uwpd21NADHyw==
X-Received: by 2002:a17:906:2189:b0:9ae:6ad0:f6db with SMTP id 9-20020a170906218900b009ae6ad0f6dbmr14989027eju.71.1696923673669;
        Tue, 10 Oct 2023 00:41:13 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090657d400b009b97aa5a3aesm8015923ejr.34.2023.10.10.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:41:13 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:41:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	vladbu@nvidia.com, simon.horman@corigine.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <ZSUAF7tzCq+Vwj2I@nanopsycho>
References: <ZSA60cyLDVw13cLi@nanopsycho>
 <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org>
 <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho>
 <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
 <ZSFSfPFXuvMC/max@nanopsycho>
 <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
 <ZSGTdA/5WkVI7lvQ@nanopsycho>
 <CALnP8ZbD_09u+Qqd2N4VcrstuGexh7TiNAtL7n4pyUvLAQ8EOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnP8ZbD_09u+Qqd2N4VcrstuGexh7TiNAtL7n4pyUvLAQ8EOw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 09, 2023 at 10:54:07PM CEST, mleitner@redhat.com wrote:
>On Sat, Oct 07, 2023 at 07:20:52PM +0200, Jiri Pirko wrote:
>> Sat, Oct 07, 2023 at 04:09:15PM CEST, jhs@mojatatu.com wrote:
>> >On Sat, Oct 7, 2023 at 8:43 AM Jiri Pirko <jiri@resnulli.us> wrote:
>...
>> >> My primary point is, this should be mirred redirect to block instead of
>> >> what we currently have only for dev. That's it.
>> >
>> >Agreed (and such a feature should be added regardless of this action).
>> >The tc block provides a simple abstraction, but do you think it is
>> >enough? Alternative is to use a list of ports given to mirred: it
>> >allows us to group ports from different tc blocks or even just a
>> >subset of what is in a tc block - but it will require a lot more code
>> >to express such functionality.
>>
>> Again, you attach filter to either dev or block. If you extend mirred
>> redirect to accept the same 2 types of target, I think it would be best.
>
>The difference here between filter and action here is that you don't
>really have an option for filters: you either attach it to either dev
>or block, or you create an entire new class of objects, say,
>"blockfilter", all while retaining the same filters, parameters, etc.
>I'm not aware of a single filter that behaves differently over a block
>than a netdev.

Why do you talk about different behaviour? Nobody suggested that. I have
no idea what you mean by "blockfilter".



>
>But for actions, there is the option, and despite the fact that both

Which option?


>"output packets", the semantics are not that close. It actually
>helps with parameter parsing, documentation (man pages), testing (as
>use and test cases can be more easily tracked) and perhaps more
>importantly: if I don't want this feature, I can disable the new
>module.
>
>Later someone will say "hey why not have a hash_dst_selector", so it
>can implement a load balancer through the block output? And mirred,
>once a simple use case (with an already complex implementation),
>becomes a partial implementation of bonding then. :)
>
>In short, I'm not sure if having the user to fiddle through a maze of
>options that only work in mode A or B or work differently is better
>than having more specialized actions (which can and should reuse code).

Sure, you can have "blockmirredredirect" that would only to the
redirection for block target. No problem. I don't see why it can't be
just a case of mirred redirect, but if people want that separate, why
not.

My problem with the action "blockcast" is that it somehow works with
configuration of an entity the filter is attached to:
blockX->filterY->blockcastZ

Z goes all the way down to blockX to figure out where to redirect the
packet. If that is not odd, then I don't know what else is.

Has other consequences, like what happens if the filter is not attached
to block, but dev directly? What happens is blockcast action is shared
among filter? Etc.

Configuration should be action property. That is my point.



>
>  Marcelo
>

