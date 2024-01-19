Return-Path: <netdev+bounces-64307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F4832340
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B6EB21FD4
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA329EDF;
	Fri, 19 Jan 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTKUA2RS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455110E4
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705630228; cv=none; b=F6gpjD9CCvofSn4Cpo21F/MK5WhhiE/GDw4LEdKvnsUDmJ9n+9SIn/JeQxoyj0QNbemE5XoCf8CYM1ljuL+M2c5+cDCxADKpVJoTRGYFBeAnh+4QAQU8bMFjkm5jWwvpjgE8756z8P6YAOktcQkSlMx5LI+DpNnvvX/2VEf9VIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705630228; c=relaxed/simple;
	bh=yBWPRuj8IddoWrTRRiSc5MshF0E4CK46lWrZGy6WwHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIU0VESR68F2vIoyc8Vdb06KjP8gSiwmn3RHnxKgaIgjIaRumJLkzZUTT27Wj+QOqcRXTPNt1yZSIznYWObXTZq/ixBuKf7pkrJX3OQ+A+B0wrfvJ2+fbkWt3rsEXTTwOhdF6F5G22KIngLC4f3RRwa08DVWulb7FXEDcDVcfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTKUA2RS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20D6AC43390;
	Fri, 19 Jan 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705630228;
	bh=yBWPRuj8IddoWrTRRiSc5MshF0E4CK46lWrZGy6WwHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VTKUA2RSiORLj/EggKJPof3VQCW+vnjNdZv8UDv8AlP4r1UkmI4oDlTlMOkBEIXTX
	 jXUvaMwJ4ZlUgwfPpl4FFTfubalTxOQoWb9kApoxw8gzrww43wThZexTx6SBH391NV
	 6ed/QYDhoJLeTcR6H33ILlEIfca3wBkWaPcgUWCa/UosvEDH8WSOyF1vo86F0lyZRj
	 J3x9gcy3XRrAmUFeIBu2NbZXuCClMFlN+XIOJZ43mNNyHOcSBn1N1+0surZqC3fLhK
	 5+HkytSnXR/U8BOpOmfIat2o8Aof8f1eTOsfzOVAXkuCr94CQ6dH+GoCFYbsIQEn9V
	 FZ7Bap9jy8RFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0939ED8C970;
	Fri, 19 Jan 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170563022803.21416.7420638870839242201.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jan 2024 02:10:28 +0000
References: <20240117234515.226944-1-michael.chan@broadcom.com>
In-Reply-To: <20240117234515.226944-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 17 Jan 2024 15:45:10 -0800 you wrote:
> This series contains 5 miscellaneous fixes.  The fixes include adding
> delay for FLR, buffer memory leak, RSS table size calculation,
> ethtool self test kernel warning, and mqprio crash.
> 
> Michael Chan (5):
>   bnxt_en: Wait for FLR to complete during probe
>   bnxt_en: Fix memory leak in bnxt_hwrm_get_rings()
>   bnxt_en: Fix RSS table entries calculation for P5_PLUS chips
>   bnxt_en: Prevent kernel warning when running offline self test
>   bnxt_en: Fix possible crash after creating sw mqprio TCs
> 
> [...]

Here is the summary with links:
  - [net,1/5] bnxt_en: Wait for FLR to complete during probe
    https://git.kernel.org/netdev/net/c/e6602b3c07d8
  - [net,2/5] bnxt_en: Fix memory leak in bnxt_hwrm_get_rings()
    https://git.kernel.org/netdev/net/c/a261fd41f44f
  - [net,3/5] bnxt_en: Fix RSS table entries calculation for P5_PLUS chips
    https://git.kernel.org/netdev/net/c/602801d18667
  - [net,4/5] bnxt_en: Prevent kernel warning when running offline self test
    https://git.kernel.org/netdev/net/c/7d544a01450e
  - [net,5/5] bnxt_en: Fix possible crash after creating sw mqprio TCs
    https://git.kernel.org/netdev/net/c/bb89cf26f515

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



