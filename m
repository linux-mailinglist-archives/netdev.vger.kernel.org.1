Return-Path: <netdev+bounces-34875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D97A5A71
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8711C20CC9
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D213588F;
	Tue, 19 Sep 2023 07:04:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066134CFE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:04:14 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89AF118
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:04:12 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9ada1842428so111514766b.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695107051; x=1695711851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/LuZHHSnEA+ZRQK6hZMwwxNsZx+UGYYWxDQS26Kk7A=;
        b=FTAxQ5P2sa7g91esbt8i99hEj26EcRFJ0XDgNzeKJYb+5jffByv/ELBx2abMKIXB32
         DdiVPD04xzLcKyKzIxW6T9oY5mTx3gdCRmvVbquQyGw79UHunEg358YhSLV6F19v+PB7
         tmr3mZ15vGCYXj0dq67B8PRih4DiSWP1sdqTZYgtV2e3+bz4jQ5sLLVIRmuln9vb82TB
         MlIS8GuAt5bHsicxNS/ADTl03CPfVC1KSHOiCzU4WQcKqcG3piC6NoRBdeE42qlvxL6W
         tdy3saS+fig76G5YGukYFILeGNJObo/THLu567etlrdQE76Nx1ZNYSORc8G2y+u7KAGh
         kCpA==
X-Gm-Message-State: AOJu0Yx3pJsi3wZPxE4UZ97kD6KppuHVVMIUXoSLE6jf/Ro0i2Qo85Yl
	rFNdaEc/LP/OIby3rp3YEC4=
X-Google-Smtp-Source: AGHT+IHWmj4W+Y9QZ2DqpEfiibOwPzes1Xi2G5DM9117uMzoXLq+26BklRQ62M9WKTUOYi7X5WHFeA==
X-Received: by 2002:a17:906:9e:b0:9a5:ce62:6e1a with SMTP id 30-20020a170906009e00b009a5ce626e1amr8790586ejc.1.1695107050998;
        Tue, 19 Sep 2023 00:04:10 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id jw24-20020a17090776b800b009a168ab6ee2sm7366103ejc.164.2023.09.19.00.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 00:04:10 -0700 (PDT)
Message-ID: <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
Date: Tue, 19 Sep 2023 10:04:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2537congwxt.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> @@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>        else
>>>                msg.msg_flags |= MSG_EOR;
>>>
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +             nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
>>
>> Didn't we agree that setup_ddp should move to setup time and
>> not send time?
> 
> We believe we haven't reached a conclusion last time [1].
> 
> Moving the setup_ddp() call earlier at setup time is less efficient (up
> to ~15% less IOPS) when it does the work on a different CPU.
> 
> 1: https://lore.kernel.org/all/253h6oxvlwd.fsf@nvidia.com/

Can you please explain why? sk_incoming_cpu is updated from the network
recv path while you are arguing that the timing matters before you even
send the pdu. I don't understand why should that matter.

