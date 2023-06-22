Return-Path: <netdev+bounces-12930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E220739784
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DD28180F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29A5239;
	Thu, 22 Jun 2023 06:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BF1C05
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:38:10 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE2132
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:38:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f90b4ac529so53933945e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687415887; x=1690007887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP1z6i20ELzXjomMZNW2hZreeiKj2LnKNkFR/8DZck4=;
        b=2RfJ7jmDjn6BDMM03Tup5DhV41Mm+QX3qIdi+27RlWHqG2l3Ft6lEwjQ8J/y6gi0jR
         NXXcyR75fPsNLj8pbjoKUOfOBLAMGrdaA/kXoeJEPXexLf6M9LQjU4zEKar4hL2lK43M
         5Y4T64OYXDpvpfu43LGiJ//y5aZN3rfGicjoRKuw3pYIhofWx3z2Xfskt7sPrvMpXJdW
         sQmYhuxzjtg65QP627a4LVsdkghlF/YvZAljw8oRmYQmrUMsXCa+R42SrUAee8ns0wA1
         RA2mXQcwTq02wypEkAKaylkkK4UzcifnLF8PV95VXANQlHgHjgavJnQTlTHpwaDtL2ob
         fecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415887; x=1690007887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP1z6i20ELzXjomMZNW2hZreeiKj2LnKNkFR/8DZck4=;
        b=PJ0YqvicNrKSnJw1sAkAEFwcs98CwH+17fp5btsAnS6E/A5/ffXm0YZTXwxGXOs25V
         wgJ/1wBwUXIGoH/RiTHLkx6ROZMFn6Mju/eZu96t4rqbk3ghR6DzegWPghndLd3m5r2k
         YHZ4Rs1nF7AAClI6h0VjsVgqXSsJ/1/dCzkNox4lDezXjfGIdCH42jmkiPbGoH12z76N
         K0nEqNYENpnPuWbkEYgopeNIA9uT8f9vhfnllmCX/gRe0Nm0il44rX8lCwhTVhivLPAC
         /7i1iJMTpNOqx4j+PZ2TXOPowky+baldywjFPJIO240M7A25RikQ7K/3Gcdnnf+5Ft0e
         p5Cg==
X-Gm-Message-State: AC+VfDy/Y5HPUBZcMhstqlFL2AT7cFWgACH3nSZ1Wsb6MWIG4YLV2Jms
	WnojtsvfqFnuTcbDuAWCggbDZQqrs1pTnMmVMLrX9w==
X-Google-Smtp-Source: ACHHUZ6OQRapOIAXb1o6udSAwJ5FCOEU7+klvqPv1Qnrks1R4UMZaQBp2xXEk53/GYO1it7FUj/7+A==
X-Received: by 2002:a1c:7c0a:0:b0:3f9:b58:df5f with SMTP id x10-20020a1c7c0a000000b003f90b58df5fmr10091393wmc.41.1687415887033;
        Wed, 21 Jun 2023 23:38:07 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id v15-20020a1cf70f000000b003f8d770e935sm18152526wmh.0.2023.06.21.23.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:38:06 -0700 (PDT)
Date: Thu, 22 Jun 2023 08:38:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJPsTVKUj/hCUozU@nanopsycho>
References: <20230610000123.04c3a32f@kernel.org>
 <ZIVKfT97Ua0Xo93M@x130>
 <20230612105124.44c95b7c@kernel.org>
 <ZIj8d8UhsZI2BPpR@x130>
 <20230613190552.4e0cdbbf@kernel.org>
 <ZIrtHZ2wrb3ZdZcB@nanopsycho>
 <20230615093701.20d0ad1b@kernel.org>
 <ZItMUwiRD8mAmEz1@nanopsycho>
 <20230615123325.421ec9aa@kernel.org>
 <ZJL3u/6Pg7R2Qy94@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJL3u/6Pg7R2Qy94@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 03:14:35PM CEST, jiri@resnulli.us wrote:
>Thu, Jun 15, 2023 at 09:33:25PM CEST, kuba@kernel.org wrote:
>>On Thu, 15 Jun 2023 19:37:23 +0200 Jiri Pirko wrote:
>>> Thu, Jun 15, 2023 at 06:37:01PM CEST, kuba@kernel.org wrote:
>>> >On Thu, 15 Jun 2023 12:51:09 +0200 Jiri Pirko wrote:  

[...]

>>As a reminder what sparked this convo is that user specifies "sfnum 11"
>>in the example, and the sf device gets called "sf.1".
>
>Yeah, will look into that as well.

I checked, the misalignment between sfnum and auxdev index.
The problem is that the index space of sfnum is per-devlink instance,
however the index space of auxdev is per module name.
So if you have one devlink instance managing eswitch, in theory we can
map sfnum to auxdev id 1:1. But if you plug-in another physical nic,
second devlink instance managing eswitch appears, then we have an
overlap. I don't see any way out of this, do you?

But, I believe if we add a proper reference between devlink sf port and
the actual sf devlink instace, that would be enough.


