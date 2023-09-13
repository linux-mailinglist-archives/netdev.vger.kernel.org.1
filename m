Return-Path: <netdev+bounces-33536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C279E69F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27067282787
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD891E530;
	Wed, 13 Sep 2023 11:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7523A0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:25:11 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EFE173E
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:25:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso880731866b.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694604308; x=1695209108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcntLYdlJrieUdg/kYF39cJLZoMWMCbVHI+U2izHBXM=;
        b=uI3q86OootmZysZRmDQl7e7rShJj8AQ0LiD80O8WpjAeGm1lnuEPHa/r5C8WEiDpEP
         lqwO+erpo9Lg6kmhRLtRq57pYndJLbE3If+TVuS23zKLDQ7b5k0RMriWZ7Y3/Uabbu3q
         ofODH11lN0KTGWPH8qL8/QWtdV6K8uPetr/KpRLJFEYuQ8zAtqCfhrM7DMPdzROUrsH3
         AyhDEpROtok3SB9odV0arg69LCH/ESnW7uihAU9HJc6Rd5gstiXwG3QbnO1qoGNsGgYM
         rP2AltilIHwTdFXPO00l2QLbsUinPvaHlIKwKTmKdsFSQ6rSC+LCd3atJ0K3aNmpVqrz
         itOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604308; x=1695209108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcntLYdlJrieUdg/kYF39cJLZoMWMCbVHI+U2izHBXM=;
        b=eAgVUEIktj6+3ABN3a/jchht/eDIxdxcLqqu2c7LxUD8sEW8kg+6I4GH5bU484J5By
         kYX4cLvCTqTAWymwOQU8T/J8N3nAxo8m14jSmWMJly0sCruX3sPHVH+fBXXEJoqYN0z+
         f+lCjDuuzyBrqTlQU8l64ux/m+4/plwkPRxKw5EpBtAtA9m1MXJAV7Qy3pBf2yBy8SmQ
         hPY5ejH9eO+Wo5iLQKqRKHBWxSea//BqC3XpW8uKT4R5EAlbD13B68triK4vx0ysQ44i
         tGANWWcipmoRt598XzPYll9Fr2/Aq5GMx/MBxGGEXanfVHilgi0OFK2vblNEG7gHYhJS
         9gdw==
X-Gm-Message-State: AOJu0Yy5FAGJUucuaOPgYx85wrugOvK3D4455rxgpGUa1i0Cmb2nGayv
	dCTzc6KSJ5fHT+RIkz7exWlW7rqR2OQjL3mWx9pdHQ==
X-Google-Smtp-Source: AGHT+IFcbUiTn2Rfv4jukpMcXnkLNIxaETPnCltPEUgzzKFocH1lSUpwiP1y8KHdzK5bvj4lyoTzIg==
X-Received: by 2002:a17:907:62a6:b0:987:4e89:577f with SMTP id nd38-20020a17090762a600b009874e89577fmr1944307ejc.24.1694604308311;
        Wed, 13 Sep 2023 04:25:08 -0700 (PDT)
Received: from fedora ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709060e8c00b0099290e2c163sm8274762ejf.204.2023.09.13.04.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:25:08 -0700 (PDT)
Date: Wed, 13 Sep 2023 04:25:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa
 Prabhu <roopa@nvidia.com>
Subject: Re: [RFC Draft PATCH net-next 0/1] Bridge doc update
Message-ID: <20230913042503.431d8969@fedora>
In-Reply-To: <20230913092854.1027336-1-liuhangbin@gmail.com>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Sep 2023 17:28:52 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> Hi,
> 
> After a long busy period. I got time to check how to update the
> bridge doc. Here is the previous discussion we made[1].
> 
> In this update. I plan to convert all the bridge description/comments
> to the kernel headers. And add sphinx identifiers in the doc to show
> them directly. At the same time, I wrote a script to convert the
> description in kernel header file to iproute2 man doc. With this,
> there is no need to maintain the doc in 2 places.
> 
> For the script. I use python docutils to read the rst comments. When
> dump the man page. I do it manually to match the current ip link man
> page style. I tried rst2man, but the generated man doc will break the
> current style. If you have any other better way, please tell me.
> 
> [1]
> https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/
> 
> 
> Hangbin Liu (1):
>   Doc: update bridge doc
> 
>  Documentation/networking/bridge.rst |  85 ++++++++++--
>  include/uapi/linux/if_bridge.h      |  24 ++++
>  include/uapi/linux/if_link.h        | 194
> ++++++++++++++++++++++++++++ 3 files changed, 293 insertions(+), 10
> deletions(-)
> 

Not sure this is good idea.
- you are special casing bridge documentation and there is lots of
  other parts of iproute2
- you are introducing a dependency on python in iproute2
- the kernel headers in iproute2 come from sanitized kernel headers. So
  fixing the documentation would take longer.

What problem is this trying to solve

