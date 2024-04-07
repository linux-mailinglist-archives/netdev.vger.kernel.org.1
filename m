Return-Path: <netdev+bounces-85555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA989B47F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 00:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1B628146C
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1542D44C71;
	Sun,  7 Apr 2024 22:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D842073
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712528497; cv=none; b=OQPaAMfvk3+bDoCr8601QDF/zq6+3wJtM58gj+oDbJiIYb3kpzP0KfnaNgOaW5/WZYGOJaG/4+CQzYAO7szizKawc7ShN5L9sTe4F5CR9b5TUbKpHkCO+7pF+xgjhz5wCiq8eqAyIj/QdIBPBZp0RrsFnFGCe2eux4O2wmkL8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712528497; c=relaxed/simple;
	bh=ZnCM2yaQjEcPb6WbflW3KN7qO163OCfe9Vi1/RT+dxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSEHz17ABMeej3CP0cOhpGITBK6jIF4hFpsHExkRWV5kPweBNRD93aGp3DkGPYk77Uj5uFXY7Agx9R8+onfG2NlaLEYgervIUdN8+IQymnSNUiby66g+3Q8eup+RYGoTqC/IQRLXShR9ABGNkHFXdlxfGRJOirGw8GEJgyyhZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34560201517so193321f8f.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 15:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712528493; x=1713133293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdWWKfy1sBES+njCUFCe6uvHTcfI8Vhkg1gV5AVrYTE=;
        b=sUDdfbQE7gxSg6otCJdDGrwfEMfAZslMfuaY1kg7nqd7UHZgLcMwLXP1gq4AXtpqI0
         NKf6zFQmafaqa2tZov1QMadxcYKitnRHtCjs1dVGXapLLBE1j/qh4deu176cjafkX/2c
         rZ1nmvKY9C78FxtzPTcjXYu3gkTk0k8KnalEz8cEHMZz5XlRRndUL3We2f2/FYJ58VXw
         YOmDUuzAkb9cackgf8FHEw3IzBqvaKfLudidd4+ZY9Xeq4FtzpsR4YWupP+UkNDEjMrq
         WfvuMLuVF6bBM04UvdqjlQDqPIWce1Fsi2QYbJg+k8LBKETLfLVl0B8XpThLLGHddczm
         NHQg==
X-Forwarded-Encrypted: i=1; AJvYcCW3jZiIrtIuZrSnvEJKUvfjGoS4GFFWanW+40Nmz4dL+6eIe23FED6hRc7FZ3Td7EfJVhTtA2mmePyfbPB1Wy9KRgCEuMw9
X-Gm-Message-State: AOJu0Yw1OPU0AIEIjdzL2fSAx7hAALEWU12ZYnoloB5/pz5cs6wgvJpM
	Pa52a1C/2gIAnKG8htH1nfgMG3B8JPtcAAz6LgE1wSCPQXcjkQdA
X-Google-Smtp-Source: AGHT+IEj7K1D6DUtOtvrn42Q3upnCYQ72/noTp1nXGbopYW0ZY0mSdk54qaK0Jw2BZ8P3Z5sI6AkXQ==
X-Received: by 2002:a05:600c:1c01:b0:416:2b27:8134 with SMTP id j1-20020a05600c1c0100b004162b278134mr5486715wms.2.1712528493561;
        Sun, 07 Apr 2024 15:21:33 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b003439b45ca08sm7434254wrq.17.2024.04.07.15.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:21:33 -0700 (PDT)
Message-ID: <1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
Date: Mon, 8 Apr 2024 01:21:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
To: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240405224504.4cb620de@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240405224504.4cb620de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/04/2024 8:45, Jakub Kicinski wrote:
> Doesn't apply, again, unfortunately.
>
> On Thu,  4 Apr 2024 12:36:57 +0000 Aurelien Aptel wrote:
>> Testing
>> =======
>> This series was tested on ConnectX-7 HW using various configurations
>> of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
>> targets.
> About testing, what do you have in terms of a testing setup?
> As you said this is similar to the TLS offload:
>
>> Note:
>> These offloads are similar in nature to the packet-based NIC TLS offloads,
>> which are already upstream (see net/tls/tls_device.c).
>> You can read more about TLS offload here:
>> https://www.kernel.org/doc/html/latest/networking/tls-offload.html
> and our experience trying to maintain and extend the very much used SW
> kernel TLS implementation in presence of the device offload is mixed :(
> We can't test it, we break it, get CVEs for it :( In all fairness

Especially when nvme-tcp can also run on tls, but that is incompatible with
this offload at the moment (I've told the nvidia folks that I do not expect
this incompatibility to be permanent).

> the inline offload is probably not as bad as the crypto accelerator
> path, but still it breaks. So assuming that this gets all the necessary
> acks can we expect you to plug some testing into the netdev CI so that
> we see whether any incoming change is breaking this offload?

Agree, also given that there is an effort to extend blktests to run on
real controllers, perhaps we should add a few tests there as well?

