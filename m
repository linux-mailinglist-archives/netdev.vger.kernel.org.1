Return-Path: <netdev+bounces-249187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C148D155C8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E52A3036C79
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC7342513;
	Mon, 12 Jan 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quT17+Df"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5307342500;
	Mon, 12 Jan 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251666; cv=none; b=KeT7Pjnf1vvBenjfITwD20uJfQRrul65wPLrEdf0ON08oUQ5MtDDTBpfyjY85yE+B05eQPn52S3O5mkit0W+rFb2/fnEDu9+KcuDDqdH1w4kxDRln2Jc1kJHDCWp66AW0580JpiqSJ8/LpKl+hINJIiia/RAqunNa0e7dAjUEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251666; c=relaxed/simple;
	bh=/u2v7NKVVBXsNYQCcf+lW2DbUdDK4T13jtG974lnPEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K18SUlNRHOCB2hOIoWYXOuQ+K5A7CvOPB6W4pVzCCcqM0wfYIM2Eju2/R+JHuuJXWIKrUgkNaWv9dSJ8pBeALQA1P/yg1IP7/UjSk+rXauM7Qj0Hx9SRyfb1U+An/ZRInbWbwVn3kqa5Nu84AdhRERHEFU2JEexJrBgxWUCdV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quT17+Df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55628C19421;
	Mon, 12 Jan 2026 21:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251666;
	bh=/u2v7NKVVBXsNYQCcf+lW2DbUdDK4T13jtG974lnPEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=quT17+DfjwUZjZUO+l56nIcisGumbQmhvwxIHaGkAA0N2T7aUZcaJfwPfKeSDNjS7
	 3U/oVX+XXuty1yCjIOroyZfHpBzeXrWy+zecN+2cnzS1Qp183K/DgzooDTmen5A3oN
	 Au7OQ8spBlYvk/g2Qr2lU6xv4lb3Sv7iGJgMA+dcaDjaMMdll5fGhVWi6afoeSQS3l
	 Gp1t4OomitG7LE54lkyj6C5ozgSOgo2lQGKyiKnP4I/OcJpzVA6lpqaVdfpUxuDbLp
	 tAqWqHckZ81AVVMbWs0aGyQehQgK5P3qU6hB7yAlyzb5EBTuzQAT++Bmy2F7hMQruE
	 MoQf7XCB3Ymeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79075380CFD5;
	Mon, 12 Jan 2026 20:57:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: convert drivers to .get_rx_ring_count()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825146028.1092878.13721111596542561549.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:40 +0000
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
In-Reply-To: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cai.huoqing@linux.dev, benve@cisco.com, satishkh@cisco.com,
 dmichail@fungible.com, manishc@marvell.com, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 09 Jan 2026 09:40:51 -0800 you wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: octeontx2: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/623b213825fd
  - [net-next,2/8] net: hinic: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/08cbb4a3de08
  - [net-next,3/8] net: enic: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/415a9d10d180
  - [net-next,4/8] net: funeth: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/983d4b8ec519
  - [net-next,5/8] net: niu: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/5baf736ba4f3
  - [net-next,6/8] net: qede: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/a64f302022ba
  - [net-next,7/8] net: hns: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/2103a5ed1b5b
  - [net-next,8/8] net: hns3: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/cf8c4e1f08ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



