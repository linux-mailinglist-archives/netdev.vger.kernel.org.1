Return-Path: <netdev+bounces-47133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE817E8267
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BFB20DBB
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1D3AC3A;
	Fri, 10 Nov 2023 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4pfe43e"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69C2BD01
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:20:40 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1010415E2E
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:20:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so2459441b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699644038; x=1700248838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmDqdAWs76Z38wbCXMVzmK7UmSAVaiZdksg9Nozpdp8=;
        b=A4pfe43eMhEXQmBZBUhJX0Po1sv9EUnsEEVkX+znz+Ar0nct3KkqceJzmaE1W32K6Q
         h8FYXWYzIh/EykJUt5graVnWbC7TLIYm94dpl7ATz4kOHJHhrs934tgv4G0WrgPhQZEf
         1h8ryRBWIYVnwLC45DAjoqPNUHg2xGTNTNOuU1fIeSQo0Sm5qRi//D3tF2hB2h8nqs1F
         2EVOmIZed5xf1Db/vVqEz7dcWK/wrUd1KUOPZakkVCr/BrI698406fj6hVZY1cxfzwaT
         +bPQwBCktwHniqGAXCWu42rvTcR02wzJxi+8niHuksz/RFBXS0KRQut/xZTimksxCDLc
         0yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699644038; x=1700248838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmDqdAWs76Z38wbCXMVzmK7UmSAVaiZdksg9Nozpdp8=;
        b=hHnMNI0v1z9Ft9RIJXTQMqflDtursRIAgblW1FO8jc0D0+d9lqxdMKFpVNb49lRhMk
         PtENwiJzjA1vAQfd93y9mWT4ghhRy6ksQYc21Gb6ut6r5La0ctT1HfO6Uk9MBlhxwon7
         oEJX66XzXsEKLyM0YKkgf3u2ciqwzNpLjmu4mxlCqeyy5X0zaB+P0PknKzC2v8e+nCrb
         dxLN4t7JszeMFrh0xZqwjwKbtykdjY+V7wUXJIiPLHqRTGiKlvc9j/b/UGVc8HciCb4t
         WGfhBIivdHjpBnzAb+Lmj5XTMYHnY05R41uHFLUw+tPRHYO19Cc1FqIQqPTA7wH+5DdM
         KMLw==
X-Gm-Message-State: AOJu0YyLbRqWX7dgIOwZIwjPFDM2fLZvaRbcmdL0Y6oYrfLTdXOwi/oI
	XiUk3sJBjFAcKH1tAZY7v/u6y9Q=
X-Google-Smtp-Source: AGHT+IGjQZYceFZlkLGm/EfIF1Vis4zESpzioSQUieFa3Kg8E3dOt0VspAX2UHxfpbxz1G8loZjCJa0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3212:b0:68f:cb69:8e76 with SMTP id
 bm18-20020a056a00321200b0068fcb698e76mr1374197pfb.2.1699644038285; Fri, 10
 Nov 2023 11:20:38 -0800 (PST)
Date: Fri, 10 Nov 2023 11:20:36 -0800
In-Reply-To: <20231110111223.692adbd7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110084425.2123-1-kdipendra88@gmail.com> <20231110111823.2775-1-kdipendra88@gmail.com>
 <20231110111223.692adbd7@kernel.org>
Message-ID: <ZU6ChFruBvEnA0V0@google.com>
Subject: Re: [PATCH v2] Fixes the null pointer deferences in nsim_bpf
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dipendra Khadka <kdipendra88@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="utf-8"

On 11/10, Jakub Kicinski wrote:
> On Fri, 10 Nov 2023 11:18:23 +0000 Dipendra Khadka wrote:
> > Syzkaller found a null pointer dereference in nsim_bpf
> > originating from the lack of a null check for state.
> > 
> > This patch fixes the issue by adding a check for state
> > in two functions nsim_prog_set_loaded() and nsim_setup_prog_hw_checks()
> > 
> > Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com./bug?extid=44c2416196b7c607f226
> > Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
> 
> Don't think so. It's probably due to Stan's extensions / reuse of 
> the offload infra.
> 
> Please put more effort into figuring out when and why this started
> happening. Describe your findings in the commit message.
> 
> Current patch looks too much like a bandaid.
> 
> Before you repost read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

I agree, I have a similar suspicion for the same report on the bpf list [0].

0: https://lore.kernel.org/bpf/ZU13dQb2z66CJlYi@google.com/

