Return-Path: <netdev+bounces-247545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D8DCFB974
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1DC3073E0B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADCB1FC7FB;
	Wed,  7 Jan 2026 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKmVmEFA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5D1DDC07;
	Wed,  7 Jan 2026 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749018; cv=none; b=A3KOMtTpe2fuRTmDi8gvKB+ES651Q/p3FbY+TxcwbIygtBA8mWyrikx0zSxj5EOkBg6ZZAyR9g00iiVIPqxPFF+Z8lUUhLTTah8xVijW5DWjzTr5jjlHyDmbgVAdYce2hlJZymv/qmGYACOUG22ZzMsBlME8j+kL3kZvuR81LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749018; c=relaxed/simple;
	bh=dotjOuG6ppUKuShkbdNj41kB5q26Y+gu03zECLoUz9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o6ZJ/1ycYmNjjbpXiCwMQrNlkphFjiABL7Q6yFBvPfbFZ9tP6teIv9u7/LbCbv++MFJZFlk9BtPEiLIinAc4F9aRXAsTPVsVQrx1Tu843gHI2AlMaLyE13jII3TtahS8Ex1omO2MZXnmQuYAUN2XOUv/Sv18fPFZab/zFy+lvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKmVmEFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3B5C116C6;
	Wed,  7 Jan 2026 01:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749018;
	bh=dotjOuG6ppUKuShkbdNj41kB5q26Y+gu03zECLoUz9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pKmVmEFA+tNG3+8wsdGvNANk+FWfNdX24wdBd4+ArVqH5YEPB4KMpiQfvYUQ9g6Bh
	 iqHuecvsB0KjT/RmW9f4gjRf/B+TJjzegoLI1q84/vHTbtDeKdaR0iXJk0CvT++3yf
	 XwKGrmjOlOEN6WbWeNGymDsVIrjl/oIpPQOHpKt4MJ7572SjTut2HazzRmx2kEWj2Y
	 hqT5ppOUcfOYvULy7N9xjAQJMEvJmlg7R+XDdPifZW1g7UpvDHCy3wHK8uHELyR1Tm
	 aeWOx5tbbXjn0ZnvqusgsxEMOOFOYJ+e0SDUlz6UrdmEMuzBraYdxhjI5cbIdwbhle
	 xmO5Ip2ZuQwWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2869380CEF5;
	Wed,  7 Jan 2026 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: fec: Add stop mode support on
 i.MX8DX/i.MX8QP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774881577.2188953.15980756809721233406.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:20:15 +0000
References: <20260105152452.84338-1-francesco@dolcini.it>
In-Reply-To: <20260105152452.84338-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, francesco.dolcini@toradex.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 16:24:50 +0100 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add additional machines that requires communication to the SC firmware
> to set the GPR bit required for stop mode support.
> 
> NXP i.MX8DX (fsl,imx8dx) is a low end version of i.MX8QXP (fsl,imx8qxp),
> while NXP i.MX8QP (fsl,imx8qp) is a low end version of i.MX8QM
> (fsl,imx8qm).
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: fec: Add stop mode support on i.MX8DX/i.MX8QP
    https://git.kernel.org/netdev/net-next/c/3f049b653450

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



