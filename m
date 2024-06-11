Return-Path: <netdev+bounces-102532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F43F903987
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0331C216FC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79C17B42B;
	Tue, 11 Jun 2024 11:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCB17B426
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103698; cv=none; b=Xu9CF5iO7GGnYzKVfQUJ99OvXCD/CUHJrry21ivaEBFqYJJlQghBXJGINIfaxnRezQBSIINUDiAg3ZhqeYO7BIYo2PWtR2AD+vQEQf82lR9WVYpEcFcCRmTR6MAu3VaAOBWiXMKlP6DBz9XU1iCZANKz8l3Rfd2euznTgCF9Xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103698; c=relaxed/simple;
	bh=6Jsj4L1nIAWRumQjeO3YLOX+dSoC0GerJKMOnWQ2FLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLI2rCTO9ZOb2iS2T5h5m9m4RLCbTk4ePzgj5y6zMT6a9Mnej5xWY1DI8+nn3eSjTiF7LRcLc3Hf+tC43QtyxNYcLlUVliawgMddZNpH5pCy1X45E1ZYYqEabsgcVeYprgw/09LVfPSL5T7NojdGm6X6LunjClmBJpMvVEIXF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c1e33e283so613239e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 04:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103695; x=1718708495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkeWmt+Nx2AbtvOpSXf3xtCT93dTPkRd2wDT5Ci+nzc=;
        b=cDlkdsckzUgR70tJeP+UpSt+BebMUD2SoVn8nt0GnJbzkwiZh+XLJ6dzN3fMkjJjDQ
         UEvk+T91mplA+Rd0tpSq6xe0ckNLupEilHIszE5pf/J2tSNJjFDMz5l8DT6epcWkVILP
         +bVYcaz2T1g1/N4XE9UdzGSGZacC+p4xU3bbTJSRdOQo1qAQR3LdxLZLSZ48PlpbmRrP
         CDqiVNT3df3hai60KPoMqpKSQZVwZwmoIzv4oD8cr7Q9EB7YTZRJd5srxI+GRIKp3cOf
         ziwcuAA6HceVEJ4QrvlH1VDtPd08/tdxf3X65Fp/7KH881xoOaXg5Q/zPEwVY/tiXqxY
         qSdA==
X-Forwarded-Encrypted: i=1; AJvYcCVcbelPpz+Nl394aBKP8TuruCcBv4juXXMQzWlSKr2GGiKvwWmfR30XlZPWCuoo1DGNAPMA+ztyAh/1PD8GfyedYiJMw0Ly
X-Gm-Message-State: AOJu0Ywbsh5KHx3c2Fbzy8r+0EawOXfBcmrW2cFOTPAIyBNsWSDdP32C
	WzwPbVmA2ud//IyT516ILCJw7QDEdDW4ftRbbnTJQn8esOZnit8+
X-Google-Smtp-Source: AGHT+IFFGKrZiYwDzEvS9vPvXOK2ImQGbAVJIS92wSdCM0deuyAXrB/gzLfnFmjwDtgXbv+nUtewTQ==
X-Received: by 2002:a2e:312:0:b0:2eb:de36:6775 with SMTP id 38308e7fff4ca-2ebde3668eamr39391041fa.4.1718103694508;
        Tue, 11 Jun 2024 04:01:34 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d6d5ed3sm9915406f8f.19.2024.06.11.04.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 04:01:33 -0700 (PDT)
Message-ID: <6d53cf9e-a731-402c-8fc1-6dfe476bc35c@grimberg.me>
Date: Tue, 11 Jun 2024 14:01:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Christoph Hellwig <hch@lst.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
 <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
 <20240610122939.GA21899@lst.de>
 <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
 <20240611064132.GA6727@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240611064132.GA6727@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2024 9:41, Christoph Hellwig wrote:
> On Mon, Jun 10, 2024 at 05:30:34PM +0300, Sagi Grimberg wrote:
>>> efficient header splitting in the NIC, either hard coded or even
>>> better downloadable using something like eBPF.
>>  From what I understand, this is what this offload is trying to do. It uses
>> the nvme command_id similar to how the read_stag is used in iwarp,
>> it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
>> the command_id to an internal MR for dma purposes.
>>
>> What I think you don't like about this is the interface that the offload
>> exposes
>> to the TCP ulp driver (nvme-tcp in our case)?
> I don't see why a memory registration is needed at all.

I don't see how you can do it without memory registration.

>
> The by far biggest painpoint when doing storage protocols (including
> file systems) over IP based storage is the data copy on the receive
> path because the payload is not aligned to a page boundary.
>
> So we need to figure out a way that is as stateless as possible that
> allows aligning the actual data payload on a page boundary in an
> otherwise normal IP receive path.

But the device gets payload from the network, and needs a buffer
to dma to. In order to dma to the "correct" buffer it needs some
sort of pre-registration expressed with a tag, that the device can
infer by some sort of stream inspection. The socket recv call from
the ulp happens at a later stage.

I am not sure I understand the alignment assurance help the NIC
to dma payload from the network to the "correct" buffer
(i.e. userspace doing O_DIRECT read).

