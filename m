Return-Path: <netdev+bounces-190121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF43AB53DA
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D4C3A551B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7728D8EF;
	Tue, 13 May 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXDB6Riu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6628D8DF
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135808; cv=none; b=r2v0r1IUUpRrJ2xCJO/m736If/A3aCmd6M6ZabGqP95ftJK+VL4EnKWNgQIu2UWbtV5HAIns6IYq/kWf5NMcuJG2+nxVPNUn4kzSmMsVXWAforbptZVMMYTIjqrUTtqG+NVlohuvcRqipBaJGyMOsCIpd+99pz/CCxV5cZOS7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135808; c=relaxed/simple;
	bh=ZkOoLdkBgVZjErwMEaKxADj2EhWpjd3KLOKD1Bsv2mE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kp3g0YL1wvtx0o0uL4/xqznvoNAx1JVbwZ1649QrqLn/YHR/Ck134zaguNaj13Wf4BGinboCo4J1w/QGD9eF5FT5UsLEcNybRq0RwaHLKGpaHbvATgdyxER/T9N5oS3mgRSFyh8GY6phFJM60Yc4ygF81Js1yx6JW7lF52llPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXDB6Riu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68704C4CEE4;
	Tue, 13 May 2025 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747135807;
	bh=ZkOoLdkBgVZjErwMEaKxADj2EhWpjd3KLOKD1Bsv2mE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JXDB6Riuws10NqmYtLpJgxy7l4BllJvFVutggPq9Qkjk5ojDvTVLNJCY60Cgc9Mad
	 8EwfXXjawwAJUJvAr4hDH4wDW0JvCdYAIrWXS/lk+F1pI/nlgESjT0k6fCd6ZBs9wz
	 OVtnjXalLFJnH6QCo8to0qjmNhxo9tD7ePMBn7ksosb8jczTQ/zj7aefeZAeSgPfpD
	 kU2bmoYibEdCKzujwHXc+NI3OM/QaozxAn8a308epWTLA7Fdu8YRjsrPIYz1afobc6
	 J1WKJJVuOT9jLZIOvQ58W+DvZJyBXOaxGy6hSLclnxAw7YUOoFMw3hwyfSXkL1S6Gb
	 9VH5NjTugLYVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB339D61FF;
	Tue, 13 May 2025 11:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] tools: ynl-gen: support sub-types for binary
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174713584501.1293330.761507551341626973.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 11:30:45 +0000
References: <20250509154213.1747885-1-kuba@kernel.org>
In-Reply-To: <20250509154213.1747885-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 May 2025 08:42:10 -0700 you wrote:
> Binary attributes have sub-type annotations which either indicate
> that the binary object should be interpreted as a raw / C array of
> a simple type (e.g. u32), or that it's a struct.
> 
> Use this information in the C codegen instead of outputting void *
> for all binary attrs. It doesn't make a huge difference in the genl
> families, but in classic Netlink there is a lot more structs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] tools: ynl-gen: support sub-type for binary attributes
    https://git.kernel.org/netdev/net-next/c/02a562bb2b08
  - [net-next,v2,2/3] tools: ynl-gen: auto-indent else
    https://git.kernel.org/netdev/net-next/c/9ba8e351efd4
  - [net-next,v2,3/3] tools: ynl-gen: support struct for binary attributes
    https://git.kernel.org/netdev/net-next/c/25e37418c872

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



