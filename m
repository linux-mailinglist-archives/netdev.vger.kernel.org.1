Return-Path: <netdev+bounces-91979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC28B4AAE
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 10:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DF81C20B57
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ED351C5B;
	Sun, 28 Apr 2024 08:15:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D250A7A
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714292145; cv=none; b=JdzEqO2i7jpLv/ONMnu5BT1nekx/pqW3nYjGKtIsrrZucKleM4A3BY1GBSVzfTkjGWPoYNZk56+py383JBCbkPHE4/uvzzUDe0BRGpefuvZbUPORN1R1YXECws7/FgASSTyQ4uZPguO7sn1igyuMK9bWrlwEFGn28p7W9InuXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714292145; c=relaxed/simple;
	bh=l/k+vM0/NzBXJOI3pUm4+hls/7uEKnTncklT5+b+ouw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqNwrkXWl9az2pV1anZzjLh4N4a9+nQYszJeYPzJoYTWIZ8wIzIU0LTFoac+TqGnL3rffvGmYhWtuQyPaTQWE6ijVzL568NXlTUtHHhbL+B7cMRhQDy9edooF5Kh7v0+CisRPN0vP7CrrgZXc8OUgd/3Jh1SfLgN9QZVepnh1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d874b89081so8329201fa.0
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 01:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714292142; x=1714896942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enjxRNkKuZiWZ2RiN4WqGso5DfY7oIJ6tL/Jqqxp350=;
        b=dL1KjqPYSSWuiyBy+mS/rgFRqoiUCDKx2mQqAcdf0MCdlbaS0ju04a43kcTv8F17yb
         RSseb0brtBpdr8QphDkb40NxMvAyo00Jr5IHBFLSv0Avh2pdmdK63gpD+b2LtLhoI7sv
         3udWwt9m/2/9JtfXuaLKEDXN1xyazLZ733+DRyYl7KNrxL/ovIWtYPOhnWSrz6l/bf+F
         uJJomi0TElRAjaHHK3gs/4qxFzY8qvTEc0Zqv9UEMp8tWuGqi2r9gWgzIX/vefPw5duV
         Y1VVbOn9KwDDZWT5cKkgKkj1LJXSOiIkfL2EQ+miuoEqrXkG5kHwerO6AJ1WcJxPhDRm
         8GFg==
X-Forwarded-Encrypted: i=1; AJvYcCXaWHnQhiapJMe42CT4dIVkG8MN/DIos0bF/loDwxVI30uxFkT/poZ5uzkDegRYLFxy9FV/ZKPd16i3xsFu3rUpysqXrI60
X-Gm-Message-State: AOJu0YwwZjRcZuajd+wyBEs2nXpk5ldFBLmPPEl7KZl1Vpf6VJSnIQ/n
	wKe7LBgW9ogam1jfE16i+UU1aCI84d9V8OuL4MPMK8URDL8d/Y3B
X-Google-Smtp-Source: AGHT+IGgjtFA6/cgUSNKNIFtaCVcvt+A4VZ8wiDKLn1OldQJe21264nSpXFsT4bzNQX2wDoiLY87SQ==
X-Received: by 2002:a2e:97d4:0:b0:2df:1e3e:27e8 with SMTP id m20-20020a2e97d4000000b002df1e3e27e8mr4050673ljj.0.1714292141883;
        Sun, 28 Apr 2024 01:15:41 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b0041bf21a62bcsm3462222wmb.1.2024.04.28.01.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:15:41 -0700 (PDT)
Message-ID: <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
Date: Sun, 28 Apr 2024 11:15:38 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/04/2024 10:21, Aurelien Aptel wrote:
> Hi Sagi,
>
> Sagi Grimberg <sagi@grimberg.me> writes:
>>> +     config->io_cpu = sk->sk_incoming_cpu;
>>> +     ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
>> Still don't understand why you need the io_cpu config if you are passing
>> the sk to the driver...
> With our HW we cannot move the offload queues to a different CPU without
> destroying and recreating the offload resources on the new CPU.

This is not simply a steering rule that can be overwritten at any point?

>
> Since the connection is created from a different CPU then the io queue
> thread, we cannot predict which CPU we should create our offload context
> on.
>
> Ideally, io_cpu should be set to nvme_queue->io_cpu or it should be removed
> and the socket should be offloaded from the io thread. What do you
> prefer?

I was simply referring to the fact that you set config->io_cpu from 
sk->sk_incoming_cpu
and then you pass sk (and config) to .sk_add, so why does this 
assignment need to
exist here and not below the interface down at the driver?

