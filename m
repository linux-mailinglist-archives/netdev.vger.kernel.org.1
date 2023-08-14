Return-Path: <netdev+bounces-27445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A766877C046
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61223280DDD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189BFCA62;
	Mon, 14 Aug 2023 19:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4ECA49
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:01:31 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA101722
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:01:20 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe0a3377bfso1985760e87.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039679; x=1692644479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ77JWlcF/3CKlrUcH+wSXPOTkNjnUsQD1YZzzBs6TY=;
        b=KLJsy8ja9P9ko1XGdWWzP+7u+6gWoCgRe/n7GbC6wjbmE6eXKhuv4u8TQXw4hoNnsh
         Mm2pTxBFOVECGswckG0wzjW+v9QNN5FH39tloG+TW73Z1MJkqLrLhSdy2+A1IJxZdrb9
         EymhA3AMghYxU8kEp3pcxdMpMlzkdHq86I+ifln6/TdBJ8LfJetqdzoueQqA+jUGLvFv
         Q5QCNU9BDDszKrChBiPS1FmoOsVU6yT8BjLsJ6n3UQotoZ9VEs6H0e6aHWaPhZSt3B9X
         sh3zua0Y1PRvCla1qFtZ00jjPLPeAoZYsHdoXYvCYCv4fk4ZCwjs/iBT+NLwV61fVMSp
         qIZw==
X-Gm-Message-State: AOJu0Yw8pzQrcwvV8663huexlbMmGJiAtOnUxURaJIhALT7FkprduSHC
	2UDBcL39GOeIWzFdPxVgAXg=
X-Google-Smtp-Source: AGHT+IFmLrTLGuDhCCL9vHJGXv/EwdcTHk0uU9kaQdWWrlrg1XR/E2162sm0MRiorOfiuwiNj22ICA==
X-Received: by 2002:ac2:519a:0:b0:4fd:cab4:7d15 with SMTP id u26-20020ac2519a000000b004fdcab47d15mr4727508lfi.2.1692039678801;
        Mon, 14 Aug 2023 12:01:18 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b0099d0a8ccb5fsm5990701ejb.152.2023.08.14.12.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:01:17 -0700 (PDT)
Message-ID: <1a28b970-1954-a482-5906-c6ee96b248f0@grimberg.me>
Date: Mon, 14 Aug 2023 22:01:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 08/26] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-9-aaptel@nvidia.com>
 <1d5adbe9-dcab-5eae-fff3-631b91c2da94@grimberg.me>
 <2535y5hwqkg.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2535y5hwqkg.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> @@ -1308,6 +1407,15 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>        else
>>>                msg.msg_flags |= MSG_EOR;
>>>
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
>>> +             ret = nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id,
>>> +                                      blk_mq_rq_from_pdu(req));
>>> +             WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
>>> +                       nvme_tcp_queue_id(queue),
>>> +                       pdu->cmd.common.command_id,
>>> +                       ret);
>>> +     }
>>
>> Any reason why this is done here when sending the command pdu and not
>> in setup time?
> 
> We wish to interact with the HW from the same CPU per queue, hence we
> are calling setup_ddp() after queue->io_cpu == raw_smp_processor_id()
> was checked in nvme_tcp_queue_request().

That is very fragile. You cannot depend on this micro-optimization being
in the code. Is this related to a hidden steering rule you are adding
to the hw?

Which reminds me, in the control patch, you are passing io_cpu, this is
also a dependency that should be avoided, you should use the same 
mechanism as arfs to learn where the socket is being reaped.

