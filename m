Return-Path: <netdev+bounces-181850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F5A86952
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D579A71F3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC472BF3C3;
	Fri, 11 Apr 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdbSxd8c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621D2BF3CB;
	Fri, 11 Apr 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414797; cv=none; b=Z+PdxHpywIU+Yivf7o6eT2of98eDW2F9j0sXV+iX/r3RCqaxl0MX00s9wK4aQ+82CJMluLdkBklOD89Chk44FKHrenXc88a918pFUiDQ0LMCwFS2BilZaa5vVaHbmGCgvbpDReWPobvIlxRq/bfBay/VdWc1zDTiB51gyRXsQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414797; c=relaxed/simple;
	bh=Iub9tIu4lDZSTS4D57n9KDNfEekOGDs0iibxj+YOwbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DG2ijJFTG69qwvUN2HQEddoKm25WNa75ftqYlVe2fLxP9u/K0zMPQ/HI7tyKdtjESHAQZGy1Pl4Ax8u311MG5pD6GrsFGMY1mPG7g9o1QZp5532aRRFx1B7g4YlotweZMc3HkrqyFWWOtvAMKJKl3vrm7oInrrSt8INLHpuS0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdbSxd8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDAEC4CEE2;
	Fri, 11 Apr 2025 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744414797;
	bh=Iub9tIu4lDZSTS4D57n9KDNfEekOGDs0iibxj+YOwbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SdbSxd8cI7F/2RqhuHNdVkUQ/e8fgdtrkwpIGUkfL/3rUbCQX6EzvIyU2fE51OMzN
	 HF7ubfamfiNYZKo/bKLdW0q1WnfSeiAkNxgevwQLQEMSzs7Z1/gmNnfLaeEtWc1hBs
	 5GRX0dxvAsU+iZqWV5wcnIQX5JuOhxjAvgMJ0Dh3rYD1FhBfUGORS/rO1YGd08Hsbt
	 63hgsTdRwEKumgZO6TXjsJ9s8xnJSaad+e911kx9uiYKOVNPVaFGTaPKjGyjfZHBLO
	 rOgHKZa/RxjL+QdKGDq0Lwsf9W55J+6VVQLy1XkEYHa474RzsggU1lHrrJSf2pCEdG
	 wdECgTi3S/+YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CAB38111E2;
	Fri, 11 Apr 2025 23:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-04-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174441483476.518794.631210422314921616.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 23:40:34 +0000
References: <20250410173542.625232-1-luiz.dentz@gmail.com>
In-Reply-To: <20250410173542.625232-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 13:35:41 -0400 you wrote:
> The following changes since commit eaa517b77e63442260640d875f824d1111ca6569:
> 
>   ethtool: cmis_cdb: Fix incorrect read / write length extension (2025-04-10 14:32:43 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-10
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-04-10
    https://git.kernel.org/netdev/net/c/9767870e76f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



