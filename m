Return-Path: <netdev+bounces-23571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482976C8BB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC139281CE1
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF253B6;
	Wed,  2 Aug 2023 08:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D21FC4
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:51:56 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1611FEC
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:51:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so29606055e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690966311; x=1691571111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3turL+bxvSdqD2YBiYhAh2OUJfkLRe54LDfjmZfuE0s=;
        b=UGD+ATZQvJ1tylSqBXfZXn6mCwyJKurYa+IiWwI4OnwAuEVKxi5LiSNuiC51XACgY4
         6yT6Xs4sUkkGLh7QXEhqpFtz8i/watkgGkKBtR/v43fUZID0m/z93dhv7Fp6zWpwEdzh
         GU1weQYgeTqQ0I47mSABLKigm6PuW1wwxyuLPf25dZkqsrxZ9JSlncrypvOgLgIu1tGd
         iFCq3ortemm9WirGPiqP2Xpo6TCnkwVajMKsr0q7ZbIKt1BxGd5W+DERYRwP+jLQJjPI
         tb6FEfdONbf6DNZZeCzjhyZNg3WbWBGzS6nUIkfgla1GxUpkI7CAb3SLwF7iJQmbvTol
         C8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690966311; x=1691571111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3turL+bxvSdqD2YBiYhAh2OUJfkLRe54LDfjmZfuE0s=;
        b=BdHbVkOMvJN6LdNxNeZcB6av8v9eRJisldXeEvXSWZmvvqLsE6F0VM7/A8MEVtXb6I
         /xlZD90uXI2FVgvPdMg+oNbgLNUz8V4RwTHnq3iAXeXCFYupFl7G+NCl8BqFcPm4hLIl
         lfx+tEy1J+u88u/Hf6TyBdFmuWrmxn3uVu2RFAEPRM0ONYapOF3DMbi1NMVmoH7O1Rvo
         tQtvXYFch+Ve+dDS+Yx9NdoXG4PNAL01AyAeYm/BGvamj0rSJcC52bus1vzCouBmsY68
         Eoeas+FqAAUqnn7dyETZqYIwd8v+2AqS4OXc2ytiivsbf49BmlHa3TFMfCyVUuuoLn4J
         LvZg==
X-Gm-Message-State: ABy/qLZ5qqVxNAKY1vyQSEFH1sIF1vL9d4dw29JkWMtB8VxATeuBmFJw
	fjKoFQpFtTMk8+HVx6oXLyniGA==
X-Google-Smtp-Source: APBJJlFcyO98OWpdT4teWJG/lU+6IEohDTlM8+NElwuL7ZySrq2I8DHOxUmjDlsAmzU8W0BGUsC/sw==
X-Received: by 2002:a7b:cb88:0:b0:3fc:f9c:a3e6 with SMTP id m8-20020a7bcb88000000b003fc0f9ca3e6mr4289248wmi.9.1690966310798;
        Wed, 02 Aug 2023 01:51:50 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0ac500b003fc02218d6csm1112614wmr.25.2023.08.02.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:51:50 -0700 (PDT)
Date: Wed, 2 Aug 2023 10:51:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 2/8] ynl-gen-c.py: allow directional model for
 kernel mode
Message-ID: <ZMoZJUZmw2rNAoex@nanopsycho>
References: <20230801141907.816280-1-jiri@resnulli.us>
 <20230801141907.816280-3-jiri@resnulli.us>
 <20230801112703.2690f706@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112703.2690f706@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 08:27:03PM CEST, kuba@kernel.org wrote:
>On Tue,  1 Aug 2023 16:19:01 +0200 Jiri Pirko wrote:
>> Directional model is only considered in uapi mode. No reason to forbid
>> directional model for kernel mode, so lift the limitation.
>
>I mean, the reason is that it's not tested so this way
>I don't get people sending "fixes" claiming stuff that's
>not supported is broken :)

I re-phrased the patch description accordingly, hopefully to your
satisfaction.


