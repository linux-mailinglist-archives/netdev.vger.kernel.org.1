Return-Path: <netdev+bounces-138573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459919AE2C8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44421F22C45
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C931C4A23;
	Thu, 24 Oct 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM3m4WEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE51C07D8;
	Thu, 24 Oct 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766423; cv=none; b=eHbNJoHDS8iaRgWvPpS91D8tc8bOt9GlDs9BFU6j9doqyEM0AU/rkaSARiunVtDnG0vJDGxeqE9+sCJO6jdc6hjW4nNyzwXCQ7dhfYMR5yCQyTSFtXOocaatm3I//fu65ZTKZgmjYeKTsNFmFCSJ9eojxpxNXjuTz1kdta7mmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766423; c=relaxed/simple;
	bh=NqWjKQ1C2jVEQ51CsKa3uP+QnimsgUPY695hNwSpy2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PcC8u2RnCJJx1TJT26wOew9YEELba7K6fUyr8tvhy2SyveRr3QG40d3Eo8xyaZzdDjbDgFY+SzzZsYzJjwJ1DIBJglxqIg0npmJTX52qlcoX3dCnhs6g38AOE3xE4395iLuK3WfcS0bmrhZyMuyZ/aaaMOwXgFVXvPi4D/Bl1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM3m4WEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1998C4CEC7;
	Thu, 24 Oct 2024 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729766422;
	bh=NqWjKQ1C2jVEQ51CsKa3uP+QnimsgUPY695hNwSpy2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mM3m4WElCx7Shx2FGBGeRiMOFiveQrK18Ud7xL7fwS6c6I4qqloWgGAhdtsWlagYt
	 DcS1yukxDASDHwml4pHI+FZzVYwmaD6YUQfK08rPlHO9CgFkg0GGcUiR1dZAHeefXY
	 1qx3RxFC9f9dw5KCCHynXu5eM/qrPNz4J8ZrEVUwMm433i9vE+4BGiSZVoFowCsqk7
	 tHckh7KY0QvxVdwHOt+695VtIUD4zo11gVWCT9j/eydrSqEQn8idNpVAlWZuZ8+kI9
	 MUuvJc9MDb/war2RlxjKaBO8P97S6brw1BjLsY4mtESlOxuRcRViyyjXFr9XBnhRM7
	 idS3x9AJaz4kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC9380DBDC;
	Thu, 24 Oct 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172976642926.2192492.12593037734391391394.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 10:40:29 +0000
References: <20241023143005.2297694-1-luiz.dentz@gmail.com>
In-Reply-To: <20241023143005.2297694-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 23 Oct 2024 10:30:05 -0400 you wrote:
> The following changes since commit 6e62807c7fbb3c758d233018caf94dfea9c65dbd:
> 
>   posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime() (2024-10-23 16:05:01 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-23
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-23
    https://git.kernel.org/netdev/net/c/1876479d9866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



