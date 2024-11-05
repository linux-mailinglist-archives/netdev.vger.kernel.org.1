Return-Path: <netdev+bounces-141739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126B9BC28B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AD928339C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75211CA9;
	Tue,  5 Nov 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2M+LW4V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998311C6BE
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770062; cv=none; b=rM8wWR5TpZHr1r99wjXnTut2xNpTfV6p0CiIreN+UIdjIruyrK4K94+zPUT0ld3b3ULzA5yNXrmiCQvEosXLD9ytBgJKzXRa3Yn68WT7TVoZBdDnuu+7ILb/3tyY96DKH8R7NiUQ4GNKXgS82g10sHBNMSI9mkfs7sAeYFrQBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770062; c=relaxed/simple;
	bh=TlgtJoP3hGa6lpGMhOlrhCOzmHqCdm6VdaQVmprRBv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Vbe1qTSx76NtdnW8TOxOxDcsnLRTil51fn8PvcTXDvrdMMxTVQjFF3dchlIXO7XHjR0mWR+OZE3tC1sUKbKvAURKiMMWIg4BFLPVW3Ksxr7jaKfxU4e+dFvnbLplgVrSYh4DDjUy+FrrEYsFo8FaShL6hx4Yb15nUlRXWtoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2M+LW4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC69C4CECE;
	Tue,  5 Nov 2024 01:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730770061;
	bh=TlgtJoP3hGa6lpGMhOlrhCOzmHqCdm6VdaQVmprRBv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2M+LW4VKwhog5UpEEGjBhy7WmVTAwYpOccqodYsLCnxvD20iQfW91407H6WYgR0n
	 islV0ynw4MzBU36WFX7JyeAaZEUyQuj6FCs1qKPBi+sBr5G+WdRWvY+pgd/Q2IK4J5
	 od8Vm2PFJMfUARUhEt2L5ngZIXmHt9uJgGcrb4GgiRkLt0B0CtQensPmlfTPbM0APv
	 q6nZ6eFnPk/y6RIR15ldjAvKVoL0dc7taR1d5pHzwnk7JxPN5sRGEoPj+Av8yZ5Fwr
	 zHzLturFg32gjhzZ1SD/iAzYJ/SXA6mn08tBfvkB3AqoAkQyrhTWwNSvxT20o2IEr3
	 4du/obWQYzi6g==
Date: Mon, 4 Nov 2024 17:27:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, leonro@nvidia.com
Subject: Re: [PATCH 2/2] selftests: rtnetlink: add ipsec packet offload test
Message-ID: <20241104172739.2993c325@kernel.org>
In-Reply-To: <20241104172612.6e5c1a14@kernel.org>
References: <20241104233315.3387982-1-wangfe@google.com>
	<20241104172612.6e5c1a14@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 17:26:12 -0800 Jakub Kicinski wrote:
> On Mon,  4 Nov 2024 15:33:15 -0800 Feng Wang wrote:
> > From: wangfe <wangfe@google.com>
> > 
> > Duplicating kci_test_ipsec_offload to create a packet offload test.
> > Using the netdevsim as a device for testing ipsec packet mode.
> > Test the XFRM commands for setting up IPsec hardware packet offloads,
> > especially configuring the XFRM interface ID.  
> 
> CI appears to not be on board:
> 
> # 26.29 [+0.07] RTNETLINK answers: Operation not supported
> # 26.36 [+0.07] FAIL: ipsec_packet_offload can't create SA
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/846081/25-rtnetlink-sh/stdout
> 
> Maybe you need to add more options to tools/testing/selftests/net/config
> 
> But stepping back - I think it may be time to move the crypto tunnel
> tests based on netdevsim to
> tools/testing/selftests/drivers/net/netdevsim ? rtnetlink is our main
> netlink family, likely half of all our tests could be called a
> "rtnetlink test".

PS. this wiki tells you how the CI builds the kernel, so it is useful
for making sure the config options are chosen correctly:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

