Return-Path: <netdev+bounces-22823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9476961B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A345E1C20B76
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C0182CD;
	Mon, 31 Jul 2023 12:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529F8BF0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:22:23 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C91FD6
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:21:57 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d30b90197so27672046d6.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690806115; x=1691410915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFJKUlEi1dwMUzXqehE2/1K7AORG2mjzS4XpmVxhBIA=;
        b=A5pFXRBjYDsIPfRtKNqnA+sL9R+KeLY8rZIGFbdoycC8ddlBm7FI0WdCLBrbY5cgjR
         DNf3ZG4Clht8Bmgn13/TMCo+O/+giENhxIpGn1dPm5Q+kPalJAPflXNNiuoJsZOWtr81
         gqDiIJpuAAdhbKYkaOcLcmwNNqVb+3zt2KcEH25Nq2D+FUKeEh1p8NJ6zEx91p/PM7OZ
         YL/qS+2tkLGlMUsgAGPs1iRdlvstcsUTn3AtN+/aykqV9rYjmCMEtT/NV6u/ob2jGCk2
         1o1pFhXAR6IPlZ3oTuvhOunQckSRe9Gdp4s9M57dUaVQKWzeISpEjrvmRUox8bGCAkqE
         WCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806115; x=1691410915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFJKUlEi1dwMUzXqehE2/1K7AORG2mjzS4XpmVxhBIA=;
        b=VDBQSF45NHYxIYA6Nx+jgVzpSspeI1zfA9FjtqUHnJG3ZJBJTIB1RR0vseKARKfl08
         BfVZ9n8xviWXi35Fmhp8rq9ENg7Tr87lkH5uYCsL6flyc4vKZCPtri2aQ+jDWpaB0TPQ
         SOwUBEVK7M0srTXXMokZ8iKljOzplyO7WQmZd7ZGckODEVsRPSZLalQwbFPGtmGUi8kU
         jlwwkteQ9Z9w7ZzkXbxFT7wX8T8a2aEcUx79+LIW8tV2K6QH9J1mPXoOXqEKxFXk1QJL
         6d117Mu+KcJf5xi59WFUnRwYnMDStZUMT52W+YThJX1vLlrUoPUtYYjDn7KnJrc87Cio
         2cJw==
X-Gm-Message-State: ABy/qLYT0f1T+H4NvhfyG5cXz3FWknDzX600pojkG3ZpG4Nl6uu7ZkeU
	UsLTFz5dH5e3+ClTnnnPBuBQpQ==
X-Google-Smtp-Source: APBJJlFfi8YyXXrC7sZHQB3hNf11hgMoW8nTgHCgbVr6dLrbdKY8y50Q14NAKQ0Pb1OzvxG6dbUOJQ==
X-Received: by 2002:a05:6214:9a6:b0:63d:2a0b:3f79 with SMTP id du6-20020a05621409a600b0063d2a0b3f79mr9184306qvb.45.1690806115320;
        Mon, 31 Jul 2023 05:21:55 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id d8-20020a37c408000000b00767b4fa5d96sm3222919qki.27.2023.07.31.05.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:21:54 -0700 (PDT)
Date: Mon, 31 Jul 2023 14:21:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 08/11] devlink: introduce set of macros and
 use it for split ops definitions
Message-ID: <ZMenYPE5zrA2myAm@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-9-jiri@resnulli.us>
 <20230725103816.2be372b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725103816.2be372b2@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Jul 25, 2023 at 07:38:16PM CEST, kuba@kernel.org wrote:
>On Thu, 20 Jul 2023 14:18:26 +0200 Jiri Pirko wrote:
>> The split ops structures for all commands look pretty much the same.
>> The are all using the same/similar callbacks.
>> 
>> Introduce a set of macros to make the code shorter and also avoid
>> possible future copy&paste mistakes and inconsistencies.
>> 
>> Use this macros for already converted commands.
>
>If you want to use split ops extensively please use the nlspec
>and generate the table automatically. Integrating closer with
>the spec will have many benefits.

Yeah, I was thinging about it, it just didn't seem necessary. Okay, will
check that out.

Btw, does that mean that any split-ops usage would require generated
code? If yes, could you please document that somewhere, probably near
the struct?

Thanks!

