Return-Path: <netdev+bounces-161245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDCA202C8
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 02:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164D81657BF
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD68624B;
	Tue, 28 Jan 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAbOd6uY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A53D561
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026006; cv=none; b=QDnibJ+/1v78pmUuvJprkb7pksq8Ur92qxOxdEXxTKKG1maU9sutJ+mJ0QyE5KK7lTFpJvQbqCfAN44QLyN4sa8cN9fINcquzi3Mt05p17LhwabOLCugrT05omHeg53oQfgegcxWckYRiZ1G6P29+Z6pXyYiB5ffsYfjqYimi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026006; c=relaxed/simple;
	bh=4flI/VEKfhPK+Y1gXBX6Jd1fW+8wmke6bRgeqG+Qv10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSm61rXF6K0GFGNR/IBdZS9zmpTwgqBpLUZnZcr/Y5pt7R2QoOD15NfwKL82yExasQLh7ODxma09ZG8OHg3uaedFiPXjYTpWoEn8vHuom54SAD6gTWoW9Lx0UcxpwqEO2mETtj/n/7PasxXJFwdNTVcPsHC0RoQUoc0z29cWldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAbOd6uY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531FEC4CED2;
	Tue, 28 Jan 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738026005;
	bh=4flI/VEKfhPK+Y1gXBX6Jd1fW+8wmke6bRgeqG+Qv10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TAbOd6uYvuzls1pc+l5WPGh31y/y71R6Bu99EoLtrrchuU/8SGBDlKUKz+yAu4akf
	 Mf6ciR14HYrO6T1ynOGIwkUd+PZLHMDiXg8IpJuTNsWYJZZfWZmMvY021bsJRg3PpL
	 57kq/gqNSxKLTTFJD45jhtVHgc3X2vpXBETstk8Cm2bjSq/sFYJc90cuxsCLoGHMLn
	 +Vb7Kr/j+1LNGReRKNPgNdETCeGY3kU2mwa3l2OL6uMdZ/kx7aLiFT5qYiXQYf7HHC
	 hjZJr7nZIkIGo0q4BaKwBW8feIggOp9F/sl533kt5c3tHpNJb+OSFApWifQ9eiaAYg
	 OF4y97fqVTMmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E30380AA63;
	Tue, 28 Jan 2025 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2025-01-24 (idpf, ice, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173802603102.3279292.13352764610578738388.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 01:00:31 +0000
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 24 Jan 2025 13:32:02 -0800 you wrote:
> For idpf:
> 
> Emil adds memory barrier when accessing control queue descriptors and
> restores call to idpf_vc_xn_shutdown() when resetting.
> 
> Manoj Vishwanathan expands transaction lock to properly protect xn->salt
> value and adds additional debugging information.
> 
> [...]

Here is the summary with links:
  - [net,1/8] idpf: add read memory barrier when checking descriptor done bit
    https://git.kernel.org/netdev/net/c/396f0165672c
  - [net,2/8] idpf: fix transaction timeouts on reset
    https://git.kernel.org/netdev/net/c/137da75ba725
  - [net,3/8] idpf: Acquire the lock before accessing the xn->salt
    https://git.kernel.org/netdev/net/c/d15fe4edd7de
  - [net,4/8] idpf: convert workqueues to unbound
    https://git.kernel.org/netdev/net/c/9a5b021cb818
  - [net,5/8] idpf: add more info during virtchnl transaction timeout/salt mismatch
    https://git.kernel.org/netdev/net/c/d0ea9ebac3e7
  - [net,6/8] ice: fix ice_parser_rt::bst_key array size
    https://git.kernel.org/netdev/net/c/18625e26fefc
  - [net,7/8] ice: remove invalid parameter of equalizer
    https://git.kernel.org/netdev/net/c/c5cc2a27e04f
  - [net,8/8] iavf: allow changing VLAN state without calling PF
    https://git.kernel.org/netdev/net/c/ee7d79433d78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



