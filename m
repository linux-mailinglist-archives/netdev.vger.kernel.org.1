Return-Path: <netdev+bounces-162787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7333A27E41
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947E33A6A32
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE7222565;
	Tue,  4 Feb 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuaDs3Sy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5F221DBF;
	Tue,  4 Feb 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707630; cv=none; b=kXF3gpejAgkLr5546LS0pN+q88kgWPQR+uE5Z7smMk/fXPv5/BW9j35Odhid6JV+iRsoE5o6KomLjvfVXhLktt2O4ZD4D6F3uIp1aapVK9OuCpwdo5TDXSU3GHkqmFc7KkLbSEtIaHjSoCRon9xKjRGTp/nb+c3jPQE4R1BV4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707630; c=relaxed/simple;
	bh=uj184n3RmJ9V69ZkBYP7GVqlhc21BDoxOFx5nful/AQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qGI4xVEYTuYfQOswVvNeic7zrPf8ke8+A12GnMXz1Y5/rT6jMSg3tLkeivy76Y+HwN/jQbMGo4tFXt8xyjrIkXi65oqbeEhnPno7UMJ51xO6WywADhSy5Qbc8cXb92oaEphyOm42YduZV0Y1l9oFWgBY28Lp5a0Z+Xk0n8/IZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuaDs3Sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F97C4CEE3;
	Tue,  4 Feb 2025 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707629;
	bh=uj184n3RmJ9V69ZkBYP7GVqlhc21BDoxOFx5nful/AQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KuaDs3SyI9HbV9An5iC3UR7lajpJ9sSYGtQVh7anEt1OQbENCogfdXIOhhp53jcvI
	 PZ9bDx4RfDlHXXR+AiTtEvJa2+5+dOl76lxFYEZNjw0tCqboE8Lbkla0kRablFxLB6
	 MsG1ZYYU0V9uoKdXcI+arTkCnrSrKGmvhXYgXRN9JIf0t4pcw/i0jjdv74DqRndjiZ
	 FVfwNnzF98DnILPiSaHRSBkuqSd5qK4JYeZoEkn9YupOm4ArbW5oRz47U8RT+YxJps
	 vAkQjJ1/Sq1tv41DVrvFQjz2bEGllQQIzHst+DY5l/whXVBkurwX1HjT4JJyqqp4J3
	 g7WAciprUwpdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB3380AA7E;
	Tue,  4 Feb 2025 22:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: Remove unused functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870765701.165851.8406378208245756890.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:57 +0000
References: <20250203190141.204951-1-linux@treblig.org>
In-Reply-To: <20250203190141.204951-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 19:01:41 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> mlxsw_sp_ipip_lb_ul_vr_id() has been unused since 2020's
> commit acde33bf7319 ("mlxsw: spectrum_router: Reduce
> mlxsw_sp_ipip_fib_entry_op_gre4()")
> 
> mlxsw_sp_rif_exists() has been unused since 2023's
> commit 49c3a615d382 ("mlxsw: spectrum_router: Replay MACVLANs when RIF is
> made")
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_router: Remove unused functions
    https://git.kernel.org/netdev/net-next/c/626b36727609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



