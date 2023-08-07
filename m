Return-Path: <netdev+bounces-24801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C307E771BC2
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FC91C209BA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE58C2C0;
	Mon,  7 Aug 2023 07:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B472AD45
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:46:58 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F7B5
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:46:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so19619755e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691394414; x=1691999214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpqdTONlpi3G07rnwUafrNHsRWwfMm3a1uejZJocsEc=;
        b=aPzyf4Agl+ymx7gzJZYIC0CCJ/DHJere12jDw2utFbKoqhRx9SqqIPOodawBg0iEiU
         ApKY2qwprix69u/dq9WjCiqT7XhSHncmoJt4SlvkfgP8JVl6ZY/Uo4gfTXEzAB5Lh9y9
         fFfDBU9g+s3sUB/drLg2mGlZqfcKRcMLTxQzedLRLXACqMa3LRedIgut1+fZkjDbKkkf
         E+mPwHxQiPmFJBms97WTfWqvWHaeai0pwqSWmSPbHI5O138Tg75Q46+jAT5VVIGILahp
         Ne4LBxsO0JmsGYRVaytbwmumUMk4pnFh0HFHPdCBWOi3cwBr3NTORsNw828CeD4oL8fa
         +KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691394414; x=1691999214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpqdTONlpi3G07rnwUafrNHsRWwfMm3a1uejZJocsEc=;
        b=IEqMv0BUHsTPyZQ4mlT8AZyxEXvvQUWkBz1SCeVk0wk2HPNEbxIcte5XamnBKyipia
         1pwEh2nSmBElM1eXbXLCJM4dMTn9olpjwBHoW7oQKw+8vdFqwZghtjUODslRG5XhUX9F
         3+AUv2xYLaEpULXt386nSho3KKqFW+lPhioDtb+cFLQ3goFTKkxqrN+a8KiJTbYd//Vm
         44KIVun7x1IgEBCRL2l8w7/phIotesn/FnuNpCXTyHrPuEH0pA/pUp4DZ+anL+ABXbYc
         VZ7L/ud/c9n/a4v8G+q+slgmHIsjKeSRxueGD0ed8xAZixR0+UCxCAg33CRkemH0JrWK
         G2ig==
X-Gm-Message-State: AOJu0YwqroEhfzbHCpV+Xr2R6hAs7QvFz58uSSccZEwE5PdqLFb7z0bO
	HFN7Ykrf1nQD08y/EQ5PlCZBcro0nZgZvaHX53J2UA==
X-Google-Smtp-Source: AGHT+IEw9AXB7bXSpCw08cfjahzkwEY15BlvCv6dKvfDP8XXZ/QLAYpUR2sQyofzI04Gw37DdY5cKA==
X-Received: by 2002:a7b:c7cc:0:b0:3fe:21c2:7d81 with SMTP id z12-20020a7bc7cc000000b003fe21c27d81mr4923934wmk.35.1691394414119;
        Mon, 07 Aug 2023 00:46:54 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003fe1c332810sm14211561wmq.33.2023.08.07.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:46:53 -0700 (PDT)
Date: Mon, 7 Aug 2023 09:46:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v3 0/5] team: do some cleanups in team driver
Message-ID: <ZNChbDOF3J40deOv@nanopsycho>
References: <20230807012556.3146071-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807012556.3146071-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 07, 2023 at 03:25:51AM CEST, shaozhengchao@huawei.com wrote:
>Do some cleanups in team driver.
>
>---
>v3: add header file back to team_mode_activebackup.c
>v2: combine patch 5/6 and patch 6/6 into patch 5/5
>---

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

