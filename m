Return-Path: <netdev+bounces-172184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB0A50A4B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45BA17295F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6F25332F;
	Wed,  5 Mar 2025 18:51:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0C18A6B5;
	Wed,  5 Mar 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200717; cv=none; b=WDsbvl7y4+tihrXTM5jWBH3KbF6oftU5c/XRWGJCUKq/igpqL0N6T6w/qW4kleuM+PiaJh+ugMqJ+tTaUU5GAbsm/2SIM+tQImqj6OYTBIGNYnBwc+V8fwCIL9qep1RtXH/SM7TtI8p5c3Tq6sBwUOq7AuW2Vi7+6R3oxryb9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200717; c=relaxed/simple;
	bh=gnlTp6wg7JauvaL8a4K9vrq5T4pAlOC59D5utdSZC4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sodDCWsl5mOGGRjCl/fGhu1JixxXA54SzWjF0+6xzvMtygDkKCuRORUYAxv22U+MGTgTDy+ydjFgA0ISpPFsj60iUquvxSs0yEPQfwe0UF7s8QYhIT97YTUQgtFE+SxSfs+ChTP8Xchmij9xvlMkXUvVdYG6Y++MCL17XMlIHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso1224316a12.0;
        Wed, 05 Mar 2025 10:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200714; x=1741805514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9Bcx0gjvUvjedkP5bIPCZqQbMdhPkF/HMFV4Lbojoo=;
        b=HUNVtQejY/A0l3ovhxZltUIWXPhF9+/tYP3Qd1ZcTONRLZdPgbn+lqJ+WF2aaSxsh6
         8F5TgYB35nd623mXm/e5Hu062izYHvzZeVOYBLpc3gfwNn/OZWBNsy1c35JIaOYkoIer
         IeeUqEynjKbrTznAqJ3728dK/5bH2qRRBhG4f0Z2juqfcizsIWg8Q2/Sfb0xKoVKANOg
         TcmTG8QzAE4AsSjAo1qQ6fG9FVOqIy9xc2WjLdO27WU+RNbpVL53b1F27ex+7Kq6MwLH
         qOx5OQsbY8MSlx6pbjgN5TDoFjTp2pIvdhIi6KGbVt1oVw0IlNrWwDFIv1aJHkwgaary
         ofDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQS7kIu71JH17tO8txn1SFy/KosG5kXvnvEOkCFcjT3FxtqR4Nk1xHkS5NFHA7JLXlHjeHSVDxOFI/E4I=@vger.kernel.org, AJvYcCVhqDv4d/vuPP67wE9pMp2sRLgMGM53WEd0K4JTU92J5FRZ5q8J1SbHIYgrY7gPQNSbbWuO15c4@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfuW3Sa644UkM19LkQyeOoIKf//iLl6cHOreThn11ihdtsYmi
	jEASBe/j5grd89UEVblNMmhNqIsHZ8qMeUyds3wr0vJBy47qlFa3
X-Gm-Gg: ASbGncsgjKgX6FWTXjJ29vRxKCyHo/mkFhLRSdPMPA395Ne2YqVUk5/ZoPNXwsD0lWh
	1QEK2uFxAeoYJ/HsO0ISLytGSMh3QO5uhRoGQ/My8uVitJ9V9AJRrk1y5E5Z31W+R9X+gPf1jJR
	HPPNATsTUkGrO0NDbsGV5Cnc9k4MA8TkgUAy1q5dx6FveXl4/dXzZOxcrOHNLSelkCG4pL1saOX
	B6GTqX3hFdolT1o4cWxBZmgwUHZ1pH8DPjqNumQW1c/NzV0/nvLzrw3gfylUmvEEWwL8G5GpHyk
	0N4qOfwzKWRCKf6AdLxQ9kzjw/PN2QCzZ1QQ
X-Google-Smtp-Source: AGHT+IEDHNcc894TPh82hqOYbFYBfCO7jI6zwH4fPv74yqgD/PeSdUHQTLyxYWxlpsvoz2QUD4lg0A==
X-Received: by 2002:a17:907:c486:b0:ac2:13f:338b with SMTP id a640c23a62f3a-ac20db01cd2mr473179266b.55.1741200713496;
        Wed, 05 Mar 2025 10:51:53 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf56691042sm805244466b.99.2025.03.05.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:51:52 -0800 (PST)
Date: Wed, 5 Mar 2025 10:51:50 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net] netpoll: guard __netpoll_send_skb() with RCU read
 lock
Message-ID: <20250305-dancing-pretty-kestrel-b269df@leitao>
References: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
 <20250304174732.2a1f2cb5@kernel.org>
 <20250305-tamarin-of-amusing-luck-b9c84f@leitao>
 <580ce055-b710-4e97-8d91-1cfea7ec4881@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <580ce055-b710-4e97-8d91-1cfea7ec4881@lunn.ch>

On Wed, Mar 05, 2025 at 05:09:14PM +0100, Andrew Lunn wrote:
> On Wed, Mar 05, 2025 at 01:09:49AM -0800, Breno Leitao wrote:
> > Hello Jakub,
> > 
> > On Tue, Mar 04, 2025 at 05:47:32PM -0800, Jakub Kicinski wrote:
> > > On Mon, 03 Mar 2025 03:44:12 -0800 Breno Leitao wrote:
> > > > +	guard(rcu)();
> > > 
> > > Scoped guards if you have to.
> > > Preferably just lock/unlock like a normal person..
> > 
> > Sure, I thought that we would be moving to scoped guards all across the
> > board, at least that was my reading for a similar patch I sent a while
> > ago:
> > 
> > 	https://lore.kernel.org/all/20250224123016.GA17456@noisy.programming.kicks-ass.net/
> > 
> > Anyway, in which case should I use scoped guard instead of just being
> > like a normal person?
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
>   Section 1.6.5: Using device-managed and cleanup.h constructs
> 
>   Netdev remains skeptical about promises of all “auto-cleanup” APIs,
>   including even devm_ helpers, historically. They are not the
>   preferred style of implementation, merely an acceptable one.
> 
>   Use of guard() is discouraged within any function longer than 20
>   lines, scoped_guard() is considered more readable. Using normal
>   lock/unlock is still (weakly) preferred.
> 
>   Low level cleanup constructs (such as __free()) can be used when
>   building APIs and helpers, especially scoped iterators. However,
>   direct use of __free() within networking core and drivers is
>   discouraged. Similar guidance applies to declaring variables
>   mid-function.
> 
> So you need to spend time to find out what each subsystems view is on
> various APIs.

That is clear. thanks for the heads-up!

--breno

