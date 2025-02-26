Return-Path: <netdev+bounces-169690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD57A453E9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6871217C435
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95383255E3C;
	Wed, 26 Feb 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWHqqlYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F4254B0A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540007; cv=none; b=TgCTvvTZJvA+rTK96X1Zq5/AB7sKk6uaHXZbomsO+3YMmRFZVFY2O1ws4IjHsI4xyjq/vvoVhBgjOgkcex8GH7umutUpYYpqmfm39OeuDSa+2VbB+1uHP0I4F1IFBkB66tD9DOCLXKGHJM/ADkayF8hndDR0L7ZHvV86G03W9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540007; c=relaxed/simple;
	bh=VbCFmxeJx7Ac4nxfBAqnkMyuN/iqSKbYO5JI34xsRT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzNBdZi5nLcOF3h6t7NIJc2QaxP88VcYyIbNSu3CpmapDCw2aDKjF5zbx8vm8hQjTnyP77b1ig9HpW64+5lcVW1nnbmrdhr3r47z+5NEkvcsKsfBucVfXI69syTRFpaq/sI4EEHBH64lA52ETKGzllLyrRIs1jxQuh7OYI99vGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWHqqlYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B01C4CED6;
	Wed, 26 Feb 2025 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740540007;
	bh=VbCFmxeJx7Ac4nxfBAqnkMyuN/iqSKbYO5JI34xsRT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cWHqqlYbJ5jaSxrUsV+Jb4nKM3/9bGhPQvKvIdTPV17Sp01G0cAD3YMxOzSe8Ofd1
	 k45saoNu9xiprR1uP6sAE1EIJAlwu753/X/TLaOSDcFt+CS1sm8ITYiWz7pyQiYI34
	 NDQkflqA24W/OHWo/NCWLyswS1MqRZ4P4+EG3ecXgfgA/ZyVEJdovUPRBndW52k0Dk
	 1En1JU8Hgabs6iv+3dKXox6MPlrf6HXoa0xqPeCfPJIm+t7yxAgixkruFzw6qP9QuY
	 hLRqDZUahz333V/NQh/uN9vl+j+LSutP3IMnqKuQ96v/7urxq6eXPCqT5QLTqwlI2G
	 tGupbJ9x9LdmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC0380CFDD;
	Wed, 26 Feb 2025 03:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-02-24 (ice, idpf, iavf, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174054003849.219541.15972123501420371726.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:20:38 +0000
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 11:06:40 -0800 you wrote:
> For ice:
> 
> Marcin moves incorrect call placement to clean up VF mailbox
> tracking and changes call for configuring default VSI to allow
> for existing rule.
> 
> For idpf:
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: Fix deinitializing VF in error path
    https://git.kernel.org/netdev/net/c/79990cf5e7ad
  - [net,2/5] ice: Avoid setting default Rx VSI twice in switchdev setup
    https://git.kernel.org/netdev/net/c/5c07be96d8b3
  - [net,3/5] idpf: synchronize pending IRQs after disable
    (no matching commit)
  - [net,4/5] iavf: fix circular lock dependency with netdev_lock
    (no matching commit)
  - [net,5/5] ixgbe: fix media cage present detection for E610 device
    https://git.kernel.org/netdev/net/c/b1e44b4aecb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



