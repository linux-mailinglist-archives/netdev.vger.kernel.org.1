Return-Path: <netdev+bounces-85554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB8789B477
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 00:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A181C20ABA
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698244377;
	Sun,  7 Apr 2024 22:08:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7226AE3
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712527701; cv=none; b=u1pEW6n7OdckuA0wYnT2Dgw9lU7MXfNhK0xH4UnfIjv+s8XI5CHGimtQiXPpf/qfJA9R54UwfhLv/bwKKCNbSrcNHE72kx7MBI+l0rzPvW5MzYrL2vZo0AAsYu5knoXvJC9o8DOY6t2+ybLLyUNOz9OcDL48FJk867MuGG8zVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712527701; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r979IEuuanu6JGP5B/RWb+9piL6uKCR/zfOLqkbUPfN+0cT/80NVJZG93Da/I8rhmBbd5bjI+Ei1ce7oVzkPtwhgOQRrGQxJQHmFWhuy97LV6T9TYIQ3FaRiBt/7+27r4vGbJcOqR6XYL0eNjm/NuTbKJffxRq59qqUeO4CkvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343d32aba7eso822580f8f.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 15:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712527698; x=1713132498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wxWPB06Y33iV9/XZzwv68nKpSW58RhnvK9jfDWqFt22fnYEXfD/nBofVgFAOnv7BR0
         FjJr79tDnUxRmSKX8sskIudh639yX3FxViSO4K73rOJvTvLZfFvEzCB65ZgEMsv7uBBT
         1Y1F4XbWkaS+B6Z2HpsJfujyu3S2txiBVNxtvrem0cWojXE6DyUjqMXMeDZ4i2XKY8o6
         UJeCy4wzGGjCGnV4AI11kmhTaJGPVwqK9gTSHNxxzkDVMulCoCAcGZUoBmPWrXJ0ejKh
         uyzjO9JBUnQK3Zr2cMlNwsXrxlB68LfMMNhdAT4om+AHG80xAA8MHZ6Nrqk+8j7shjY5
         hlyw==
X-Forwarded-Encrypted: i=1; AJvYcCWGUK347EsBQb6bHm4rr3siBoguKx4QWUUl1V0NejO8NHJgTmrShOAX6VaB0m8fFaLcsYAfqSR3zOTBtw5Lss+GgmijZiWM
X-Gm-Message-State: AOJu0YyAobmv4G1uFVCa1hgedKJyo2WSxRe/7m9vcKbODZ6Q68F0Rjcs
	BO0oIfta0NXyT9TwrOa+1tZx230c17Lew8zIEbUSFT8QXDVvAELJ
X-Google-Smtp-Source: AGHT+IGDF8tsJ874mEe6XkoqEKWxA/iRW0vG8/gA+TkxveM1WuRq2ay+27LWLJ/uK5YDN5U7IV0brQ==
X-Received: by 2002:a05:600c:3b08:b0:414:b440:4c66 with SMTP id m8-20020a05600c3b0800b00414b4404c66mr5794243wms.3.1712527698538;
        Sun, 07 Apr 2024 15:08:18 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bd8-20020a05600c1f0800b004162b0b88f4sm13884883wmb.31.2024.04.07.15.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:08:18 -0700 (PDT)
Message-ID: <a307cd8b-510d-4bb0-9e5d-68fdbd8a362c@grimberg.me>
Date: Mon, 8 Apr 2024 01:08:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-7-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

