Return-Path: <netdev+bounces-156522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4DA06C59
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE145164199
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B62156220;
	Thu,  9 Jan 2025 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtKCT3Q4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B601155744
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394009; cv=none; b=Bw2gXEEZEd2nJG3zR0IBIKA3ly1W+UA22caOl9iRMDN5rl20ViEgKcwPqwurlvldEPFTeqcgRDhMNmA+XVKtXxIr7MgQAsg1eaa6HReLi+vgJ/XN570lrwYGk5TR/qTsw/YzWOiyvvD74oZfacXbqZ4ZZYrGMzGr5xm4148COJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394009; c=relaxed/simple;
	bh=u0arFl/qOQOsk33MLA2ENK0kTx8k8CbKbh6Sq1FxgVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3+ic8Ncn9lWtt6mixjBNLk7EjAp6WHUdoWwmd4Vx3kxdQIdA06EpzGS2x80bV7hJMdMvvNCdnIhUzrYkqfgvUWD6t70uN8LKfWXx2/XEnooS/Yx5X2qaDnpthvp+Fj4qiwOAAlDTld69hP0fQ47qvTu+0v+bjSwQEeBwoKVZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtKCT3Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F998C4CEE2;
	Thu,  9 Jan 2025 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736394009;
	bh=u0arFl/qOQOsk33MLA2ENK0kTx8k8CbKbh6Sq1FxgVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LtKCT3Q4zkEDy+8LGwewMQ2UAvh0rH/O6tNqFZpoz9IZQb16iEG8CxIaLdmicwp0Q
	 BBMyyKTbVSmHiWJj4QaY8KL4P6qeyFf0Hhz2HlKtGejedQ8T8LqAFcTwMs3XwOGH/L
	 roGkxQRuLJFUuVlOZFuqdejMrXxDKdpm95J2XGDTQ7ZOb0SsgXqwmYqVEyQbj/45dy
	 l+qqoxaOT5+gAiRnbal7CBsekJ6G5QQJpUi7D/++6t2WbUFTy9ggeN6oGjy/hJgO6F
	 WdQrpx0k1X1Sd8/PQm3IyVhXqtdEHDAtgceIwL0d5Px4b9ijnXpfIaeFXpOXc0NYsm
	 x27IuLFZCx77g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAB380A965;
	Thu,  9 Jan 2025 03:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2025-01-07 (ice, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173639403053.861924.14818642283159680442.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 03:40:30 +0000
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  7 Jan 2025 11:01:44 -0800 you wrote:
> For ice:
> 
> Arkadiusz corrects mask value being used to determine DPLL phase range.
> 
> Przemyslaw corrects frequency value for E823 devices.
> 
> For igc:
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: fix max values for dpll pin phase adjust
    https://git.kernel.org/netdev/net/c/65104599b3a8
  - [net,2/3] ice: fix incorrect PHY settings for 100 GB/s
    https://git.kernel.org/netdev/net/c/6c5b98911608
  - [net,3/3] igc: return early when failing to read EECD register
    https://git.kernel.org/netdev/net/c/bd2776e39c2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



