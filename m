Return-Path: <netdev+bounces-84260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823EF8962A3
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E268BB23DA9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482A18EA2;
	Wed,  3 Apr 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e99RjsCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2E14F70
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112031; cv=none; b=d6WmUbrtS+tfej+Fi8TG4eDTKTFs703pyGLxdBJ6nY2EkEw8kyXFdnwOg6kIuDmdCbSVLtBla6HxKu4IhuEJIrlH31F0YsB8ptIsVM2fawA/ujvxGx90sL+qTJwBRNCjQkquRiZ6CdXw0Z6Op0p16esGT46amJod5vWqgzsPqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112031; c=relaxed/simple;
	bh=dXqM/2twPdXlQHi7Zc6ixK541QFl9i/ceqKikw27u/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oGan9T5WC7PX0rdES5Z59XKZuZ2lgkS/HYbkz2CSjkPFiBPTb1epnscHvsMcYhUfhvtpdNxSAklezRvbOPh+b+gXEQnTkfznAYTVpwQ6MLF1vpx8YucQP6DBYmH2kI/yPyq7mMGmUtJDVQkrmdjkrRfplDxR1PEHCimaJ4Jxs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e99RjsCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E7FFC43390;
	Wed,  3 Apr 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712112030;
	bh=dXqM/2twPdXlQHi7Zc6ixK541QFl9i/ceqKikw27u/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e99RjsCyxCtLZDKI0zIgkp4yjrJoGiZn/bM8WpnnPTMHTTrvjqlm5+Fc9kdOBkmFw
	 adhZrnykeTQYtTJu+RqqtNdCjX3iXDXVyxqXxymq6VO/+8YWO5aJ/EzD9xtPuI+zf4
	 Lw14tvc37Q2yTjV6KJLySGon/4D1EAbdZRqSPdBunoJkqD8fIl9XYS7FsDvo1M6jNf
	 R7uiyMDViu8utFjlwDMo5gAbJ5wfkvdzIXNKCkPtrcZQQd3k/wf/CSfOdkY3b+mED9
	 6tZ7gQ9g9N42qUgFpFUtqUEyoFj6CQkmh6We/NlAxCZu3/O+UUoTC4GnRTML3yUCTE
	 6jbQRqq4a8EmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F6D9D9A155;
	Wed,  3 Apr 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] Intel Wired LAN Driver Updates
 2024-04-01 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171211203058.15246.14431368905400570869.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 02:40:30 +0000
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  1 Apr 2024 10:24:10 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Michal Schmidt changes flow for gettimex64 to use host-side spinlock
> rather than hardware semaphore for lighter-weight locking.
> 
> Steven adds ability for switch recipes to be re-used when firmware
> supports it.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ice: add ice_adapter for shared data across PFs on the same NIC
    https://git.kernel.org/netdev/net-next/c/0e2bddf9e5f9
  - [net-next,2/8] ice: avoid the PTP hardware semaphore in gettimex64 path
    https://git.kernel.org/netdev/net-next/c/d29a8134c782
  - [net-next,3/8] ice: fold ice_ptp_read_time into ice_ptp_gettimex64
    https://git.kernel.org/netdev/net-next/c/22118810fc7c
  - [net-next,4/8] ice: Add switch recipe reusing feature
    https://git.kernel.org/netdev/net-next/c/95ad92d687e7
  - [net-next,5/8] ice: Remove newlines in NL_SET_ERR_MSG_MOD
    https://git.kernel.org/netdev/net-next/c/e6893962ef0e
  - [net-next,6/8] ice: move ice_devlink.[ch] to devlink folder
    https://git.kernel.org/netdev/net-next/c/0545cc86767e
  - [net-next,7/8] ice: move devlink port code to a separate file
    https://git.kernel.org/netdev/net-next/c/4ebc5f25d081
  - [net-next,8/8] ice: hold devlink lock for whole init/cleanup
    https://git.kernel.org/netdev/net-next/c/118c6bde78fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



