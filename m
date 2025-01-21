Return-Path: <netdev+bounces-160089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D59A18147
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC8E1882E87
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F301F4285;
	Tue, 21 Jan 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNX83P+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EC1F3FF4;
	Tue, 21 Jan 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474140; cv=none; b=XY5C8khFd3Q8IdcvJb+ItXmOocHuJn0oWIsG7B7TCp7kbqaUgSKMHWL3BYIXNv4rfK+PlKIIbrpZoJCiDPE9GKclu2jj1rU3GIf6L42vCiN6KtaAslWmXA+BBWcYNzSBae+SVcTcLlumqMpiGjFTapZV+vzhBMV100GaxFlqZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474140; c=relaxed/simple;
	bh=YecJRBYAg4nuYrQGofjHTFJf0h8Nq2uq75EF22J8VNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGmrIJFiHNdM7xv+63cvMV9/CFOtEpjbd5MUpr7bR/ca8pKjeMDeDU6XT2NF51Sm1AzuZtAwlHVnAjk22bCiNSbQcoIvrJdcYnYgGkZms2IbdDVLv5yUxBrOq9emBcIi+k28kZ3xfF9vvbkZ1urHXnHs/KX/EmoCSugGOc1TeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNX83P+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F90C4CEDF;
	Tue, 21 Jan 2025 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737474139;
	bh=YecJRBYAg4nuYrQGofjHTFJf0h8Nq2uq75EF22J8VNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LNX83P+iBxZ1ZUb5Kkl96Q18iWpuSDOzPXy9UtEE6N3W4M64qjIp/pRynEtsQ5qmA
	 GNEquRUa994qJUG9mlQ4PRI6y8fgjy+JquNAEaSFZ8aQbwY9Q1Z2/MqTOYy0OTXaTE
	 3pJZKk7wYmoMhUaNOITLn7egaF/jygfYF72kqwg8/b9WjASUy1CFwOpmKHdQb5AwkN
	 EeAd7BVvCgu+6lQEaAyVXnqp8KlKQ5G4MOS5fNSoiwFoag74aJhi3jfCxw5s504hfU
	 iIO8RY9gEQT8PmnxVuWrcdAGi9FrW/98ROdqStWTLdZZNRdxS5IdaEOHkc+8F3SzQN
	 arAb0vgngErGQ==
Date: Tue, 21 Jan 2025 07:42:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 Guo Weikang <guoweikang.kernel@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <20250121074218.52ce108b@kernel.org>
In-Reply-To: <Z4-AYDvWNaUo-ZQ7@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
	<173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
	<20250116193821.2e12e728@kernel.org>
	<Z4uwbqAwKvR4_24t@arm.com>
	<Z45i4YT1YRccf4dH@arm.com>
	<20250120094547.202f4718@kernel.org>
	<Z4-AYDvWNaUo-ZQ7@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 11:09:20 +0000 Catalin Marinas wrote:
> > > Hmm, I don't think this would make any difference as kmemleak does scan
> > > the memblock allocations as long as they have a correspondent VA in the
> > > linear map.
> > > 
> > > BTW, is NUMA enabled or disabled in your .config?  
> > 
> > It's pretty much kernel/configs/debug.config, with virtme-ng, booted
> > with 4 CPUs. LMK if you can't repro with that, I can provide exact
> > cmdline.  
> 
> Please do. I haven't tried to reproduce it yet on x86 as I don't have
> any non-arm hardware around. It did not trigger on arm64. I think
> virtme-ng may work with qemu. Anyway, I'll be off from tomorrow until
> the end of the week, so more likely to try it next week.

vng -b -f tools/testing/selftests/net/config -f kernel/configs/debug.config

vng -r arch/x86_64/boot/bzImage --cpus 4 --user root -v --network loop

