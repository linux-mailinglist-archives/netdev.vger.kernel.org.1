Return-Path: <netdev+bounces-17194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D47750C50
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C231C211AF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C424171;
	Wed, 12 Jul 2023 15:21:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7024167
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:21:12 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F651FFD
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:20:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso11657546e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689175243; x=1691767243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=17i4MQI21mjKRCPVFtor86iZ9XXawUMql3s9RQLaP6c=;
        b=QQnH1hvgSVJbNCC5jigm96LdC0bKANMfI0YQX9N2RNwyyHfFr76QOcqQ8gdEdvOGAd
         SE+ePCA0yU++0ZnyJjKVukz64jfR8qA/4K/8x9t01S9dY+m0tT9qAW9gc+9wi+i1ctgy
         OM8h7DUhxD6Y9ez2PtvXsbUwlC8r6Zhd/JlX8DwYf48PaYfBwgRBWpf555TXB+5xerw3
         0qFEh53pk/w4PRjJu5Q3HRqq4MtR2iXfRrcTUcltOpN1vEKtLwrX8+1hqiH/3Td7AEOA
         jwGTe2UlFy6kHC1/PnfwN6Jld801Hgp+0AD2pV9lx+jQg+jV6AXgYfmtU3djfRT9gccz
         a3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175243; x=1691767243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17i4MQI21mjKRCPVFtor86iZ9XXawUMql3s9RQLaP6c=;
        b=E1CLMqU/qZqgoX2GnrIcMPzgXNvTtX4vq9twsGZkqYJ/jtG6GH/U2bZLkcrEwvacPC
         cccL6eLLscYNjC6hTDsbpnh4U+84p2TNpirG9PUvKwJgRiKKa9cgNx/vWzJ9P9PXw9QG
         GUARmhvKrywvRqLMxrVJclNza2Va3DdbOp9W0kBtXJ0DhhVuwlOHIhHURhWjkiaE2jeT
         ZReRTa3TxuVBs8xw2XAlrt29yxZpiYn0+7JK1mcTJZUmLVWgWjhg3oFaFzEuBBKTt3FD
         CfLmxQMrqsLIPnPqLBfN6lPz+iuF6zJjVavBcWXa2s5NrecFcNDdXGbuM3uMVypnDlI/
         +OyQ==
X-Gm-Message-State: ABy/qLbIEE8062a4H08G8qqTdublZC71qoQewyZJe1osZJutJF13ocAY
	fgnozsBoCP/DpEPC6ABMbwdeliYL+00a8TaJ8hU=
X-Google-Smtp-Source: APBJJlGoHG36JrqOmT+bFAL96QSX3zxlujZY9rau+AfYoNKZa9GJudj3wMCa9JVBNvRtIkNwSlJJyA==
X-Received: by 2002:a05:6512:2ed:b0:4f8:6dbf:401d with SMTP id m13-20020a05651202ed00b004f86dbf401dmr14337779lfq.57.1689175242756;
        Wed, 12 Jul 2023 08:20:42 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7de0e000000b0051e0cb4692esm2892198edv.17.2023.07.12.08.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:20:41 -0700 (PDT)
Date: Wed, 12 Jul 2023 17:20:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next] devlink: remove reload failed checks in params
 get/set callbacks
Message-ID: <ZK7EyBcE7sFVvYvh@nanopsycho>
References: <20230712113710.2520129-1-jiri@resnulli.us>
 <ZK6u8UFXjyD+a9R0@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK6u8UFXjyD+a9R0@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jul 12, 2023 at 03:47:29PM CEST, idosch@nvidia.com wrote:
>On Wed, Jul 12, 2023 at 01:37:10PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> The checks in question were introduced by
>> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
>> 
>> Back then, it was a possible fix. Alternative way to fix this was to
>> make sure drivers register/unregister params in the code where it is
>> ensured that the data accessed by params callbacks are available.
>> But that was problematic as the list of params wes static durint
>
>s/wes/was/
>s/durint/during/

Maintainers, I will send v2 with these typos fixed tomorrow, if these
are not any other comments.


>
>> devlink instance being registered.
>> 
>> Eventually this limitation was lifted and also the alternative fix
>> (which also fixed another issue) was done for mlxsw by
>> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
>> 
>> The checks are no longer relevant, each driver should make sure to
>> register/unregister params alongside with the data it touches. Remove
>> the checks.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>I don't see how we can hit the issue after 74cbc3c03c82 and any driver
>that suffers from this issue should have already seen it after
>7d7e9169a3ec, so this patch looks reasonable to me.
>
>Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!


