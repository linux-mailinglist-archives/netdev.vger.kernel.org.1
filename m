Return-Path: <netdev+bounces-12952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17BA739914
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E259E1C2107A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4315AC7;
	Thu, 22 Jun 2023 08:13:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58AEACC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:13:23 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162A1BC3
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:13:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa70ec8d17so3290385e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687421600; x=1690013600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxLUdJmVd0ETDzeyKPn7SZFc1uqf2kKlnDi3sO0D5bA=;
        b=m6S/1aChLob1kPwjzOxRWbVw6phKHvBwUuMbKgJXFUUDIVeEMYZwHU0JRSddKN/F9T
         X0gPncN2Cr00y6wzOB0ZoQ34oYQYjz+3bMSV5rpBfJABPcSCwjCrEl6wvvfjv/65ObHj
         gonKAPHtf+BWGYyRppoeSQEF2iNhfiiVS/e4tF8CxFx1Yugub1I7Bj3p+S80Chi0S8Zd
         wgmTZf+AM+pg3bZpsuzSdDdbSbijID5YA6/+ZLkBxQbwrvBO6c7uZP+KyGJzKTqpgFrK
         WkrWDBUOVpsUJ9gn0QkU1WpWys6Y+OZmIqUYX7aqPtUEhANDwtePae81z5QuG9Tk4nkb
         MVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421600; x=1690013600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxLUdJmVd0ETDzeyKPn7SZFc1uqf2kKlnDi3sO0D5bA=;
        b=I/UB046DOO/nPUO8A3ZXqc/Wv1NhUeR4nS4ciqAs1VDHPC2VDEruVys3lIW0QnZaZ9
         ZX0YNciFsGzqJnxbdHPWCUGquKLLN8u3zDBa0a/QXTENmXQY7yHqTPYgL2/tuPSam9JI
         rQwON2y0ly/6iQZGmZDktVD8hG+dv4iiFbHE+unO4oa5I5PYdib2EXiaHgokHU6QOkRW
         eKNgH+1L/848CL+EzQlmrNQotUCpmuuQw6P6LvYf0pmfi3xqC8y7AXb3j97xJ3LQAI36
         rEq9wJkK8gxiMpCKYSyPqi7phwSWotAixcDBs3qGur9jGXezgcJK7LJa9oCIF18IN8n5
         FWqA==
X-Gm-Message-State: AC+VfDzUgARJY43jgqMJlobiQQtAT1JUY+xfio2hT+HVvEq/ecUcjx6u
	1/cyagYJdjGW77VbOxUSLXQICg==
X-Google-Smtp-Source: ACHHUZ5/yVN8oCoK0xe5hZIq6nL4aj3WkftYMpUVpR0rf2ivexC2SAnBmK0FQvOJ5tZxjRcF7e/i4A==
X-Received: by 2002:a05:600c:4e92:b0:3fa:7515:902e with SMTP id f18-20020a05600c4e9200b003fa7515902emr625228wmq.16.1687421600301;
        Thu, 22 Jun 2023 01:13:20 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003f8ec58995fsm7070435wmo.6.2023.06.22.01.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:13:19 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:13:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net] net: stmmac: fix double serdes powerdown
Message-ID: <ZJQCnny4pLY3qpYQ@nanopsycho>
References: <20230621135537.376649-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621135537.376649-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 03:55:37PM CEST, brgl@bgdev.pl wrote:
>From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
>Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
>stmmac_open/release") correctly added a call to the serdes_powerdown()
>callback to stmmac_release() but did not remove the one from
>stmmac_remove() which leads to a doubled call to serdes_powerdown().
>
>This can lead to all kinds of problems: in the case of the qcom ethqos
>driver, it caused an unbalanced regulator disable splat.
>
>Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release")
>Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

