Return-Path: <netdev+bounces-38478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FF7BB212
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180A81C20962
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A2563C6;
	Fri,  6 Oct 2023 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sbDz0kRj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A564414
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 07:22:08 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506CCA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 00:22:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so6386439a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696576924; x=1697181724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJo7oIZR3gjhuk1oGKEv7qNc+qhsoFP87IRQei8vad8=;
        b=sbDz0kRjQVm4ntQ/hFROm6AcRavH8gpd8DozFc1Weq/4T0XSDaYpYnYKjOQ9zL5Wg4
         y81lLmSluMrhuWCjGHpDQRDA27OhUCXpu7XUGCpfPVYGPpES1bgNEkl3IgDyYN0xlEeq
         9WOD0CgpKooBaBmJQfyg1z/o0b5PQpfW5DsnB/Jg/jJ1ZFJ/mQXFBvTbfQwoNubatzd/
         WukGj8LqYl9yWTUkbHe7+BKTxSbhiDTh0GDZnI/dqYoNqw+LivCIeTHBj+CaNe8XNxiQ
         lQAfdsr5wKtTvSrjhg89sIvhCgsy5ukiT0VP0O20gBIBY8U651yRSxZ4urerdOjmH7T1
         peIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576924; x=1697181724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJo7oIZR3gjhuk1oGKEv7qNc+qhsoFP87IRQei8vad8=;
        b=L/JwJ1tk9ddAWy/XepRF+fZV++3xfgJCuHUWnR/CEkh8Bc77+wK3RTKIOcpThE58hN
         Ps13QHEekguZpOAhvCniqwc0p5b90r9L/xxSuyDuSTVvQan/OVZkFSRngU3SjIebi3xf
         VhiAkPqczFdpzkL71/iPZuxLiJHO8lR0aueBnCkstXJzz2Li2+1rmxV+0Fm7KTiy8qeR
         1CQFKXXJC4TapvoEHBk2rx7XtzuDDLroT4xbO39Puzk0TP2M1SyPrqHyu0L7sXPwEkcK
         fBFK1jeJKd68b7BKo0iavyb42WfzFm7xN2e0Dp1CNYiKS048wa71ecypQZHlSPFhQuIU
         Qayg==
X-Gm-Message-State: AOJu0YxZCc0XlQplbv3CWIheWiun2NMeYJpalgYSBILg4+WHLRDVGQX0
	nm0UIXatg8R8HQ22F1iuuAcyAw==
X-Google-Smtp-Source: AGHT+IEpwu2IfmcUb1JNknderdNOgeA9FwzPBt9SwTmTEQX6Y7O+8wxwil0ZdOy0j3qmWvqE6Jkxbw==
X-Received: by 2002:a05:6402:22a2:b0:52f:86a1:3861 with SMTP id cx2-20020a05640222a200b0052f86a13861mr4415977edb.7.1696576923837;
        Fri, 06 Oct 2023 00:22:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7de0e000000b00532eba07773sm2162292edv.25.2023.10.06.00.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:22:02 -0700 (PDT)
Date: Fri, 6 Oct 2023 09:22:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZR+1mc/BEDjNQy9A@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
 <20231005183029.32987349@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005183029.32987349@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 03:30:29AM CEST, kuba@kernel.org wrote:
>On Tue,  3 Oct 2023 09:43:49 +0200 Jiri Pirko wrote:
>> To fix this, don't take the devlink instance lock when putting nested
>> handle. Instead, rely on devlink reference to access relevant pointers
>> within devlink structure. Also, make sure that the device does
>
>struct device ?

Yes.


>
>> not disappear by taking a reference in devlink_alloc_ns().
>
>> @@ -310,6 +299,7 @@ static void devlink_release(struct work_struct *work)
>>  
>>  	mutex_destroy(&devlink->lock);
>>  	lockdep_unregister_key(&devlink->lock_key);
>> +	put_device(devlink->dev);
>
>IDK.. holding references until all references are gone may lead 
>to reference cycles :(

I don't follow. What seems to be the problematic flow? I can't spot any
reference cycle, do you?


>
>>  	kfree(devlink);
>>  }
>
>> @@ -92,9 +93,8 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
>>  		return -EMSGSIZE;
>>  	if (devlink_nl_put_handle(msg, devlink))
>>  		goto nla_put_failure;
>> -	if (!net_eq(net, devlink_net(devlink))) {
>> -		int id = peernet2id_alloc(net, devlink_net(devlink),
>> -					  GFP_KERNEL);
>> +	if (!net_eq(net, devl_net)) {
>> +		int id = peernet2id_alloc(net, devl_net, GFP_KERNEL);
>>  
>>  		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
>>  			return -EMSGSIZE;
>
>Looks like pure refapeernet2id_allocctoring. But are you sure that the netns can't
>disappear? We're not holding the lock, the instance may get moved.

Yeah, I think you are right. I can do peernet2id_alloc during devlink
init/netnschange and store id into devlink structure. That should solve
this.


>
>Overall I feel like recording the references on the objects will be
>an endless source of locking pain. Would it be insane if we held 
>the relationships as independent objects? Not as attributes of either
>side? 

How exactly do you envision this? rel struct would hold the bus/name
strings direcly?

