Return-Path: <netdev+bounces-27575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76AE77C6F0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D2B281304
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83C1864;
	Tue, 15 Aug 2023 05:13:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE53220
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:13:08 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B16198D;
	Mon, 14 Aug 2023 22:13:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbb7c3d0f5so8036005ad.1;
        Mon, 14 Aug 2023 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692076387; x=1692681187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ4YGMdb2nnz4alb05WYpjmy2CP4q90v/SgWID2/w4g=;
        b=gNewD4tqVtP31rd96rLn46IeHkQaF7wKes3I/bbSYDrH6nzkMpMVBva7t+bRViPAA7
         fNgn5WfjH6Ba/YsFOj7yBh1E4IUuRPN4wHwu3WqsnIQIoWGczAZ2ohPd7tOxIS3JhEE1
         bvC8coTC4Xv07YQlTz0dOeOlcYAuIAyM6x2sPEpgQaByRc+qQfP7jnAqcbbKG0GPbRMP
         9PmIP9IABcyuHKwCw+FZTv9wzxwcztUNscJeVNKKZ9fd5SU7Ly6uzBO18tle3zUHYCT0
         iddjURCQxyHL9n6BCU05DTsa4BvRZjwHvt4TcuCVEjdApqUfR0WU7ilIQczKFswZfJ/K
         PqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076387; x=1692681187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ4YGMdb2nnz4alb05WYpjmy2CP4q90v/SgWID2/w4g=;
        b=AY9GDPhdyLp1D0a7aywfYvph2PfMJ0swFhSfBrJjox5Az6M5qRrPO2UUhxNEwRKFxN
         eX5kQiHCYGCXQi3NZ+0W7ovGQUcmnZHK4HsJYjmlQKLihJ2YJE5ZOCL8HeUdNePlu0cr
         TN9VvsVwPkakTTWVGh6HhNQ2MEJh12r/g+aStwGADlY0h1L6+JgpOGyJVqV2Aq9ewQMx
         tEl6ZH3o+25BOOuqYmsLWWLeOgeApbcDtxikMolylrYAxjenQZOKiJJUwNSQ2j1WXiE+
         YsksMH61T94DX9PrWzDSeNeSp16Kec+gobSjQhKHzt4MmAr7CF6yriFduQXaLlAwjz3M
         JK4A==
X-Gm-Message-State: AOJu0YxHWJd9g0IEqtjchPJMfyzmir6Y8QjG9pIuU39Cejw8TIOXoLU4
	QcEioidvgx8EMPfCO0j3xnA=
X-Google-Smtp-Source: AGHT+IHsHd2Cx/ynqlSuqRExAHoep8wja5fCZyRZGGgqJuQcJHouYNjONKURdGlFc/fFvdPyUbOc6Q==
X-Received: by 2002:a17:902:e744:b0:1b8:1591:9f81 with SMTP id p4-20020a170902e74400b001b815919f81mr14213893plf.4.1692076386648;
        Mon, 14 Aug 2023 22:13:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:de5f:36a9:275e:7e3b])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902728c00b001ac5896e96esm10286781pll.207.2023.08.14.22.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 22:13:06 -0700 (PDT)
Date: Mon, 14 Aug 2023 22:13:02 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] wifi: iwlwifi: mvm: add dependency for PTP clock
Message-ID: <ZNsJXtnrnU5c3pYo@hoboy.vegasvil.org>
References: <20230812052947.22913-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812052947.22913-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 10:29:47PM -0700, Randy Dunlap wrote:
> When the code to use the PTP HW clock was added, it didn't update
> the Kconfig entry for the PTP dependency, leading to build errors,
> so update the Kconfig entry to depend on PTP_1588_CLOCK_OPTIONAL.

Acked-by: Richard Cochran <richardcochran@gmail.com>

