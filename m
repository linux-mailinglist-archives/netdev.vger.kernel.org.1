Return-Path: <netdev+bounces-225359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBDB92B65
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199EF3B16B2
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F49831B828;
	Mon, 22 Sep 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNkLtF8r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D231B810;
	Mon, 22 Sep 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567630; cv=none; b=VlVYzz51jh0XviXUpOdkTVf7kmUZDtIzwbAkUJeVYYUBmwpu/mnnOfKhB9NO74RwbLCmmeErGQs7nze38AStW3lUElOeyCp6PHoqdg08yXUwJ22lCtPp74uFEV4BoZH/zXYPQNp91fdGsbQ2l5ctTKUVTutXMjGVuUIY1B0Y6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567630; c=relaxed/simple;
	bh=x/VuXV88MHP121jAwfm4jczBNshx9FghhOmT6w6bMkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r6iT7EFD+znAHsbRLU6pKNTCYOusIJoMw6eB72wbUudm0v15/69n31lKVCSeKNKqkRatj6Gyd/6KHHQPEa1afsxyiNxbAOEV1ZdaAqZ7s1snswQAKvGG5X8RFm0FZmxD5dME+8L3CnmKZ/W2Hh7ufGTbDa8oxwygTuTZW6ACmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNkLtF8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC4C113D0;
	Mon, 22 Sep 2025 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567629;
	bh=x/VuXV88MHP121jAwfm4jczBNshx9FghhOmT6w6bMkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNkLtF8rBzz8CmloRoikg6BQN2rnEHR303qBUudL+V3kA0Ce6+EXRhva6vKcdtSKx
	 EiPhGskaDM5kZB1DsW8yeBfBTefhtJO0KQP6ycEdQ7/mXV3FngDUoa55BrG/gZa/Qr
	 C3jFSfjPBh/SO5kD6by35HdKhqhtTQzixu3TU2P+Pn1kATFhsAXFVdEDT7ojkIh6qB
	 eUqiIggjReiwFmj6UufLk7V5pawDasQWOQBk2DOsrp0D6wFY7dD6P+sjWnZ8ktOnKH
	 fXtBdekLFT2D3hg2nnPDNWabcmTtx97DUIcD7mllI8+eAvvF28Zv/TbAgdQDhJ2pN9
	 Dns0TB8b2FtlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4A39D0C20;
	Mon, 22 Sep 2025 19:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] net: enetc: improve the interface for
 obtaining phc_index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175856762699.1122110.3761628175335219202.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 19:00:26 +0000
References: <20250919084509.1846513-1-wei.fang@nxp.com>
In-Reply-To: <20250919084509.1846513-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 yangbo.lu@nxp.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Frank.Li@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 16:45:07 +0800 you wrote:
> The first patch is to fix the issue that a sleeping function is called
> in the context of rcu_read_lock(). The second patch is to use the generic
> API instead of the custom API to get phc_index. In addition, the second
> patch depends on the first patch to work.
> 
> Note, the first patch is a fix, but the issue does not exist in the net
> tree, so the target tree is net-next.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net: enetc: fix sleeping function called from rcu_read_lock() context
    https://git.kernel.org/netdev/net-next/c/26644c90e8fb
  - [v2,net-next,2/2] net: enetc: use generic interfaces to get phc_index for ENETC v1
    https://git.kernel.org/netdev/net-next/c/ac0e650fde45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



