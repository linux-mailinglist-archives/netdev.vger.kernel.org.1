Return-Path: <netdev+bounces-154084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974239FB3D6
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08D8166DD8
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14D1C5CCA;
	Mon, 23 Dec 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK5wmFee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AA86250;
	Mon, 23 Dec 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977423; cv=none; b=nJfiO6hzuQiCsj2F6eDZZFtGfrpXFlXPjfv0j/19sksuwDVD+6pEj4DmMnbvgJ9CPpH00VMotvWY8oFCvqv9XLaajOZX/t+KDEYznv1CTBxfBWBqoC69DMA1p7cqc4gLpnT5wjIQ4tB4ydfbvY5OXqrZUL7ezAFbaLWw9Sys358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977423; c=relaxed/simple;
	bh=kMBOYez1tgrB4tT5ZszAHyp+isWYUWXZYtFJFnk7aak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hfwoj1EaE0IS1rV4/HAeix8hEQZstQ2zbF2cjGT+SDOKQYc8p073QfHqE/WZaMTagJJTZcZDX//m7aOKctV/O4xwyqwN6HMdDlu6MpfqX/ImKQcTmHOEHZ+9IDysebsnCacvVvRlElJ9KJlVATRMl0+zOHHETvpOeaLHMbUQ8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK5wmFee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E08DC4CED3;
	Mon, 23 Dec 2024 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977423;
	bh=kMBOYez1tgrB4tT5ZszAHyp+isWYUWXZYtFJFnk7aak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SK5wmFeeUb7ZPa1hbQlC/u2Kjhk9Nu4UNC8hvJ0KBGe6InIhyQazQyrAE2iv5G6gb
	 seIWWTg1kmV9EkuyY4e8J9v0EbSzTIth8MySS0LEPZjarvwte2uRRGzH/s/W48W/he
	 NxjuwC7Mm9hJVSmhXZSGRRkjSBH7umHAJLl4R/1cWgSO0g8bthq3C85C3WJlL5HRdq
	 67mbU5gPZ3pimlwp2bgOFNO5BZAOwpDBMzOT0dM14MUVRPQAUujN3vhBBi8gm35Ode
	 NXgFHlnLccj1l5L0Kc6rBs9mbhEJRwYRSZ1yt9xr2sT3sOnngKWv73/AGsB/ekeCqk
	 zzWf7/fM2Sc4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ED83805DB2;
	Mon, 23 Dec 2024 18:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 0/4] Add more feautues for ENETC v4 - round 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497744174.3921163.12880978370301151615.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:10:41 +0000
References: <20241219054755.1615626-1-wei.fang@nxp.com>
In-Reply-To: <20241219054755.1615626-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com, horms@kernel.org,
 idosch@idosch.org, aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 13:47:51 +0800 you wrote:
> Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
> some features are configured completely differently from v1. In order to
> more fully support ENETC v4, these features will be added through several
> rounds of patch sets. This round adds these features, such as Tx and Rx
> checksum offload, increase maximum chained Tx BD number and Large send
> offload (LSO).
> 
> [...]

Here is the summary with links:
  - [v9,net-next,1/4] net: enetc: add Tx checksum offload for i.MX95 ENETC
    https://git.kernel.org/netdev/net-next/c/d9a093d2d12a
  - [v9,net-next,2/4] net: enetc: update max chained Tx BD number for i.MX95 ENETC
    https://git.kernel.org/netdev/net-next/c/93c5d5a0ddf8
  - [v9,net-next,3/4] net: enetc: add LSO support for i.MX95 ENETC PF
    https://git.kernel.org/netdev/net-next/c/69797ff888d3
  - [v9,net-next,4/4] net: enetc: add UDP segmentation offload support
    https://git.kernel.org/netdev/net-next/c/c12e82c053f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



