Return-Path: <netdev+bounces-92432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7538B74EE
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194E71F2283F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159413D247;
	Tue, 30 Apr 2024 11:54:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D116134412
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478059; cv=none; b=Rsi601fTfU/9Kv4HIFOFeWJXnMcdfTGpbe6rmEaLbv/nhchjytDoPZV03pMxP21u3VahhEKnpBcCs1FbwpYVSpV/3w+w/KVAhxEm0R4UB/TgL92S//FUf3ibzJdBcFsZbERfxAOR3QqSSnlqH8Te1R0U4zFNCUoChOf0/v5P4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478059; c=relaxed/simple;
	bh=nWGZMkeZ63L06gJahSkSTZM3HvQcoWlxsNEcXO1wg9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv9qW6k/sEBAvms478SXb+ypMbg4HWXFH9+Y0WmkeuD3U9vX9ETNLjqaOvlkXAQtOagQTVJzG0yBiMwzWYKZhhmPwiOxGhzA1zqM8LyO3uWefHtz8pKC90v9Zh555lFTwkw5qYpO4lUW8qSPTBm87v/qhM5BJI2NNRGm2gSJKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4190c2ec557so1990705e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 04:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478056; x=1715082856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI03EuF8ZM4QyEdXiSTl6tAm2Vj64rLofeDwYKijk6k=;
        b=ZwD5rg3rf9FLYfmVynGgDcx5fqR7Wh7lpPfSP2WC0m6gtaxBc27BHmcGGrU5GCDnlF
         Si2k86VjAJUD1LwkJLQ8KUnFLGUgrg3Qc3R9ZoiRZi3O2oizIDv6Ipcu7zEfex6N73Qs
         TYBNUKaYOFSOP3tB/xEnV/sffSQuTDRE/Sh+7bpGeNX7FLNHLGu8rbfAByxZCmILYe1a
         /+IR4pLm+KnNSDuo+vMYmqtg+mwqMHXjdWa+7M8izULYi9W1lKQBEM2/PMDgMgkkJuqs
         rVnll4HABQ7zuL9IKdxGudeINUZIL0hsx1erHrE2tZ27CvRaMr/LCZo7vsvibBOHuM8g
         FtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLK9EwyikcBR5oRr4wARugxarfcIuc9xZiwBkZySNfUk9DogjP8qqUab0umEHAa0mS7784NI7oyKw9Jajsxfcf8lXM104o
X-Gm-Message-State: AOJu0YyJcjVd2QXrQB+V9cfv3igm61hur0UIPV6ibcdkg1zhwaulAsZx
	yWWM/wKqDJovbvd+6jB3vSE2OE7jv3hwPE3HmzZlcpjM+Ygf5oS/
X-Google-Smtp-Source: AGHT+IHuVsQR5/yvCj+OaBR12hedijAAPkXtXNeG3df6QXogZQ5cKmjXk7OZbwHQT8Bs6EFA3qkMkQ==
X-Received: by 2002:a05:6000:c44:b0:34b:dc52:266d with SMTP id do4-20020a0560000c4400b0034bdc52266dmr9015797wrb.3.1714478055984;
        Tue, 30 Apr 2024 04:54:15 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0034a25339e47sm30981529wrr.69.2024.04.30.04.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:54:15 -0700 (PDT)
Message-ID: <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
Date: Tue, 30 Apr 2024 14:54:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
 <253le4wqu4a.fsf@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253le4wqu4a.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/04/2024 14:35, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>> This is not simply a steering rule that can be overwritten at any point?
> No, unlike steering rules, the offload resources cannot be moved to a
> different queue.
>
> In order to move it we will need to re-create the queue and the
> resources assigned to it.  We will consider to improve the HW/FW/SW to
> allow this in future versions.

Well, you cannot rely on the fact that the application will be pinned to a
specific cpu core. That may be the case by accident, but you must not and
cannot assume it.

Even today, nvme-tcp has an option to run from an unbound wq context,
where queue->io_cpu is set to WORK_CPU_UNBOUND. What are you going
to do there?

nvme-tcp may handle rx side directly from .data_ready() in the future, what
will the offload do in that case?

>
>> I was simply referring to the fact that you set config->io_cpu from
>> sk->sk_incoming_cpu
>> and then you pass sk (and config) to .sk_add, so why does this
>> assignment need to
>> exist here and not below the interface down at the driver?
> You're correct, it doesn't need to exist *if* we use sk->incoming_cpu,
> which at the time it is used, is the wrong value.
> The right value for cfg->io_cpu is nvme_queue->io_cpu.

io_cpu may or may not mean anything. You cannot rely on it, nor dictate it.

>
> So either:
> - we do that and thus keep cfg->io_cpu.
> - or we remove cfg->io_cpu, and we offload the socket from
>    nvme_tcp_io_work() where the io_cpu is implicitly going to be
>    the current CPU.
What do you mean offload the socket from nvme_tcp_io_work? I do not
understand what this means.


