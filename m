Return-Path: <netdev+bounces-155601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFAA0324E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331B17A2369
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F91E0E14;
	Mon,  6 Jan 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4r7BUgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC741E0E0A;
	Mon,  6 Jan 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200215; cv=none; b=Q/YsjAEEg7tPfylQIgGLPLK14gZr1I8Yn78z0TOxbEbarvQJSJ5rbKpVd0NEDovfr2GCHBj+HvV5gcQ6e/CgihqWuuwwsANADO+LL3rgEHelVfCJXz89J0jgygvm9EYxT8kGKfAwOA+ST+YtXqBTjM+3mrly7BCMFfqFxiQMXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200215; c=relaxed/simple;
	bh=R0r9M5LonzpOpsq/gji7YTTeW+Me6k2FVCsZTHKVObg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+fc1/29hihRntLuVqsdSG2FZXujITZlVKhB05Sowhj53lu44CuX/X2ol4K8X+0gRFlNoydp3ZovthR+5tMxnpmjxoNREa4S8ZHFrn19kz7tBtMm0CI6dm1+atrGfZ3SKBwgY/92NWZtm5R4d9Ifq8HUCgROW8FdxbSlGtbYW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4r7BUgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54241C4CEE2;
	Mon,  6 Jan 2025 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736200215;
	bh=R0r9M5LonzpOpsq/gji7YTTeW+Me6k2FVCsZTHKVObg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s4r7BUgyTrHVK7VhEvW9W6TePNY6fZ47gPLAVX8+3+Fyt/MFxBmGVEt5hKGi/KM8F
	 jHotgaYsi/2OunpXhWQQfxGbFeWwGNU98I+dmLiBs8KGoYfEp2vi18lwxmL4h+CrQ1
	 bK3EF4rZBd5UXyGl6ujOJRPZSDFzyH7P9Lb6zHqxtddMD/AVUtMCO67toDQD96Zv55
	 d1bQzrZraN9tK4lVw37wFBq3o7Yp0VUyac8aIjqmTNKp4BWzqnXIhssgIEcHRmzbon
	 C1Z1VFlYEdyat5FU1Z2AmNziWmN+maw+LPSYO9Q+TPHIJPG7cAeDiTF9+NUknteXPu
	 fLh8NYrFxxjdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCDB380A97E;
	Mon,  6 Jan 2025 21:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] igc deadcoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173620023624.3628195.9876367005194137334.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 21:50:36 +0000
References: <20250102174142.200700-1-linux@treblig.org>
In-Reply-To: <20250102174142.200700-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Jan 2025 17:41:39 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This set removes some functions that are entirely unused
> and have been since ~2018.
> 
> Build tested.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] igc: Remove unused igc_acquire/release_nvm
    https://git.kernel.org/netdev/net-next/c/b37dba891b17
  - [net-next,2/3] igc: Remove unused igc_read/write_pci_cfg wrappers
    https://git.kernel.org/netdev/net-next/c/121c3c6bc661
  - [net-next,3/3] igc: Remove unused igc_read/write_pcie_cap_reg
    https://git.kernel.org/netdev/net-next/c/c75889081366

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



