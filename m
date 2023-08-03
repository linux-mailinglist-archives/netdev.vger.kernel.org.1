Return-Path: <netdev+bounces-23886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E553276DFF8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E851C2143B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176A846A;
	Thu,  3 Aug 2023 06:01:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E516FA5
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:01:41 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F252E6F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 23:01:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-31751d7d96eso465529f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691042496; x=1691647296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXS/R9KsztjgvQfMuTAvGWJQZ7kBz1HCrKMvOwOo/Gk=;
        b=yzJjrpUsZQgB8Uibucc7a+73iDhWXAHttm9gq3qJue8LTUGaLwOuDugg2Alf9tmmnT
         rVrbGVn8Phqz5/g+7RvAlGAJyG6MQCfwu4HfhdHju+FXieLkrgHmIxY8Zgn9cfXRcIyU
         yu5Z5lt98/fx92CwYpVqwrCvB7sGWSFVDKgbslnftIh9TT6U1WpNCf1/JnBA3WAX31PZ
         0sAm//m/emsYAI0XOonHdyp1JzYelvZzpxzzRHO/aglTaybLzEI1E2qDcy9yDgJkRBMF
         e0bHuLgcg0wx3c2ILjte/mZOhLcNLyXzj9haYwhXH3/1NtgtiCGQK5FB+K/itp5q14PN
         /ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691042496; x=1691647296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXS/R9KsztjgvQfMuTAvGWJQZ7kBz1HCrKMvOwOo/Gk=;
        b=e7PA3p2z2R1IPZttj3b3hY0xW5wsgKspApdSWc0YBPA7PVbk23ltx8JJ5vXdvfQHqu
         E0Zh6pALbAutSGWVeuF+xC2l2Q/Ld+FBcMui7sqRAKDZUoNgdbmJuugUU0yLmbW2BrKV
         8+vVbjbhUz9plWu7fpnfh8/JrVeIZvUavbUius2LpnXv0/K8eXpZGqiBwI0DL8ANwxcw
         rATszVESBX1/IdXwc0NFhoKoayQTDmoAM98z/AcsvpUSPChn5yDR77tUQF3Jj1lU19K1
         zF8jty4SkdK+t0lGc6G1ZP3DRa1I2blmvtagFVQF8ZevD8e6bSCeMmU7kVu37FzBx7+D
         PUsg==
X-Gm-Message-State: ABy/qLYsGvMkTb802npu9rtBC82p3dED0ehbJmCgzuajcyOQq3PUlwzr
	Bk9zTsv79ZEON+CJf7dBVXCQmg==
X-Google-Smtp-Source: APBJJlFf8R6G1o5y/Z22aDZHXnusJ6BrqR0Uyo/WQLipK0IzgGitW7yfhfIlueiqCMcbj9Cn7+We4g==
X-Received: by 2002:a5d:4292:0:b0:317:6816:5792 with SMTP id k18-20020a5d4292000000b0031768165792mr6418621wrq.50.1691042495801;
        Wed, 02 Aug 2023 23:01:35 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d5607000000b003143cb109d5sm20809246wrv.14.2023.08.02.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 23:01:35 -0700 (PDT)
Date: Thu, 3 Aug 2023 08:01:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 00/11] devlink: use spec to generate split ops
Message-ID: <ZMtCvitU6o2e41up@nanopsycho>
References: <20230802152023.941837-1-jiri@resnulli.us>
 <20230802190734.4a9f9c0a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802190734.4a9f9c0a@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 03, 2023 at 04:07:34AM CEST, kuba@kernel.org wrote:
>On Wed,  2 Aug 2023 17:20:12 +0200 Jiri Pirko wrote:
>> This is an outcome of the discussion in the following thread:
>> https://lore.kernel.org/netdev/20230720121829.566974-1-jiri@resnulli.us/
>> It serves as a dependency on the linked selector patchset.
>> 
>> There is an existing spec for devlink used for userspace part
>> generation. There are two commands supported there.
>> 
>> This patchset extends the spec so kernel split ops code could
>> be generated from it.
>
>Looks good! But you need to reshuffle stuff in patches 7-10
>because there's a temporary build breakage. Some squashing,
>reordering and maybe splitting patch 10 should do?

I was very careful not to cause any breakage. Will double check, fix the
2 nits and send v3.

Thanks!

>
>Feel free to post v3 without waiting the full 24h.
>-- 
>pw-bot: cr

