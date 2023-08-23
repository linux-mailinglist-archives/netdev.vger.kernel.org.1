Return-Path: <netdev+bounces-30006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7A78594C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1161C20B0B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E991BBE7B;
	Wed, 23 Aug 2023 13:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E82917
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:29:05 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CF210DF
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:28:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fefe898f76so10548325e9.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692797302; x=1693402102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj69YZQd4IQTXCplo0PVh7rUR4w60CaDSqQgsAYXTWc=;
        b=kFoo0gGRcHFb16Wv00Ohw7B6ZJ1Ilt/va0JKk02l3XENbsHgZnx3+pGYeLYSCiEjut
         ztUC2o4G+5BhsD0SBcSybGFl90QoeDMEF3TEl3QfaPZwdoES2tOGJNDejiLKXbiDeS0Z
         GHWtN+OhXF937GEjp+KzgtFty14GtNjVHP6fOdGJYLMln+F/1hcJm6EgDDxgqRWRlRjQ
         6NemKii2RU77ZdF6JhD4AwrIWsAn5zCaiyPz9226NupBG3TZoqqbR48ikFkgvD/5CsKh
         bc6JNqLEcQUA5LnYgoxFtN3uE9MYPCTlMEn9gb0iek6cwk3+npTDIRRwBpYW0i7dhsLv
         GSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797302; x=1693402102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj69YZQd4IQTXCplo0PVh7rUR4w60CaDSqQgsAYXTWc=;
        b=FF3v8FOSZXJKnFyzXJ0oAc2aeCTUIv/MvQfQDeFRSXrBCTjBQV6ZFRBm8UzstgNCud
         jBYnKZxiepVlFBsRv85SDJERN8jgac0wqhx+X2P+T97kRceZ/daMYorpnKHzdlyMJ6nq
         rgUdFM/GL19/3LPmBIXEir+XVDsMO2AI5dzsOmykx1Z/qppIamx9I0twOhKOpyYABwc7
         67NWAQeIdbZ8P06p8IbBbdcOsAd89WOeSExzTDLKZogOTBE+hbXhFtW0a5fgCDR7ubHK
         XhjqyKLqfb3r9ixt9kdiWHo/WIzkHUNU36JfGHGRS8HAE6hsPH9B1TZSZY4Y9IjWOGvF
         lVXg==
X-Gm-Message-State: AOJu0YyYqhjquX6OsagkHGK9EJQGvM5yOXEZ38lLYKRyC1BYLCHG7JV3
	4BrpAj4iy9Z+ZRZlkJ10igNb+zYQG4gxsTt3ZVrVjQ==
X-Google-Smtp-Source: AGHT+IEfOV/EvvwfGvdBNKTLv8Pk9GjAj6joQU7JWfW/Nw07G3q19ZgQ+QZlcWTVnJFd7aN87RbCvQ==
X-Received: by 2002:a1c:7413:0:b0:400:2dc5:2006 with SMTP id p19-20020a1c7413000000b004002dc52006mr1009322wmc.36.1692797301971;
        Wed, 23 Aug 2023 06:28:21 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003feee8d8011sm11280110wmi.41.2023.08.23.06.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:21 -0700 (PDT)
Date: Wed, 23 Aug 2023 15:28:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	shayd@nvidia.com, leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <ZOYJdAiKzlkAEMYK@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
 <20230817193420.108e9c26@kernel.org>
 <ZN8eCeDGcQSCi1D6@nanopsycho>
 <20230818142007.206eeb13@kernel.org>
 <ZONBUuF1krmcSjoM@nanopsycho>
 <20230821131937.7ed01b55@kernel.org>
 <ZORXVr4bcTlbstj8@nanopsycho>
 <20230822082833.1cb68ef7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822082833.1cb68ef7@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 22, 2023 at 05:28:33PM CEST, kuba@kernel.org wrote:
>On Tue, 22 Aug 2023 08:36:06 +0200 Jiri Pirko wrote:
>> >I'm thinking about containers. Since the SF configuration is currently
>> >completely vendor ad-hoc I'm trying to establish who's supposed to be
>> >in control of the devlink instance of an SF - orchestrator or the
>> >workload. We should pick one and force everyone to fall in line.  
>> 
>> I think that both are valid. In the VF case, the workload (VM) owns the
>> devlink instance and netdev. In the SF case:
>> 1) It could be the same. You can reload SF into netns, then
>>    the container has them both. That would provide the container
>>    more means (e.g. configuration of rdma,netdev,vdev etc).
>> 2) Or, your can only put netdev into netns.
>
>Okay, can you document that?
>
>> Both usecases are valid. But back to my question regarding to this
>> patchsets. Do you see the need to expose netns for nested port function
>> devlink instance? Even now, I still don't.
>
>It's not a huge deal but what's the problem with adding the netns id?
>It's probably 50 LoC, trivial stuff.

Not so trivial after all, with the locking and objects lifecycle
(port can disappear before nested instance). Uff.

