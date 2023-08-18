Return-Path: <netdev+bounces-28730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB378065A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413651C2159E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978714F9A;
	Fri, 18 Aug 2023 07:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0014F72
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:30:22 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6430DF
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:30:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso6059965e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692343819; x=1692948619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeNdkErbl4pXDesfGI7sfXJOs6yIzvoXVqW+VCY5JVM=;
        b=eVvE8PPxupteSU911JS3sG3VtNvXMTgZixjoClw0r6VaWWHNiQl1tyyKwnrobtGnzY
         v2mah+T8jSTcXRAzps4j9RtjcSIwlGc3Z6hcfkxpymQI4OZmiZ63K1Z7nHuocgkzXCT+
         NUkU/pBNdlVPzNqhRGxt/PK2rGzEqVm9AXOEnalC8e7LyupnClWkm1VE/0yVUwPL/Vkf
         wGfBKyr7Sn8fiBZNrBmdm+pHPX1RJgEDrK/RVXgEUnn4nwZiHlIcyEW4fzNe0C7Ak4D1
         r2sFEkgi3cwdQnRwsCCKAswguzudRKo57X5TnJ6e/a3vmlx04jSpxQHTa70XfLXPCsrN
         rA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692343819; x=1692948619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeNdkErbl4pXDesfGI7sfXJOs6yIzvoXVqW+VCY5JVM=;
        b=BcuYgzCyd19p6Y1omLCOMfV7vZxtJlhq7/EqYd3LXHam8p3UITzOPhJbHiisTW1Inw
         1scqLXkQ1deOLWdRB4hVDrIkvaTz+L++ukB0QNtFBXXyCfXA9ZuhfizZjXm3M3OvrrM7
         iBbxzaVwWMw3gA1dbs5dSf/yhYT+ExD/adktiN3t7HWsGbce1wW4q1q70jeQLeveFJJ5
         uDTuUrFtECN8nx3zz5p108OIu7XOrFOYZUNDyB/jtNIwhPkNY20MrWhdtsSDb29uXcfd
         2U+svGeGdWA/vX6tedm1QfpXvXsUAVGEhrAJYOSxhpBP+KP/2bU2F/kPcLz4ENiHheCz
         BoaA==
X-Gm-Message-State: AOJu0Yyiq/rvwdarlFqba79tgcfNTwop8j4M+fhJ32KtYxrN5+Yvgrys
	Kp/G2SbOFLT8lN9dwYULRncTDg==
X-Google-Smtp-Source: AGHT+IEwMexq/hye6IAH4Zldly2KJC4VPUmaiT75NytACekRcywunxWpZW91SRTHbe0vHnUTb7MlIQ==
X-Received: by 2002:a7b:c3d7:0:b0:3fe:ad3:b066 with SMTP id t23-20020a7bc3d7000000b003fe0ad3b066mr1505860wmj.41.1692343818931;
        Fri, 18 Aug 2023 00:30:18 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b003fe2b081661sm5383987wmm.30.2023.08.18.00.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 00:30:18 -0700 (PDT)
Date: Fri, 18 Aug 2023 09:30:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	shayd@nvidia.com, leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <ZN8eCeDGcQSCi1D6@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
 <20230817193420.108e9c26@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817193420.108e9c26@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 18, 2023 at 04:34:20AM CEST, kuba@kernel.org wrote:
>On Tue, 15 Aug 2023 16:51:51 +0200 Jiri Pirko wrote:
>> Currently, the user can instantiate new SF using "devlink port add"
>> command. That creates an E-switch representor devlink port.
>> 
>> When user activates this SF, there is an auxiliary device created and
>> probed for it which leads to SF devlink instance creation.
>> 
>> There is 1:1 relationship between E-switch representor devlink port and
>> the SF auxiliary device devlink instance.
>> 
>> Expose the relation to the user by introducing new netlink attribute
>> DEVLINK_PORT_FN_ATTR_DEVLINK which contains the devlink instance related
>> to devlink port function. This is done by patch #3.
>
>The devlink instance of the SF stays in the same network namespace 
>as the PF?

SF devlink instance is created in init_ns and can move to another one.
So no.

I was thinking about this, as with the devlink handles we are kind of in
between sysfs and network. We have concept of network namespace in
devlink, but mainly because of the related netdevices.

There is no possibility of collision of devlink handles in between
separate namespaces, the handle is ns-unaware. Therefore the linkage to
instance in different ns is okay, I believe. Even more, It is handy as
the user knows that there exists such linkage.

What do you think?

