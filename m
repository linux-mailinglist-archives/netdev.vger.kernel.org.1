Return-Path: <netdev+bounces-159157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21681A14886
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D7A3AA704
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7491F63CB;
	Fri, 17 Jan 2025 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT9KM/bj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE01F561F;
	Fri, 17 Jan 2025 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085103; cv=none; b=UOSrVWkDnSuuJIcTnX8371s8GQyonW2swpz7t1+/nRzzSidPJnC69sOYaIaZn8NqJSzXdOwe0pW50Oo0HAbopxgbYJtlf4PbMr4q84U8cx4dPIei5OrLUma9Ug5QwbvQYgST/KJS5hX0KdSE5ZPCxIIjqqOclwCeD/JuA9A8hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085103; c=relaxed/simple;
	bh=snHAxk1TYzvH3dhSnERfBbh+NdZmEUqniozTVHXK9qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQrDXLgMC13LgxULm3sFzZqfHYE7D2pZRZKjWrqoT1IdadjAcGyPa8zvi+cJ04pZazeLQb2ACV/3tuiLnO9vhqWpLpxP4+7hyS3BxeNalcMI2fzGSMwnO7na6vM6o4bxmmPFMg7vurCBbhr9IZS1fwV2T81FwNgFkBigF4FL2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT9KM/bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D878CC4CEE0;
	Fri, 17 Jan 2025 03:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737085103;
	bh=snHAxk1TYzvH3dhSnERfBbh+NdZmEUqniozTVHXK9qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nT9KM/bjpEZ5x165fDXqMd1MMdq0VJZrjRgDh7lZXS6GelmUIyujVcSlJOw8q7zQf
	 T4RQHtFq9jpRCd+bGCPIA+s2kCTDAtfZ/pjvwyq+zOXmLsAXmp8VZ20QLTipMsotaq
	 SunUuygw6yIxCOkEY3TspsfNGTkReCoMT59kAnpmrF4t415RsMyVA1D1gKZnjUgpwh
	 8j3E0X3M3sIWtYUN0j295k8f901HsZCAJooi1Z5Z03VnzTxDqqkheVUh+E+qF63umi
	 nh8vEaOKUXEqNfaQLLnKzU+EafZOfOKuVRK2+xgXkn/m1y8b2NlmYvV7N814I5yvJD
	 hD/1kF+ZgR1Og==
Date: Thu, 16 Jan 2025 19:38:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, Catalin Marinas
 <catalin.marinas@arm.com>, Guo Weikang <guoweikang.kernel@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <20250116193821.2e12e728@kernel.org>
In-Reply-To: <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
References: <20250109182953.2752717-1-kuba@kernel.org>
	<173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Jan 2025 23:21:07 +0000 pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Thu,  9 Jan 2025 10:29:53 -0800:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc7  
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/c77cd47cee041bc1664b8e5fcd23036e5aab8e2a

Hi Linus!

After 76d5d4c53e68 ("mm/kmemleak: fix percpu memory leak detection
failure") we get this on every instance of our testing VMs:

unreferenced object 0x00042aa0 (size 64):
  comm "swapper/0", pid 0, jiffies 4294667296
  hex dump (first 32 bytes on cpu 2):
    00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    pcpu_alloc_noprof+0x4ad/0xab0
    setup_zone_pageset+0x30/0x290
    setup_per_cpu_pageset+0x6a/0x1f0
    start_kernel+0x2a4/0x410
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xba/0x110
    common_startup_64+0x12c/0x138
unreferenced object 0x00042b00 (size 320):
  comm "swapper/0", pid 0, jiffies 4294667296
  hex dump (first 32 bytes on cpu 2):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff c0 74 78 98 ff ff ff ff  .........tx.....
  backtrace (crc 0):
    pcpu_alloc_noprof+0x4ad/0xab0
    setup_zone_pageset+0x6e/0x290
    setup_per_cpu_pageset+0x6a/0x1f0
    start_kernel+0x2a4/0x410
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xba/0x110
    common_startup_64+0x12c/0x138
unreferenced object 0x00042dc0 (size 48):
  comm "swapper/0", pid 0, jiffies 4294667296
  hex dump (first 32 bytes on cpu 2):
    18 07 01 0b f3 00 00 ea 00 00 00 00 00 00 00 00  ................
    00 00 09 09 17 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    pcpu_alloc_noprof+0x4ad/0xab0
    setup_per_cpu_pageset+0xd2/0x1f0
    start_kernel+0x2a4/0x410
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xba/0x110
    common_startup_64+0x12c/0x138

This is unlikely to be important, but I'm not getting any hits on lore
so I figured better safe than sorry...

