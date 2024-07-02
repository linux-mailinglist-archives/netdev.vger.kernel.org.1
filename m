Return-Path: <netdev+bounces-108405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB14923AF9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D751C21E50
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456701509AE;
	Tue,  2 Jul 2024 10:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71112F392
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914447; cv=none; b=u3HxtqetySNf3/JmwyibN/0yifC+1D/fHr12JcDRUTRVAWddhAalt8ILkortpqLyvROiFNMUwgKhOqobaExpfgUS8bejyzrznnOY0iqdKvGnzoX0k5QniHYkTk87suBxqvzdjHyopJ/XGaMogjUZ431MhYvJJMiOupHRDS2q9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914447; c=relaxed/simple;
	bh=Ktl1tfVd73nnyU6RFdtGDuVOjDp+QDqMgQ/2LXNl/Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkxAhQ8QD82QfkFNM+vORGfZNiw2oxMfMF6iMtcUqpe4um6VKwQBAj8m/t+fzgm0AfS/WM+1Y3DKka1UGwQ7O5B7rjfFPYyUjZR43PaqLxHtXHlku1t4fABo95OSNo9snRvvj1R6LM0Ok5A24ne4oRtar05/CLIh2nk2L7FK0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec5f72f073so3549431fa.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 03:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914443; x=1720519243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktl1tfVd73nnyU6RFdtGDuVOjDp+QDqMgQ/2LXNl/Bo=;
        b=diKUxXG54aI+X0choMwF3Eue5EwvEE/Fh2P0u5LPlClXgot3z8QqX3VVLpqamN7IBD
         79ENlTuk1rWqQc5Rxz4Qw8vE+iiMpMDBExuGv+0wCRHDaLaeaRDcTkqbDIOpsXsbASKT
         hAX/veSnXSoErKy0DuSUs5v5qE0dMASbXTP3TnxA9s+aYTxe6BNijlnwd+XlaPnD70aA
         uJQWIS1eMvB1ralmlR5EiiH+IG9JrWk8X9lNd/k6TVvsRWhe7VsIPj7jT6SFA045H5QY
         eam5PCqk3PNKjYlNInaekZQM1IMlZ0KgbZHFfDZLHrJnS+5rgCYSelPVH2XxDECxqrqL
         fHbw==
X-Forwarded-Encrypted: i=1; AJvYcCWSWBeeUv6TBLmXo/zn31/TTVmHBxBtp/TSW7q/ziE7uball3yJnpeNX4c5diQnWOabaKHH1RCA4xwa23LiLBdY0k91WuZt
X-Gm-Message-State: AOJu0YxraqazLrh2615Oirwi9yP45+BVnLrD7ZiSst2B/ul3brFN1ZoL
	HIqDL99qhHC4Ei/vMhiLbg3TSbBikkWmSsfU4khshnK5I+P++Krx
X-Google-Smtp-Source: AGHT+IHNEMJLR0gUrBlAKAV1LbVzJ0AB3OjecbjfRZv2Qzd2IrJRGJ+xOrPglzbofLH3cgqqSV28Og==
X-Received: by 2002:a05:651c:b23:b0:2ec:5467:375b with SMTP id 38308e7fff4ca-2ee5e2a77c6mr64466311fa.0.1719914441106;
        Tue, 02 Jul 2024 03:00:41 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0621fesm190003715e9.24.2024.07.02.03.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:00:40 -0700 (PDT)
Message-ID: <15fe5c2a-78dd-4700-a175-94c8bd20b652@grimberg.me>
Date: Tue, 2 Jul 2024 13:00:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: allow skb_datagram_iter to be called from any
 context
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>
References: <20240626100008.831849-1-sagi@grimberg.me>
 <2346b61ddecfca4d95a20415d27bdd8c50a83e9b.camel@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2346b61ddecfca4d95a20415d27bdd8c50a83e9b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2024 12:51, Paolo Abeni wrote:
> On Wed, 2024-06-26 at 13:00 +0300, Sagi Grimberg wrote:
>> We only use the mapping in a single context, so kmap_local is sufficient
>> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
>> contain highmem compound pages and we need to map page by page.
> My understanding of the discussion on previous revision is that Matthew
> prefers dropping the reference to 'highmem':
>
> https://lore.kernel.org/netdev/Zn1-2QVyOJe_y6l1@casper.infradead.org/#t
>
> To avoid a repost, I can drop it while applying the patch, if there is
> agreement.

Agree, would be preferable avoiding another repost if possible.

