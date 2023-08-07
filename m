Return-Path: <netdev+bounces-24793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4115771B67
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910631C2098E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF510443D;
	Mon,  7 Aug 2023 07:22:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58F1FAF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:22:55 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD87EB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:22:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so33822995e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691392973; x=1691997773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7Cdwjf0JT50InaFahEN+945tUB86fExWQGME8KgQqE=;
        b=CHJsW7O8rxk2BwQ8s4eMXc1mJpZtggPTWfhHcwXxPYDrFayttpe8H7LOqQqpESrVtk
         4KepxS7atROCX2EGpHGtiwHUQYjP9reHVGeUazLxIJyNPQguSFkW1TyLYJzVoTiRdXvM
         FJpImMYpDSzV+9vcwznv48y0cLJV7xICrAhPebSB0gxugjBK6tDHro004dUAhawXeuLY
         Dq2l+JdGnlPwyHVRHEflg2UYfcrnVe8XMrkoOP0nLApEpAzlyf5BrMc2ndWvYjPCgTTn
         dgjBtwg6ZLE7fWCyIBD7M7AZx0GxUBf1jqbZ9joVufdU5DdjBhR4C3C/rCLbvNbtzo/Z
         aumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392973; x=1691997773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7Cdwjf0JT50InaFahEN+945tUB86fExWQGME8KgQqE=;
        b=C/Rw0NjpW84xpMZ4KYdDw3YfmxxCg315TYusjsY9qxNfcsQoLrAwhsNpjqw7V5mxkm
         rtscXP3N5rfUZTQa5Q6eZ5GpbPafC1JdP8bKxynmP/nREaOPOpbFQY9v0OI7DaP1jYtV
         RlOQpOsIToqoRLWfdiUQb+1rezpxeKQ8W0FIoo/kmiKu+e8p2toBJjYRkM9QuQ0TZLSl
         wXHtrkTOSdfqTHDqzxIyk3c7mUMSuOn7GcQS3kQmro6IP54AwvahaNgkTDDMuK2KY+ob
         XApaZohD+UJMwZVi+/ZA9y+qmrVGGXQi6t/de3sIls6CzVb4AYBoO8GbP6xMPdbbWtGt
         R1Pg==
X-Gm-Message-State: AOJu0YxfFAfZ/Fcdrr1FzieWjaJxm7wlLQt4ZTgqbZ0LGwM0ApT8JN8p
	z0AMpNgEi7IMEZH2eACnbrhAEQ==
X-Google-Smtp-Source: AGHT+IG3EGtoXfJZOrVxyfRtL1EFsoGFgcWbZPDHnJvbcW0brh9PWN2fWvJDGcZuDVnxkpkQkOdhdA==
X-Received: by 2002:a05:600c:291:b0:3fe:22fd:1b23 with SMTP id 17-20020a05600c029100b003fe22fd1b23mr6686703wmk.34.1691392972620;
        Mon, 07 Aug 2023 00:22:52 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003fe539b83f2sm5859855wmc.42.2023.08.07.00.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:22:52 -0700 (PDT)
Date: Mon, 7 Aug 2023 09:22:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com, davem@davemloft.net, edumazet@google.com,
	haijun.liu@mediatek.com, ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com, jinjian.song@fibocom.com,
	johannes@sipsolutions.net, kuba@kernel.org, linuxwwan@intel.com,
	linuxwwan_5g@intel.com, loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com, netdev@vger.kernel.org,
	pabeni@redhat.com, ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com, soumya.prakash.mishra@intel.com
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink
 framework
Message-ID: <ZNCby8kzaZrxY+eJ@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Aug 05, 2023 at 02:12:13PM CEST, songjinjian@hotmail.com wrote:
>Thu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:
>
>[...]
>
>>>+static const struct devlink_param t7xx_devlink_params[] = {
>>>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>>>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>>>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>>+			     NULL, NULL, NULL),
>>
>>driver init params is there so the user could configure driver instance
>>and then hit devlink reload in order to reinitialize with the new param
>>values. In your case, it is a device command. Does not make any sense to
>>have it as param.
>>
>>NAK
>
>Thanks for your review, so drop this param and set this param insider driver when driver_reinit,
>is that fine?

I don't understand the question, sorry.

