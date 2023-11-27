Return-Path: <netdev+bounces-51215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F337F9A7C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 08:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F8D1C204FA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB42E576;
	Mon, 27 Nov 2023 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jzDtOUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD101BDD
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:07:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so4293405276.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701068869; x=1701673669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aGwLB4PKOfqsYEDK44OuFWBroYv9+mrDLHCZwa+s5g=;
        b=3jzDtOURb1mTG0d1J06qVEB9BTn6I0auy8KH9R9MjczpGwXLY2WypO9qDcSUDQSNoI
         y+Y8hpfz3kwnvzXk03X9iv91JXadrfTf4yX/FaCiFTzOobLiwR/nfNdjzXd1IADAXbpW
         uEDohUEWReQkO5z50I3v6qH5C3c2uzTxKk+LSZUIbaU0PogDkThtlmu6o+ga9G7pR3B4
         B9FXmvVf328bRHPYKCtQQo1rLese8al6lF5DxOXSXfvZxcwHeg0A9zMb7QJ+bcvR3/9W
         aqubsnheEV4GHne9qQbEAkIisHvHugZrpqVLj+aL98Mw8//LqOd0TdTzwco0arFukgCF
         fDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068869; x=1701673669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aGwLB4PKOfqsYEDK44OuFWBroYv9+mrDLHCZwa+s5g=;
        b=cMZBvQqwF7Z4mFScoCqSHuHotOwwq2oxnxh2y5DOfsBW5JxGVZI4xCELbeaL7SYXNx
         dUSwpU9F+VaVnCl65/cvqR8AeDCzXKbZL0QG/AH4vzy27XkGGcL2MZSZBKHZaP5OfGSD
         iCW65NoVV/Mu95Ih6FWucdLdm0zQ/A9U6frjjLTboCHK3BH5f/urAUEJ+hfhUzGquPHE
         dIl1upG4H3CPKv4YRXiralSwP9SI5y6i2sD2BIlA1qGumrAomSdqyJ6k/KtzhbynUhNd
         Kfi46aLCViaYCF7hPati2tbljIsW2OE4YUEiTPvDlFivWN0UwEFDjV7K9QoA4nB/0shO
         cVxA==
X-Gm-Message-State: AOJu0Yz7vBaECj0JjIK0Nnn2iTkCr3IbFSPP75IxnqUhrSnda3FcNLIr
	MilF9QpOIvGspU/SQ/71MGWCT7VNXXTQfA==
X-Google-Smtp-Source: AGHT+IEwfWfewG2q2SYcKrvTHyJCvWVAlbPg2StneblwzPjMQHnc8oIRzRi4x5aE0z8+16NTVCcVrt7WigSCFg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:d74f:0:b0:da0:ca6a:bdad with SMTP id
 o76-20020a25d74f000000b00da0ca6abdadmr313457ybg.10.1701068869443; Sun, 26 Nov
 2023 23:07:49 -0800 (PST)
Date: Mon, 27 Nov 2023 07:07:47 +0000
In-Reply-To: <20231126230740.2148636-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231126230740.2148636-1-kuba@kernel.org> <20231126230740.2148636-3-kuba@kernel.org>
Message-ID: <20231127070747.37a42srqxs6jqtz3@google.com>
Subject: Re: [PATCH net-next v4 02/13] net: page_pool: id the page pools
From: Shakeel Butt <shakeelb@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Nov 26, 2023 at 03:07:29PM -0800, Jakub Kicinski wrote:
> To give ourselves the flexibility of creating netlink commands
> and ability to refer to page pool instances in uAPIs create
> IDs for page pools.
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

[...]
> +
> +static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);

One nit which you can totally ignore: you can use DEFINE_XARRAY_ALLOC1()
above.


