Return-Path: <netdev+bounces-29735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF3784881
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313FA1C20B0B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711812B575;
	Tue, 22 Aug 2023 17:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1442B544
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:40:23 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F310D9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:40:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3197b461bb5so4233922f8f.3
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692726012; x=1693330812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nor8yMe/l2U11L6dAYkiZyqRYkSnsn50zRoRnithc4Q=;
        b=k1gYlmkDNUep/I+n4Hbc3DlPCNjLi9WJNBu1FePzYMQ4ARhgiC9qGnrJvGlaoQaFG+
         GViaT8nwcJRsqCks+G2YxiZHEjSvjDx0GG1bwg0Df3nchNikjvEsSv5K37qfiJE7yL2E
         Z790GnE/KkZdGNbgYe07rqLIyn9REkc3HZm4sGq2PX5Om6yMmDeY7vw+Qsaf8G/4GhEm
         q1a6bpUjxUFZTxU2BxjMIBKcIHvIoxQ9a/CW6c2XTE5lL6g6L7D/mS4x1GU0avjFIpFu
         b06Gs0kmLD1cqbYai0vDcJ0XdNwPwLE3NIcRwygl78WLcv2eVKJgEN19cBoO53BCRCdF
         m1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726012; x=1693330812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nor8yMe/l2U11L6dAYkiZyqRYkSnsn50zRoRnithc4Q=;
        b=gNTCjG0iQqM/rqUzU9VKc3CqeqfjHe6X0kOxgadwe+C1PpwidWCjlb6ccBQqqVngiW
         49f1qGVNG3GORI1H0GiihMoJWv97x0/tTMTPj+O3B6bF/NHtYe3VjSrkEE3iAhgMT+aq
         i76NVVnGE9xH/chXRlfNPLm+0tE0HWW254gLrNk399uhQe4+uLrONA1t2NjNAGZwlOM6
         ldn1VTc8y7oovPpeS7oVXfyEn+zyhJGS/WI7RBnvvDBpKZp6uBaJKeaX/KxmPfMX4B2y
         ctL/BJNOfRXusDiN8ff/I3vaJzVC+lEhAbz/VZbcDdaVtSdNbBGobXc7emYyXTOSyEw+
         sTNA==
X-Gm-Message-State: AOJu0Yx05UL1FTe9kOeJl+pbD/s0YdrOuScaBQXHRdQg3LnRF7+xK+lK
	I5/EtkKoeSxTvuO4Xnv8Z/CdfA==
X-Google-Smtp-Source: AGHT+IG8VaVZDAfR/EqoZgni42/WUZaBifW4s0TcNv9MTJs0FE5dt+wyRbLr/bqVcVk4dQC2p6f4Wg==
X-Received: by 2002:a5d:5255:0:b0:319:6e6a:66e with SMTP id k21-20020a5d5255000000b003196e6a066emr8299156wrc.14.1692726012115;
        Tue, 22 Aug 2023 10:40:12 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q1-20020a056000136100b003180027d67asm16237930wrz.19.2023.08.22.10.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:40:11 -0700 (PDT)
Date: Tue, 22 Aug 2023 19:40:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	shayd@nvidia.com, leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <ZOTy+sdg6raDGGUu@nanopsycho>
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

Okay. Will do that in a follow-up.


>
>> Both usecases are valid. But back to my question regarding to this
>> patchsets. Do you see the need to expose netns for nested port function
>> devlink instance? Even now, I still don't.
>
>It's not a huge deal but what's the problem with adding the netns id?
>It's probably 50 LoC, trivial stuff.

Well, you are right, okay.

