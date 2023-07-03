Return-Path: <netdev+bounces-15133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871BB745D9C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4249D280DB2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392CF9D9;
	Mon,  3 Jul 2023 13:42:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76815EAD0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 13:42:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0E2FF
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:42:06 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fa86011753so9445315e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 06:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391725; x=1690983725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSJ7njo1frNB2wbznmgMSd/7sKrygugYA+ScAa+ssjk=;
        b=D3fzjOFuc8vk5LT015BpMGO8MAPAt2F/Ief+u7JOFc8ttVcdAYayB78nwq4MuCK8UO
         9IK+o96Ru1gKTG4b9t8OTPndse11rqNsewXmUHpTHLoOzb1rd6vxpQthfng+wCh3npBt
         xbmOWJxmNHBwivXfL/OB+ab2cXkL6PBUJe6iPa7efn3XshWENGHndfdEZ+LBASRShwa+
         OqgJNuFEkABzKXrIouWGqiwbS+DAia9LddpCy2rtaUwAe3nOnLVE1CaBLdLA13dvVu12
         sPSxx3caa/T5/vVOrbQD0NR0m08eM8v+9zHCa4aoac9zkHHT72hum4QdGcOzh9FJGJjd
         uwXg==
X-Gm-Message-State: ABy/qLbsGg8uXndoDkYO9KLf0eiukzlLJw3LbWJoBgasnITK8jxCzk/I
	haB9tAKf9Oo/XgfcSLdwEmBmt+vkDnM=
X-Google-Smtp-Source: APBJJlEmmmyuCovPziLK3HGeeAZFgTUR1+KeDjKK+DIWyKksv8HpLzKMWjOoJPla9nYz1yDcHNlMXw==
X-Received: by 2002:adf:f504:0:b0:313:e20c:b8e1 with SMTP id q4-20020adff504000000b00313e20cb8e1mr9320754wro.7.1688391724867;
        Mon, 03 Jul 2023 06:42:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b0031424950a99sm8432273wrp.81.2023.07.03.06.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:42:04 -0700 (PDT)
Message-ID: <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
Date: Mon, 3 Jul 2023 16:42:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> Hannes Reinecke <hare@suse.de> wrote:
>>>
>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>
>>> Can you be more specific about the crash?
>>
>> Hannes,
>>
>> See:
>> [PATCH net] nvme-tcp: Fix comma-related oops
> 
> Ah, right. That solves _that_ issue.
> 
> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to your 
> suggestion). Investigating.

Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
does not interpret this as a transient status and simply returns from
io_work?

> But it brought up yet another can of worms: what _exactly_ is the return 
> value of ->read_sock()?
> 
> There are currently two conflicting use-cases:
> -> Ignore the return value, and assume errors etc are signalled
>     via 'desc.error'.
>     net/strparser/strparser.c
>     drivers/infiniband/sw/siw
>     drivers/scsi/iscsi_tcp.c
> -> use the return value of ->read_sock(), ignoring 'desc.error':
>     drivers/nvme/host/tcp.c
>     net/ipv4/tcp.c
> So which one is it?
> Needless to say, implementations following the second style do not
> set 'desc.error', causing any errors there to be ignored for callers
> from the first style...

I don't think ignoring the return value of read_sock makes sense because
it can fail outside of the recv_actor failures.

But to be on the safe side, perhaps you can both return an error and set
desc.error?

> Jakub?
> 
> Cheers,
> 
> Hannes
> 
> 

