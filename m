Return-Path: <netdev+bounces-147265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACF9D8CDA
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142D0B2679B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A431B87EC;
	Mon, 25 Nov 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcp9TNHW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC781AF4F6
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563019; cv=none; b=HBRmQZ/ke6oOw1qTWO+6/0zf7WQbXqlMzuefGUstVmyg9uIT89liL43tcRtEuQicMOCY66/o8QCzIW3OFXVMc4h7K81NeXgcJCNF8AWmDYoQnuM/owXUM2HhEa2sewIVW3IlkjlwBuBz/V7C7i12aQSIDb6b3f9kc+iidUHKdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563019; c=relaxed/simple;
	bh=BUa+AAtCPGOpR7Zfec5WE87hSJyGfwIv7qV3utA9WfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=df0QbtsNEPkxB2fx/qfw8dKgy+sVw4yapHHXINMmTSMMwUnrxuxnmrHzB/U1WoAW76bNhN6DwQv5M5/b6EBqtFEX6ZCStiit1WkShRGP/Lmq6+sMmeHPUw/mZHkHCKUD3wOpmrhYQPuXLhaOsesGLe3fxyju8TwOYVH8+ZfPzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcp9TNHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B3EC4CECE;
	Mon, 25 Nov 2024 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732563018;
	bh=BUa+AAtCPGOpR7Zfec5WE87hSJyGfwIv7qV3utA9WfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gcp9TNHWizg/9XP3nu6yZ/jxZdyRorGfREO8zlioMEZ+xB9zunNjppB+IElD0Cf4/
	 YFQyVle+cd1iG4mTeXKNNLobDUlXR8wZtaAYdxDfSC/Nh++e9rPm01XJTkQdcAtQuE
	 kKruxrRzU53JvkTjkbx4ACXvfDKjSqvMsWdLbRMq7+VAQZZgZgZfb1HGOS/oCVd0Sg
	 WUi0my5dmU8kgbe2ki+8SMW9xyc6mjAAAPCxk/A+T2JiLDloeyARQ3cv+2eVelG4Pw
	 yRjDz9O4FkT1fMwtDmvWKmubehBE1AdfSz6zjIjiuxK7v1lFi3MZhLxuFIC0RD/rcd
	 670t3YYDMY/8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2E93809A00;
	Mon, 25 Nov 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] ethtool.8: document the addition semantics for ntuple
 RSS rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173256303151.4014014.12858260783593414487.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 19:30:31 +0000
References: <20241125181802.8765-1-edward.cree@amd.com>
In-Reply-To: <20241125181802.8765-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, dxu@dxuuu.xyz, gal@nvidia.com,
 kuba@kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Mon, 25 Nov 2024 18:18:02 +0000 you wrote:
> From: Edward Cree <edward.cree@amd.com>
> 
> Signed-off-by: Edward Cree <edward.cree@amd.com>
> ---
>  ethtool.8.in | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [ethtool] ethtool.8: document the addition semantics for ntuple RSS rules
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=f7c3d20307b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



