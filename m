Return-Path: <netdev+bounces-25721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253977544C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CA41C21121
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16290613F;
	Wed,  9 Aug 2023 07:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A46124
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:39:49 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E51736
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:39:48 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f13c41c957so1678490e87.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566787; x=1692171587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcnCQ8xaUB5P+nnoqcvRQHtgfnUd197HfgGPw0/AMZ4=;
        b=i2AEo6+ATEDk5quyKq2SJ+D1G0smkEuUiDzLp0dgRdo6Y1bEKlo1DF3XXxqaPp3bX1
         rKdyhK1E2Zl3mmDplGY7bQ6Avj3ajH8LbJ6uGYXWcWFPazvR+SwTdfwEngqM5NXPMmDz
         zIkATU9/PjqeeyrYoo6ZAYAxX2LVarBxgxyMRsV30u4NtSBYzxny73b+ZAmUfHlD3nwQ
         aAPfOYv0NxV6qX8M36vZavs7llB2Ak/lr6Scto/iZ6S65gj7V6l1JRXwHXT8MVk2aDTE
         I5plpzHCfRFzUUd5dSNS/DW2/Dhvm+W1zv5pg1VRqkFr20jvESnQdKfiQj9G180VXtqZ
         e7Ww==
X-Gm-Message-State: AOJu0YxVMe0lTEpHEYt3umd3K7wytN/0Op0AuH44WpcR09j4r8i2C47v
	bukOlZ/qY03Mp0aajL0Qd7c=
X-Google-Smtp-Source: AGHT+IFJX0Xo0Kww2n3GLSYlhtOJuzJjcw2BH3VbUdL+l46JRVFYUsKV5vo8Mm3CIUvknuBnWyY1QQ==
X-Received: by 2002:a19:750c:0:b0:4fd:d0f7:5b90 with SMTP id y12-20020a19750c000000b004fdd0f75b90mr1092919lfe.4.1691566786641;
        Wed, 09 Aug 2023 00:39:46 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b005222b471dc4sm7504786edy.95.2023.08.09.00.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:39:45 -0700 (PDT)
Message-ID: <2ae6c96b-2b05-583e-55bd-2d20133b9b37@grimberg.me>
Date: Wed, 9 Aug 2023 10:39:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Aurelien Aptel <aaptel@nvidia.com>, Shai Malin <smalin@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Gal Shalom <galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 05:25, Chaitanya Kulkarni wrote:
> On 7/12/23 09:14, Aurelien Aptel wrote:
>> From: Boris Pismenny <borisp@nvidia.com>
>>
>> This commit introduces direct data placement offload to NVME
>> TCP. There is a context per queue, which is established after the
>> handshake using the sk_add/del NDOs.
>>
>> Additionally, a resynchronization routine is used to assist
>> hardware recovery from TCP OOO, and continue the offload.
>> Resynchronization operates as follows:
>>
>> 1. TCP OOO causes the NIC HW to stop the offload
>>
>> 2. NIC HW identifies a PDU header at some TCP sequence number,
>> and asks NVMe-TCP to confirm it.
>> This request is delivered from the NIC driver to NVMe-TCP by first
>> finding the socket for the packet that triggered the request, and
>> then finding the nvme_tcp_queue that is used by this routine.
>> Finally, the request is recorded in the nvme_tcp_queue.
>>
>> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
>> it with the PDU header TCP sequence, and report the result to the
>> NIC driver (resync), which will update the HW, and resume offload
>> when all is successful.
>>
>> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
>> for queue of size N) where the linux nvme driver uses part of the 16
>> bit CCID for generation counter. To address that, we use the existing
>> quirk in the nvme layer when the HW driver advertises if the device is
>> not supports the full 16 bit CCID range.
>>
>> Furthermore, we let the offloading driver advertise what is the max hw
>> sectors/segments via ulp_ddp_limits.
>>
>> A follow-up patch introduces the data-path changes required for this
>> offload.
>>
>> Socket operations need a netdev reference. This reference is
>> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
>> a follow-up patch.
>>
>> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
>> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
>> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
>> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
>> Signed-off-by: Shai Malin <smalin@nvidia.com>
>> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
> 
> For NVMe related code :-
> 
> Offload feature is configurable and maybe not be turned on in the absence
> of the H/W. In order to keep the nvme/host/tcp.c file small to only handle
> core related functionality, I wonder if we should to move tcp-offload code
> into it's own file say nvme/host/tcp-offload.c ?

Maybe. it wouldn't be tcp_offload.c but rather tcp_ddp.c because its not
offloading the tcp stack but rather doing direct data placement.

If we are going to do that it will pollute nvme.h or add a common
header file, which is something I'd like to avoid if possible.

