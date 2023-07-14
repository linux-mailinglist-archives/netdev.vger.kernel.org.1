Return-Path: <netdev+bounces-17952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C5753BF7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D7C282128
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85052D520;
	Fri, 14 Jul 2023 13:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677113724
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:44:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1A358E
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689342276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAomTBbogGjThZFN5TWIgkvChHNK0qU90/lhwutfJTU=;
	b=Y78Nk7FaSZE9BtASVGfAc5FHlJNvbs1ZskZe2C0/3eXGnLet6BmkOdtKWfSzK6hyNJG52V
	3oG6RoQYGd0vognTyxXC3H+AZ1+QTsmGdu9zrDvJcMxcM7Fca0JrmpEqbc2E+NRlp4nq8B
	OTgB9FxDqto2oq0K/llY9fcyaZEF4Vk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-BSctxNOXNLORdSFNzxgVXg-1; Fri, 14 Jul 2023 09:44:35 -0400
X-MC-Unique: BSctxNOXNLORdSFNzxgVXg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993c24f3246so229334266b.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342274; x=1691934274;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAomTBbogGjThZFN5TWIgkvChHNK0qU90/lhwutfJTU=;
        b=PLOzLbh082K57kLUAH6FEwFVcf621nKbwNK8kyjG5+9O0AfVD15Ao0uQJkhUscrCSB
         GZvTegDYO/EsfFUhW0PEkyHrVZsK0xcQMqiM8cNZ+OThThbnmft1irKoQbHzJjYNi6md
         GoZgv+WSXrWkp+ayj5542wiVSCj385o9n6AP6y6URRbgVfMc2IM5pvZ2UDnrk9HyY+Zo
         vdcyKvfAkFBy511YNdNwblOt+KRa4B8kPMe/55c/DQKbV+HqQSwGjh0GbuReBtiiNzTF
         fFbpFiDJmGrgFQxaQLTI8FlNvqSrNJdRw3Mc+/MYuxYLWizb6fUlLoPX9FoRDBzq0Wes
         HLtw==
X-Gm-Message-State: ABy/qLYIxw9PIKd95jRa0BDxiOvRiU0dvVg3I4JFkPT2ix5l5npXKW1i
	AKXHrwPxnglTh6nG6IOjNb94w2avNYZ5vXLo/94vSzsQxbc1lnv/o9kyfNPU4mlQMVLDhcaZDpg
	SVAPBRo9tBlq3S1fY
X-Received: by 2002:a17:907:1c21:b0:993:f664:ce25 with SMTP id nc33-20020a1709071c2100b00993f664ce25mr3298762ejc.19.1689342274070;
        Fri, 14 Jul 2023 06:44:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFC27aKyBCXDolJGd6c0/6zg8McfiWC7uOuZPAJsKU8BLBmGbGccw+CItaYySADg4w6PyZlOg==
X-Received: by 2002:a17:907:1c21:b0:993:f664:ce25 with SMTP id nc33-20020a1709071c2100b00993f664ce25mr3298744ejc.19.1689342273762;
        Fri, 14 Jul 2023 06:44:33 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906395700b00992a9bd70dasm5513143eje.10.2023.07.14.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:44:33 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6e0ca9e8-1238-0581-2742-acdc88b252ae@redhat.com>
Date: Fri, 14 Jul 2023 15:44:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Liang Chen <liangchen.linux@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
 <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
 <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
 <20230712102603.5038980e@kernel.org>
 <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
In-Reply-To: <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 14/07/2023 14.16, Yunsheng Lin wrote:
>> I know that Olek has a plan to remove the skbuff dependency completely
>> but functionally / for any future dependencies - this should work?
 >
> I am not experienced and confident enough to say about this for now.
> 

A trick Eric once shared with me is this make command:

  make net/core/page_pool.i

It will generate a file "net/core/page_pool.i" that kind of shows how
the includes gets processed, I believe it is the C preprocess output.

--Jesper


