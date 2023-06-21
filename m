Return-Path: <netdev+bounces-12605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577FC73849E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E91F1C20E15
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731C171BB;
	Wed, 21 Jun 2023 13:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE88DF4A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:14:40 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2843170F
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:14:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31129591288so4150282f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687353277; x=1689945277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1U1vCPMp25LN6ApHDbwGudHhQtcWN7h3cd02FiA7mY=;
        b=OElRUEHuGRh5QBZpt4SvVwcj3hz+lE+By3A3uYVD6P9JWdfk4JpYcYNEShde5EeO+3
         DDdWKeQf4mKDV8+SbPN4UZWpmMw0jOGbPeNH4ZKmVl1mZkTAgM99evyFOiHn3ZctV378
         koDn+zF7j3vgokNeGPy9ib1fH/avsVt5eVuo7YYR4g9/lOoguBoc+LQJc6daNUrGyN7r
         MyRHaSNbkT+XKJ3Zt3+z313mir/mg6rUHbSHn5ke/iTRtDBMMLV/geB/hm+UkAHTqnBU
         gtJPt4b6x8acpN/TypKKy6A3AiJOLA0LUNnlPjYph9VeP4AGDv+X5LVFi1qD1bWsh4Px
         BDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687353277; x=1689945277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1U1vCPMp25LN6ApHDbwGudHhQtcWN7h3cd02FiA7mY=;
        b=ZX42LantZSBPD3vSGPfYvPPWcEf/bZrwefqDZX0JnCOVsWiepO7CIee9JXTLNsejK5
         jK5hTmXKM98Q7w8ldGcxDtYdfmUVzl71a4eBlyQagaL9TbDlKUDLdExBKnsLYmjQcJMy
         gKe2o6gWGbXZ77a5rz6Zt0we7UJM3rb53ouT5uC3rVc7Qe9qpcZFFq59TMiuH27YnBP7
         EK6u2tKYt54RctV5PIvmwRnHKxUKkrMVPf9DC1H8DZMe4mBiQ7+MpdGEkqxRyn+VcO9c
         pFLy9EqzatnQ395uvOnA4tehlf6AlZKFne2rS3Wh58D5+pdFps+OiZk6v+HF4I+dN7IL
         YlWg==
X-Gm-Message-State: AC+VfDwxB7WAjFPBVH7/+mi8RK6sWwt+wGkOKjaIubBgy0zge7sdAZ7u
	02WMo/nNt+DqjgI0OYudK2lt5w==
X-Google-Smtp-Source: ACHHUZ5IUkSlzsbt4j6AG+re/6Qk/Qju2LbuZ5aGwyE+KoNnbLloDqo7eaQbNFjNtZL+h8XUeFuswQ==
X-Received: by 2002:a5d:650b:0:b0:30f:b3d1:8f99 with SMTP id x11-20020a5d650b000000b0030fb3d18f99mr10376365wru.38.1687353277234;
        Wed, 21 Jun 2023 06:14:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe842000000b0031274a184d5sm4453058wrn.109.2023.06.21.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:14:36 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:14:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJL3u/6Pg7R2Qy94@nanopsycho>
References: <20230610014254.343576-15-saeed@kernel.org>
 <20230610000123.04c3a32f@kernel.org>
 <ZIVKfT97Ua0Xo93M@x130>
 <20230612105124.44c95b7c@kernel.org>
 <ZIj8d8UhsZI2BPpR@x130>
 <20230613190552.4e0cdbbf@kernel.org>
 <ZIrtHZ2wrb3ZdZcB@nanopsycho>
 <20230615093701.20d0ad1b@kernel.org>
 <ZItMUwiRD8mAmEz1@nanopsycho>
 <20230615123325.421ec9aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615123325.421ec9aa@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 15, 2023 at 09:33:25PM CEST, kuba@kernel.org wrote:
>On Thu, 15 Jun 2023 19:37:23 +0200 Jiri Pirko wrote:
>> Thu, Jun 15, 2023 at 06:37:01PM CEST, kuba@kernel.org wrote:
>> >On Thu, 15 Jun 2023 12:51:09 +0200 Jiri Pirko wrote:  
>> >> The problem is scalability. SFs could be activated in parallel, but the
>> >> cmd that is doing that holds devlink instance lock. That serializes it.
>> >> So we need to either:
>> >> 1) change the devlink locking to be able to execute some of the cmds in
>> >>    parallel and leave the activation sync
>> >> 2) change the activation to be async and work with notifications
>> >> 
>> >> I like 2) better, as the 1) maze we just got out of recently :)
>> >> WDYT?  
>> >
>> >I guess we don't need to wait for the full activation. Is the port
>> >creation also async, then, or just the SF devlink instance creation?  
>> 
>> I'm not sure I follow :/
>> The activation is when the SF auxiliary device is created. The driver then
>> probes the SF auxiliary device and instantiates everything, SF devlink,
>> SF netdev, etc.
>
>Sorry, maybe let's look at an example:
>
>$ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 11
>
>needs to print / return the handle of the created port.

Yep, that is what happens now.


>
>$ devlink port function set pci/0000:08:00.0/32768 \
>               hw_addr 00:00:00:00:00:11 state active
>
>needs to print / return the handle of the devlink instance

Right, that makes sense. I will look into adding that. It's a bit
tricky, as the instance might actually appear on a different host, then,
there is nothing to return here.


>
>> We need wait/notification for 2 reasons
>> 1) to get the auxiliary device name for the activated
>>    SF. It is needed for convenience of the orchestration tools.
>> 2) to get the result of the activation (success/fail)
>>    It is also needed for convenience of the orchestration tools.
>
>Are you saying the activation already waits for the devlink instance to
>be spawned? If so that's great, all we need to do is for the:

Yep.


>
>$ devlink port function set pci/0000:08:00.0/32768 \
>               hw_addr 00:00:00:00:00:11 state active
>
>to either return sufficient info for the orchestration to know what the
>resulting SF / SF devlink instance is. Most likely indirectly by adding
>that info to the port so that the PORT_NEW notification carries it.

Yeah, we need to add the same info to the GET cmd.


>
>Did I confuse things even more?

No, no confusion. But, the problem with this is that devlink port function set
active blocks until the activation is done holding the devlink instance
lock. That prevents other ports from being activated in parallel. From
driver/FW/HW perspective, we can do that.

So the question is, how to allow this parallelism?



>
>As a reminder what sparked this convo is that user specifies "sfnum 11"
>in the example, and the sf device gets called "sf.1".

Yeah, will look into that as well.

