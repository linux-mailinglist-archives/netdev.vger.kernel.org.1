Return-Path: <netdev+bounces-79321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E05878B78
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 00:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD40B21130
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09E59B43;
	Mon, 11 Mar 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekh67TvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF759B4B
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199233; cv=none; b=YpKWfao1wentUWx2wYigERrrEBeAaBGASyDAI+/0UHQRud4a+DPryINHzpBer65hfOu4AN2uYcjAW6RPvMtW1yWH1boEvaMc8T4d6hjR09aufSoyWC2yiSmdYJlVbFoaVQQrMrOFEehfmlu5EKCUcM08Rw3nrlBypJBZ54n38fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199233; c=relaxed/simple;
	bh=kNjFZaVSzFXIHWXCnW5npiWMUPAOcU1WoSstQFL2Sdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=deg542mkiz/WGltmgh0/W4syVYK5Q/tmEs5NsWBI4nk7CZ84YSs7EaM0Puvg85Tspf1TX4nLC5/Ayu7cL051Evm1TiYCrXdRso+V6f0t1UkExJIeQHxRsfFMnG2YTDzk0dHcdun7LiZoMJvwvMDomBdjPPOIgXPT8hNnlBc/Eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekh67TvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD1F8C43399;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199231;
	bh=kNjFZaVSzFXIHWXCnW5npiWMUPAOcU1WoSstQFL2Sdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ekh67TvRZbt3hyYsq6qhYjt5KW36bFlY7DPcsTnozf/Fr+bhH8oSdgP4OFXj+ocrJ
	 uZocPORLiaJ9Uipst8622h02s48gFfszsEAswXVGZHkyJz2pzBqt7jMrOFMsPNP9/M
	 sjQp1He2ed3MotCp/xvyGg4zgq18GX7wPfF0S3PMS36d/tp3+E/zUNePYOSp4sFWIN
	 gjj7i4ZKDWHfXQFYR1lwoMFxKmhSqfo54WBHq0rAiVMusg8KTxlySGeiAlFg04b06Z
	 nB6sjT7dHdYHZR9xzvyU9X0LjG9uTm45BsaireCTgEF754+CNpQyjiRX8nZCYgUZuC
	 cPRyeP+wEeO2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4621C39563;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] devlink: Add comments to use netlink gen tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019923167.27198.682455526947159595.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:20:31 +0000
References: <20240310145503.32721-1-witu@nvidia.com>
In-Reply-To: <20240310145503.32721-1-witu@nvidia.com>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Mar 2024 16:55:03 +0200 you wrote:
> Add the comment to remind people not to manually modify
> the net/devlink/netlink_gen.c, but to use tools/net/ynl/ynl-regen.sh
> to generate it.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] devlink: Add comments to use netlink gen tool
    https://git.kernel.org/netdev/net-next/c/eaf657f7adba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



