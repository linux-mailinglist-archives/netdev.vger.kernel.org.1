Return-Path: <netdev+bounces-26680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3275277890F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B7D1C20E26
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9912113;
	Fri, 11 Aug 2023 08:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A41869
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:41:10 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758902737
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:41:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317715ec496so1613767f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691743266; x=1692348066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XiYtcfIpRLvVC1+RLwJafSeDJ5lmCUvHEkiwiYIzHg=;
        b=Z+rMMO1AS7M2gITb+Qc0g2lHb3Ytc+cq2IKsKSis5p148kveMBMII+MPZEtqH70qnb
         H0n+PxY2g0gbyCMi7pFAlF1rWaC5AljEJBhxgULFPGTn6A7ImGdErPcb93WkP1WA4Sgt
         NDcGxOD/flP61L3lzeGwu/H/aE46/t0MUhZ2/Va7i7ByeZgvErPskqHXQSbKZWf4H/1B
         zjP+n6fx+PObyacxATD7D7XG9GSzVGxWJUMXQNpyi9/U9vS6jjYoBpDbE4oAC7qQHHjp
         TuR/YvW1qJhoMtUkdHXPcHAAN9Tu3IRcAvOHZY+pizJ9muz6kbPabPS0n/AXlkxN/3pF
         0sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743266; x=1692348066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XiYtcfIpRLvVC1+RLwJafSeDJ5lmCUvHEkiwiYIzHg=;
        b=GarkiLN4JapiPBBe+EWwFJsAdeDUoTG6MyRtfH+I7Rg+Ltdslibt3hGj9wCwkfDusP
         lBjTxxkQGgt1Vc5SLE4FYXz6t4T7WeRClXg8a9+haqVy2fIS8JDfOzF2DA7lFgxqpKK6
         3nbwqBwO/8FKEenoFO1vomOaLEFbvOYL6ptp6e6DoZ0SrTGJDtGica32DYUgD2J1uTQZ
         Gore6ebNDcNbfDdT5GIbL40DRV0EvxXihwfZsTjNHqD6mhnknyh4nl281b61GlmNpUOL
         qyR3jVKhgUBtYNo28EL2bELhYPIyFNgyAxpO363zJNorph6fk9z4Us5JdO3kVSjVPng1
         R08A==
X-Gm-Message-State: AOJu0YyVv4pS7cs7BsOFT7DCPmitiX95me5xJyQL3IAnItvqre8dUyi4
	Z+wKNQC8PhHzSAJ0+FZnFATEAg==
X-Google-Smtp-Source: AGHT+IFiu5wphNvLLoh0N7HzNn2IrZaPcV3PgfwzxWIUfLVXF6urzRdje3nNFoGQHVqDBQyzXLiSUw==
X-Received: by 2002:a5d:604c:0:b0:317:ddd3:1aed with SMTP id j12-20020a5d604c000000b00317ddd31aedmr772746wrt.68.1691743265869;
        Fri, 11 Aug 2023 01:41:05 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm4664220wrr.32.2023.08.11.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 01:41:05 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:41:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v3 10/13] devlink: allow user to narrow
 per-instance dumps by passing handle attrs
Message-ID: <ZNX0IFu0td1YtY7L@nanopsycho>
References: <20230810131539.1602299-1-jiri@resnulli.us>
 <20230810131539.1602299-11-jiri@resnulli.us>
 <20230810191722.7c19f190@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810191722.7c19f190@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 04:17:22AM CEST, kuba@kernel.org wrote:
>On Thu, 10 Aug 2023 15:15:36 +0200 Jiri Pirko wrote:
>> +	struct nlattr **attrs = info->attrs;
>> +	int flags = NLM_F_MULTI;
>> +
>> +	if (attrs)
>> +		flags |= NLM_F_DUMP_FILTERED;
>
>Are attrs NULL if user passed no TLVs?

True, I fixed this for v4.


>TBH I'm not sure how valuable NLM_F_DUMP_FILTERED is in the first place.

Yeah, I just noticed this flag, so I decided to throw it in. I don't see
any harm in that. And I believe it is actually correct to use this flag.


