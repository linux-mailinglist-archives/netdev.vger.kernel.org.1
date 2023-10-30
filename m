Return-Path: <netdev+bounces-45225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD87DB97D
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69111F21F25
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F114F9A;
	Mon, 30 Oct 2023 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tk6cYUSb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F2D29E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 12:07:15 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A44C6
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 05:07:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d34b2b51a5so170330566b.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698667633; x=1699272433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAof5WwCREHhgYvZP5oL9OZtxCJg/p8F1Qyqhopa2tA=;
        b=tk6cYUSbwPm94Sddc5HmcF/6xvZycbisb6NRMHiZRwgedeVomxu3fOpnu6SFB6HRBg
         MFm8fYFiVFe601gpfhjoylVsQ2emYZ6f3CfjrHGe4iHfAZTlo9gvs7rHC9IZF0i0zqaj
         jRiW7zPCD0XZUK95q67FEETmOUgJMG27sQ8Ttr2UUvpKNxCReYXBHTWNrxCdUkq2djIu
         Z9fzGEHsY2rx3rcEXZbPJAAxPYt78Deq2OtFLyKVKKy1Zgbz+VaFT62P9lKdqYH2t7WG
         O4V8mJIsJzONMWKcHpdZh+55xgav5BYEUCBdB6i8fg1Fw6HAmiEB0XXnRvQtfs+mWHFn
         C/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667633; x=1699272433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAof5WwCREHhgYvZP5oL9OZtxCJg/p8F1Qyqhopa2tA=;
        b=hzvGxqsTPiQJuuz4V6qUdrAYUD/LgTaKzQguHX91Oejohr2izBV5IpScSGCrosDVdy
         AVV+0tqiOn2lyuyFVkznKModLmL7IahyHsvRbTgbg9eXny4f++pE4w7NWBFHZ4/+sEAw
         nxO1HjupgyiWGxtiINIDbQFtNP/9mJdFXulr35mc7pCAgXR6eRRx4zSXnRN9fcv9vO/r
         OLVl9FUwQSLx+1ph+lzuf5oAzoS4EQlX1DosOE5OnlBOr64CAQsJO3cINJ0Aqe8XaGxh
         HKjEghiMazaOVkzYzYDq6HKaVaw4IIM6rnFSDmSWIQObsmDR2Ailgnhmgb1bkrtWxLYZ
         agmw==
X-Gm-Message-State: AOJu0YwVrrZLsNBla7OFqr8ogTtv+kx+KP79tKj/O9hydE+qu9ePTYJh
	Scn9QOE8sRVMm8L4Bpgp+OJc5A==
X-Google-Smtp-Source: AGHT+IGBHK0i5fSOAaHDaa1kq/y9l+3D/IFB+FmpFVFFTGvhuxbi2H37szUupGExcwAp3AVcfJetTw==
X-Received: by 2002:a17:907:7f1e:b0:9c3:e66e:2006 with SMTP id qf30-20020a1709077f1e00b009c3e66e2006mr9039051ejc.9.1698667632723;
        Mon, 30 Oct 2023 05:07:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d26-20020a17090648da00b00988dbbd1f7esm5870031ejt.213.2023.10.30.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:07:12 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:07:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jdamato@fastly.com, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, linyunsheng@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
Message-ID: <ZT+cb4sO3PK1EbT5@nanopsycho>
References: <20231030091256.2915394-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>

Mon, Oct 30, 2023 at 10:12:56AM CET, shaojijie@huawei.com wrote:
>From: Jian Shen <shenjian15@huawei.com>
>
>When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
>is not called to free pool->recycle_stats, which may cause memory
>leak.

Would be nice to see the use of imperative mood in the patch description
too, not only patch subject. Nevertheless, fix looks fine:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

