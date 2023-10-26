Return-Path: <netdev+bounces-44526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA2A7D86E9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0932282012
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3A15486;
	Thu, 26 Oct 2023 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HhVgDKS+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150111CB3
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:47:23 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2971AA
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:47:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692c02adeefso1026590b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698338841; x=1698943641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdlXvNC1oH8LpDpUtTg5FvSVkJ8vtx+5H8ZrGXJ1ghc=;
        b=HhVgDKS+/6Qp9UyLmiFRY1h2ZhU1Mo7r9tXKn/ETcmosEa5Y7uMDgVrxRPhvxMNv02
         9yKL6GZSSVOIL5GbTQdiCulm4EyW+qvun8qSCiVS30sNusT6MLfD1ZktERDVC3Qm/+9v
         IegEp9T1KZf0KE3f7SWLmS3eh0DZ02B3alzmFzdCh0nkwH5uRmTAcgkh0As9sjaEoLtn
         1bnKMjgAXxuVQAnxYYoQWsHfu6eRhSGqVyEmZfboAAHng05TS9Bz85B8VAfRMDSJk8je
         7Yd4Shd1EbiHswa/w9bogdExf0N5HogIrwTiiH51Hox5YWO89LADi17W7SljOvMO7184
         Rvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338841; x=1698943641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdlXvNC1oH8LpDpUtTg5FvSVkJ8vtx+5H8ZrGXJ1ghc=;
        b=vlMGnMOLycufLmMQftQlkvwTzPTr0yzHkS8nXPFY2xC8m7SXF2nqjidLCKI0+7ju84
         ti6yDbXaG/PxkucUHRlO0iDTd/8EVNyx+pHeV/lg8AFGVcywbWFqOw6pO9ox2AG0Fdzt
         QS0DcXM4JOheNazFBJQX7NLs4tHN0Cbqz1OuOiTQTGklsSnFf0uu2VFeiFgkkBiO6LbE
         d/oy2KkR4Ypqb7O3dZpEFUY6nclQueTn6lQuxVox3piBtZbQOSQvk7AHObFsJxgwY4Hu
         2GLXh33eCCtPw/JSbaFUg+G4fOISwCHT97QmZGTW9vkxJHQ22bSph34d8cEmAZCU+iKU
         xCOA==
X-Gm-Message-State: AOJu0Ywh3tZAx1hIVne7g43JPc3Zm72hMOjCaWHVF/IYwYjMWpMvE6GM
	4hF1v/J8LBJeskGWn1U8OhZsPw==
X-Google-Smtp-Source: AGHT+IH8FSwFpW91FuCTU44KJZe03BzdcRhpD6cilALb1W6ubekxWLvOyZfKm3UyQTuWKQaC+rgpBQ==
X-Received: by 2002:a05:6a21:47c1:b0:15d:9ee7:1811 with SMTP id as1-20020a056a2147c100b0015d9ee71811mr334913pzc.36.1698338841412;
        Thu, 26 Oct 2023 09:47:21 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79414000000b006bf53a51e6dsm9749547pfo.179.2023.10.26.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:47:21 -0700 (PDT)
Date: Thu, 26 Oct 2023 09:47:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Message-ID: <20231026094719.04cace95@hermes.local>
In-Reply-To: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
References: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 15:50:50 -0700
longli@linuxonhyperv.com wrote:

> 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
>  		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
> -		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
> -			netdev_notice(vf_netdev,
> -				      "falling back to mac addr based matching\n");
> +		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
> +		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))

This part looks like unrelated change.
The VF mac address shouldn't change, but if it did don't look at i.

