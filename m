Return-Path: <netdev+bounces-102212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BD9901EF1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A194E1F27E0B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E3762D0;
	Mon, 10 Jun 2024 10:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219475817
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014066; cv=none; b=qT+AeXJ5NusaTjeuxoQs2VPsHbvICQOieKJLaRfOIcQL8zjTB6SsSfqT7lIeRc5fL7Q9DFb3gGh0xXey6gnX01eDUdDTwol99wpmcMSu6C9Py4GIb3zJSai4rs7FZpPWj+lZeyTkKEAcLqry2B6RzADlgwbbaiAIplBZGvuYqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014066; c=relaxed/simple;
	bh=gusV37GeNeY+oeCFRFa4YfsAprY6hsRabaSJi44TvCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2w1aIahWnazZWM+nTnH8r0HjdxoU29uI6Ny4Gi77Mb9qlykq+lHNbQOPQw4bAzJGEAoW6bxwoY30M8Hr847O3NYLMJuejorpAr+2BTnXFdQGjYYRa/tX0vvuBkiRmytI/LLTit9aeyIqHDH8I0Hzq/IaXMnS/1M2LDpIJtWvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42179a2c755so2166895e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 03:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014063; x=1718618863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gusV37GeNeY+oeCFRFa4YfsAprY6hsRabaSJi44TvCw=;
        b=nM1HKYiR+Wd8beEMsuDpRtZMV12cV8kbpae6EtKUjZrVoD0hUOoyAvDa3jSmBYtSpN
         +sQs1TbPCRzY+lKhIx3m+KeX0LKm7xT6loCjn88aV6P9Qo4bRD8rLTTvHQfryIdfQRPp
         GOVTbfGt1/PkWhKDwbH9hF4PjYi36EI2sEBcg8vz1ZePgCCKgTCfTkEJRgMtSZj0thMa
         1/SQdlvfIkgzUBGT24pY/2Jf1Wl+oVBJM+J6k9T84cHTPDJHFRIAImu9Rt7zUsjaWY84
         NQClcnb5MEZ+WHYhQnTy29LZRxfaaodqFxSvcs2mOzgYJy6SIfTHKLD6mQsLoUU4iyd3
         ojZg==
X-Forwarded-Encrypted: i=1; AJvYcCW5I99M37Zc0mymSyVfu7VsohCsoXHL7Ly8e4cNRk4M7kjTmC5EbyW0zD0LzJVBvkXiGXZ2IA0Zg0mIo2nxTTJCG9JmLajR
X-Gm-Message-State: AOJu0YwhORvJn9whtARP/9vW6F2fi9WVUXFGopXlqhOb3ecCyHxBRT/6
	NsFjgGbysNYHPv6SbBdmmSirjXPGeLp6MCs+9oWIVizV+oXFJzBQ
X-Google-Smtp-Source: AGHT+IF1MvSTf+KQ/Fpbu6jYXs3sjGYXa/fDF+6ZROWh3dpcnxcOeS+ygB9F/kRaFlkWEJVF3Am3BQ==
X-Received: by 2002:a05:600c:5113:b0:421:b65d:2230 with SMTP id 5b1f17b1804b1-421b65d25afmr21427615e9.0.1718014063361;
        Mon, 10 Jun 2024 03:07:43 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4217f633f2asm63882665e9.28.2024.06.10.03.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:07:43 -0700 (PDT)
Message-ID: <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
Date: Mon, 10 Jun 2024 13:07:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530183906.4534c029@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/05/2024 4:39, Jakub Kicinski wrote:
> On Wed, 29 May 2024 16:00:33 +0000 Aurelien Aptel wrote:
>> These offloads are similar in nature to the packet-based NIC TLS offloads,
>> which are already upstream (see net/tls/tls_device.c).
>> You can read more about TLS offload here:
>> https://www.kernel.org/doc/html/latest/networking/tls-offload.html
> Which I had to send a fix for blindly again today:
> https://lore.kernel.org/all/20240530232607.82686-1-kuba@kernel.org/
> because there is no software model and none of the vendors apparently
> cares enough to rigorously test it.
>
> I'm not joking with the continuous tests.

Is there any plans to address the testing concerns here?

