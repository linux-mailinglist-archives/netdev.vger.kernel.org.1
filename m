Return-Path: <netdev+bounces-29156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F6781D7F
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 12:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D957D1C208A3
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E0539F;
	Sun, 20 Aug 2023 10:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692017F8
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 10:52:52 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B74C37
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 03:50:52 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99dff8b95b9so60423266b.0
        for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 03:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692528651; x=1693133451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzS6FOY5DluVyxJ0R/l4YI6y1Nc/Zcc8HgLIVuxHk50=;
        b=PTavgg5C+V0D/Zkv4Ov22L3ODeXPcRwW1BMApe4nJvBE3t/+l7bizz0si/1v7c5Ogw
         mRabZ+KL7j+Hd+/LZnyYSlIsRnwT4vrjKEYs23DRFvIRoHjRG6xTEKTaef3f+cIioAOf
         AW368BHZGAL9ZN6EvTzsWLtVWiwFVC7GF3nJb0vvXV5z8P6hgxxEONTS/bTNjsQesDIr
         o9BslB2tuR1Q3ZsL33X5jjlxigNKURj1TGEYKnzFG+f5M5B7IvhdXZAsuVQx8Jn7IVSM
         RzMwP9jAkSs575x0LjTweBNYaVGlCRgmv1RnrrSyCnpGRDXgPW3fJySZSwc2e+BXfiNB
         gsVg==
X-Gm-Message-State: AOJu0Yzy/3ZavTET47hnfXGxJ7Lf68a4UtNneLpAVL2h1CmzYRWAAcwi
	dR49xCNdET+fhXreRv7eSbE=
X-Google-Smtp-Source: AGHT+IGw3UA/xFtqp40aBGeG//jAZQEVe97PIsavTwgbZi2r1SQHPVDIDp3n8XwqvtSDU4F2kt/UKw==
X-Received: by 2002:a17:906:535d:b0:99c:d995:22e6 with SMTP id j29-20020a170906535d00b0099cd99522e6mr3037131ejo.3.1692528651192;
        Sun, 20 Aug 2023 03:50:51 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709062ecf00b0099cd008c1a4sm4398763eji.136.2023.08.20.03.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 03:50:50 -0700 (PDT)
Message-ID: <f92abcda-695a-b427-f342-a3540a45be1a@grimberg.me>
Date: Sun, 20 Aug 2023 13:50:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
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
 <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
 <253bkf5vjyu.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253bkf5vjyu.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>>>> +     switch (event) {
>>>>> +     case NETDEV_GOING_DOWN:
>>>>> +             mutex_lock(&nvme_tcp_ctrl_mutex);
>>>>> +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
>>>>> +                     if (ndev == ctrl->offloading_netdev)
>>>>> +                             nvme_tcp_error_recovery(&ctrl->ctrl);
>>>>> +             }
>>>>> +             mutex_unlock(&nvme_tcp_ctrl_mutex);
>>>>> +             flush_workqueue(nvme_reset_wq);
>>>>
>>>> In what context is this called? because every time we flush a workqueue,
>>>> lockdep finds another reason to complain about something...
>>>
>>> Thanks for highlighting this, we re-checked it and we found that we are
>>> covered by nvme_tcp_error_recovery(), we can remove the
>>> flush_workqueue() call above.
>>
>> Don't you need to flush at least err_work? How do you know that it
>> completed and put all the references?
> 
> Our bad, we do need to wait for the netdev reference to be put, and we
> must keep the flush_workqueue().
> 
> We did test with lockdep but did not notice any warnings.

I'm assuming you are running with lockdep and friends?

> 
> As for the context of the event handler when you set the link down is
> the process issuing the netlink syscall.
> 
> So if you run "ip link set X down" it would be (simplified):
> 
> "ip" -> syscall -> netlink api -> ... -> do_setlink -> call_netdevice_notifiers_info.

ok, that should be fine I think.

