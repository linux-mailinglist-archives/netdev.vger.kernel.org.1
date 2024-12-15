Return-Path: <netdev+bounces-152032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8AE9F2667
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00461884DBA
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814411C460B;
	Sun, 15 Dec 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtvvh7RM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81A1C1F19
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300013; cv=none; b=EkGbxUrtvg8zzBkwBJY6NRPuBly+DdAfXvrv6gys+4x6IU/dkOkKRcGl/7fF8/dRJZ5FsqwrsoDW0sSV3PIW+cjv+1dbISPidEoLc2H+P0ZMLNPMJHS9fNoSWA07RgGq+y0orvAnf9Osl3wv8Fs47UqLaMul1PZ22/+/7CTQwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300013; c=relaxed/simple;
	bh=kB3XfMQ0tcMDLTFNrlEH5KDKJPpeB2l+0o/IzTD1jT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqHTHAY8mSwf2Q4qhRlg//HP19IR/BU4DXWbpNjv/GxnIjHtvWP19grrt/BrKUIUuPdfw2vgBzmSd7tuB+lbimMEHWyXy5VYPyRG2oGrJJp2AtYcrRXaagkun/FFI1u1Kym9fX5EnpqKtYkNgeW43FmVQoMaFOVD2DBe7IiJ5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtvvh7RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38A5C4CECE;
	Sun, 15 Dec 2024 22:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734300012;
	bh=kB3XfMQ0tcMDLTFNrlEH5KDKJPpeB2l+0o/IzTD1jT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vtvvh7RMrrqrKG7KBPGEwsMSvGbOmc/c110g9xS7fHtm7jIK8zApLaQPPDPYPM55L
	 5lg8p9110lsU94efg3MbqNSB/TYOtdnT2sTOHSfdARZpSCOwWfcoVDs6iVr3IItcTT
	 uJ8FD1E5PesFXoc51PND0X0lyiIsgy6UB+mGQifBBo54PrUv5DJbe4oiWnhAQkZfgJ
	 nc4CmAYFB75iP7dKIH4qZxNcocPJBuZks/0MrvAiZR2vDrLfm3gQkbpTDM7HCByLJP
	 KeWTAvK7ijyldEczfQWZVCwj2XKx40NS6j4FWgslh3lurzJGA8soMvnM34C7+u9VDp
	 wPLhKo5uJvdgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0463806656;
	Sun, 15 Dec 2024 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ionic: remove the unused nb_work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430002974.3589621.6483305575827763574.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:00:29 +0000
References: <20241212212042.9348-1-shannon.nelson@amd.com>
In-Reply-To: <20241212212042.9348-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 jacob.e.keller@intel.com, brett.creeley@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 13:20:42 -0800 you wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> Remove the empty and unused nb_work and associated
> ionic_lif_notify_work() function.
> 
> v2: separated from previous net patch
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ionic: remove the unused nb_work
    https://git.kernel.org/netdev/net-next/c/a63bb6953966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



