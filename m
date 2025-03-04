Return-Path: <netdev+bounces-171628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF48A4DE55
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB6D3B102E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E47202C52;
	Tue,  4 Mar 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdGdba2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE38202960;
	Tue,  4 Mar 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092600; cv=none; b=knHAGHyEzwxeoYaeMz/6asrLRWwcEK7b1B2I85b6ITbWecGRbYfD7k+/jMHjjVAeXUZCGyipHg7WEyWT/k/yWzH3lvgM//Gog6tF8NU8aqmoPK6VXzTm/wJd3W3Ci3OWidAcfk+9qEK9ZXSO+UjEqG8FRfAJuxYAzdmEE4JW+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092600; c=relaxed/simple;
	bh=a6QinKqDIMkZ8XorkobTU2Cya4t8AO7Fb/SG8uey8X4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=draAn0NfRxQLP0zYr0NfKMXRnHKWv6PXhjIlp3jzh+GvnccLEIfrv007ynV/XD1r0bNs7hatdz7sj4KKxzRSst2fCI7fK9wWFnyRNEsWgPNuBLaG3T0ZrXzZ/uCIggjD76UCTCPgf4K3DPuEnKANzYRNPjCCyFY2PUArTiErlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdGdba2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98793C4CEE5;
	Tue,  4 Mar 2025 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741092599;
	bh=a6QinKqDIMkZ8XorkobTU2Cya4t8AO7Fb/SG8uey8X4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KdGdba2Eq3HpCVBhfsTZUdxakiGRxsbaWuc+WFy95UERKDsYiy8WLsOru8GtT39xK
	 yaol5ItmInR9p5oqS2AmR5dj6vEcz2Hl3YD7dKp8wFNHY0BJAhCNEyBkR6gfkiaPM5
	 DebPl59TAKr7UpYNYUHNXYOX8a2Z8nkVxDPh3tlL9hdhGZAszaxqO0EddI8lpSrfk8
	 ZqJwdjb9ah14gJyna/nYrvrfv2I3jTDdn8ZvaRrIfhQXq/cramirtJ4uUXkxwmWHjZ
	 kQtrqu6TGaCDsFuqMHTORoa9pw68nzhOOJY8nZkNLFDqbDGFzNo92PZuv3Phayd5Cj
	 ZARI66umh2+mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8C380AA7F;
	Tue,  4 Mar 2025 12:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/6] Support some enhances features for the
 HIBMCGE driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174109263250.131753.15116775173435171481.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 12:50:32 +0000
References: <20250228115411.1750803-1-shaojijie@huawei.com>
In-Reply-To: <20250228115411.1750803-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Feb 2025 19:54:05 +0800 you wrote:
> In this patch set, we mainly implement some enhanced features.
> It mainly includes the statistics, diagnosis, and ioctl to
> improve fault locating efficiency,
> abnormal irq and MAC link exception handling feature
> to enhance driver robustness,
> and rx checksum offload feature to improve performance
> (tx checksum feature has been implemented).
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/6] net: hibmcge: Add support for dump statistics
    https://git.kernel.org/netdev/net-next/c/c0bf9bf31e79
  - [v4,net-next,2/6] net: hibmcge: Add support for checksum offload
    https://git.kernel.org/netdev/net-next/c/833b65a3b54d
  - [v4,net-next,3/6] net: hibmcge: Add support for abnormal irq handling feature
    https://git.kernel.org/netdev/net-next/c/fd394a334b1c
  - [v4,net-next,4/6] net: hibmcge: Add support for mac link exception handling feature
    https://git.kernel.org/netdev/net-next/c/e0306637e85d
  - [v4,net-next,5/6] net: hibmcge: Add support for BMC diagnose feature
    https://git.kernel.org/netdev/net-next/c/7a5d60dcf998
  - [v4,net-next,6/6] net: hibmcge: Add support for ioctl
    https://git.kernel.org/netdev/net-next/c/615552c601ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



