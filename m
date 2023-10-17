Return-Path: <netdev+bounces-41890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E67CC1B8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AE8B2100B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3241A9F;
	Tue, 17 Oct 2023 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUFvAdFh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AE41A93
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:26:57 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9154B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:26:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c16757987fso69721241fa.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542014; x=1698146814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mrPEDQIfS8myn90VdtG7Z+Jy8KtQq8Z5RZA+Vo/542M=;
        b=CUFvAdFh3+j2ng/tH+ncDfsc9hLOnlgxeRB1OZ1yd8cRxCephedAgV8m/hrykw51HK
         TWUgdqQ7nT7RQ23E/XL0DTiyyEnN4lspnWkqJBwXtUyik5LsjkO0t6wAi2iC/0Pr3oie
         c1jpTeW5+4wdU2m/zFusKDYDuW4tG/FCIKG5cxmaCA2d8dSszUzJOchJiytVk0FHJcjh
         Gsx1Q3KYs/PbVyEQSGujEdVz6bcn3CcYMEeC5djUpYBMwoIR7hkG1GYqIviUMlimNbUe
         Hog/XAx5gAtfxEqB9a3LoHUGYyKWFtlrcHfGXQJvFoSfURTZI1Gvdjmr9GdpwHC57hw+
         3yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542014; x=1698146814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrPEDQIfS8myn90VdtG7Z+Jy8KtQq8Z5RZA+Vo/542M=;
        b=Q+h3GDczQbNq6jjK6yCAWYp/K6g2uzjyAeEzSQMpyJ1K1FLEjMTAQpKbBjdk9IQXss
         UoCTibGjJgZB4r6QVHUgY/l1+3K+NoSRPzgVMs8N+q1Imh/eL3tJ3uXi8GK52i3NL+pv
         ykNvPTGwxfjUjKrkO6cpPN7VFe6x8L56ET9vG6kil6sMrat53tXX1o+YEf07pyCfH9iS
         +kQZiZSyr2lZEhAbctAFzO+lqRPlUSTCasWnvE6lv9wmgg98NaZ62ehXOHFwUleZyAw0
         R6ATQaNaL1+TdYxX1GEBAHhzlXOT7U+wh+qcmYCPGma1JYCoWDnnL9LGYJtqyPPUUa/a
         6aTw==
X-Gm-Message-State: AOJu0YzbsB4Xma0vVcmr9bLbQiJLJ6wrBUBbhOHCkDsw8JSrzIlIkLad
	99Ow9gxgfZ1Mh6AgVUybgrQSI/6FZvIrDomSstQ=
X-Google-Smtp-Source: AGHT+IENlhC/ey3U5k6d8Zmi3Iqqfl0mXehHOr2xRmCWHRJE+uWO2iLA6wOkxp8toMD5Wy5vbUYccpYLSEK2f/HkTv8=
X-Received: by 2002:a05:651c:50c:b0:2c5:1542:57e9 with SMTP id
 o12-20020a05651c050c00b002c5154257e9mr1550891ljp.41.1697542013933; Tue, 17
 Oct 2023 04:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Tue, 17 Oct 2023 16:56:42 +0530
Message-ID: <CA+sq2CcA_Cv8sQ8_vqCAW=EoXTkCfoEE8QNWEQmnyHTNfK0wdA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:
> IPv6
> Flows   with patches  clean kernel    Percent reduction
> 30k     0.000202535503  0.0003275329163 -38.16%
>
> On Intel platforms with 200Gb/s NIC and 105Mb L3 cache:
> IPv6
> Flows   with patches    clean kernel    Percent reduction
> 30k     0.0006296537873 0.0006370427753 -1.16%
>

Great work !!.

What are the L1/L2 cache size and cache line width on these AMD and
Intel platforms ?

Thanks,
Sunil.

