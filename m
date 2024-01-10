Return-Path: <netdev+bounces-62925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A779A829E30
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B72FB228D5
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5A4C61B;
	Wed, 10 Jan 2024 16:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FE4CB20
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33751fdc2a5so499263f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 08:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902722; x=1705507522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gV/25XO458e+IXbfHFTvvAGwBUh/NnuEXl/XrprNRsQ=;
        b=haTGc7AlFA9Wb1h0E3EzotmLAf7FGETMTXEWqtECDRZQHjKNC91jCW4SqV8QxbeZXA
         5TM5yIYKcHZpaYik0jQDIqicMJYaOlEuORZnhhIR2lx86PQYBTBHOT7BX1RrmvHJfPFN
         kgkdoXvE9w4b3kA8hpk+p/T5izLK5IXAbk3gqzov8tPE1otaa7CVpN51+aI8S1g0Usue
         yOxj0CihwfsV5Vm+DLi9CN/ws3W6wPYqPyk7ErWoUWI/I4ARtVF8KM0WqrweG9QARW0R
         xEQPN8Jf71sVtp0niU4TNQiWthYNG1Th25aa8qL0I/JkdcN+buAOYllCPSE86WM4SQrH
         FnFw==
X-Gm-Message-State: AOJu0Yx3QX11/gPrPaFTS6IrzxqZJoEzthmqtM0e7249JkpBL227m4AJ
	hHEf4dDNJIDQD1NnwvUAP1I=
X-Google-Smtp-Source: AGHT+IE8XRt6tUPcRi8yaZUBxN/MB+i9dYc7A8Cej77C7yLjysTbMzZtyNXkFvjOjbPP3isI6BPJxw==
X-Received: by 2002:adf:e990:0:b0:336:7f36:5225 with SMTP id h16-20020adfe990000000b003367f365225mr1632659wrm.4.1704902721954;
        Wed, 10 Jan 2024 08:05:21 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v5-20020adff685000000b003366cf8bda4sm5224003wrp.41.2024.01.10.08.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:05:21 -0800 (PST)
Message-ID: <7ff7046d-ce4d-44d0-86f5-8ed7cb0229a3@grimberg.me>
Date: Wed, 10 Jan 2024 18:05:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-7-aaptel@nvidia.com> <253zfxehmum.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253zfxehmum.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 11:34, Aurelien Aptel wrote:
> Hi Sagi and all,
> 
> Do you have any other comments on the patches (nvme & netdev layer) we
> can address while the netdev mailing list is closed?

I don't have anything major I think. I'll review the nvme-tcp
part again.

