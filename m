Return-Path: <netdev+bounces-142428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D99BF12C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2134B2813A1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA361E0480;
	Wed,  6 Nov 2024 15:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDD185B58;
	Wed,  6 Nov 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905584; cv=none; b=JDezk1mGdp1wTPax4+Ls5d8s36Hy/R3iYzIJgTSImZdB/I9sbbtiwh1A4uHczmwKSnCOkg2mthVjgPDdjX/mH20eg1uN4xcUXnc/HqhEPEG8qK2ReynDQ8TcUGQ1ALGyX+965FgI7E0Yac36F6lCH2X3IIu6RBBKHfwkEZIXYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905584; c=relaxed/simple;
	bh=T8a5iFhc5Ssx6DFL4DXCQ/DgD7BS7f9QlIrgZZoCbr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfGbbc20Z/v0XnYGWdS0YbNM3kKU8sL/Aqj1sFlHZO2jImVINj9mi0/I0D/D5yNqFSYa/9zmvmRAqUsNuV21AlYpETsG+IAhXlZRmucBHu+F7asTddgR/LcEv6XD6f2unnALKt4Tl6sK9FiV50JFqgHr7DMXtO0vPJ5xyv7Dz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f53973fdso878715e87.1;
        Wed, 06 Nov 2024 07:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905581; x=1731510381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b8V+kZQ7lk3KHYStvRTDKIPiVMbS+yqDViM9lOKTcM=;
        b=JXDcCVIJs9xUbIgAzB8otsu5ucL9MNiOobmCU5fBqET6Bx3izfRv0NOn4vsUC0OCKB
         vGbKw5N1arrHN5EUHEZYgjtwe9jdmaLN7ySdc85Fi6/MEyJSQFpClCqzQZFvOEpx8Knm
         eW78Ug2tZMFZ3wMm7fEAgg5NhxcFHDWhNcZT4jgvLXaC9foDdhagSNsS5jnYyp4/XNSb
         bnWhWIQicneBMia6Qv/Py0PeeH8eBUGwSSS2W6ypUfUbO2jA4EkQ+KcUw2LEvNuLXj4u
         WEk2U/dcY8qVQCCn1I73tH8Qrywop6S/XX8bjw/lsv4TB1cXC2PF0M1k0hDC5JvjuYrz
         BP4g==
X-Forwarded-Encrypted: i=1; AJvYcCVU1coLc/nKMoD8Kcfq3uFxwZoSz3/P9i5djV0PTuTmxGqHCon6odx8SjUjM/Bbj4ckyfcSa+4KIzjWEuQ=@vger.kernel.org, AJvYcCVzb+P6UFYCvm4h88oFrk6TiZqX6QC34aM5y2UHIhRJSQOcm6BMhzg1zSmGyZl7zm5LaHIj0HIY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gF1QDE5G0wXBnKPhG4z01cHpZM5vTn+OE+HiyhsnHsUNodD0
	xJFIU3BXJ2+zE7M5UtOsdVebwWBEIP0wKXbMT1m1rZn7M+9q+xJ9xyssDQ==
X-Google-Smtp-Source: AGHT+IHJMaw45GELJlrNBvI0uH/AkRhX0R2T4x/chYX42ZaqPPrfNufCoeFgJKhWWKI+oL1AKZHBDw==
X-Received: by 2002:a17:907:daa:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-a9ec671dae1mr296623566b.26.1730905569680;
        Wed, 06 Nov 2024 07:06:09 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17ce97bsm295144566b.127.2024.11.06.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:06:09 -0800 (PST)
Date: Wed, 6 Nov 2024 07:06:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241106-gecko-of-sheer-opposition-dde586@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-2-leitao@debian.org>
 <20241031182647.3fbb2ac4@kernel.org>
 <20241101-cheerful-pretty-wapiti-d5f69e@leitao>
 <20241101-prompt-carrot-hare-ff2aaa@leitao>
 <20241101190101.4a2b765f@kernel.org>
 <20241104-nimble-scallop-of-justice-4ab82f@leitao>
 <20241105170029.719344e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105170029.719344e7@kernel.org>

Hello Jakub,

On Tue, Nov 05, 2024 at 05:00:29PM -0800, Jakub Kicinski wrote:
> On Mon, 4 Nov 2024 12:40:00 -0800 Breno Leitao wrote:
> > Let's assume the pool is full and we start getting OOMs. It doesn't
> > matter if alloc_skb() will fail in the critical path or in the work
> > thread, netpoll will have MAX_SKBS skbs buffered to use, and none will
> > be allocated, thus, just 32 SKBs will be used until a -ENOMEM returns.
> 
> Do you assume the worker thread will basically keep up with the output?
> Vadim was showing me a system earlier today where workqueue workers
> didn't get scheduled in for minutes :( That's a bit extreme but doesn't
> inspire confidence in worker replenishing the pool quickly.

Interesting. Thanks for the data point.

> > On the other side, let's suppose there is a bunch of OOM pressure for a
> > while (10 SKBs are consumed for instance), and then some free memory
> > show up, causing the pool to be replenished. It is better
> > to do it in the workthread other than in the hot path.
> 
> We could cap how much we replenish in one go?

If we keep the replenish in the hot path, I think it is worth doing it,
for sure.

> > In both cases, the chance of not having SKBs to send the packet seems to
> > be the same, unless I am not modeling the problem correctly.
> 
> Maybe I misunderstood the proposal, I think you said earlier that you
> want to consume from the pool instead of calling alloc(). If you mean
> that we'd still alloc in the fast path but not replenish the pool
> that's different.

To clarify, let me take a step back and outline what this patchset proposes:

The patchset enhances SKB pool management in three key ways:

	a) It delays populating the skb pool until the target is active.
	b) It releases the skb pool when there are no more active users.
	c) It creates a separate pool for each target.

The third point (c) is the one that's open to discussion, as I
understand.

I proposed that having an individualized skb pool that users can control
would be beneficial. For example, users could define the number of skbs
in the pool. This could lead to additional advantages, such as allowing
netpoll to directly consume from the pool instead of relying on alloc()
in the optimal scenario, thereby speeding up the critical path.

--breno

