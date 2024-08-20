Return-Path: <netdev+bounces-120378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17595912A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403C81C225C9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD818E035;
	Tue, 20 Aug 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxepoFmx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D21370;
	Tue, 20 Aug 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196251; cv=none; b=hkH8HmlaYUqooDGGoLQa3cGdii3H3nnR1Xj2TXSYFhEnqeiqOMvGJjBBJBa/cKHpSZuXMZ/0TtSUUmAMCMh0pk1YsMbAC3orCzG5yJ8v83zDqTaP/c1QOrf25YD25DAqvpuwQIaAffFCkuq0jyQ9+1L7Lp5rOj63Sj18qHqjw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196251; c=relaxed/simple;
	bh=Bgw5hU99derk7U1NmjbqkCmMgXck6gaGKiWqwznP96s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/Q5xDo8d03CWlsto2WuUn93vfbWRTx8/5zuctKy/jOTcO5H/WDIuvxxMdrOUHKg+n4yZ/U7VG0DkoaTsX3MaBEn6ciMWiR/LAHMitoEvDfXDkgPWyw8n78wcUoQrNsz5JFwXOHvuWUCpJA5HPC1tsRyfrmxSRmgR67bl0Eenmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxepoFmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09ACC4AF09;
	Tue, 20 Aug 2024 23:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724196250;
	bh=Bgw5hU99derk7U1NmjbqkCmMgXck6gaGKiWqwznP96s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxepoFmxfQO0UydG0v3ZV5buhg0oSeHlHX+McfdpdT2wIONHMoOuk5UekC70aOqLu
	 PRIdPa3JYBzVLWEeMQHuD+OYn2KtiCGJnZMYfNHD0zIQ+QPjId1vpPJSUP7vK2Cf5r
	 g+k4BOa9v778e4sSRjGBFsq32605TUK3G/sP8F4W4ugKBe+ZKyD0F6zwV7x1j0fFaB
	 WP91l6wdTihxqmMUGKdT4RsaAvNttX9Nay08ueScQbFFXj5XyRHy7Nx6Y9lOZ/oBf5
	 A9qv7int+Rw6i+q3Dd1eCpNp4pRPA6hapanVoVOi9IMiQjx7hFCklMX3UF6tGg3aRn
	 fATnsf0enV2og==
Date: Tue, 20 Aug 2024 16:24:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] netconsole: pr_err() when netpoll_setup
 fails
Message-ID: <20240820162409.62a222a8@kernel.org>
In-Reply-To: <20240819103616.2260006-3-leitao@debian.org>
References: <20240819103616.2260006-1-leitao@debian.org>
	<20240819103616.2260006-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 03:36:12 -0700 Breno Leitao wrote:
> netpoll_setup() can fail in several ways, some of which print an error
> message, while others simply return without any message. For example,
> __netpoll_setup() returns in a few places without printing anything.
> 
> To address this issue, modify the code to print an error message on
> netconsole if the target is not enabled. This will help us identify and
> troubleshoot netcnsole issues related to netpoll setup failures
> more easily.

Only if memory allocation fails, it seems, and memory allocation
failures with GFP_KERNEL will be quite noisy.

BTW I looked thru 4 random implementations of ndo_netpoll_setup
and they look almost identical :S Perhaps they can be refactored?

