Return-Path: <netdev+bounces-123034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFAF963811
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16AC285FD4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2491C6B2;
	Thu, 29 Aug 2024 02:09:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FED520;
	Thu, 29 Aug 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897383; cv=none; b=MX0o6YRx4YnScjUoiApXjTrEdAZEwGDqYDPSzYi18cBSkcW3skpgX9CTytUelutX7u3UVc0kad5vJmA5F7iAxMM6kxh91XkEhzDs1tmMktseFGi2zt0FpQzSR5+0W76w56ULmRmaj7PS+yJnlmsyDZvw/Esic7pFsJ+linjxIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897383; c=relaxed/simple;
	bh=QXsZX6d4lukL7TtS1mcNPz1GZ7HkAN5Bco8YcVyD1Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzzyIbIioEKH3OHc2A5nGn10h9TKj9VyEbjUlW0D8u0T+S0GXj6v8gQ58ZjWzzpTRBlOUNMUnKwSVxSkd4ScZVMba27fbpo/8js+h1xPSeylQTypy2mdXqZXzv4qMVCesg7Fe4ud8u7HWvM4uCWmdWzegFrACFzCT3Js8FGPLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202508cb8ebso839885ad.3;
        Wed, 28 Aug 2024 19:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724897381; x=1725502181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvjopqElUG0+335tmD9riA+4aBAzYkKWDL/5MY/sQAw=;
        b=lSYsV64M5KU7f3l2/sdm1pVNqln6kf8GghZMp7eLiEx/6YCEUuYWWllAAeNL6nkWGr
         cCd3P6C2em+yelb62HKtF6aWd7eQsPu9iFElR1/ZamDxo4hkvsQ5AbNo0n0oUzvF3KON
         g8jjfia+xLwOmuR6koKH9oGBJyxkpe9KXO08s7P+LjOGt6bPPERYwmrYJv1jCu1gTe0u
         HGbWMQlvnrd5fi+C8HPjtqoMW4Y/E8pE4qVXgcAxTgTmD9lvXhoUeylO9rfPzq1yqLog
         YoJW7XMiKtxK5RlvMT0I/0bRKiSkoRxelfxCuLUDx75TVKeJaafyas00lnvXNWw6ErK1
         /w4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/QYCNDB4HGp+LEGaYgGgFHr96xHVrasqSJis3hvYcmjnipCqexacrVcikD4MxMzyffX5AE6/D0ZvSv+E=@vger.kernel.org, AJvYcCVwolFMowhuUrO2ZHfVqsA19xJE/rDOksHbErQlmI9jlVsp8KOhW9+QhXgh5Cf1bz6eNXhJzAoC@vger.kernel.org
X-Gm-Message-State: AOJu0YycVX2r8Uqk7nHp/bxeHLm6RxnuSxJNI/baPvtc6xhcxAm8uLyb
	9jBwhd2EzMdBlsJsFWNE2tfv63Vc4OUMP69AOQAZzH5qI75yuPY=
X-Google-Smtp-Source: AGHT+IH9vkiYsCf7r4NrvpAOTspDUn5NG8+UZu2gwYneSQGKtH/f6zE8vvBsQbesaVKGFtxgOiK4WQ==
X-Received: by 2002:a17:902:ce8a:b0:202:3735:6257 with SMTP id d9443c01a7336-2050c38cb15mr15400035ad.21.1724897381028;
        Wed, 28 Aug 2024 19:09:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515550badsm1269535ad.241.2024.08.28.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 19:09:40 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:09:39 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Naman Gulati <namangulati@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhawaja@google.com,
	Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
Message-ID: <Zs_YY8RO_SQZv7nF@mini-arch>
References: <20240828181011.1591242-1-namangulati@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828181011.1591242-1-namangulati@google.com>

On 08/28, Naman Gulati wrote:
> NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
> epoll events after every napi poll. Checking just for epoll events in a
> tight loop in the kernel context delivers latency gains to applications
> that are not interested in napi busypolling with epoll.
> 
> This patch adds an option to loop just for new events inside
> ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll napi
> busypolling.
> 
> A comparison with neper tcp_rr shows that busylooping for events in
> epoll_wait boosted throughput by ~3-7% and reduced median latency by
> ~10%.
> 
> To demonstrate the latency and throughput improvements, a comparison was
> made of neper tcp_rr running with:
>     1. (baseline) No busylooping
>     2. (epoll busylooping) enabling the epoll busy looping on all epoll
>     fd's
>     3. (userspace busylooping) looping on epoll_wait in userspace
>     with timeout=0
> 
> Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
> and varying flows:
> 
> Type                Flows   Throughput             Latency (μs)
>                              (B/s)      P50   P90    P99   P99.9   P99.99
> baseline            15	    272145      57.2  71.9   91.4  100.6   111.6
> baseline            30	    464952	66.8  78.8   98.1  113.4   122.4
> baseline            60	    695920	80.9  118.5  143.4 161.8   174.6
> epoll busyloop      15	    301751	44.7  70.6   84.3  95.4    106.5
> epoll busyloop      30	    508392	58.9  76.9   96.2  109.3   118.5
> epoll busyloop      60	    745731	77.4  106.2  127.5 143.1   155.9
> userspace busyloop  15	    279202	55.4  73.1   85.2  98.3    109.6
> userspace busyloop  30	    472440	63.7  78.2   96.5  112.2   120.1
> userspace busyloop  60	    720779	77.9  113.5  134.9 152.6   165.7
> 
> Per the above data epoll busyloop outperforms baseline and userspace
> busylooping in both throughput and latency. As the density of flows per
> thread increased, the median latency of all three epoll mechanisms
> converges. However epoll busylooping is better at capturing the tail
> latencies at high flow counts.

Any idea why timeout=0 is not performing as well as looping inside the
kernel? Can we cut this overhead out? Or is it pure syscall overhead? (usecs?)

