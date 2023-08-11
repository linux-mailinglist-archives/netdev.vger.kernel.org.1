Return-Path: <netdev+bounces-26675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C77788B5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8D1C20BBF
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0753539B;
	Fri, 11 Aug 2023 08:05:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19054C94
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:05:09 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD010FB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:05:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so15537655e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691741105; x=1692345905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8MNjAdO3GlZOOEGn1OYYItZUYi8AMXG1EBkP3RU7DI=;
        b=EKxhtplHRRFSZYPRCv/hDMRd7FjMoLn3WF7Rt01Bu6fZWhWPF7ohCjJwrGSLBJY4AU
         3FHGjHyxva9KTbuAP1+FB5/gwuHqQflukz/YlvgZjcuS7PO1KMojRqSxnFLsWfTfP7+/
         GGd/q5FlPa3AOea15BVjg/V3GZbNESk9w4+R7UTTs+8N5RTHyVWs4MxsAVVZZNhq3Sc2
         KpGV5w1VDHo4/q7RtaOGNk3YdlxQ7EW6yJUFjeBQaiuQMfqpzqppjZe4833Jtc97kDy4
         SJHioidxtyaRjWa78LskJ7obleK/iEp768uXUGfky+6udC4aDXhnEFEOeUNtZaLDjxCH
         7Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691741105; x=1692345905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8MNjAdO3GlZOOEGn1OYYItZUYi8AMXG1EBkP3RU7DI=;
        b=hYn6s/ap/ghbSkFvyevTLXidIya/zr/VKv8FRY08mCij07FRH1UEePlvOiBeTq1QoO
         IY2qA0BGXevM+nQL5NhqobMhDmTeNKnh9L1PIsoI1SFntSRAMjTltfWJ5EEdaD2BAZqI
         9q2Le7Bpvo2RcQ/chkwhJaaYdJ2HUDS5pvyLK4ukpUyVHTLe5mz2j2itZV5d/RXVl638
         v4tq1C3zn440Eo5BrBkMWz1ugD7qsySUnbayTaYvPAn9gvLq6DB05mFR9fIolB+S8cjz
         AHiJX13ekewoDmwAhdhV8qOkeopg3ZSZP1URZhKou/e9dgSD1NSgU0nLLgQVuuZhctyt
         RZYw==
X-Gm-Message-State: AOJu0Ywd4/n6iHmiqGdtc+s84L8lFUrU1AfspYiTcguNd1XldelLlQwo
	HTUYXWgaqzEQqU1Vo/156J4dNA==
X-Google-Smtp-Source: AGHT+IEGyAM5hD8Q08FLRA6h5iyhzjfoEt7KhCJns5QwcJoTV8LX3rFnIyi3GB7QvlrxZI60eZOcDg==
X-Received: by 2002:a05:600c:82c5:b0:3fe:90f:8496 with SMTP id eo5-20020a05600c82c500b003fe090f8496mr976974wmb.1.1691741105405;
        Fri, 11 Aug 2023 01:05:05 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q12-20020a7bce8c000000b003fe26244858sm7273770wmj.46.2023.08.11.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 01:05:04 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:05:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v2] devlink: Delay health recover notification until
 devlink registered
Message-ID: <ZNXrr7MspgDp8QfA@nanopsycho>
References: <20230809203521.1414444-1-shayd@nvidia.com>
 <20230810103300.186b42c8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103300.186b42c8@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 10, 2023 at 07:33:00PM CEST, kuba@kernel.org wrote:
>On Wed, 9 Aug 2023 23:35:21 +0300 Shay Drory wrote:
>> From one side, devl_register() is done last in device initialization
>> phase, in order to expose devlink to the user only when device is
>> ready. From second side, it is valid to create health reporters
>> during device initialization, in order to recover and/or notify the
>> user.
>> As a result, a health recover can be invoked before devl_register().
>> However, invoking health recover before devl_register() triggers a
>> WARN_ON.
>
>My comment on v1 wasn't clear enough, I guess.
>
>What I was trying to get across is that because drivers can take
>devl_lock(), devl_register() does not have to be last.
>
>AFAIU your driver does:
>
>  devlink_port_health_reporter_create()
>  ...
>  devlink_register()
>
>why not change it to do:
>
>  devl_lock()
>  devl_register()
>  devl_port_health_reporter_create()
>  ...
>  devl_unlock() # until unlock user space can't access the instance

This patch is not about user accessing it, this is about
notification that would be tried to send before the instance is
registered. So the lock scheme you suggest is not necessary. What helps
is to move devl_port_health_reporter_create() call after register.

We have the same issue with mlxsw where this notification may be called
before register from mlxsw_core_health_event_work()

Limiting the creation of health reporter only when instance is
registered does not seem like a good solution to me.

As with any other object, we postpone the notifications only after
register is done, that sounds fine, doesn't it?

>
>?
>

