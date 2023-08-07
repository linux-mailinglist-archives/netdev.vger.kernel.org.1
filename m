Return-Path: <netdev+bounces-25051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8F772C66
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC05281496
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3696125D0;
	Mon,  7 Aug 2023 17:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FA107A5
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:13:03 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E0271B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 10:12:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso25394215e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691428352; x=1692033152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmrtWfbdewUvfJZfFZ6nNRIhd9inDaYkaWym9JjXAUc=;
        b=L/WsV4K+Z+9n0PTuVOnajbs+NV/mwmq3JXVFXWZ17G4USdwFdCp8+ulWtj3kOnriOj
         RSaLj4x3tSE0YjMJKD43uRovyiDnBcPHdrV+6/caybDY2q6tNRTNT/h1tBhy/bw5PXk2
         xqdxGCf0ZPQqRUMtmHr3uT1IAYN/qO3E+WFU5IREBpe6uJJ2pNywuQfmqZUf6lTlvqW/
         bzFxb+bnbKjEanTodJCVskbD3dcpxJAfjGKXGutVBEkHkiy3B0tMXODqZZNKyce/eNjM
         HqdwPhERiaeht270dV/cLmYyYZq5t4FvPWjxJIezk8/iqdGxUpTeeq9+vGDELIjDhT/B
         uadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428352; x=1692033152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmrtWfbdewUvfJZfFZ6nNRIhd9inDaYkaWym9JjXAUc=;
        b=Uem62zRiGMl+XyvRdwnfVbJ+A2CkNAwq7pFK+eISkid1J4RPtiZNM4QOQTyCaAHlDc
         dvvwZkZCdvx092w3bYAcjRdCHBynUOrC97dkdf8bxRONmvME20QqS/qzG6hq3DcLH6h5
         Y8XP8W6T7iS0VXjYiJ0dvuW9SCofo0IopCE0VXsXqJ0Il5gceyjZnsmlzmmWZwmN37/q
         huu5K+O6owyn9x2mV3phpLsrHzjZ1rmiHFOjCSRq1iYD+s+VtlszjyrrPe/9ij6eGGg0
         SxOXQl5dp9JabA/1nrLOultkv4r9sUMXOCQP1eBj1wpXvNkCJuM/2hKRYRrcgW5OyS7U
         091g==
X-Gm-Message-State: AOJu0YzKHH8r/QbggvmN8PvzAxSFDwYaEbqMjXPklTC9Is2aZcMYKY1F
	CaGV/aCgi3dlt822qVQb4iin9c/kd0DDGZU1HpxuLN4L
X-Google-Smtp-Source: AGHT+IGpK/yZXNcDHaB5yABkq6k5A+8gI7uidhb8OPo8ykqF2xgFqcDl1uNumn6CVb3DPDAK77hG/Q==
X-Received: by 2002:a05:600c:364d:b0:3fb:abd0:2b52 with SMTP id y13-20020a05600c364d00b003fbabd02b52mr5935693wmq.13.1691428351840;
        Mon, 07 Aug 2023 10:12:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0031417fd473csm11148500wrw.78.2023.08.07.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:31 -0700 (PDT)
Date: Mon, 7 Aug 2023 19:12:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZNEl/hit/c65UmYk@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
 <20230804125816.11431885@kernel.org>
 <ZM3tOOHifjFQqorV@nanopsycho>
 <20230807100313.2f7b043a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807100313.2f7b043a@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 07, 2023 at 07:03:13PM CEST, kuba@kernel.org wrote:
>On Sat, 5 Aug 2023 08:33:28 +0200 Jiri Pirko wrote:
>> >I'm not sure if you'll like it but my first choice would be to skip
>> >the selector attribute. Put the attributes directly into the message.
>> >There is no functional purpose the wrapping serves, right?  
>> 
>> Well, the only reason is backward compatibility.
>> Currently, there is no attr parsing during dump, which is ensured by
>> GENL_DONT_VALIDATE_DUMP flag. That means if user passes any attr, it is
>> ignored.
>> 
>> Now if we allow attrs to select, previously ignored attributes would be
>> processed now. User that passed crap with old kernel can gen different
>> results with new kernel.
>> 
>> That is why I decided to add selector attr and put attrs inside, doing
>> strict parsing, so if selector attr is not supported by kernel, user
>> gets message back.
>> 
>> So what do you suggest? Do per-dump strict parsing policy of root
>> attributes serving to do selection?
>
>Even the selector attr comes with a risk, right? Not only have we

Yep, however, the odds are quite low. That's why I went that direction.


>ignored all attributes, previously, we ignored the payload of the
>message. So the payload of a devlink dump request could be entirely
>uninitialized / random and it would work.

Yep.

>
>IOW we are operating on a scale of potential breakage here, unless
>we do something very heavy handed.

True. I can easily imagine an app having one function to create both do
and dump message, putting in crap as bus_name/dev_name attrs
in case of dump.


>
>How does the situation look with the known user apps? Is anyone
>that we know of putting attributes into dump requests?

I'm not aware of that.

