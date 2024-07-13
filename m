Return-Path: <netdev+bounces-111300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C09307DC
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4699F1F2199C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E114A624;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EojgsOhp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF113D881;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911030; cv=none; b=iuHBDKBqvNzZzhsnJd9uPmd7abKSpfo953Gc7sZjGqaJWZUkBAl15gr89Z6mqcXyyyL9LvFIaUsD9X8BWtA8S9urHRnS6m34owdjGuCt5N7O3DSIjid3zCuFjf2rhDPG7QlF1Kaf9Le4Q5pWvkRlKKxu5JsB9xDs7A6CRClDCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911030; c=relaxed/simple;
	bh=e47nO6hsmSNbPmkiBxViJcHcd37trZNLi5Zkg/LaV78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dah1/xAsaTtq3xntfpIVw63Hfwfvv7TD65MJuapQG9zwv9AIc/kM0js5yHDuL28IRRBM87KPwDE1p9IM+K6t7IZRJyILncc3QO6YGq97+uMGznpxyd88yBT4tVVDW/A/pc/QoDrKi9prFBXYZdjS0648XjQchY4RL2zHk4wn0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EojgsOhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E9DEC4AF10;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911030;
	bh=e47nO6hsmSNbPmkiBxViJcHcd37trZNLi5Zkg/LaV78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EojgsOhpV1zNOsxMFW5FVeqdLQpnMJbsRWbL0/7Pyj/3yFsYN8ztB7d9rEUk0zVwN
	 S4Ttsoo05WO4gXLdKNAl0cA98ssJL18AZij71IjQ41x86gVRw/r7JGoF2FUer141ob
	 gH2QYsjRlEIpsRzYgj8E5AnZVQe0v6iDV0W/Bmi/4KO7Qsdm6YmpFAf5PsEix0jAZr
	 ymApb2F3dDXNX1F6K355SJg0S7J/u//5MEqWya3uqdS2HxKNPDoIcwTxNs9RAY5mKN
	 KxR5pHhb/iioXCsYhoick4f3EaU4Aapo36LADUfwX+o6dlh8Rziq3kVrQ77r2jyeX+
	 G/IsAAZPa6aIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC42BDAE961;
	Sat, 13 Jul 2024 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: Monotonically increase the message
 sequence number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091102996.32137.16513833581251462374.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:50:29 +0000
References: <20240711080934.2071869-1-danieller@nvidia.com>
In-Reply-To: <20240711080934.2071869-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, petrm@nvidia.com,
 ecree.xilinx@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 11:09:34 +0300 you wrote:
> Currently, during the module firmware flashing process, unicast
> notifications are sent from the kernel using the same sequence number,
> making it impossible for user space to track missed notifications.
> 
> Monotonically increase the message sequence number, so the order of
> notifications could be tracked effectively.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: Monotonically increase the message sequence number
    https://git.kernel.org/netdev/net-next/c/275a63c9fe10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



