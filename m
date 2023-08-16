Return-Path: <netdev+bounces-28093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DE77E352
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BD41C210F9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFD11CA9;
	Wed, 16 Aug 2023 14:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B4101F6
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:10:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7361C26B5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:10:45 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe8d816a40so9959875e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195044; x=1692799844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95HPwFgqaDXlLLkzpChDZIHs2R0I1EBhpERpAxW/ijY=;
        b=Bzs6vR4bjGrtc7XdFOdA/7EaC96qIG/XceQht2cplgj9WYiy6pPGx03vX6vzlHqBAk
         eTdyBUUhj/g0X6icOg59qjP15h9SsikgyV5oFhtybbVtiFh3eRsEyWlfK2GHGiF2KVy9
         dwPY/pLET7shH+T8jJiGNG77ldI4YcWIoQYJUqWmtjA/IsWiBS8t2U/w2kEJWfOETKbi
         gEWhvhwqYD/kICQlHYDvdBM+VigdQr7RK4dE79ZRbjjZra+hffj7QQzKex3wYGcSz5ZL
         CGFXgO2KOJ5j8mLhmGz9+gwwHhHFJxp3hC459EVg5T3fFDPqZ2UFln6NemH7V8iOMnRC
         MF3Q==
X-Gm-Message-State: AOJu0YzrgS7N0Hc1j09/t/YOmhUIJYlmFrLqVfU4u23QtAi7WDeGjUlu
	HsYSj8iJFYxqoye/TMu1pZk=
X-Google-Smtp-Source: AGHT+IFAdE+gPg7IcxZmulI51PLKclkD6DyWh+geDi49pMSfDRXQdy9EFgoumun16fMKn/34l3Q+WQ==
X-Received: by 2002:adf:f0c9:0:b0:316:ef5f:7d8f with SMTP id x9-20020adff0c9000000b00316ef5f7d8fmr1652244wro.3.1692195043533;
        Wed, 16 Aug 2023 07:10:43 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q10-20020adfcd8a000000b0031753073abcsm21417662wrj.36.2023.08.16.07.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:10:42 -0700 (PDT)
Message-ID: <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
Date: Wed, 16 Aug 2023 17:10:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
 <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
 <253pm3nuojy.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253pm3nuojy.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> +     switch (event) {
>>> +     case NETDEV_GOING_DOWN:
>>> +             mutex_lock(&nvme_tcp_ctrl_mutex);
>>> +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
>>> +                     if (ndev == ctrl->offloading_netdev)
>>> +                             nvme_tcp_error_recovery(&ctrl->ctrl);
>>> +             }
>>> +             mutex_unlock(&nvme_tcp_ctrl_mutex);
>>> +             flush_workqueue(nvme_reset_wq);
>>
>> In what context is this called? because every time we flush a workqueue,
>> lockdep finds another reason to complain about something...
> 
> Thanks for highlighting this, we re-checked it and we found that we are
> covered by nvme_tcp_error_recovery(), we can remove the
> flush_workqueue() call above.

Don't you need to flush at least err_work? How do you know that it
completed and put all the references?

