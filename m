Return-Path: <netdev+bounces-242479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C01C909FC
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A788349E31
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77A28469F;
	Fri, 28 Nov 2025 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxKNHnha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C01283FF9;
	Fri, 28 Nov 2025 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296606; cv=none; b=r1/BJCkJ4wkVvhrBdV9FcsVo9qkHzqMnb+Zl8j4qE4//WzqjNZIjyRyGH6kZ+qkxnbFJClcj9609kWT/gfiquD6iGwZIQE8vOGcXAt6uHhIS4iNrfixbogsVkKni8ylfQccFV1jilVraZZdQ/4n0ycYsTK55puk5k4GeuCUgWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296606; c=relaxed/simple;
	bh=ZVk6JuEZPmmQvkrKU0x8KmvuYrNiqT/j21f2UD7/Sb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USZf195gPV2YSv++bteoCmQwA64RWFAmyqjH91fpn6xYPkV3rxq+7E23XnQBT0rJhcZ365gkVR8wb5inxKZIW4F2Z9wK3wJWufGRnbv0MnzWImShOZnsILqAlFNfxxpaR8e5Za137/6xfZw5gl+ZiK8XkzmhwZpSdbOW7dkjvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxKNHnha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2D1C4CEF8;
	Fri, 28 Nov 2025 02:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296606;
	bh=ZVk6JuEZPmmQvkrKU0x8KmvuYrNiqT/j21f2UD7/Sb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UxKNHnha6+Ym51fSzbHvvLiS2yNBPwiln1emklAl3rFhu/5o0eCTToYQo3HTvlt5l
	 jWgBeNGQ2s29zM7yn4QDOtAZqHKb5gT/hCZMNq739pVXuIIaU2y6NC8/vIsIXmRPkx
	 P0iBkh920LGdegxo6+XHvVLOTkaNFnRBi2CTCWaQgnbX0X/dqIhDjYqNQpZi6XV/71
	 VMHd2RXcBSQgvzHbdXH5oR5hR8DBIT6H0jNMt+vptjqFRzD59tbEd+SNXirBKIotxW
	 SrRu9JRfld4tVqRKKKgYSkb8m8rNPkEo0RcD1U5Vx6YomWHPXnMrcxm4MUusuBV6ey
	 QR2Yq5PYaF6WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7879A3808204;
	Fri, 28 Nov 2025 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3][next] net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642802.114872.7453197941812148270.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:28 +0000
References: <aSfBgwYhRvMe6ip7@kspp>
In-Reply-To: <aSfBgwYhRvMe6ip7@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 12:12:03 +0900 you wrote:
> Use DEFINE_RAW_FLEX() to avoid a -Wflex-array-member-not-at-end warning.
> 
> Remove fixed-size array struct usb_cdc_ncm_dpe16 dpe16[2]; from struct
> mbim_tx_hdr, so that flex-array member struct mbim_tx_hdr::ndp16.dpe16[]
> ends last in this structure.
> 
> Compensate for this by using the DEFINE_RAW_FLEX() helper to declare the
> on-stack struct instance that contains struct usb_cdc_ncm_ndp16 as a
> member. Adjust the rest of the code, accordingly.
> 
> [...]

Here is the summary with links:
  - [v3,next] net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/eeecf5d3a3a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



