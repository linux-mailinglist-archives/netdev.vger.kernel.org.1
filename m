Return-Path: <netdev+bounces-33510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68079E533
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA61F1C20FD8
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB4179BF;
	Wed, 13 Sep 2023 10:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6E17755
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:49:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D5CA
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:49:06 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-401ef656465so19968235e9.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602144; x=1695206944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Esn3bDVPqFAsAFDnhhKPSrWoO2OiXMkjdGA2/ZknMxY=;
        b=Kk2JsTI6YZDs6DZ6bHz3ZZgbTg53sjkgHrvIUfwYYA7lHDWJSup5l3855s/VC1st5z
         Uio4I5voyk4MXMPGU3STaxevSI0qqyOhVJpWS1tCTTfhSt0gaPJrWF63e8Vvu+Gj9p+a
         T6ugo7N2/zeYgjwzMGjLDAxudkzJkuwpdv5DB3rRVJlwDyUx8e/RINas2ecqNfsDiMvi
         I6bL0o+6E6GpP1YMbHS5gh/ReCYxOr600rxaf8EC5DjLvYJp5CzoEmnttMI4F0BBpS93
         +39Nxlmbx3rJUiXiDSDFqeXO48Lohznf8xg8/1kOGhVWOlt9v5WCIeLegckfRs7CSbyE
         uqTg==
X-Gm-Message-State: AOJu0Yy5LmEAuJBpBsD1UcqKSH8GzSx3KGKRFpTp9lD26uzCnMJawR3b
	Q1d24itycGdKRdp+OyAPurk=
X-Google-Smtp-Source: AGHT+IG4m9pCndyGDLU5E9jXsiega50BJYoH3R+yUG8SLcQxS5ITG4ubdS76CNbUddekEUl07q0Fbg==
X-Received: by 2002:a05:600c:1da2:b0:401:7d3b:cc84 with SMTP id p34-20020a05600c1da200b004017d3bcc84mr1805926wms.0.1694602144226;
        Wed, 13 Sep 2023 03:49:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003fee53feab5sm1694093wmi.10.2023.09.13.03.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:49:03 -0700 (PDT)
Message-ID: <d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me>
Date: Wed, 13 Sep 2023 13:49:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912095949.5474-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	int ret;
> +
> +	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
> +	config.nvmeotcp.cpda = 0;
> +	config.nvmeotcp.dgst =
> +		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.dgst |=
> +		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
> +	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
> +	config.nvmeotcp.io_cpu = queue->sock->sk->sk_incoming_cpu;

Please hide io_cpu inside the interface. There is no reason for
the ulp to assign this. btw, is sk_incoming_cpu stable at this
point?

