Return-Path: <netdev+bounces-35201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B37A78C5
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FE4281481
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F915AC9;
	Wed, 20 Sep 2023 10:12:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6924156CD
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:12:05 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33ECF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:11:52 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-405101a02bcso8742035e9.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695204711; x=1695809511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFLGB2qgIpGyxCAHfm2i+PmCGhGU/0Xqf15cnOn5phM=;
        b=c7isln2GdzkQRzFuTbZ3NfzZiusbrif0sUwxDWP9J0bPSEeG5uRSBg1Bd75Hvt/oIM
         6k90LokOL3cpMGjnBT9V4BajOCNTuJwADoZ3YahI8Jgud+dczfprgTakBRAT+cOzHSG4
         QevGua4eMQtd1aP//mOP4/8IGBUrgQ53ebMiZ3uj0ybJpJnL5NEK32XtXAfABhPtS4IC
         V8h2oIl67XGfJtRjAy13Ik0F7Xkox9slTWfrlXxlEx5P6u/8B81LYKrobKHRNdBGSIdt
         LmBMNsN0ZG7E9heKDNJLeBResjh9fFeGpBzCIoiLZSyQce9Hu5w3NYA9UWtsyba1rwn2
         98IQ==
X-Gm-Message-State: AOJu0YzI9vvnQ8Ro0LqaLdQDy2xxdPIqJ6voYj5Gc00wNwbMeaHaocR/
	QMVcdPdtPkg9yG1/9isfNY03ufZCk44=
X-Google-Smtp-Source: AGHT+IE8jps8mSxzh6OP9U5onGqg4xq5lXToTiBZCN6JQ9cBGAViZJwoh/6vwSycDqZnwVxCwrwX9g==
X-Received: by 2002:a05:600c:4706:b0:404:74bf:fb3e with SMTP id v6-20020a05600c470600b0040474bffb3emr2011904wmo.2.1695204710971;
        Wed, 20 Sep 2023 03:11:50 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v9-20020a1cf709000000b00402f7e473b7sm1525727wmh.15.2023.09.20.03.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:11:50 -0700 (PDT)
Message-ID: <b82d4ecd-77f3-a562-ec5c-48b0c8ed06f8@grimberg.me>
Date: Wed, 20 Sep 2023 13:11:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
 <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
 <2537congwxt.fsf@nvidia.com>
 <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
 <253v8c5fdc3.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253v8c5fdc3.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> Can you please explain why? sk_incoming_cpu is updated from the network
>> recv path while you are arguing that the timing matters before you even
>> send the pdu. I don't understand why should that matter.
> 
> Sorry, the original answer was misleading.
> The problem is not about the timing but only about which CPU the code is
> running on.  If we move setup_ddp() earlier as you suggested, it can
> result it running on the wrong CPU.

Please define wrong CPU.

> Calling setup_ddp() in nvme_tcp_setup_cmd_pdu() will not guarantee we
> are on running on the queue->io_cpu.
> It's only during nvme_tcp_queue_request() that we either know we are running on
> queue->io_cpu, or dispatch it to run on queue->io_cpu.

But the sk_incmoing_cpu is updated with the cpu that is reading the
socket, so in fact it should converge to the io_cpu - shouldn't it?

Can you please provide a concrete explanation to the performance
degradation?

> As it is only a performance optimization for the non-likely case, we can
> move it to nvme_tcp_setup_cmd_pdu() as you suggested and re-consider in
> the future if it will be needed.

Would still like to understand this case.

