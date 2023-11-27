Return-Path: <netdev+bounces-51214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A357F9A55
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 07:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B084B20525
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD9DDDA6;
	Mon, 27 Nov 2023 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xbWX2Dp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A6136
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:56:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da1aa98ec19so4682054276.2
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701068214; x=1701673014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9XmQ18Vq9AS/FrAADSETB49vxbzMQUf90IEZ55+oxc=;
        b=0xbWX2DpA1CbybGU2Chb7k+AvjuJaVJDIML9XZVxiRxT6MfSN/uI2Gfx/z5JTIEXfJ
         OZKf+PUaUv7P8Lo7xlSH/7C62eD//K5m8Ogf/9VmkPyVoTokjKqU+2UOKkFQg3Eeh9/z
         J79lgv35d8NISrcoM6PHHpBF4Uf2Ypzenhmt5dnKeVsgI0Eg+By9xZlyF6ht6H/4dKHK
         GIkCMot5K6KfICjN/NdbxpcJsGoS/JtMCdmGRLW8aBCXrZAa3+sHSX26luu/os+dNd4Z
         9iy1YK0QqWHtllshTSsRJXU2oaX8VP5fB+F7taV83Ml8bSYYsgYvlJTTHpCO78Ze+me3
         5e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068214; x=1701673014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9XmQ18Vq9AS/FrAADSETB49vxbzMQUf90IEZ55+oxc=;
        b=ZOcHw9qyIQum9n6u53w3xbzSVXzeKsFkdwUHVmWExOZTIL8ibByS7SX4YuLCOntNTa
         EQVbVTpdO0QUAP6f4wZ/JMcQBmkCBWO4tW2N8bfYnEoER05XbdNZt/HecaJ5Ly5fpZ21
         BySRLAdv/UtY3bcnBRjh8H1Qhbv9bBYBn6ZKOBwQX4/EAGs9R8wm422pPuY7f4N5oolk
         l7RmjVvRk6HXA0qSDJsR7NT/rFxJcK197wBaAlbpSjN8QYevy6RHRcp9WWMUUK3TlP7p
         DeIjwSbMBimLFGMI8PqmSxdhz7d9eITUqfG4+bBbEpt5gQ5umkXhOi0HDQJHhbvvGmVo
         4PgA==
X-Gm-Message-State: AOJu0YwneBixkZ6SvPImozJQXmmZJC0a0ywvn8ColPbYP3jTlR7zR2h1
	UIrcf8DttaWGcy648z+cRncbEtOZZKcMFg==
X-Google-Smtp-Source: AGHT+IFRHobDb7dhTMks/hGoJL1dUOSHaf/tculNySth6ZWovjrspQIo9ob3iKgkB2SYhI2pEgEusMriUPzLtg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:3106:0:b0:da0:3e20:658d with SMTP id
 x6-20020a253106000000b00da03e20658dmr313753ybx.10.1701068214540; Sun, 26 Nov
 2023 22:56:54 -0800 (PST)
Date: Mon, 27 Nov 2023 06:56:52 +0000
In-Reply-To: <20231126230740.2148636-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231126230740.2148636-1-kuba@kernel.org> <20231126230740.2148636-2-kuba@kernel.org>
Message-ID: <20231127065652.z5q6cd7eyf6kaa3f@google.com>
Subject: Re: [PATCH net-next v4 01/13] net: page_pool: factor out uninit
From: Shakeel Butt <shakeelb@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Nov 26, 2023 at 03:07:28PM -0800, Jakub Kicinski wrote:
> We'll soon (next change in the series) need a fuller unwind path
> in page_pool_create() so create the inverse of page_pool_init().
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

