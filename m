Return-Path: <netdev+bounces-222882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98551B56C23
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE763B29D5
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46D2DA77E;
	Sun, 14 Sep 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp04hMe9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D80284678
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881226; cv=none; b=dbhl51fCf5H42JKF79ZXDCMgRdWmKaqjh19g6ui8E2pKJ/DugZXAYwoBYwU/c/laW+IddlHNXwukRxF2Y5XSjMgQG9otngD7lSy/jy/2BCgVQXtypi33VWz3j9RMAMrKtxvb2begYWxrQ6G0fynYhqUpWzNx2VBwm5jDmu9jm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881226; c=relaxed/simple;
	bh=1i9PJqb1CBhKNvCU0mmFcZX7zTjOplsF+M9fMriwH/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lpZeBATHexUN2uQ5wvcwLJzy5vfeFO6sB7Kusw/wOb0K+J+/+MTmUnvDgdA3L9ze+JQVjw5AvFb/ksS+1xZkFnLgv2uksjv6fsRtLQa7galutE46pMs0QnD2sT9yIza8O3Odys/2e+mwyyo7xzTbXCD+q+0/qeuR5nyU06W3bm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp04hMe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D9C4CEF0;
	Sun, 14 Sep 2025 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881226;
	bh=1i9PJqb1CBhKNvCU0mmFcZX7zTjOplsF+M9fMriwH/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pp04hMe9fthuQy/040uirwHvMg2+GeL5z1fEOXbFsyDzb8HCOgbkKokcQxzsyBIaC
	 CtKApajcN47vwrFHJNppoAub5xKoOTCqFQQN4B4WJHGWEaicS+Ah43An+bZVVRE/mi
	 zb8sp9S4XrXwZikV8xwphmce5vqJiY/zsOmFAqPxMDwLyzATO7lDBYFX6FD13Eo+ny
	 uucekvfCtMVVxXZ0gZrVbu/94LpiWeQFuPy93pY/SYvK0kiqWOPqtrB8+LLz7ysRcW
	 yAFi4cZ7WkA2WPxmHyDxUd3CeGoQ6qE2iwM7fMmD10fHer7grlpxJW/iyudD6pkUKo
	 9d+WLShZtfrHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEE39B167D;
	Sun, 14 Sep 2025 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] Fwlog support in ixgbe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788122773.3542932.8289747156925490121.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:20:27 +0000
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 11 Sep 2025 14:04:59 -0700 you wrote:
> Michal Swiatkowski says:
> 
> Firmware logging is a feature that allow user to dump firmware log using
> debugfs interface. It is supported on device that can handle specific
> firmware ops. It is true for ice and ixgbe driver.
> 
> Prepare code from ice driver to be moved to the library code and reuse
> it in ixgbe driver.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] ice: make fwlog functions static
    https://git.kernel.org/netdev/net-next/c/c388ea486f74
  - [net-next,02/15] ice: move get_fwlog_data() to fwlog file
    https://git.kernel.org/netdev/net-next/c/ffe8200d5c82
  - [net-next,03/15] ice: drop ice_pf_fwlog_update_module()
    https://git.kernel.org/netdev/net-next/c/ad3b33636f07
  - [net-next,04/15] ice: introduce ice_fwlog structure
    https://git.kernel.org/netdev/net-next/c/daf82b61ba09
  - [net-next,05/15] ice: add pdev into fwlog structure and use it for logging
    https://git.kernel.org/netdev/net-next/c/4773761949de
  - [net-next,06/15] ice: allow calling custom send function in fwlog
    https://git.kernel.org/netdev/net-next/c/bf59b53218bb
  - [net-next,07/15] ice: move out debugfs init from fwlog
    https://git.kernel.org/netdev/net-next/c/dc898f7edd9b
  - [net-next,08/15] ice: check for PF number outside the fwlog code
    https://git.kernel.org/netdev/net-next/c/360c46582e88
  - [net-next,09/15] ice: drop driver specific structure from fwlog code
    https://git.kernel.org/netdev/net-next/c/57d6ec57089c
  - [net-next,10/15] libie, ice: move fwlog admin queue to libie
    https://git.kernel.org/netdev/net-next/c/413cf5db2fee
  - [net-next,11/15] ice: move debugfs code to fwlog
    https://git.kernel.org/netdev/net-next/c/2ab5eb4bf7b6
  - [net-next,12/15] ice: prepare for moving file to libie
    https://git.kernel.org/netdev/net-next/c/02f44dac8930
  - [net-next,13/15] ice: reregister fwlog after driver reinit
    https://git.kernel.org/netdev/net-next/c/4b5f288ab0cd
  - [net-next,14/15] ice, libie: move fwlog code to libie
    https://git.kernel.org/netdev/net-next/c/f3b3fc1ff082
  - [net-next,15/15] ixgbe: fwlog support for e610
    https://git.kernel.org/netdev/net-next/c/641585bc978e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



