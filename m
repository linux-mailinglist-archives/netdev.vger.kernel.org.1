Return-Path: <netdev+bounces-33511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F171079E549
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABE828202D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B0E179B0;
	Wed, 13 Sep 2023 10:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F4210D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:51:21 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C15CA
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:51:20 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1353245a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602279; x=1695207079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT3l7i+aaLrI/+eQTFzmHILyA3PGI+5lHDaISXZ0F9A=;
        b=Fp5XQd+QwewrZws32r5KT+RETcMLObnCxe6YYDzT3Jtfeh1I7/ME1+y2g/qblQ4c88
         q6vYRbUApPG4XqMzAimTwfPEBiFdJk7szTFTILyNqDi00T4Xeu9u2l76TAghS1lipcqg
         swqvJckDofbm8Gpfngfcp9M3+PyuDzTshPycTOMpebwERfycqpyrTQsOAci8x6GzhN/X
         lIAOVIFKD+rUP/06ryzH/YkQqU8npm8A8xT8mElGJYLSPEE/U3tPlhakITR8Jx3DFaRe
         WG6eiA3JvObDRnFJM5Wsl0ccQOqUvZ7u6yYWibBYif4LbMm6j3N2tkK2iw3bOiwkJ8q9
         uULg==
X-Gm-Message-State: AOJu0YzirYVDbOgV1NPFBnD5xahdTKIEJrRLyD8VeT/4aKznCGa04Ok4
	P0k/JCnGtLjkacNdDtClK6Q=
X-Google-Smtp-Source: AGHT+IEAyrfqpWpyxAVoS13uAEsG0q/J7bO9QB2vL2sYr9c13QouX2BwWVUN1EXe3xxjxm+RtTyWxA==
X-Received: by 2002:a05:6402:3493:b0:523:220e:a6ca with SMTP id v19-20020a056402349300b00523220ea6camr1797766edc.3.1694602278902;
        Wed, 13 Sep 2023 03:51:18 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bc3-20020a056402204300b0052348d74865sm6964078edb.61.2023.09.13.03.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:51:18 -0700 (PDT)
Message-ID: <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
Date: Wed, 13 Sep 2023 13:51:15 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912095949.5474-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> @@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		msg.msg_flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));

Didn't we agree that setup_ddp should move to setup time and
not send time?

