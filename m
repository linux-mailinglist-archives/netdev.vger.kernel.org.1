Return-Path: <netdev+bounces-36012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F77AC6F7
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 09:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2D42FB208CB
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 07:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF065B;
	Sun, 24 Sep 2023 07:28:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A3A38
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 07:28:21 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6582103
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 00:28:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f4f2a9ef0so45924807b3.2
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695540499; x=1696145299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlhytN8p6rzsoNNyF2qTaia7H0UbvnXVgo1f8ue1miw=;
        b=bzemv4DxQIseJIZGlcspLaUqsTJ+pNLlu4GBS30lHDRoXayjlS3aKQVLaaq7mZHHAS
         LF4KFpnYj/oqv+iLOBVj4QTA9s1ROI6Q7qbopwqBNV9M5u7wWCVP8sBZYanb5sH5If6L
         Tpdmw6tnWY/S6+mCF8bIZOZ7l0wUic5/swoKZ5aLOPdDIY7G65ONrJEbrOSt3lfnvd8h
         eHkCE4ys3myKIam9xyfe9tZISOAW7KX4mMYGcq69E5hKCk4cyeOdTPn+DXjnHnYPaw71
         OTKRBQnVvfNRqio22MSKg6jrC3fjHpEkMTGOAbleiXmVLyzRX73USUTEyLbIwlW990dV
         CTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695540499; x=1696145299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlhytN8p6rzsoNNyF2qTaia7H0UbvnXVgo1f8ue1miw=;
        b=gpnyA35DbaMANvf0HEe/B1IkyNMncI64MjsStXZVDzsWKBk6p2SggGnXScgBxTTtAG
         bxkLMduoWqVcTcY14tpWz4Woe3htl81wtTjhyW8PGRPDCKkK8YqyUKfVgakHbVPWmM2M
         /RD3wKFlzTA9W8cO5/8dl7nFGSqvTn3Qhq8L/d0sCONcs/rkSzHd3Nr8eNZZgdyg6hNg
         TB06RGD6EX9XQ7ss9EVP7EepYldNnLaedhurni0ZqibFAn3txchdz5SbAQuUf5t1aSur
         cIF9hpI7Vxa7/+G+mu3jjXQKktMV1NyiyLhQA1kJlZnRk701o9YO/VsXA2LlQPqHZgz4
         nvDw==
X-Gm-Message-State: AOJu0YwtnPeUR/axDXjOZnHasVaM6vjtPO4v+NEUrXNWRzg0YXDQ9jcN
	7MElDUiLCGcQekpWw4kWoK7weZzOK50C4Q==
X-Google-Smtp-Source: AGHT+IEhWDis5bOzbmBGOi4zqdXmHXsB5eM3APbeJBFJO8QLORC4+n5ComSE/iuNU8T1xE+g9g77xuCbvAPMMA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:e304:0:b0:59c:b9b:8940 with SMTP id
 q4-20020a81e304000000b0059c0b9b8940mr42160ywl.8.1695540498994; Sun, 24 Sep
 2023 00:28:18 -0700 (PDT)
Date: Sun, 24 Sep 2023 07:28:16 +0000
In-Reply-To: <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
 <20230920132545.56834-2-wuyun.abel@bytedance.com> <20230921190156.s4oygohw4hud42tx@google.com>
 <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com> <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
Message-ID: <20230924072816.6ywgoe7ab2max672@google.com>
Subject: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising memory
From: Shakeel Butt <shakeelb@google.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, 
	Jason Xing <kernelxing@tencent.com>, Xin Long <lucien.xin@gmail.com>, 
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 06:10:06PM +0800, Abel Wu wrote:
[...]
> 
> After a second thought, it is still vague to me about the position
> the memcg pressure should be in socket memory allocation. It lacks
> convincing design. I think the above hunk helps, but not much.
> 
> I wonder if we should take option (3) first. Thoughts?
> 

Let's take a step further. Let's decouple the memcg accounting and
global skmem accounting. __sk_mem_raise_allocated is already very hard
to reason. There are couple of heuristics in it which may or may not
apply to both accounting infrastructures.

Let's explicitly document what heurisitics allows to forcefully succeed
the allocations i.e. irrespective of pressure or over limit for both
accounting infras. I think decoupling them would make the flow of the
code very clear.

There are three heuristics:

1. minimum buffer size even under pressure.

2. allow allocation for a socket whose usage is below average of the
system.

3. socket is over its sndbuf.

Let's discuss which heuristic applies to which accounting infra and
under which state (under pressure or over limit).

thanks,
Shakeel

