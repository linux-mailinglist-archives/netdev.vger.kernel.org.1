Return-Path: <netdev+bounces-34550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7887A499B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C561C20B91
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43B51CF81;
	Mon, 18 Sep 2023 12:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638B79CD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:29:45 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE398E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:29:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f737b8b69so4269509f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695040181; x=1695644981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wpmJkdpb+JDSVO1kMGWt31z3W/TtnzYsqMLsdNp6zI=;
        b=Ban7WxdrAbJBdtDnGUl7HHC8KHNpMgFhdxYlCcJf0LCvxTyauQZhWJWiLu+tpNC7gA
         0Brv/lghCnZst/1bconUL/+OAP66qgzLfe3YoQNyVVio5x3kxKQsdPtqSubazv+Dbz2a
         8sv26aIIckf4Tmzsd3+BvngjN651i9G9enWVmA7fsAe+Ww4U2rWXaF1b+Eq8pYzBFzVF
         Bzkd696MBBBr1LEm4A+J5ortvvQ6IkskqDXzyMqsmAT97HhTZZ9OYvnySriiH/6go+DL
         fgBEMPp0WPCFC4MaWz5Q/cs3BORz4SYkIUQG+o+b94hNXuL+RByLPbo5BIMXIDWekvdb
         YKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040181; x=1695644981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wpmJkdpb+JDSVO1kMGWt31z3W/TtnzYsqMLsdNp6zI=;
        b=X36/kia8QqUFFwoDBw7bIjNASLAt139rIpYqh11TJyDnRZVmA95Geez4qovXNYieny
         46qwJqt9pDCGTdJmCjrT3o63rR45EepzaDQmqOZTRMX9w4z3I3wChw6W5/GXul7QnZxV
         2UegAD+dkFi40KsMUkSkE89PdVi95X3zMKuVYpV7bwvdJJioFvC1lLWadMF4UwXEhY+v
         zx6UZCmUeaLW7owxuIBSQF/mw99rNn4y6pDoLz83PFoKXVgKTnLJl3M/bZZhyXnnEKUu
         pQKbmrlK09PYd5RVel89nvXyxSPXokqp6bnZ7KTz2HErCCyL+boGGdmBTXv/cnp+05Oq
         lIbw==
X-Gm-Message-State: AOJu0YzhVHNbNR2+QPZ4puHgDMXUK8eOSJRq6m9D5MkoK4FVhz9XaG34
	P3P+/1yy/KMa3c9MpEH61z3Gdg==
X-Google-Smtp-Source: AGHT+IE8Gm1RFKQ3s1xaI4wI/BrOYHA8+kE/YIKun9jPjNSyVwzuOV9rZ4TFt+049v0yi/7md3O8TQ==
X-Received: by 2002:a5d:5088:0:b0:317:e542:80a8 with SMTP id a8-20020a5d5088000000b00317e54280a8mr7434738wrt.15.1695040180771;
        Mon, 18 Sep 2023 05:29:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l26-20020a056000023a00b0031ff1ef7dc0sm9633304wrz.66.2023.09.18.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:29:40 -0700 (PDT)
Date: Mon, 18 Sep 2023 14:29:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com
Subject: Re: [patch iproute2-next 2/4] devlink: introduce support for netns
 id for nested handle
Message-ID: <ZQhCssHQIYEIn4Wn@nanopsycho>
References: <20230918105416.1107260-1-jiri@resnulli.us>
 <20230918105416.1107260-3-jiri@resnulli.us>
 <20230918113448.c6qypl3xsppv4usz@DEN-LT-70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918113448.c6qypl3xsppv4usz@DEN-LT-70577>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Sep 18, 2023 at 01:34:48PM CEST, daniel.machon@microchip.com wrote:
>> +static int nesns_name_by_id_func(char *nsname, void *arg)
>
>Hi Jiri,
>nesns -> netns?
>
>> +{
>> +       struct netns_name_by_id_ctx *ctx = arg;
>> +       int32_t ret;
>> +
>> +       ret = netns_id_by_name(nsname);
>> +       if (ret < 0 || ret != ctx->id)
>> +               return 0;
>> +       ctx->name = strdup(nsname);
>> +       return 1;
>> +}
>> +
>> +static char *netns_name_by_id(int32_t id)
>> +{
>> +       struct netns_name_by_id_ctx ctx = {
>> +               .id = id,
>> +       };
>> +
>> +       netns_foreach(nesns_name_by_id_func, &ctx);
>
>.. and here

Okay, will fix this typo. Thx.


>
>> +       return ctx.name;
>> +}
>> +
>
>/Daniel

