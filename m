Return-Path: <netdev+bounces-53287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC40801E7B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270591F21005
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90C21112;
	Sat,  2 Dec 2023 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOtvKRx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B4188
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 12:28:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1b2153ba1so47531907b3.2
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701548896; x=1702153696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODDcMAdQhouraohZRnNZUroO4X5evMmcCVE/klv9514=;
        b=bOtvKRx+MurvFDtogm+rkyszc71ei25m4y3+xaoYEi0PBV+QpwKycT5QZ+KulimTTl
         rA8czyO87EUYA9cdUJwCzAasGdYg8RPtdOMqjBvh2NMikFAfI0lLxcFr2lWvhtj6s8Hz
         /GorlQWa+ZenpuZHYiskbCveafyFRt9FIw4FbFM3EMEJkctbvLbULujsbpkhQ9uTOijE
         468owU9UJV0Y/2HOWo81k9MW8Wy9Lm3cTghdZUJpmnkdqjJtIWlC0TenWYAnuIIyolqb
         TkDybLbEvcTL2J4JOsq5ky5g9DQAlKTMRyEiLzmtwKX5Vss0vX46M614RfPQui1kMlYO
         /9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548896; x=1702153696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODDcMAdQhouraohZRnNZUroO4X5evMmcCVE/klv9514=;
        b=wMUfs2zIHxAypPjJc+o0dSLwW9YaIe8IMpT1eKLIs7rMVV806j/tWJWmq+YfNYpL/7
         QRVu6tEn7uvPPKTqI0Q6NVrdzXCCu1QmbJ7s/dWsFzk0tpAa6p3HMlutTVqRFJGwM89o
         CmhcOcpxD8sNhMMhcfLIY+PDfa9sVnGQxOmPA38YCCuIW7iyZVUwm98EPM4nA9acaJHT
         iNI4gLZlyw4kHDOnq4u0z8+iE/7myg9twBmZm7kDSm+WHFtwnRnL1GGjAT0aiETwgRJm
         2IQbF1/eqeWyIsyOfqbYADwqS3pSdr1QBjkzrK39xE1ax+1PbHoNUGSb864eo3tJWKG/
         DAVQ==
X-Gm-Message-State: AOJu0YxzDK77mPt6KmFY0K8tgyQxwSY0yX6QXS+W4cd2Yhej9uy/WYff
	IxfB3BZo7qHobOk2GvlWM5awAcnLar4ZZA==
X-Google-Smtp-Source: AGHT+IFVnYkkFGvRXRYNa0ByAFxtXQPkoUosKNUgTUv7FuN4JsDFrW2TDj03BoLZ3FQpRE6zaSwnfqyECnfXcg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:2712:b0:5d4:1b2d:f436 with SMTP
 id dy18-20020a05690c271200b005d41b2df436mr162169ywb.5.1701548896090; Sat, 02
 Dec 2023 12:28:16 -0800 (PST)
Date: Sat, 2 Dec 2023 20:28:13 +0000
In-Reply-To: <20231129072756.3684495-5-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-5-lixiaoyan@google.com>
Message-ID: <20231202202813.mhrv76taop7bermr@google.com>
Subject: Re: [PATCH v8 net-next 4/5] net-device: reorganize net_device fast
 path variables
From: Shakeel Butt <shakeelb@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 07:27:55AM +0000, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order
> Fastpath variables end after npinfo.
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 4
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Coco Li <lixiaoyan@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

