Return-Path: <netdev+bounces-39828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB977C49A1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5831C20BDD
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5EFC09;
	Wed, 11 Oct 2023 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XRXMBZH6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCFCD2F0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:10:35 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52898
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:10:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99de884ad25so1145517766b.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697004632; x=1697609432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jm0uZxHMOJmgYhkcGqxg/YI4JPoYQgTRWeNJzX7sTQY=;
        b=XRXMBZH689s6SE9BSAfEej4SPEKn7R7smWO/dHY7U8z5K1C4xq8qoxSHtYcWF3bRgk
         ObxAEfuUywsfq9EhjNjmXU7AN3J8FekE9Y0GsSTA0VmMHmsBrsH6+xCIJyDAtosHUIPY
         8C8oRxRFgpY4DkypRoN82f6rBrTdueUJinEC74ZIJRcMUL62ZItnqvCvTj5BmDfyidRQ
         P7ZMS4ovZ+MU6abdMR1aNBpdH7fNbV8MBT8sF5IwiRMxRTw2OlOnEWAAtdtJdzUFKslb
         vIii7VBr4nHxt5dSnaOQBYvGfKJuREZLtFupSG7zJZrD3bkYDGwa3oCw0PZyoTiz4hjh
         q32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004632; x=1697609432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm0uZxHMOJmgYhkcGqxg/YI4JPoYQgTRWeNJzX7sTQY=;
        b=ImTbQLfO7ByaeYjP4RAcSHnkHF0vlbqvKIEmssYi4i2WLSwPuilL7xe29Gyo/w7htI
         lvdxEBLYhkMAKz2vKZglCXUaPISYMjNNMEPPJk/NKcH/cNpP1VYjAxZwFKBIB+TLkTXR
         etaKBTRmGQJJdml0Wq4z8HKdNAb8TOyCfXgrr4cW25pQBIwoUwOcBF8SkjGCos7AmRjJ
         21t/CjMeNm6NJmM3z2rOrXw4Ao9h13S/snCTY9trYyFKnm6vbRyzZng13+1V/fqJI/iY
         vrSm31LwF6lYHy7HjQa+YHy0GLugqpTXmZC+D6dLs48MVle2KbLd3aGtQIgGXedVT2yL
         3kfw==
X-Gm-Message-State: AOJu0YweAt7Wc7DVGqX87xAcycpuUW6AEiCiKyFYLJlPRq+0I5oTLhyN
	kEFgpGPOV5dSVCqp227Ti7mpDxA6IUzmjgJkcoI=
X-Google-Smtp-Source: AGHT+IG/5kAacXk8hMU4fXeMHZnvoZcmqwE+ONbjMm0k5toxvvJoE90y7mU2w6p5bHwowmaa18iXKg==
X-Received: by 2002:a17:906:2249:b0:9ae:5ba3:9d8f with SMTP id 9-20020a170906224900b009ae5ba39d8fmr18593920ejr.17.1697004632136;
        Tue, 10 Oct 2023 23:10:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lu20-20020a170906fad400b0099bcd1fa5b0sm9347842ejb.192.2023.10.10.23.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:10:31 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:10:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v2 0/3] devlink: don't take instance lock for
 nested handle put
Message-ID: <ZSY8Vg0ztfMN93uV@nanopsycho>
References: <20231010091323.195451-1-jiri@resnulli.us>
 <20231010121015.5d9bb45d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010121015.5d9bb45d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 09:10:15PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 11:13:20 +0200 Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Lockdep reports following issue:
>
>Weren't you complaining about people posting stuff before discussion
>is over in the past? :)

Sure, but it isn't? I believe that this fix is needed regardless of the
A->B objects lifetime. If I'm missing something, sorry about that.

