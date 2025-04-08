Return-Path: <netdev+bounces-180189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84DA80317
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A799A7AB95A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8FA26989E;
	Tue,  8 Apr 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvdMqF8V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3D268C43;
	Tue,  8 Apr 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113000; cv=none; b=iVcCIB7XWpidX1hCz9dWt0nHe2j0H2jkroyj3UVu4ctot+pazfWnNpMRgGEH7tusmGbAB8UeH8fgkTPrZy5qq/A5BpjAOkeoT/OL8AmpPSUsc/VLcaOsD5+i8EpsIy1v8GFs+aZB2QgwG0E3iRY4OMnc14zCeUOfnvj+52omMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113000; c=relaxed/simple;
	bh=JoBeA8S84gcDanuCzCGvmvw4K5dQrq0iAYo0KpI/tR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aY0/coAeIeRJ/hwjs35xx06oq6ZbU61cq2NNz1EUJOJuWLgKRCq/fDvxKvAWKoRFtkpOkmT3YmSaVZO9pb8ccSbR3ccikXRni7SDZkof3M1SXE1MsM8zm9Lgu0K0h0vVf2aAHkwZu84qqx1HGY65fXrJ1FUoOrVc/95LAhY99bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvdMqF8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19628C4CEE5;
	Tue,  8 Apr 2025 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744113000;
	bh=JoBeA8S84gcDanuCzCGvmvw4K5dQrq0iAYo0KpI/tR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hvdMqF8VsH3pYqXVeHDDuNn9lZ2z9R79Xy4BQmyselZo8fWgv7BQNi9lioVnQPiKZ
	 EO3DB0+FjWCtgAvLAh3vyieRkUnCC1oMMl3YARhkv61nqPcmBJSTpTDc8UvTRaH93t
	 A2W2lahqn0B+gvYvevz8zMiIL4mEb7Dg3wp/xMXuvLL8gLXJhozzkudDcIyheSHKCG
	 DgV/pa3vYwaF8sQ7U6t/xQlgBIXwHFOEY9Tzm50pieocAkTh84ldE2vV0H1Q8HN3Qc
	 ecMFfereQZMLjp13CFSlCUxtgoJDNJZJSpunUw801pkR3LGDZPq9A4LCDFulTU1qx4
	 gsNOZSr6gx4+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8BC38111D4;
	Tue,  8 Apr 2025 11:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amd-xgbe: Convert to SPDX identifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174411303723.1891756.10495771408871613514.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 11:50:37 +0000
References: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
To: Rangoju@codeaurora.org, Raju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 7 Apr 2025 15:59:13 +0530 you wrote:
> Use SPDX-License-Identifier accross all the files of the xgbe driver to
> ensure compliance with Linux kernel standards, thus removing the
> boiler-plate template license text.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] amd-xgbe: Convert to SPDX identifier
    https://git.kernel.org/netdev/net-next/c/34a07c5b2574

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



