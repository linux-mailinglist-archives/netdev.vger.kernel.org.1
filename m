Return-Path: <netdev+bounces-32227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07EB793A58
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA871C20A93
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5A566D;
	Wed,  6 Sep 2023 10:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1C7E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:50:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3710C8
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693997411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVfJZ1KNOctMNmCT4yWOhTYMFTvh1ErzEkSv6o/Mdyw=;
	b=JeqOaWikK9pOT7S7C8eviOxykcahtv3EnByaF3Yg85lWqov0Qsw7iRqnw6Q3842pxRyBBX
	e5jI1cNIvGzbBOyx7NTg1EW3UJh7yIErzDuADWY0o6KVBWljSS7yK8sgm2WfGfz7LrP7a9
	tmrQRTSt9k6mM/HV7UT/CqPdTmlfg7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-RuTn8D4jP3Su6DSn59mDWQ-1; Wed, 06 Sep 2023 06:50:09 -0400
X-MC-Unique: RuTn8D4jP3Su6DSn59mDWQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402d1892cecso3847675e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 03:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997408; x=1694602208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVfJZ1KNOctMNmCT4yWOhTYMFTvh1ErzEkSv6o/Mdyw=;
        b=UycDnQbjoO9+U9LH4bKXsWGxUlos9hf9uI1XKLNvO5HCN0adONs0NYYHexF9Hv8tUH
         2v7JFe6TOHGv/hxsEseNg3oDwfkmFpC4adUMGybqFFnHD/p9i6x+nwW9FQbGS+u9rEkB
         oL2jKC15I5sj3OV07rhvTh2zBZTDUZjd20R63cx/rr75CIR3pGO9nJkXOcIKlfZd6ROb
         DoNIrL0lVyZXEuTTcv/GMJHfhzket/5zwzghC4791gR7u9IjGk/1YLxDPbYDPlGI/4Q5
         frlXEYsu5rdxqHtuhv1rC2+FZtJDeCXH8U7UhUdJw3OIpambZ8oTpoR7fDp2wn1RCucA
         LR1Q==
X-Gm-Message-State: AOJu0Ywl/6IEqUPnsdrLUum5c3+vHcaRMOr4KUtln3WXmS6ZEDqxHiif
	q9znAMQpqnekQ+CiH6eilfZ2ldh5S+ZTpeZUJSKQvFMxmDnALKZIRp04DWkNcZtCz/gAPfwcjub
	lBwtL3JCI8mwI9Kyl
X-Received: by 2002:a05:600c:2283:b0:400:cc2d:5e02 with SMTP id 3-20020a05600c228300b00400cc2d5e02mr2239721wmf.17.1693997408495;
        Wed, 06 Sep 2023 03:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7+IIUgjcHQguYQhWTUWOCXmevt2F1a5khKhPdN7WPbANS/uZ47N35PoinLuW3PZE/QYTgzg==
X-Received: by 2002:a05:600c:2283:b0:400:cc2d:5e02 with SMTP id 3-20020a05600c228300b00400cc2d5e02mr2239706wmf.17.1693997408172;
        Wed, 06 Sep 2023 03:50:08 -0700 (PDT)
Received: from [192.168.1.227] (85-160-57-38.reb.o2.cz. [85.160.57.38])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm20022067wrn.48.2023.09.06.03.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:50:07 -0700 (PDT)
Message-ID: <7a1e8afa-5b01-4081-9961-18c6e4b00be4@redhat.com>
Date: Wed, 6 Sep 2023 12:50:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v9 02/15] ice: init imem table
 for parser
Content-Language: en-US
To: Junfeng Guo <junfeng.guo@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: ivecera@redhat.com, netdev@vger.kernel.org, qi.z.zhang@intel.com,
 jesse.brandeburg@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
 <20230904021455.3944605-3-junfeng.guo@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
In-Reply-To: <20230904021455.3944605-3-junfeng.guo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne 04. 09. 23 v 4:14 Junfeng Guo napsal(a):
> diff --git a/drivers/net/ethernet/intel/ice/ice_imem.c b/drivers/net/ethernet/intel/ice/ice_imem.c
> new file mode 100644
> index 000000000000..005e04947626
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_imem.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Intel Corporation */
> +
> +#include "ice_common.h"
> +#include "ice_parser_util.h"
> +
> +static void _ice_imem_bst_bm_dump(struct ice_hw *hw, struct ice_bst_main *bm)

You have a lot of functions whose names start with an underscore. It's 
unusual. If it's to indicate that they're only to be used from the 
current source file, it's already implied by them being defined as static.

[...]
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index 747dfad66db2..dd089c859616 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
[...]
> +/**
> + * ice_parser_create_table - create a item table from a section
> + * @hw: pointer to the hardware structure
> + * @sect_type: section type
> + * @item_size: item size in byte
> + * @length: number of items in the table to create
> + * @item_get: the function will be parsed to ice_pkg_enum_entry
> + * @parse_item: the function to parse the item
> + */
> +void *ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
> +			      u32 item_size, u32 length,
> +			      void *(*item_get)(u32 sect_type, void *section,
> +						u32 index, u32 *offset),
> +			      void (*parse_item)(struct ice_hw *hw, u16 idx,
> +						 void *item, void *data,
> +						 int size))
> +{
> +	struct ice_seg *seg = hw->seg;
> +	struct ice_pkg_enum state;
> +	u16 idx = U16_MAX;
> +	void *table;
> +	void *data;
> +
> +	if (!seg)
> +		return NULL;
> +
> +	table = devm_kzalloc(ice_hw_to_dev(hw), item_size * length,
> +			     GFP_KERNEL);

Use devm_kcalloc.


Michal


