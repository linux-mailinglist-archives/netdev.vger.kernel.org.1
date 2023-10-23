Return-Path: <netdev+bounces-43388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E297D2D30
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF132813FD
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC511CB4;
	Mon, 23 Oct 2023 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="fBDWFABt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5523C5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:51:19 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828DD6B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:51:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507973f3b65so4698924e87.3
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1698051075; x=1698655875; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ysSPIE1IsCCSmbKD8t6b4YAJn+91dFhQHWn97JPjhfo=;
        b=fBDWFABtdRy/dqJUpSZ+liDyBE3Yz4jUtCRqnbrsQ1+/b6CbT4YpugRDwZnXT42Ov5
         0Sn0D11S4TDcztFBNmNoed/a0A7qXzGcnha0v0g2ND2NsFpXS/pQuR/2bInodCU5l0/u
         FkseaI6z1bluG4Ldw9twsA5kNBDohQt/rd2uqiM7DFCT8ZJfBgpECkP7AKya9NTD8Nma
         iL2wNkEP97CXuX8gis7V6MP7YrNd54fDy6sgU9QzBMMBal0WtjhxjJYQO75hPhdiQKVc
         samvIZjVAzm/Tzxuja7T5QYbrCjXmYupEbk8nubMq+EoPPgh3nsuaNtp+pNZb9XHnLHd
         thTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051075; x=1698655875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysSPIE1IsCCSmbKD8t6b4YAJn+91dFhQHWn97JPjhfo=;
        b=qrWILri33ES7ELaKzL1RNhv2bN7IfSqhae5JFkcTwedLRairIKWrF7QDiElbeRuEgH
         +lbUgu0BsE/3P7jgKR0rtg6VTPnm+8JSUoZ2Q9Ch+YhRlU9zYK7klA5Rq5YERpCNuDgR
         iksUtdrQ6ajHU8YNnBLZnQ2+npYAvEizymr6Q7EktFZg2sHkqWaoSgNkoDHraNSOgQQp
         OiFzxw700JbZPD6PpkO/mGkXPOpTIelZLD2nXhHMBL3oau6MCXzZrhD0Lxwf3mjumMr0
         ym/+1wfULT0PqMpDErGS0hiIp5gebPhL1FP+dWWzWQdjB3Iydn9wiSNohsQZK5yJemDy
         p1cQ==
X-Gm-Message-State: AOJu0YyhoZLmGhMks0WrmG1i7FBQf7eQ/3JQHYbSyeRCSaUNPcm3aoIk
	qF1v/gpMgM9j5oDRK/Rd17aqWg==
X-Google-Smtp-Source: AGHT+IFEURVUnPN4CEHL4cv4l6EZj9sBwtljJmg6BWQjvR/0RRtPiq7dIc0YgYd3MEVCJaTEEeOFfQ==
X-Received: by 2002:a05:6512:3449:b0:503:1d46:6f29 with SMTP id j9-20020a056512344900b005031d466f29mr5831713lfr.37.1698051075030;
        Mon, 23 Oct 2023 01:51:15 -0700 (PDT)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id v26-20020ac258fa000000b00507a3b8b008sm1610739lfo.112.2023.10.23.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:51:14 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:51:13 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: ethernet: renesas: infrastructure
 preparations for upcoming driver
Message-ID: <ZTY0AXS2QtkIkLX7@oden.dyn.berto.se>
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>

Hi Wolfram,

Nice work, for the whole series.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

On 2023-10-22 22:53:14 +0200, Wolfram Sang wrote:
> Before we upstream a new driver, Niklas and I thought that a few
> cleanups for Kconfig/Makefile will help readability and maintainability.
> Here they are, looking forward to comments.
> 
> 
> Wolfram Sang (2):
>   net: ethernet: renesas: group entries in Makefile
>   net: ethernet: renesas: drop SoC names in Kconfig
> 
>  drivers/net/ethernet/renesas/Kconfig  | 9 +--------
>  drivers/net/ethernet/renesas/Makefile | 4 +---
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
Kind Regards,
Niklas Söderlund

