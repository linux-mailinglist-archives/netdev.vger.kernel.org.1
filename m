Return-Path: <netdev+bounces-58509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D8816AEE
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8E4281BDA
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CE13FE3;
	Mon, 18 Dec 2023 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="R37K1isA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826914F79
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso32162195e9.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895092; x=1703499892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgqfxng/f1TeURYLmSla2oJOkzUelTfDM8uCrGRKaag=;
        b=R37K1isAxgLNY7Ij3aFyyFp0qRPSzukg6M8lfvEDul7/MmLlbbx5P1tZLhNNiuuTNl
         hD7hsTmWXPznhQsyVVAO8P3VNZGUVxqUSGsbG/dVnmzmkvOnVH/mUQPsf1DMM02XjdgO
         mUPee5SySkbDmObLtqWxFxxSPOfSwtJXH+VpnjEBa82oFwmVHHvSXsbOB0YzFLj3VUkA
         +Srqo6QFN+UsTylqjwGUt3v8bs83pEOyHv2FyTK1oqp2c7s/aZ1nCEAXiQo7/FVN19rb
         QERKL1E5R5gdbr/XnfPQa5hkPhqOAW8flgoEAgN+WGTwEHkjw97Ww0ATJRcZ+011Wtc6
         AVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895092; x=1703499892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgqfxng/f1TeURYLmSla2oJOkzUelTfDM8uCrGRKaag=;
        b=jjBkB3lpIED41QytIXPs/mLzuYKnwDfobl/Y2pngkSz913DSj1FDssYmPtu7/3X/Ln
         GirHZC9DFDCjb51QJnV9RLfpgWe1qSLnvI9pSW2Xh3HEQ0OxucL2muFpZ/7mMH8QzZzE
         dzDIQjqvIJOPZG4GV3uqjvBGQs3+O2HhFHiqYKT7B8Usw3/5Y+mA0/kRLOfXWIcABxSt
         GCwChTId9GsidjSekWJJXrgPsDWErzxoKKBgrX2GVYdJUbGBgjAg0qRG2qmFXIn48AK3
         nQBbx2YO6SeFP+aqwXxFno7bX59L1LpMgVy1juUUByrKD2bZkCKyLOmc2JHg8YyibMES
         i5cQ==
X-Gm-Message-State: AOJu0YzF7Ctdv25x3oG1mVMZ7ed7c3Un3WJ/4RDm1Em85uUhzoN7zabg
	+FRyJveQDpBfRV+X/JzHdt9GZA==
X-Google-Smtp-Source: AGHT+IHtjTd2rdStR2WSp5hVDvpU9VvdG8nF9k7zFxdFMbmk9kAaOH3qG7Z/8/HZGCF/iL9fGWqByg==
X-Received: by 2002:a05:600c:35cb:b0:40d:1773:2d79 with SMTP id r11-20020a05600c35cb00b0040d17732d79mr695244wmq.205.1702895091723;
        Mon, 18 Dec 2023 02:24:51 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:24:51 -0800 (PST)
Message-ID: <4d0d42c6-8219-48a6-828b-1743d28e871e@blackwall.org>
Date: Mon, 18 Dec 2023 12:24:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] vxlan: mdb: Add MDB bulk deletion support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Implement MDB bulk deletion support in the VXLAN driver, allowing MDB
> entries to be deleted in bulk according to provided parameters.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c    |   1 +
>   drivers/net/vxlan/vxlan_mdb.c     | 174 +++++++++++++++++++++++++-----
>   drivers/net/vxlan/vxlan_private.h |   2 +
>   3 files changed, 153 insertions(+), 24 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



