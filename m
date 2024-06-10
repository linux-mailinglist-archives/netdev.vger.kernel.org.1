Return-Path: <netdev+bounces-102297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1190241A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C602F1F23091
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381E219EA;
	Mon, 10 Jun 2024 14:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4D80BE5
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029839; cv=none; b=RTw0J0tZfxBcJ8gR1lMzn3Yp840uKdggc2Z+rjNAG1CV+vPEizH/ifs8CY2V1pLsk3k60iWa8EJ+Uoswqlitih+nxEJBz04T26z2l8FDvD3lGeZ0/5NGogBD0Pli3MGmqQ3EnowXfj5uzrV1lwuTrWNnDBiKe99p/kTz/FCkXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029839; c=relaxed/simple;
	bh=4bVxaGP8kFkjKr+Ck+TYnxOMjMSrvTCJd9oRe1o4Qq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4dW/s4XKhQ7ss62JjJECXij5bK1z64GIKNZtd4u744FELrF/6K0VeZLHvBJlql9KhN47J8PwUOMG0zUPUHm90x7jHe7tdv/A9xR7I6HxP+92tR1QbmlCTb0vNRN3+PoJb03tMCKj64uWfXKFctAT/zi00WwZQanaQ2UxmZkKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42110872bf9so4918775e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029836; x=1718634636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9r8TSxia5VOpRvq2ZH+KZFO+iNGYVhgl/TCGYdPnBV4=;
        b=ixzElUyyRW9ZgWHTKv9ekmRipUMjcLzi6CgUz5Meo/DCfxCZpDUd+r8ryn57HBJjRf
         Zr3p6zyd3ewl+IMw1oc75/KrWn4oAzs6q/4ZhxfedttaJkuaRAOr3dRk6hxUrLnW2SGE
         JwqoVcTIPs4uB+jR9c720egj8nDvJTV0uG5s9iR3ygsQ/bGr3QetE7EZdVU2KwwhETMc
         +2MLaEqA4ngfisymu/bmA640gk6az1T4QhrQScNleLqJWbcQlkFKmV3qYjmZEG6Slglz
         2BJZJaSSuCa+xMzSiNTQ+V6qihdmCxZpJKqLWhNjAstaix7Otcr+pLjbeYu2PQVrgQKy
         mr2g==
X-Forwarded-Encrypted: i=1; AJvYcCWv7V4g3jjttvAghemzCTYT+AcWVeBORxNfJyvyipk4qlPB6RjwzXx92qs+r9bk51cculkg41L/qRC73g5l6XooUW9pQ/8x
X-Gm-Message-State: AOJu0Yy5npKv53igy9jnk40LOzHFeXMn8JbREajZVYwF9W2qPyMjGe5w
	fSrH5z/E1MyopU7bFbpksdz4J9imPrNdvTZeK/XZ/oivb/7H4ZGalWCT04RO
X-Google-Smtp-Source: AGHT+IGNYwmKnUFOdEUBOUxTES955Io2GxJGmqmRpCkKr9SjdDxpdv9dXwhK1LcpQbQUyokSvA1QQA==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr7179815f8f.5.1718029836111;
        Mon, 10 Jun 2024 07:30:36 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f048dddddsm8554380f8f.111.2024.06.10.07.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:30:35 -0700 (PDT)
Message-ID: <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
Date: Mon, 10 Jun 2024 17:30:34 +0300
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240610122939.GA21899@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2024 15:29, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 10:09:26AM +0300, Sagi Grimberg wrote:
>>> IETF has standardized a generic data placement protocol, which is
>>> part of iWarp.  Even if folks don't like RDMA it exists to solve
>>> exactly these kinds of problems of data placement.
>> iWARP changes the wire protocol.
> Compared to plain NVMe over TCP that's a bit of an understatement :)

Yes :) the comment was that people want to use NVMe/TCP, and adding
DDP awareness inspired by iWARP would change the existing NVMe/TCP wire 
protocol.

This offload, does not.

>
>> Is your comment to just go make people
>> use iWARP instead of TCP? or extending NVMe/TCP to natively support DDP?
> I don't know to be honest.  In many ways just using RDMA instead of
> NVMe/TCP would solve all the problems this is trying to solve, but
> there are enough big customers that have religious concerns about
> the use of RDMA.
>
> So if people want to use something that looks non-RDMA but have the
> same benefits we have to reinvent it quite similarly under a different
> name.  Looking at DDP and what we can learn from it without bringing
> the Verbs API along might be one way to do that.
>
> Another would be to figure out what amount of similarity and what
> amount of state we need in an on the wire protocol to have an
> efficient header splitting in the NIC, either hard coded or even
> better downloadable using something like eBPF.

 From what I understand, this is what this offload is trying to do. It uses
the nvme command_id similar to how the read_stag is used in iwarp,
it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
the command_id to an internal MR for dma purposes.

What I think you don't like about this is the interface that the offload 
exposes
to the TCP ulp driver (nvme-tcp in our case)?

>
>> That would be great, but what does a "vendor independent without hooks"
>> look like from
>> your perspective? I'd love having this translate to standard (and some new)
>> socket operations,
>> but I could not find a way that this can be done given the current
>> architecture.
> Any amount of calls into NIC/offload drivers from NVMe is a nogo.
>

Not following you here...
*something* needs to program a buffer for DDP, *something* needs to
invalidate this buffer, *something* needs to declare a TCP stream as DDP 
capable.

Unless I interpret what you're saying is that the interface needs to be 
generalized to
extend the standard socket operations (i.e. 
[s|g]etsockopt/recvmsg/cmsghdr etc) ?

