Return-Path: <netdev+bounces-105930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C414B913A47
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0342E1C20D61
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 12:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BEA181320;
	Sun, 23 Jun 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhIsF/aB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B8181313
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144031; cv=none; b=XSL3pJpeP9Ei4zkQDV9LZat6vCxlyhdIQvCCkBBwC8WjlPC1HZ85/9CaKNmZWUXna7sEb8M1aPQHJD+Vg7wgqIOJ3j0rHI/CcSQve938O9sKgCZWydQTd6yYDoKgmJojcpVahsJM/PvLu8croUFaGdNGopPwsKjCLMe/hpgs2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144031; c=relaxed/simple;
	bh=uPppIcBgS4MgM9L+L5Kka4k2NKl3iGWBbo1ELJ1BkEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nFDV1pqXodwSfJaCy/gx1deMlFjEpIInRrpEOcF9hJJDBmQy8KxoRPKXzXd7ZIGIu0aADYoKinEQ/VDqS2ncgd+HkJ4W78MUPwaF6KIXPOTN785q0+VncUxmv/+RZtRDWYtaLP837RQSVkPHky91b9rNCxc0i4kSLgRkBawFxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhIsF/aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D98CC4AF0C;
	Sun, 23 Jun 2024 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144031;
	bh=uPppIcBgS4MgM9L+L5Kka4k2NKl3iGWBbo1ELJ1BkEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bhIsF/aBP7hXFZ+RUICjf9NhRO58RMdTad97Gh/XMsV0XkyoTU6l59EQjeV1I3w9T
	 EOkLHurCFfRKsTA/UTyrqCqOlwyWQpdlJsBzCpOz4JrHzharJengRK9jU2CFOELdtD
	 aUxXOZhYwjFTyAPKvm4mOBO1WYbBTAefRdKGWFsaxhDEI7H6sAzbCIgrS2FNh7YvGF
	 /6HexN3n9aVWyeEkBfSrhTQYfDWKKRkY2W4XXwxW/5tWnD37breoFUWwBUOICNTp5n
	 TIBESAFVCoRemK91bbjSM6uM28WJwBcDuNsoZQdjTODnVUkAd/iSIIBXIq7pMQQT4n
	 swSXL0alHfMmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 620CDE7C4CA;
	Sun, 23 Jun 2024 12:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] ice: prepare representor for SF
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171914403139.11613.1276505969407776187.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 12:00:31 +0000
References: <20240621160820.3394806-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240621160820.3394806-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 21 Jun 2024 09:08:13 -0700 you wrote:
> Michal Swiatkowski says:
> 
> This is a series to prepare port representor for supporting also
> subfunctions. We need correct devlink locking and the possibility to
> update parent VSI after port representor is created.
> 
> Refactor how devlink lock is taken to suite the subfunction use case.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ice: store representor ID in bridge port
    https://git.kernel.org/netdev/net-next/c/639ac8ce8b65
  - [net-next,2/4] ice: move devlink locking outside the port creation
    https://git.kernel.org/netdev/net-next/c/8d2f518c0c9d
  - [net-next,3/4] ice: move VSI configuration outside repr setup
    https://git.kernel.org/netdev/net-next/c/4d364df2b5ed
  - [net-next,4/4] ice: update representor when VSI is ready
    https://git.kernel.org/netdev/net-next/c/fff5cca345a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



