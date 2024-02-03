Return-Path: <netdev+bounces-68786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAE8483E5
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 06:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF071C213F7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A51097B;
	Sat,  3 Feb 2024 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuGa69lD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5110A01
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937037; cv=none; b=nQJU5SMsjjlcA870tDvGElIc1Pxl4vCL8mMHuaSWHHQoR9a+38uoFRobSM+wi/zzLuI87L0c9w5Ggh03Q6kCL3dWQfBgFw5qF5LnH04vubXKxKVIHpVJ1DBwzO8xbiM1QJh+nmTbbW5jfCDTqyPj04fMn1o43wz/Kxok9VkjINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937037; c=relaxed/simple;
	bh=7C8oYP4Qj9lcT1oYn+SFdrqrZqAu+qbCP6ySs4/77j0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTtiwRmgxyYS7DhAdCw+9QGMeXaSVi5/HaAR5em7ZAf/2xs/qGb5JMY7CS3o8Hqg0FVcvqEiIz7kNN/hRujSbZTfLV687FNs54AnEyRaHSvVqnP7rOxq6nFgEKl+w2JCmVXtlMZ3wna59R1PzAtF9ueU5GvNKKCeKM3spEmP1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuGa69lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB64C43390;
	Sat,  3 Feb 2024 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706937036;
	bh=7C8oYP4Qj9lcT1oYn+SFdrqrZqAu+qbCP6ySs4/77j0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VuGa69lDhwQd44Os1PGi+K2xgzd7vnF/WnbVosmph2TMXZBriy1rmAnOeNRXI2Aim
	 IAM9UGqyrELDBcfAdnpMVa2oAQ9KoCdAerjmJzLwWEL/iLj9Ckh6kGhfFs5plfGUpj
	 8nYouN4U2+qMkqo5mqnp1Egy9vnVAbgcyQ7kKvOHircNCcn9WMFZXWz77Rj1nEWq6i
	 kVsiZsbayE+co/0ba0JY1ZvTdIa64sLnn2/JVsIezy7MnG79c7lsxe+U9D/BuokEK2
	 kcZeI7RFpkDPEBOP2Bdgu8ixHimg7yGQ8yQoSsRLJ5KE0wJPrINjqEO6itSb12ehSM
	 YLrAvwe7Zsz0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CDAAD8C970;
	Sat,  3 Feb 2024 05:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170693703657.31071.9999883159469578334.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 05:10:36 +0000
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
In-Reply-To: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jan 2024 21:31:01 +0100 you wrote:
> We don't have to store the EEE modes to be advertised in the driver,
> phylib does this for us and stores it in phydev->advertising_eee.
> phylib also takes care of properly handling the EEE advertisement.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 32 +++--------------------
>  1 file changed, 4 insertions(+), 28 deletions(-)

Here is the summary with links:
  - [RESUBMIT,net-next] r8169: simplify EEE handling
    https://git.kernel.org/netdev/net-next/c/f5d59230ec26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



