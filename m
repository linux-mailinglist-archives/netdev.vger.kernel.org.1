Return-Path: <netdev+bounces-26908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06837794BC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B86228256D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F3EAF9;
	Fri, 11 Aug 2023 16:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300E11736
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:35:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469E114
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691771747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6T+k2vILp+TSABHtOQFiE+73oE9QuOce9GGiJceLBY=;
	b=GupH6jrjg6pdvCYXefGgd255AjuKdn48r/G+/uB/LlvBN3rBWEtDNozAFuqTmEMFiNef0Y
	Mqqe/zoinMfNNn148sfpceW9d8eAXO6PCwGwzTvcnPXj67zU57PM4eB/u+uAXekbivLchN
	foiv/4oKS4vIwLdiATr37bkV0eH3mwQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-3hXAdqYTOMCnpabcRREd6A-1; Fri, 11 Aug 2023 12:35:46 -0400
X-MC-Unique: 3hXAdqYTOMCnpabcRREd6A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-523400c3638so1515473a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771745; x=1692376545;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6T+k2vILp+TSABHtOQFiE+73oE9QuOce9GGiJceLBY=;
        b=GcS/O7/txeFA3v4y942AkndwTXbXo02QWnWio2Lgk49UUsrszKA8JSTRuMKwo+v04a
         1dnZGIpr21jOncBHCOSo2s56hqYouTpeQECYNgvGVqKH80kG5DQXrwzls6LTpylm1fj+
         hXSLLq+wEYGUWO8W2enrepi0nsJ0eHJLu5ditsZCRa+tZtOraBER1plz8akjVWXKvRO/
         o9e3i9AGLgTrGTo7uAiCufxuTgoi4ql7uyBfGldR3qCruTcWg486pd4YxzzfQN7iIJHm
         fQZ7uDVcZ6uRZ4F/hhbbchnJrlne9FlTuFudc2TXbX8fFIwAE0nvmLLaI6gi4azf60Gn
         x0iA==
X-Gm-Message-State: AOJu0YwbsnckhqRSY1nCcRz2bGxAdAjL/B9cZO7ftwgOBaUDiP7axetu
	9q1K8oQK59vxhFqKSOz7MjZgTMSdrED6alCwPQDA/cGwKxYUi+SSTuAhper8bh3WKEZr2Y9qout
	1Z3hQ7BhVRjQLmLvr
X-Received: by 2002:a05:6402:1659:b0:522:5957:44e0 with SMTP id s25-20020a056402165900b00522595744e0mr2156504edx.28.1691771745274;
        Fri, 11 Aug 2023 09:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkd4F310oNENrB/sIQgG9+lw9MXhd0sQlC2Qlg7ceDzsp1xUIZTesJPcgn3UvHyjYvCcmnOA==
X-Received: by 2002:a05:6402:1659:b0:522:5957:44e0 with SMTP id s25-20020a056402165900b00522595744e0mr2156491edx.28.1691771744957;
        Fri, 11 Aug 2023 09:35:44 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d98e000000b005231e3d89efsm2264075eds.31.2023.08.11.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:35:44 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b52b4aa0-ebae-f9a5-f3da-b0c9cc4ba75b@redhat.com>
Date: Fri, 11 Aug 2023 18:35:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linyunsheng@huawei.com,
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, ast@kernel.org,
 netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error
 handling for existing pools only
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <f586f586-5a24-4a01-7ac6-6e75b8738b49@kernel.org>
 <CAKhg4tJs-6HGOtyHP7KWpPjAAQy6BkbRf5LQvDzCwmLAkJXOwQ@mail.gmail.com>
In-Reply-To: <CAKhg4tJs-6HGOtyHP7KWpPjAAQy6BkbRf5LQvDzCwmLAkJXOwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 11/08/2023 14.02, Liang Chen wrote:
> On Wed, Aug 2, 2023 at 4:56 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
[...]
>>>                page_pool_destroy(priv->rq[i].page_pool);
>>>                priv->rq[i].page_pool = NULL;
>>>        }
>>
>> The page_pool_destroy() call handles(exits) if called with NULL.
>> So, I don't think this incorrect walking all (start to end) can trigger
>> an actual bug.
>>
>> Anyhow, I do think this is more correct, so you can append my ACK for
>> the real submission.
>>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>
> 
> Thanks! I will separate this patch out and make a real submission,
> since it's a small fix and not really coupled with the optimization
> patch which still needs some further work after receiving feedback
> from Yunsheng.

Sure, send it as a fix commit.  Given it is not super critical i think
it is okay to send for net-next, to avoid merge issues/conflicts with
your 2/2 optimization patch.  And for good order we should add a Fixes
tag, but IMHO net-next is still okay, given I don't think this can
trigger a bug.

That said, I do want to encourage you to work on 2/2 optimization patch.
I think this is a very important optimization and actually a fix for
then we introduced page_pool to veth. Well spotted! :-)

In 2/2 I keep getting confused by use of kfree_skb_partial() and if the
right conditions are meet.

--Jesper


