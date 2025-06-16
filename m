Return-Path: <netdev+bounces-198274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C460ADBBD8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE81717335F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6820F063;
	Mon, 16 Jun 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDu9Ooc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E12BEFED
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108801; cv=none; b=IQWrFTFgXuW9ygP8fxgb0ZlqMxpWy7H2MRaIDxOrRsX/SAsxme4iue1zkrtmvnSpPCItO5BthCSNVfDte12LDSJee62Zu80+emFi+4KpSmFc2ZxFOKtNj29ZWyh0Ho6HGL98x8Og05/eSOcZcWuNxkq/sCEym+DGm2zs3YfZOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108801; c=relaxed/simple;
	bh=M+u+VkdqHUJ4chQNcEGLF+FfaNaovDI/L1EF/UnaAsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qG3SEphFf0a9F0OpoiLXsayZGgZxxx1/MtmqsHp4wqmTYXzneu6imhxXq+PK2ikseFkdTNAomRJfILfS+LeMNCYjaQgMMgn7Cz5NU0BGb7YA7Hc9oDD75t6K6FmrlDWik9oj4CmFtYqgtLxgFpbBXBeppKieCZ4QIooNbvMYaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYDu9Ooc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52EAC4CEEA;
	Mon, 16 Jun 2025 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750108800;
	bh=M+u+VkdqHUJ4chQNcEGLF+FfaNaovDI/L1EF/UnaAsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYDu9Oocd3KykpVZLpk46aK/jeviwBK0WCkg1yxpfthhuhZadsECsdHw5TuQyKwyM
	 dVj7fV18zqBqWWmNdRnNdpwBje268g/5oZllcds5qONn9Oz/wq/Kc/5mChaGOKDaoC
	 DTmcdfmzahPSvrWO5+Q+9e2TIowjwZipuZ2gVOB5zpY1EDI3YtC/csOGrKesgrgstB
	 OelTBFaBCBJxBeocjW7GcCqnRXil28MnRc/VLncOEarHb22pyuxl+WMN767Qo80/we
	 Vf+HilD6T9TtU689FQA7Y2XQVcgJql8X/NDhBS5Eodo+bmcccIojyi5aZjO412dWgf
	 UO6rPra1k2PyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE14438111D8;
	Mon, 16 Jun 2025 21:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pldmfw: Select CRC32 when PLDMFW is selected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175010882950.2517548.16812914519632809645.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 21:20:29 +0000
References: <20250613-pldmfw-crc32-v1-1-f3fad109eee6@kernel.org>
In-Reply-To: <20250613-pldmfw-crc32-v1-1-f3fad109eee6@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com, ebiggers@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 17:46:20 +0100 you wrote:
> pldmfw calls crc32 code and depends on it being enabled, else
> there is a link error as follows. So PLDMFW should select CRC32.
> 
>   lib/pldmfw/pldmfw.o: In function `pldmfw_flash_image':
>   pldmfw.c:(.text+0x70f): undefined reference to `crc32_le_base'
> 
> This problem was introduced by commit b8265621f488 ("Add pldmfw library
> for PLDM firmware update").
> 
> [...]

Here is the summary with links:
  - [net] pldmfw: Select CRC32 when PLDMFW is selected
    https://git.kernel.org/netdev/net/c/1224b218a4b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



