Return-Path: <netdev+bounces-44155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A417D6B4A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738AC1C20BC9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B972772E;
	Wed, 25 Oct 2023 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X9iyolAG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5D22F0C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:23:33 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C1137
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:23:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9be3b66f254so793758766b.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698236611; x=1698841411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OL4xyiICLi9mMA6DtrL4/QbeYsAcnWWGOO37F71TP8A=;
        b=X9iyolAGo4obfZZWUxLq+FoKBgLuje3AciU9k8nclcFhMR+/On1qvR9zE/lk6d2UqB
         ln5+YFolVToQ/UP/A2MU684h3PVMzP5UjD8df1UOpSDFpGdfwVpS7/u7FEkSC0kJhNyI
         ljszOur48DxP/fKj8Xr2Pp/jdNTl0Lsi6bg3MRzHF40cRg/g5/Z5Nj6URuELjKgwxC/Q
         zoJvKdMOJlWhJ1bj1Yfc8c35cF7Esml8qOfYqZg3NeNxL7bg6GO2IixnlTayzvxoULS+
         roeXWQiwGPf0W5hjvbFUcPx2XtpT/eh0mmlNS2EunaylsfoeAk703Xjeq59Rq6kdxKKs
         Xv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236611; x=1698841411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL4xyiICLi9mMA6DtrL4/QbeYsAcnWWGOO37F71TP8A=;
        b=pTipczbYXJ+DcJINFWm4U0gmOZw4D1q9nxFzIuCXrTc83BPGp44VZpwpagInmVX0Xb
         w+dLeoNVfgLA7t1AaPa+kaIpVYwi9qS3flnlOYUNRU+9oOy6UeZX9kqh7yJYD3YOKbwO
         hMQ5IumbBabWX7ZXVWXARw8AjrkMuVzVLQvwvQ+/iNcBlQOEBBf9c7L6mq1XMuqC9Wvl
         aj290QP1n0xR1xkD09MZJSBC+TR0hrzprE7TonlIZqtXnHWhFuMi+/l+y4LKEvbCUg8l
         1UGjeF/ahW5zyWZpfUKJUV+hjHFh//3G5X41Mxflqy69/Bzw6k3rhK0pF0zjKnZL1AYo
         kiVQ==
X-Gm-Message-State: AOJu0Yyci/LOzP0S03pAMijrg9aUXL8m88/7QI/NzdTRk3RaMLgK6teU
	gN6AvWjGJJB8Asw6h3s1vgu3ew==
X-Google-Smtp-Source: AGHT+IEOL8zOIMcQElNv863aspleABvznGqS7qHSX4QQTYwj0AQGAPQqy9b62yOzvrKnVQsGrIl5Pg==
X-Received: by 2002:a17:907:3d9f:b0:9c1:9b3a:4cd1 with SMTP id he31-20020a1709073d9f00b009c19b3a4cd1mr11191287ejc.3.1698236610667;
        Wed, 25 Oct 2023 05:23:30 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b009786c8249d6sm10057183ejq.175.2023.10.25.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:23:29 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:23:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: ipv6/addrconf: clamp preferred_lft
 to the maximum allowed
Message-ID: <ZTkIwIFKXe9aEkY4@nanopsycho>
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-2-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024212312.299370-2-alexhenrie24@gmail.com>

Tue, Oct 24, 2023 at 11:23:07PM CEST, alexhenrie24@gmail.com wrote:
>Without this patch, there is nothing to stop the preferred lifetime of a
>temporary address from being greater than its valid lifetime. If that
>was the case, the valid lifetime was effectively ignored.
>

Sounds like a bugfix, correct? In that case, could you please
provide a proper Fixes tag and target -net tree?


>Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>---
> net/ipv6/addrconf.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>index c2d471ad7922..26aedaab3647 100644
>--- a/net/ipv6/addrconf.c
>+++ b/net/ipv6/addrconf.c
>@@ -1399,6 +1399,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
> 			      idev->cnf.temp_valid_lft + age);
> 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
> 	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
>+	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
> 
> 	cfg.plen = ifp->prefix_len;
> 	tmp_tstamp = ifp->tstamp;
>-- 
>2.42.0
>
>

