Return-Path: <netdev+bounces-105340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C60910858
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FDA2838C8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0281AED40;
	Thu, 20 Jun 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEMmxOsR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7391AED24;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893851; cv=none; b=VmsCKD7eSK4lVFUnOknXewsmuVJ4B8+bIsz9LMCWZo7ojjBpZf95O1ElROWmmgLt6tWSW20qBjZFnYov9w9EyOwjOSt+ZSyJkBci34PJhC63T9Cmg3ZKq/FOP5q0FvIF3BeYzQjqu2gAkoj6wtybj7uMOaPG8B99mKnvv/G9qDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893851; c=relaxed/simple;
	bh=pXaKWo3OGs5awclpHLmalmiSdV1z+4mNFT+a5Q6e25E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oUubGFjUFzZyUrEQ75nrcYYe7ClFlpO3CpxdnT+jaYqJSOzjp4jneU2ZVGKlLtsSbkv9dWCwO7Y36TSUj41KGY/F3IuRsMW44gw2PgCpD4QLOy3ARkQJkvloITFIUWWq79jgOpEG0ryY5mjS920xM5mwdV5ngwn8Qchcr1R9gSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEMmxOsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98B48C4AF0A;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893850;
	bh=pXaKWo3OGs5awclpHLmalmiSdV1z+4mNFT+a5Q6e25E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aEMmxOsRDoc6rzj3gA2uRL+fI9xOMOMmtHV5dtMlfWKUz9qoXFNlrsU3oHdANcOB4
	 ec64y7IuaTI3TgIuv7IJp7tlQh7mDZgm4uF9DGNFlGtX1GpqRHxBPRQNmZ9UwJkp13
	 FYnW4riodUtDCYtxpv1Z5fKCAKPGX9q6tpmD56laFpfut2zyeF0fq/p7A/FpVFMoLe
	 Z0kTT+DBZSxzbo1hxp6FNLjO2dIdbXzJTCvuEmiCl0ZSGNhXk1IOzAMJqxIcyCN9Nt
	 VRg/zKVIxOebwxrrXWary/MjBj3ZXRodvRY7iIo4r0Ldy8YQxS+sRNPMeRbw0es48S
	 qfvpZnNcTcByg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80539E7C4CA;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq branches
 for v6.11-rc1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171889385052.4585.15983645082672209436.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:30:50 +0000
References: <20240612075829.18241-1-brgl@bgdev.pl>
In-Reply-To: <20240612075829.18241-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, krzk+dt@kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Jun 2024 09:58:29 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hi Marcel, Luiz,
> 
> Please pull the following power sequencing changes into the Bluetooth tree
> before applying the hci_qca patches I sent separately.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Immutable tag between the Bluetooth and pwrseq branches for v6.11-rc1
    https://git.kernel.org/bluetooth/bluetooth-next/c/4c318a2187f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



