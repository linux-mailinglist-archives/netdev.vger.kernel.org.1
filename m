Return-Path: <netdev+bounces-45099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC87DAE0C
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 20:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4119281469
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0710A15;
	Sun, 29 Oct 2023 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK0lgPfC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697B2591
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 19:49:06 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E49B;
	Sun, 29 Oct 2023 12:49:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e2308198dso1457998a12.1;
        Sun, 29 Oct 2023 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698608944; x=1699213744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvVEduFFGy1+UbYCRZST4+Tb8T3xgC/iEMnPr7os3R0=;
        b=JK0lgPfCuLn3AG3S9voDPU2NZCVAm02mdZRSjoK9gZmWzKjau0LXNK5jb+W/AL4XLm
         m9LF28oKmRKrRguV5MjfKmNGVpb+qw4206MCpoc2wUh8rNfGpIx7QLQinTv5zezCXal7
         gWCerWEme/y16tlDmshM9biUDwW4jYjLiskYyapUCqq+91M20x96upBheX1QKah3ybD1
         H7EnE2cGL79qteIjSsmxiXCY94zolwTVYxxiAQkLWmHjDh7/lDyM+XVia+iEyQFX04v4
         A09JGGGdslTvrL3ofYGMB4QtNnpYRXHbR7TWLxEx5XBuhuNOZ2Bd5+vhi7ETOcdRboXo
         LPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698608944; x=1699213744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvVEduFFGy1+UbYCRZST4+Tb8T3xgC/iEMnPr7os3R0=;
        b=lafBqk5yXsb2RBu3z3V8ikEq5x5/zhWGyLoyuFir80bN/5rJveh/ATMhFSiCC9rpGU
         Pxj1qREPfyaHWxBfT7Vb1Aksq0Fu1ifgvbAnvCqgyM3J4W7HqGr99Ih3l1lH+OaOxbj0
         O0WFCWPR5NwfAz6IR8Jf7ZbYVazZttyPLhDI5QeGqefb1vs335rS0zhhqRBCJw1/nH94
         xmaO4ONgTeKxJhb8a9g8BjW4pzqW1Er05dNjatS7w+T/CV3FjOOxqs8WqqlHKJMMFLxc
         7Wx+yGAkDIQn2kybl8dDUFGb6nXT5UckR48F3pGbn2XWekfedL5oZL8kFd8iB5C082hC
         Joqw==
X-Gm-Message-State: AOJu0YwXRkAV8kP0nwn1K6mp3vMIkXIwNtJ5+pZ+WKrPqt4BDrhyR9B8
	1cpSSkcoVa8AuzJeE+H01hP5Wvf7BpC0NQ==
X-Google-Smtp-Source: AGHT+IE7Q167o7RawkdnlhDCfCIhkxGYrQYUndrnSK5J+wBUTv8P4v6SPs3Q2jBrxEQ91EJ1r2ql5Q==
X-Received: by 2002:a17:907:7da4:b0:9ae:2f35:442a with SMTP id oz36-20020a1709077da400b009ae2f35442amr6572389ejc.5.1698608943615;
        Sun, 29 Oct 2023 12:49:03 -0700 (PDT)
Received: from hoboy.vegasvil.org ([88.117.214.186])
        by smtp.gmail.com with ESMTPSA id ay16-20020a170906d29000b009b8dbdd5203sm4812000ejb.107.2023.10.29.12.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 12:49:02 -0700 (PDT)
Date: Sun, 29 Oct 2023 12:49:00 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH-net-next] ptp: fix corrupted list in ptp_open
Message-ID: <ZT63LEJCuIY7v_Ou@hoboy.vegasvil.org>
References: <tencent_61372097D036524ACC74E176DF66043C2309@qq.com>
 <tencent_D71CEB16EC1ECD0879366E9C2E216FBC950A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D71CEB16EC1ECD0879366E9C2E216FBC950A@qq.com>

On Sun, Oct 29, 2023 at 10:09:42AM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(), ptp_read(),
> ptp_release(), which can cause data corruption and increase mutual exclusion
> to avoid this issue.

-ENOPARSE

How can lack of lock protection increase mutual exclusion?

> Moreover, the queue should not be released in ptp_read() and should be deleted
> together.

The queue should be deleted togther?  Huh?

> @@ -543,6 +552,8 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>  		cnt = EXTTS_BUFSIZE;
>  
>  	cnt = cnt / sizeof(struct ptp_extts_event);
> +	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +		return -ERESTARTSYS;

This is not needed because the spin lock (timestamp_event_queue::lock)
already protects the event queue.

Thanks,
Richard

