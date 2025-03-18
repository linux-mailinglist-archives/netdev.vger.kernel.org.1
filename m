Return-Path: <netdev+bounces-175893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF8A67E1F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A747E188EB4A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8BF20CCDB;
	Tue, 18 Mar 2025 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykzebvhn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4A20E700;
	Tue, 18 Mar 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330563; cv=none; b=YWhOMwWV82fXT4LHWvsn/+lsuibizgBxIguulEIGTUjJiD5cEsM3dAeBLYEAO3oAeD0Nt5qJePHvkKj8m2F+lhxIVrfVL8jiKCOHpVbib0J2ZiUc/wQFcGfjyMQ//awVjdRDdsSiDxaikXEc8nbO5w4GMVgzxL1f+O3QjqkRPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330563; c=relaxed/simple;
	bh=Y0PtWtiqu89GcXRegfPWMhx+gWhEerl4uVPL5dT3JHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G6XkhnNQ9iu/buEOkGjgaY2CvVidGAGiVAbRcnrtof3Ztm9KnUck0YG07DYRUPnF+voPeNTZbRi4dYMc+Wp50C0htLWc1SJJAZl9Ls+M+W25NwiFFxrv7yP5K7Zl9ahRD9IWolfNf8JA436z9sGfAC6AlEO7+q+9tahdBCqh5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykzebvhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE073C4CEDD;
	Tue, 18 Mar 2025 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742330562;
	bh=Y0PtWtiqu89GcXRegfPWMhx+gWhEerl4uVPL5dT3JHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YkzebvhnaeXsaMF0BfIQq3N0XMyZZMta0/xNQUjYs4QqhFjoOlr1Kuk3D/eU+9EVO
	 cjR9W37KfzmJBU4orLCJKypkWuDeI5/HQZLguCJa/Apj2fIqrWA1MLMf7SgMGUaf6v
	 se/vftAq32ys57+tzX4ydGS37uyB8H8U0aD5ulseITXmmKnB5A+cs8Dc8A5jmxAB6W
	 7EJFGOW3neIC3xgVUUCDWsfr3LaaaBGum+6D2w0wXidDvfEqb0P0BqLMiVLTr7MM/m
	 YY8xhKUQXce0z00Judo7YQmvZz1XyH4D571PP8cJLsk+IYn3lWwA38ouS3kXoIfm9J
	 1cp62+IAXIgeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71095380DBE8;
	Tue, 18 Mar 2025 20:43:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-03-07
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174233059829.450362.5092090786343442658.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 20:43:18 +0000
References: <20250307181854.99433-1-luiz.dentz@gmail.com>
In-Reply-To: <20250307181854.99433-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 13:18:54 -0500 you wrote:
> The following changes since commit fc14f9c02639dfbfe3529850eae23aef077939a6:
> 
>   Merge tag 'nf-25-03-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-06 17:58:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-03-07
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-03-07
    https://git.kernel.org/bluetooth/bluetooth-next/c/8ef0f2c01898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



