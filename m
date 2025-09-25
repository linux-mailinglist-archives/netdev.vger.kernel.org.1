Return-Path: <netdev+bounces-226149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD8B9D005
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2502C19C5FFD
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08892DE6FE;
	Thu, 25 Sep 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS7BPhCX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E32D24B3;
	Thu, 25 Sep 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763212; cv=none; b=R6m8zYWIH5ZfUX06EbKKB2FoLNpw1cnX30dvFkDbuCcWn4rT0HrZO+R9i+LhTjDsyJqQ8VZjy5huL3yV25Ym/w17Q80ZXioKMw8yr+HNxZEZRrkHS+gYFhzxz7mDFsjEPyJil8G4VLzuDNc1MCiFxoVgJLxRHHqeXp2TxyuJutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763212; c=relaxed/simple;
	bh=AArxCF4Hh1ss7FRtdVBzg2C5dHrMKLB2HNYexZgRH3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SMkz9rVjhzuFhQNcnJ8weeIInXU0EQis0js68J0VH8ccVplgjEEdJUtBsLgU5sKaquTf0XdPX00BgTEoDjFx0MkaBX/DS/49NWTQIrYBZ0l4R/uT9/cOowNxJcKlUlPzwSnoB1eZHpYTJMyAt7h4dcIOs6KNmjXbFs0tMlUalSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS7BPhCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29708C4CEF0;
	Thu, 25 Sep 2025 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763212;
	bh=AArxCF4Hh1ss7FRtdVBzg2C5dHrMKLB2HNYexZgRH3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YS7BPhCXvgg53/QRdSDJifFMqGzMPF++9n6elpnSNZ2DQAuvGFxOgcmA9P2C1gFGX
	 zRs6I967q1+id1xpDILe9FY+nITuybp1IcVi0GlRaum74L7MPLL1PAm7atTL+1Rv2b
	 VWDZ92DWXiFhw2htTr4pbWin+pZ12SxrNbYjvbZbseFiXQ2o5aOWQyLHA1c27E2eGN
	 wRBrckdJ3dXyPttxgJrWVugkpiJW+LuoKbvDKv0ucZcwu2ksbAdsn70H5r4nTp78NQ
	 PEc7WzeHFtoj6ni5lsnGzSrlOSzjI8b1EDST3ZIEFlkvqVKNOhZITdQs1/mr+vencN
	 aPcCviwlvS2Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2F39D0C20;
	Thu, 25 Sep 2025 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND] Documentation: rxrpc: Demote three
 sections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876320849.2768103.12252196722456540227.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 01:20:08 +0000
References: <20250922124137.5266-1-bagasdotme@gmail.com>
In-Reply-To: <20250922124137.5266-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-afs@lists.infradead.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 19:41:37 +0700 you wrote:
> Three sections ("Socket Options", "Security", and "Example Client Usage")
> use title headings, which increase number of entries in the networking
> docs toctree by three, and also make the rest of sections headed under
> "Example Client Usage".
> 
> Demote these sections back to section headings.
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND] Documentation: rxrpc: Demote three sections
    https://git.kernel.org/netdev/net-next/c/5de92bd0d754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



