Return-Path: <netdev+bounces-127671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928B975FDD
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 05:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9E1B23193
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 03:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8D18858F;
	Thu, 12 Sep 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfcRCl3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88097188011;
	Thu, 12 Sep 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113033; cv=none; b=gzrq0COsL6XNC0GAKomQKmMnCiJYfRvX9+uHgx8W+OpgSxp07JInCqp0Fvr/VHYloXHwbcUQkd+5gMvVJmjkLtiF9XvFK2zrmjy04B7825EGjTfsTzqOGpNY2ON5c8Lqgx1+5uI9DtrgYz+IudbDLqNIAS2vCsRfRI1NRiJHolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113033; c=relaxed/simple;
	bh=PQVQ2QoG2l08w+0PquwXYn7rxnB2HnuCoyQH5Cyjfuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P/lFlC0RGKQdObErlgQoZflkA4+FG39Yj/bA6+mOHoH1jDZJJb37EBq+tDA70ubsSaJXh+0CEGBkPqtZC/kAtDajaZzZHb1bvYPZm0QcuMR235nhgUXxwcKiEtB1L+RxijU7wtnyxKO4tAMPHHOKSNx3AUufp9eX9IgmxXr7iRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfcRCl3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EEBC4CED0;
	Thu, 12 Sep 2024 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726113033;
	bh=PQVQ2QoG2l08w+0PquwXYn7rxnB2HnuCoyQH5Cyjfuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HfcRCl3GfPSJ3KMseP41wYpFMoxEh2A5HSmMf/S1uFMCyuoad7FuZIuE+xRgBNk/a
	 n8QclDbqBFIb3aHEM+v+/yZl/HcbGB2mps8vNKsRa7MydAV0fAkEYEg17FqffRez9o
	 BsYZKHXWAYuS2olg9DLvVHjjb9TsdZmEw90td3tdCJzNl4wDFMUrUE9Vg3pTLv6Bp6
	 Wv/nm2OJToKQaqxmNkPlymOBGpJnMXhOpEXCxg98KfIyRr885CgCCthWjhc7XGWTu6
	 UHsJz8xFrwJtZmnbzdI3j18fthLZBmi57Ml7sbqnVncEUB8FAkv6R4m2yK8jiWiBqy
	 ed/yjShRLoPcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E313806656;
	Thu, 12 Sep 2024 03:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: mptcp: fix port endianness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172611303400.1155279.3458912895537245634.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 03:50:34 +0000
References: <20240911091003.1112179-1-ast@fiberby.net>
In-Reply-To: <20240911091003.1112179-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 donald.hunter@gmail.com, dcaratti@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 09:10:02 +0000 you wrote:
> The MPTCP port attribute is in host endianness, but was documented
> as big-endian in the ynl specification.
> 
> Below are two examples from net/mptcp/pm_netlink.c showing that the
> attribute is converted to/from host endianness for use with netlink.
> 
> Import from netlink:
>   addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]))
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: mptcp: fix port endianness
    https://git.kernel.org/netdev/net/c/09a45a555379

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



