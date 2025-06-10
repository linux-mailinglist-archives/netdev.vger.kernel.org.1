Return-Path: <netdev+bounces-196391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A261BAD4705
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6682017BAAE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869228C86E;
	Tue, 10 Jun 2025 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsRDB2w/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD261585
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599425; cv=none; b=ozWEwq86KQ1DGTc3FGnHs4ieVxhNAbXGtmvZbyTWPVnoJewW/ryC9zz9EBDU/SFXjib3leN1YNgBPKMMifJW7CNTHbfSOAnnWuE0ist9FOsUFOAKimTx6wUkz5ZUZPpZ+2dBBku56uROIB1tz32tCjfce7NqMay5D8GuhytwZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599425; c=relaxed/simple;
	bh=T9Jv5vbQWDjuGzc6EJZOWsGi/MjfCft9014KBUHiRgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r/q/MG94xVR3KyT8V7MH3L3YkKslh6GUvBJrCDSnTT/Dhz5rspYlS2yWaTbJcAhWq/uL3/QeMPMZsW9SM5NVZ3Ibu67VVtDQVF9f9Kux3miG5qegi0rCSw1YUoLa9zrsgjkdPnh10m8FXnJ4+smvHO4q6dsoQ3/6rEi1OaOZJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsRDB2w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5586FC4CEED;
	Tue, 10 Jun 2025 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749599425;
	bh=T9Jv5vbQWDjuGzc6EJZOWsGi/MjfCft9014KBUHiRgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VsRDB2w/BrLSJSfMAdSfAmh94pK844crKCDsJ7pHElZqKvOQ6XfV20HEGnS8mpd6N
	 KpkpelPDUG63hnBZMAefk+Xq2QgNGw25/LYxtOKOPId4ekCbRFDxeOx1IoSy7GGUoP
	 aLtENXLW9NSmFYJya1NGftuyHSJBdtOm0ariNFlv8yE1HH/BerZ9501tQnDGi8Lu80
	 gJtaNh/CUaHUXVbozfH+cSDibVFQnrjshH0ALEDTpYHAVKdJEDSn2gZwZsOQWQB7Di
	 RLxZzGsGA/rzvs/BoW8ZehRpaOsUxCY5aW9/FkeHQ8xM+MD6H5N6qEQhxXsE9BcPFP
	 89wsgWiXF+IRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABB138111E3;
	Tue, 10 Jun 2025 23:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool 0/2] module_common: adjust the JSON output for
 per-lane signals
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959945548.2737769.5826618253647837987.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:50:55 +0000
References: <20250529142033.2308815-1-kuba@kernel.org>
In-Reply-To: <20250529142033.2308815-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, danieller@nvidia.com, idosch@idosch.org,
 netdev@vger.kernel.org

Hello:

This series was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Thu, 29 May 2025 07:20:31 -0700 you wrote:
> I got some feedback from users trying to integrate the SFP JSON
> output to Meta's monitoring systems. The loss / fault signals
> are currently a bit awkward to parse. This patch set changes
> the format, is it still okay to merge it (as a fix?)
> I think it's a worthwhile improvement, not sure how many people
> depend on the current JSON format after 1 release..
> 
> [...]

Here is the summary with links:
  - [ethtool,1/2] module_common: always print per-lane status in JSON
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=7ca78b77af74
  - [ethtool,2/2] module_common: print loss / fault signals as bool
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=35eb71b00968

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



