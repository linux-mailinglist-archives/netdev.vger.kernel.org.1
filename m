Return-Path: <netdev+bounces-32226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F472793A55
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B661C20A96
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D717E4;
	Wed,  6 Sep 2023 10:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69837E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:50:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA08173F
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693997404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAYCQnIx8VYUXPhMIqm5qe9D2E5DAw27dX5/PsRdyM=;
	b=g4a5FpDe56JoJbQYzfQJEk4/72cKzCpf7PstPFnyNIms/bvd+jwKjc9y+vuLCy68kG3CkC
	jW45FivKdRNNi57SFde/X9/oqNGws7fUR7rGSKu9FikfL1KW2DscZImi1qe9YvdZKN0Stv
	d3Z/9hyaXmkVY9IBsg1q82vBaleoILU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-8GQug0hTNJyTIsypK3uaJg-1; Wed, 06 Sep 2023 06:50:03 -0400
X-MC-Unique: 8GQug0hTNJyTIsypK3uaJg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b8405aace3so41358161fa.3
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 03:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997401; x=1694602201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZAYCQnIx8VYUXPhMIqm5qe9D2E5DAw27dX5/PsRdyM=;
        b=JSArAdxZx113e0Suih83kySPeOy4Qre1IwtnVbnt1tVyz84RIzSZEaRiHdUvfdeo4B
         OjD7jC8agxr0KDPDxOwg6EJRt8y/KIZRqCwBxZV01AmjuvxOjFlZ9rtrqXTzCvH7qiyz
         UyCPQ8OMKHaQtGcL7IzKUBWVU0i6S4pncrqRiMS3KxTMLHpnoP1rldAYN0zln+/Orb2m
         fPvd7M4pQGLq2FZBlWIz8++cZwdfNJZccPrac8XSET8KaBF0dXUWINuFT6hMUKjznYRe
         qODwb+xE/2dnGB01ulvzhrN/oCij/rfAHIJ9I/o3v+gP+TomTv/8Ury2GoPRH8EZKGNp
         uYUg==
X-Gm-Message-State: AOJu0YyDEDxCvuwcQHaxsxjJdVQ9hxoyA4A/LfMadLJpca2hmTp2jB+z
	Cl4IKhgHDgbEJ3OTNlA4bA0Ipj2kqakntpqKIteD5NfH2J0HLqrhpT4UuvP1Ty8ty+JxbU0akmr
	gd8YxR1m+el5i5xEM
X-Received: by 2002:a05:6512:282c:b0:500:c5df:1872 with SMTP id cf44-20020a056512282c00b00500c5df1872mr2262911lfb.44.1693997401702;
        Wed, 06 Sep 2023 03:50:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaujWEXFgE2OIDX6wjHeyNjoruf3vnOJmQJLyfAbPvMDR5QYWGRKZovQPyGwd1eVgm7tcDxw==
X-Received: by 2002:a05:6512:282c:b0:500:c5df:1872 with SMTP id cf44-20020a056512282c00b00500c5df1872mr2262885lfb.44.1693997401315;
        Wed, 06 Sep 2023 03:50:01 -0700 (PDT)
Received: from [192.168.1.227] (85-160-57-38.reb.o2.cz. [85.160.57.38])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm20022067wrn.48.2023.09.06.03.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:50:01 -0700 (PDT)
Message-ID: <72beaab3-1f88-4f46-a451-2af9da8caff4@redhat.com>
Date: Wed, 6 Sep 2023 12:49:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v9 01/15] ice: add parser
 create and destroy skeleton
To: Junfeng Guo <junfeng.guo@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: ivecera@redhat.com, netdev@vger.kernel.org, qi.z.zhang@intel.com,
 jesse.brandeburg@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
 <20230904021455.3944605-2-junfeng.guo@intel.com>
Content-Language: en-US
From: Michal Schmidt <mschmidt@redhat.com>
In-Reply-To: <20230904021455.3944605-2-junfeng.guo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne 04. 09. 23 v 4:14 Junfeng Guo napsal(a):
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> new file mode 100644
> index 000000000000..747dfad66db2
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Intel Corporation */
> +
> +#include "ice_common.h"
> +
> +/**
> + * ice_parser_create - create a parser instance
> + * @hw: pointer to the hardware structure
> + * @psr: output parameter for a new parser instance be created
> + */
> +int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
> +{
> +	struct ice_parser *p;
> +
> +	p = devm_kzalloc(ice_hw_to_dev(hw), sizeof(struct ice_parser),
> +			 GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	p->hw = hw;
> +
> +	*psr = p;
> +	return 0;
> +}

The function could just return the pointer directly. You can use ERR_PTR 
to encode all kinds of failures.

Michal


