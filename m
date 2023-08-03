Return-Path: <netdev+bounces-23961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7476E518
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602741C214A1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297B15ACF;
	Thu,  3 Aug 2023 09:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B597E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:59:08 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C62D73
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:59:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c136ee106so108367066b.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691056743; x=1691661543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq+QbcdSS7H9wJSSy7McrCyPcqI2cyjBdsbzVxgntys=;
        b=nc/7kxLSL02797Sifw5k+k4Gy6SxsJ53AzTDC81fOu0vcqKr624+PxAJi+FLne8Y8w
         Blm2C+DwygFAlNFLBmwQ7EDOgfydpFby9sC7S8DW62ZIkVwoxne4R4Yn9KL2MBecLkEb
         cc7GFaHG4IgY9VDm4COHp5xBkoiutjbAuTCY7Ou4c0C4EQmyIvLMmALcSZCHeE4At3bu
         Mnsc7io8dkZQA0cE4Gil9XhGZEG0RMLUuvVTM9tRGr6qKriuFKfo0KyeQnhaiKj3nEaG
         pJKrKXT4iXbGwXdJK0sLF/t9ch8wWqtq9n/hAy5tX6XKREyENfdFERyx9JV9W5M8k4RJ
         7bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056743; x=1691661543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq+QbcdSS7H9wJSSy7McrCyPcqI2cyjBdsbzVxgntys=;
        b=dUh6xK4MMvrcUp6vhb0GER3B8QXishFJkq3CKt1yGJVDzm7lrmFpD9uTLZ8BseiZT7
         Gnfo6tvIO+MnxDJJrAc92TnTUZHEX4Rn2AA78cJQW1l5cz2Eip/3PDqjF2e5Crgg7ewF
         XntXuuVu3ov1JPgchbo6hKOMd0mNJMBvCKg/0Y0H+rDiiz3Vi+grqv78AMagCGDsKAPx
         BUWGm/cLJPKV5oEBgifghLWTE/g0iI1MDrQyk3gEP0LMnaMVXPw1J60pYUnf70ZWiInJ
         tXrm1G8BYqCsLGqUaQvFIKfM3K6dq4tGxW9KATF6Jv78tDAhEDvu5t1Tdr6thOP2bQqE
         ex1g==
X-Gm-Message-State: ABy/qLakXVU8NgJmn+k7BPLn3Tb0kNnYMaS5KiKUaPUNrUCAs0CURt1j
	56EjjS/bgiwhCFmdN/0o/rYhTw==
X-Google-Smtp-Source: APBJJlFp4LqbTkmx+PeG8V0cWoKSQPKdbjGFxB5rUGNr3wCOT8Gsbvx0890WeH8a+y+rJdTGvHNicQ==
X-Received: by 2002:a17:906:847b:b0:993:db29:d27d with SMTP id hx27-20020a170906847b00b00993db29d27dmr7962202ejc.34.1691056742781;
        Thu, 03 Aug 2023 02:59:02 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709067d4600b00988f168811bsm10365860ejp.135.2023.08.03.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:59:02 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:59:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	johannes@sipsolutions.net, ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org, ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	edumazet@google.com, pabeni@redhat.com,
	chandrashekar.devegowda@intel.com, m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com, linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com, jesse.brandeburg@intel.com,
	danielwinkler@google.com, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink
 framework
Message-ID: <ZMt6ZZxIHMrml0+E@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:

[...]

>+static const struct devlink_param t7xx_devlink_params[] = {
>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>+			     NULL, NULL, NULL),

driver init params is there so the user could configure driver instance
and then hit devlink reload in order to reinitialize with the new param
values. In your case, it is a device command. Does not make any sense to
have it as param.

NAK


