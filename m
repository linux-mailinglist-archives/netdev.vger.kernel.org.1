Return-Path: <netdev+bounces-189945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC029AB4903
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A28619E4A5D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E71991B6;
	Tue, 13 May 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f98Xznqg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B77198E9B
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101591; cv=none; b=LrYTU903B8QjLHSMyX5VJz0O7pamlrXuYpH6mb/LZ1L6eJwM3uzvO8rz2F54lF4EsSWA879zzDCqeO7GbFtfMeMd4C5QBHg/zsCpwRgWHEmPlPL4Dg8RjEDm3FHWldR9WH6axCGXhI86t8n+gjd+nCg7jpK5+/JfbnCe8FM/1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101591; c=relaxed/simple;
	bh=ziC4yV/WWraR7y+E07KquIEXLrjPnAnhLktYtlubA5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kmsahhjr/fgJ9HF6UbPVi9ysyM8UyTqpn6u7BGYeskIYs53su77n7gv7fiXlLkMXlsuqiZFF4Zk+bgK9wsJUpr8V1I3dqHgvSQr9HLbq1Ulku4JBIlheAL2mynvpz9jikUNPdljclYfhi+79+Y1FEiIyRtc/CIy8oOb43mFQGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f98Xznqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2D7C4CEE7;
	Tue, 13 May 2025 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747101591;
	bh=ziC4yV/WWraR7y+E07KquIEXLrjPnAnhLktYtlubA5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f98XznqgEfuwA8FWuDEtVHzwEA65Vn/wgxDXR5NWGRT1cB5XpbcwrXuufHn4tzLoR
	 SdQ2ghgWeuWmgLR9cqsR/3iG5VnpkC8+bhvlgqssPWzWljAaJY28/9rbATnUy6/c5k
	 AZAAzSIV7hLBVMgmYKeJfEiWCN32kQZjIl9JWLBXQ9FvvCyVrckBa+3o9i7D20MzXD
	 As2ZzqfuX6ZyJO9nkJlf0Wu8Rf0Bbnd23yKpf2Oi3JAp7IFGsBuGJuecyuGCQRRQKg
	 fynJH0aaM4muw1Fg8bMT0LxxMs1KADWaFUZWue5MgAiCt+2ip2OEuU00loIzZOH8yZ
	 qD0ArhbTQJfNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC7D39D60BB;
	Tue, 13 May 2025 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: Lock lower level devices when updating features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710162875.1142511.4425627572918409051.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:00:28 +0000
References: <20250509072850.2002821-1-cratiu@nvidia.com>
In-Reply-To: <20250509072850.2002821-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 almasrymina@google.com, saeedm@nvidia.com, tariqt@nvidia.com,
 dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 May 2025 10:28:50 +0300 you wrote:
> __netdev_update_features() expects the netdevice to be ops-locked, but
> it gets called recursively on the lower level netdevices to sync their
> features, and nothing locks those.
> 
> This commit fixes that, with the assumption that it shouldn't be possible
> for both higher-level and lover-level netdevices to require the instance
> lock, because that would lead to lock dependency warnings.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: Lock lower level devices when updating features
    https://git.kernel.org/netdev/net/c/af5f54b0ef9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



