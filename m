Return-Path: <netdev+bounces-103268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9405D90756D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE24282D88
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788F145FFF;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM+gBcWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A03145FF8
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289631; cv=none; b=fj4BNpHxOkwnCv8/fGCDED66EKXDMrORJIosAFVOSPSXREnec4OrkjQNwwJBtWuSHGn7NRC/8a6uWSKvQfZBUWIln2JE6si71C+OT//itxXvs1KuHer/+LxP9lqOKti0Doh6dHVIgZB9HlI441tVL8/uRRKQ3tU1FPlyCSDEgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289631; c=relaxed/simple;
	bh=iM66ylzEcZVrzRv1i+ybtcfJWjEOA5e229YKJNxWvm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uGbTdVKQ8CnIVXo9+QeJZyhxE0/2fZwPlip1/viZ5oIkSdL2O4PdVAlL1pt+HJxtJ6tBIC/SBinKivTmBfB85phCGQAgIUp6byS0mlRMNSl6K3oKktBxcUEmqrVmZlWbGNptDkgIZ3XXcENJAcpNDhGv0E+JWrBZWpcfEJ0A1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM+gBcWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D456C32789;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289631;
	bh=iM66ylzEcZVrzRv1i+ybtcfJWjEOA5e229YKJNxWvm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rM+gBcWObkp1RXwXob4Kjd0URlpBKT06JkRUyZbwFNiVu/Rdfe9B8XyAqV9SX295N
	 s4yyXAYt7Hbf8by2/6IjPyXwq2kPvx8pewJEd1ufyj9oqVWjQVlIgRB90unpuiJE+R
	 DepF0J9iNW6gnd4NecBdDU2kIL34aXBBiNlzZz2h7m19pmz/3PrBRoE6D2+uCuHv0U
	 vmkEfWTUTnylWLrmerWlFaiCJoP45Vv+4OfZstbgsepbNnIYGIBOLx+Z43zThHbBQv
	 eCCy5h1N2z79F3u1FrCbow9iFAh+j2f101k8Ubcd1khRGPzshQZUPF2MH5z7sDEVE2
	 HZYfbtyU0DSqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FD22C43612;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "igc: fix a log entry using uninitialized netdev"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171828963112.5991.5515276325813791571.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 14:40:31 +0000
References: <20240611162456.961631-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240611162456.961631-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sasha.neftin@intel.com,
 vinschen@redhat.com, vinicius.gomes@intel.com, hkelam@marvell.com,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jun 2024 09:24:55 -0700 you wrote:
> From: Sasha Neftin <sasha.neftin@intel.com>
> 
> This reverts commit 86167183a17e03ec77198897975e9fdfbd53cb0b.
> 
> igc_ptp_init() needs to be called before igc_reset(), otherwise kernel
> crash could be observed. Following the corresponding discussion [1] and
> [2] revert this commit.
> 
> [...]

Here is the summary with links:
  - [net] Revert "igc: fix a log entry using uninitialized netdev"
    https://git.kernel.org/netdev/net/c/8eef5c3cea65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



