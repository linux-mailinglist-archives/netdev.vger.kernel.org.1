Return-Path: <netdev+bounces-27588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D310A77C76D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976901C20BD1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E95674;
	Tue, 15 Aug 2023 06:07:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C6525A
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:07:11 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AF019A8
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:06:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso47641235e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692079615; x=1692684415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfZHt9AGbW5m+oJFEo8F2sAzlF55NyLhY5unHP1NaPk=;
        b=vL0yDE8+1Z6kKdh23VvfzCh/W5rbdTeMgqPuI0yLIbLXRBxqBRpW10FcXEcjx+L3e6
         0L2lB62uHwKDNkng7jgbNzcqz4rfdtkdr/8B1huEcF5Gc96SGOn0TPS+xsV05pAdaUf+
         FxK75Dl27/a3GclUrAmGcBYcB/Bz/dt7LQ4FreWxbJVRxxyu8uSX2u8LrjLBAnOU4p8L
         28HRCJmzcNPCcQKQ/9P8BfFvPC9AI5d9tjf+m3ZNjN8fmUk3TfLzXAXlZVkInT3TtMAp
         bt79yDErNUq7+JoI8jC+uJioJjuv2OW9SL7gc3Zg6wTwLr2swAldG89fW0IYwJ6ulXzj
         A8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079615; x=1692684415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfZHt9AGbW5m+oJFEo8F2sAzlF55NyLhY5unHP1NaPk=;
        b=N+r6+juaAQGYdOEzK7mPb+sTjU3iY0PWNBcOaqEeO81dmwwS8K6sWnmf1UikznAjSC
         anS+v8ZqnV0VfEBhl/1qvqXSjVBHtJGA70tDxM+hVusNGhCXsmj8zsL+8oPFrWtqwTJI
         zgDkhHlvki6XzOuN9kdSZVRAjohBWgym3vudRg+FTbnX44XV8Q1TsnxKWD9Ob3hJd0fG
         cZz9pv67cnjvkxM+cPzOl/I/6gyt1baIMsaxxAqE807qIowfLxYTxQeIV8ufYiiLlypc
         lUEcVyKIPfbZwVmgLOUO8SBqcFzYIb14WauwM9gDm+xSETpsti41d9vyO3ddfjYbgMFf
         40pg==
X-Gm-Message-State: AOJu0Ywe5Zu23QL7dlPdX2FowGxh04Lluzi7Q7UWSMkWaTc18TMesMNH
	ig7dlB6109Eppgi1Ca3lqN0/4w==
X-Google-Smtp-Source: AGHT+IGbI50iV8m1uisMq8Fy/7OU5vVVIwSWEnFrejSImWuLod6AiyVWm4wuXlVNG9xhaVDb1avQ0A==
X-Received: by 2002:a05:6000:42:b0:317:5b32:b2c3 with SMTP id k2-20020a056000004200b003175b32b2c3mr7544265wrx.6.1692079614943;
        Mon, 14 Aug 2023 23:06:54 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z7-20020adfd0c7000000b00317afc7949csm16040076wrh.50.2023.08.14.23.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 23:06:54 -0700 (PDT)
Date: Tue, 15 Aug 2023 08:06:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net,
	Vladimir Oltean <vladimir.oltean@nxp.com>, gal@nvidia.com,
	tariqt@nvidia.com, lucien.xin@gmail.com, f.fainelli@gmail.com,
	andrew@lunn.ch, simon.horman@corigine.com, linux@rempel-privat.de,
	mkubecek@suse.cz
Subject: Re: [PATCH net-next v3 10/10] ethtool: netlink: always pass
 genl_info to .prepare_data
Message-ID: <ZNsV/ZFsixC2CRPW@nanopsycho>
References: <20230814214723.2924989-1-kuba@kernel.org>
 <20230814214723.2924989-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814214723.2924989-11-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 14, 2023 at 11:47:23PM CEST, kuba@kernel.org wrote:
>We had a number of bugs in the past because developers forgot
>to fully test dumps, which pass NULL as info to .prepare_data.
>.prepare_data implementations would try to access info->extack
>leading to a null-deref.
>
>Now that dumps and notifications can access struct genl_info
>we can pass it in, and remove the info null checks.
>
>Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # pause
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

