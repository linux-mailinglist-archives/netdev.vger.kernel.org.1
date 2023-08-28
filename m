Return-Path: <netdev+bounces-31041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5278B075
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51E4280E29
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968911CB4;
	Mon, 28 Aug 2023 12:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7C613F
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 12:34:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B7A8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693226056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeX3XhG+CN71DFNoHnKntS+TBHF+GD6RwGz31duwrG4=;
	b=R3I+H18UIi/sUcFlY03mjB8uj6Q2a1QiDDsgNfTdO/S5sSpYZsgBNcMasE9/tFRkeHksVQ
	JJD9N3LTg3Yj54ewuadvTU7uartO9QTrNjEmtUJvN3n6++tAOH21HKUagzxZGd/zLpCkjT
	dVbbVedcIojO//y/J++QoBRiM0d5Ksg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-sMqdEYlGMOCQzqt736z3Gw-1; Mon, 28 Aug 2023 08:34:15 -0400
X-MC-Unique: sMqdEYlGMOCQzqt736z3Gw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a57d664076so417945266b.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226054; x=1693830854;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeX3XhG+CN71DFNoHnKntS+TBHF+GD6RwGz31duwrG4=;
        b=CD1V984AjvS3Ta5OFCRtYnSxt71DFbn3zPgHWsR7VPvBYBXDLk9A60oH/fU239KFrH
         C8dbHx4UUnuOu4AKuMMlAg4fNXl7u/Y/D2reZ6yZm6AJKCdNiGCzTwWPRlrybmmNwKI3
         6jdnkSiJEMJwymzkb5qg41h7l8C4FPTQlV3Ehv+ZTT97oB27sLJZnsF3qGHGHXTPYsmk
         2EXC49oIcqsehD5dWXRDmFCdMH9ZBsoZgw6SIKqMuHnae0c+Acyv+TADiGkt7fPqFBhx
         WZT/Kr7m/8i90355yw34PU9sosddnRznMVAadGD35lOY8GAcVkel1ExKbwQSZikNuogn
         S43g==
X-Gm-Message-State: AOJu0YzKqItt++Nr2n1A7N6rXfPQvXE5k7+a8//WxPh/MeRhEm36N8Ne
	sifjFSmAqmcZ/zQDhTWLoK4mAhGldqM/bQ9UaN3SEXNWoAqd+yCe6x8tTsJ/6FqrPcNbC4eC26u
	kqGjlWpUv0FVnNOXd
X-Received: by 2002:a17:907:2c43:b0:9a5:ae8a:6e0b with SMTP id hf3-20020a1709072c4300b009a5ae8a6e0bmr3152412ejc.24.1693226054076;
        Mon, 28 Aug 2023 05:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvIYvE40qF94wju/vrECQS+a8jGSOWgEJ/XOnb9M9nBvCyed4CkVVv3ij0FcWley91Ct77oQ==
X-Received: by 2002:a17:907:2c43:b0:9a5:ae8a:6e0b with SMTP id hf3-20020a1709072c4300b009a5ae8a6e0bmr3152394ejc.24.1693226053833;
        Mon, 28 Aug 2023 05:34:13 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090682c500b0098f33157e7dsm4550663ejy.82.2023.08.28.05.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 05:34:13 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <d2c2d69e-7aad-0176-828b-dca051961e7b@redhat.com>
Date: Mon, 28 Aug 2023 14:34:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>,
 Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
 <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
 <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
 <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
 <d1f43386-b337-db94-7d9d-d078cd20c927@intel.com>
In-Reply-To: <d1f43386-b337-db94-7d9d-d078cd20c927@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 28/08/2023 13.07, Alexander Lobakin wrote:
>> This can be a workaround fix:
>>
>> $ git diff
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>> index dce3cea00032..ab7ca146fddf 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>> @@ -578,6 +578,10 @@ int otx2_alloc_buffer(struct otx2_nic *pfvf, struct
>> otx2_cq_queue *cq,
>>                  struct refill_work *work;
>>                  struct delayed_work *dwork;
>>
>> +               /* page_pool alloc API cannot be used from WQ */
>> +               if (cq->rbpool->page_pool)
>> +                       return -ENOMEM;
> I believe that breaks the driver?
> 

Why would that break the driver?

AFAIK returning 0 here will break the driver.
We need to return something non-zero, see otx2_refill_pool_ptrs() 
copy-pasted below signature.


>> +
>>                  work = &pfvf->refill_wrk[cq->cq_idx];
>>                  dwork = &work->pool_refill_work;
>>                  /* Schedule a task if no other task is running */


--Jesper

  void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
  {
	struct otx2_nic *pfvf = dev;
	dma_addr_t bufptr;

	while (cq->pool_ptrs) {
		if (otx2_alloc_buffer(pfvf, cq, &bufptr))
			break;
		otx2_aura_freeptr(pfvf, cq->cq_idx, bufptr + OTX2_HEAD_ROOM);
		cq->pool_ptrs--;
	}
  }


