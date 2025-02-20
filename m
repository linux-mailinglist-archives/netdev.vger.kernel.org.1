Return-Path: <netdev+bounces-168245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5406A3E3E6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA4319C2D27
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E42215055;
	Thu, 20 Feb 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxD/FvMl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D7215053;
	Thu, 20 Feb 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076285; cv=none; b=YL87Lxf16CqMlHsevnzFUxM7pSVA/o3Y7X5CwOgP9OKUYy8D476YGGRpEk1ZsfXzTpdhcHg89lupozCdu75mPS6Vhdgn5ysHE4B2wn52+rRdG7eWUqUS/NivFVUq+O9JZd5ma0LIp1pePkYE90YizSM+/imci8Iat4+KkBr3pE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076285; c=relaxed/simple;
	bh=4tyF+EZtf5L/DIb2gUDMIhCatiE+IQLemgZKpss+goM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HIh9VCIs5soYcXqi7xrAE6etwfYlGEy3raIBFBIb0Elyw2anLXNfYtynDDCuLigGxTRaGw9h8Lj10g/B7mZ9e9MiiaF3MaNWmHot3WqfZ00dsoNzy04uycXMHUIAsuI0bWGzahJOaSH7mo2uKm+EozEJiry+Px3K1au2mYxqbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxD/FvMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA148C4CED1;
	Thu, 20 Feb 2025 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740076284;
	bh=4tyF+EZtf5L/DIb2gUDMIhCatiE+IQLemgZKpss+goM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RxD/FvMlzuyY7v+cB6kZzocvdznx2vxLYg9LEa8nlpioi9BrCM99PdFG1rlYgGwot
	 oFuUNF5VL5BAXnO8TF5kc5mXYJWZZHXGZjRm46MjbcjPN/X6TPqP0NN7EHuvNUH9An
	 2BF+YvzoTXrhSIsi5ZIDRAX52UBuYhiC3ydf4KyqerkKDRko4uIXPy9Vd6OF+0yhyU
	 IAGsULux7aRJY45bJtu3zos8NeqmTEmh1435301VZNfqmm/S9vJ9hLhLfEleNKcsqs
	 2RZQA5RF+wSgPyZ/dxEDWN87bHWccWTxUzIbGqOKugAWo12oZaN8Dvre7mYHGSvcpK
	 ht6kzSeXJHVUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02A380CEE2;
	Thu, 20 Feb 2025 18:31:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-02-13
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174007631538.1417233.7175599037990273872.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 18:31:55 +0000
References: <20250213162446.617632-1-luiz.dentz@gmail.com>
In-Reply-To: <20250213162446.617632-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 11:24:46 -0500 you wrote:
> The following changes since commit 0469b410c888414c3505d8d2b5814eb372404638:
> 
>   Merge branch 'net-ethernet-ti-am65-cpsw-xdp-fixes' (2025-02-12 20:12:59 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-13
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-02-13
    https://git.kernel.org/bluetooth/bluetooth-next/c/82c260c8806b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



