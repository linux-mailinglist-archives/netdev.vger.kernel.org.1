Return-Path: <netdev+bounces-93901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3ED8BD8CC
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FFF1C20F91
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089010FA;
	Tue,  7 May 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSc2ij4U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC119E;
	Tue,  7 May 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044222; cv=none; b=AxmyvV+LNnTftFBQgxR4y3oZeaQtRFZCNi1zima/+ZZN85BhJH3o+FvQgqgKrlDAq+VA3zTTI/bK+50XZ9S9ro+QniGinXsPJB3AZH1HwAEz9svCS9IXVG2kpGlSbQ/LJP5NI8MeFn2mumCzcGYYzxgCQJTLtJwHkcf21FHt3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044222; c=relaxed/simple;
	bh=6jpWZYJhOwDYSVa62rHeydfZ5WH5ACGOAf5+pfKDKQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3SEKCk6KZmSY7ihi/tJQ8hZKWpPrChFtb1YEpJXUrkWwPgtzABp/kyYy2VTNRW/mIXfDpZYd1VI6+akEJUteabNO+eg763Zg0OBkVyQZwmTHdYzrR0kWGDmwha6saRZo6TPhlD8fF3YKsor2YAN2C7ht01W059qwLjc8sllM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSc2ij4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19C2C116B1;
	Tue,  7 May 2024 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715044222;
	bh=6jpWZYJhOwDYSVa62rHeydfZ5WH5ACGOAf5+pfKDKQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sSc2ij4UUZgD9OWbLGvsrNaXu/Cbm+dphilCpEgFnbHTE4ZKifDQg+yJivCnvx2X5
	 OwRfzu8BOfMt86CzbYdvhxS1mFyWzQjjJNf4dUOdek1DKNf8S/SNjqYTyLfmEgfNrS
	 t/dyJKyZMEaKnErjk3bUN4JqWUkDdxAeUXy/Wq20Va5Vo0+y1I8xBH7IpuJ+WJgSFe
	 mxzgr3F1u+KLg/gkgj2+86/pO3qkH4mOT/OZ/gQJIbYdWEweBM205SQw7ecolj7HBK
	 ukEfrDttRqOM6xeyfXHGRFTpsGY/nbRUMXV/PhnDWk+VcLAqzenIALVpQ6b+0PopVG
	 CVt4FXKS7lMZA==
Date: Mon, 6 May 2024 18:10:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370
 netpoll_send_skb+0x1fc/0x20c at boot when netconsole is enabled (kernel
 v6.9-rc5, v6.8.7, sungem, PowerMac G4 DP)
Message-ID: <20240506181020.292b25f0@kernel.org>
In-Reply-To: <20240507024258.07980f55@yea>
References: <20240428125306.2c3080ef@legion>
	<20240429183630.399859e2@kernel.org>
	<20240505232713.46c03b30@yea>
	<20240506072645.448bc49f@kernel.org>
	<20240507024258.07980f55@yea>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 02:42:58 +0200 Erhard Furtner wrote:
> And indeed without gem_poll_controller() I don't hit the "WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370 netpoll_send_skb+0x1fc/0x20c" and "WARNING: CPU: 1 PID: 1 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x30/0x44" or the according lockdep bug at boot!
> 
> Re-booted the machine about 20 times without anything suspicious showing up in the dmesg. With the unpatched kernel I got the WARNING at the 2nd reboot.

Excellent! Do you want to submit that as an official patch?
The explanation is that we can't call disable_irq() from atomic
context (which which netpoll runs). But the callback is no longer
necessary as we can depend on NAPI to do the polling these days.

> What I still get with 'modprobe -v dev_addr_lists_test', even with gem_poll_controller() removed is:
> 
> [...]
> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: dev-addr-list-test
>     # module: dev_addr_lists_test
>     1..6
> 
> ====================================
> WARNING: kunit_try_catch/1770 still has locks held!
> 6.9.0-rc6-PMacG4-dirty #5 Tainted: G        W        N
> ------------------------------------
> 1 lock held by kunit_try_catch/1770:
>  #0: c0dbfce4 (rtnl_mutex){....}-{3:3}, at: dev_addr_test_init+0xbc/0xc8 [dev_addr_lists_test]

I think that's fixed in net-next.

