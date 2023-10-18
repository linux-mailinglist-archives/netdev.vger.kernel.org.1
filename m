Return-Path: <netdev+bounces-42344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C07CE602
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978C7281C39
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB43FE55;
	Wed, 18 Oct 2023 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Aqh21O7f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABA3FB33
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:13:48 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735B112
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:13:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27d153c7f00so4873959a91.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697652826; x=1698257626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/DxBdMubrGlwDuHwG+RfkPUzyCF/aFPGk7IItlMvVk=;
        b=Aqh21O7fffYiemQx7XeyemlUT8v7Ht9WbadmkZMHtSYZV2sb0NZlvC591xZZuAobGb
         oD97O9x+Ih61Pt6NVrY2Ccik4K74z4Uxu/Wc4kTGZWRmlF2yItQBxK8EOs9EBhJcNWG7
         a8L4AHZSar1bsqBoLlpijqiw64lTa53sI3NfNa/p9zti+nKJ2ucpLky+FfTM7iYXelEs
         rWVPUybz/iKIYsjLF5/8EjWTIUD+wO/JR3QHu69RImk+58msoJ2DxVgWpnLDn9gGFrnd
         6Zic9etMLzOilQjbLm3kDlMaqOMiC0C5yZ8Ug6TE1syIaxLashSqc+NH34ZDhPfX0e4T
         aoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652826; x=1698257626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/DxBdMubrGlwDuHwG+RfkPUzyCF/aFPGk7IItlMvVk=;
        b=ZFLRp9bxwekfujcYVslV66G4PnTcWOGLsxEKjHQIXw24Pr3hi025raAJ3e/ndSChln
         fLX/QfLrC4nC2rxy4EkN3fIuwJ2KZbYgQ1pcQ0lJZ93qzKQpcbCMzGRAP3CH+D11wWMV
         KOlul0NsVlxZL709YhK00Tp05GALCGOVr0E3POWOYnfJZRUJXmu3044S0DyzQYDIdNiZ
         4/dMFh09XeaisBmJsEMBleXOopUVYTgjWU6c2p90VW87c6yxMHy5xGSqokSl+w517x0i
         kP4MbsrsAu0v74Wskqs6wItUgwvj0HnoR/kxsDMM6gFhQsRAqun4bbnt2+N4+Cph4kTX
         ltyQ==
X-Gm-Message-State: AOJu0Yw/LqHVtiBRhnNhvEYalGuu3xUwstSIS/3gFie/QCuVJOYfrwK4
	JFumHPKkAZk6AtDw4C/uo8sTXA==
X-Google-Smtp-Source: AGHT+IGPJMLSBzfUbVya7ubqiyySnzJh5TpV1x3pncIFC0jOvZLiLhA7WGccgaHCVQqRGJ3c2uv5rQ==
X-Received: by 2002:a17:90a:3049:b0:27d:e5d:33bf with SMTP id q9-20020a17090a304900b0027d0e5d33bfmr5673556pjl.15.1697652826138;
        Wed, 18 Oct 2023 11:13:46 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id d92-20020a17090a6f6500b0027654d389casm189863pjk.54.2023.10.18.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:13:45 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:13:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org,
 mhocko@suse.com
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <20231018111343.176ac1b9@hermes.local>
In-Reply-To: <20231018154804.420823-2-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
	<20231018154804.420823-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 17:47:43 +0200
Antoine Tenart <atenart@kernel.org> wrote:

> +static inline struct kernfs_node *sysfs_rtnl_lock(struct kobject *kobj,
> +						  struct attribute *attr,
> +						  struct net_device *ndev)
Still reviewing the details here.
But inline on static functions is not the code policy in networking related code.
The argument is compiler will inline anyway if useful.

