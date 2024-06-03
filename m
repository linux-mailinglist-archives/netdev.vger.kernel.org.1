Return-Path: <netdev+bounces-100071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C04958D7C30
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADBEB22288
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD643B781;
	Mon,  3 Jun 2024 07:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF43B297
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398572; cv=none; b=KHicCO5j93tqGAnisSf9vPrEkvA9kCxuDD0uiIsf8tWMjmev/1BYrGhFFcAaazlalpJ8gdOyPY/DF8MjcIgXT4WC/c4pcqD4Z2FEuno3Hn/AoIRKsXtr7ZNInxxUDbyqH1r3Qpm8xDT5JDoBqJs8GgDS4BXNBJS0ZraFxs9Iy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398572; c=relaxed/simple;
	bh=vZQGMrlEvkmRdd1HpKGljrbktFKGmnk60QbPOo0kGfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLSagmLd+V5TUviEp8AnoS1EKCKZpXOe/qaiAD90+NZZSDK3+RzCmJRQwsgg9D1wHyowxipYSVc9i931SXvm6Jwevg8hdMPhRGUQPUk3jZRZCkgTFDZ49IwCi3LbwD7U3YXlRTgrFTONk/PS5fyaXQgEmr/JqVDyEk3h8jeTQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaadde4dafso1221381fa.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 00:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717398568; x=1718003368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5xzErDAmbdmISQVPCaa1tqc9grd1xDfpbrLoCt0N4A=;
        b=mwllO7uASe7tiJl+YGabRCLEdQN1Kaj6c4f6hn1z0YNIcvCHzB5MbZShXyk7X99jG1
         ltBX+E5fNi4HH0vzFVaBwLXq6J4cse4noa3VaY2qZiL+gBZ7YTm/Wi0G5ykjkMbT2d3T
         Bzaj+NTESUg6kRgaZCoDMAu1dOFJCaj3R/JA7oNm4U+2DuSnZZyEHzVrGhj7JqFzwgbM
         ud6keRWFnKRF1jxatvxU7VV/pYk6EU0TW4VPKXNdx9rCLwiEWAQYTT0fXR/9xk00spHL
         WM0nPrqa1r/6pIGLFLel3A2f3/j8oK6BQMpDvgxb+kCaBVHNt8o/xsDzrKoPK5Zj225D
         2GeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBLyWO6IeThPCyjpmuuKiHL2wGg5OWkk2uqiIXeWQMb37rX2XXTqQgU2dGEZvFFM+Gtpgt9Ks4hBu5dsiEAqpKyXj7JO9E
X-Gm-Message-State: AOJu0YwhaLsz6uibWVy4psWnbqGxVmENTnBFx7gBwxrcTsTtlvStGHhl
	Xkz0IqzwE4MLnSj8mqkGFFMNgIhCADbFj6qti1tmDi+Dj9HT903z5se2dNGp
X-Google-Smtp-Source: AGHT+IE5r0soLdabb6igj9MUhMvzBhhVUB3h1THX9KOP4A2vIvTn24IsAKgih+iOUrLVnDfjUfYBRw==
X-Received: by 2002:a2e:9899:0:b0:2e8:60ab:c6e7 with SMTP id 38308e7fff4ca-2ea950e6688mr52910291fa.2.1717398568094;
        Mon, 03 Jun 2024 00:09:28 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213cd1c075sm27099335e9.0.2024.06.03.00.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:09:27 -0700 (PDT)
Message-ID: <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
Date: Mon, 3 Jun 2024 10:09:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240531061142.GB17723@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/05/2024 9:11, Christoph Hellwig wrote:
> FYI, I still absolutely detest this code.  I know people want to
> avoid the page copy for NVMe over TCP (or any TCP based storage
> protocols for that matter), but having these weird vendors specific
> hooks all the way up into the application protocol are just horrible.

I hoped for a transparent ddp offload as well, but I don't see how this
is possible.

>
> IETF has standardized a generic data placement protocol, which is
> part of iWarp.  Even if folks don't like RDMA it exists to solve
> exactly these kinds of problems of data placement.

iWARP changes the wire protocol. Is your comment to just go make people
use iWARP instead of TCP? or extending NVMe/TCP to natively support DDP?

I think that the former is limiting, and the latter is unclear.

 From what I understand, the offload engine uses the NVMe command-id as
the rkey (or stag) for ddp purposes.

>    And if we can't
> arse folks into standard data placement methods we at least need it
> vendor independent and without hooks into the actual protocol
> driver.
>

That would be great, but what does a "vendor independent without hooks" 
look like from
your perspective? I'd love having this translate to standard (and some 
new) socket operations,
but I could not find a way that this can be done given the current 
architecture.

Early on, I thought that enabling the queue offload could be modeled as 
a setsockopt() and
and nvme_tcp_setup_ddp() would be modeled as a new 
recvmsg(MSG_DDP_BUFFER, iovec, tag) but where I got stuck was the whole 
async teardown mechanism that the nic has. But if this is solvable, I 
think such an interface is much better.
FWIW, I think that the benefit of this is worth having. I think that the 
folks from NVIDIA
are committed to supporting and evolving it.

