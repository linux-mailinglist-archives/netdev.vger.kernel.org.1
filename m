Return-Path: <netdev+bounces-98577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82078D1CFE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3511F2442C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F316DEDB;
	Tue, 28 May 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3zK10yf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD216C68B;
	Tue, 28 May 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903032; cv=none; b=gxA5QA/bHu6jDEdlz+2VKUP9881daqEX78CCZ+BJK4Lt0OS0ko9c54Mbrg9Yp8EPHjiEiYQkVO+7wyiNKaxJ2pAeuRNHKapjh3IiYj4piS9EnJtwknpsGWia5igj3OQ7SWJ0wGlv1RcKZqN6VrEgBMoaC/pmEKYwLauWUBCHz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903032; c=relaxed/simple;
	bh=MEnlAMANldkFFgFaW2dPY9k/vDKMcxv7qLE2ki50xZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B7Uqm59vdnonkMNiKAu0cNrOWDgwbvVuG4Hn3HmaGUYsVQioq7G30zMAupcLkAe4VagZopb8hgbmbpEi9a8LITmVCdBtEowquogbT5itV/YhuyEh8AI58fbD2m/9HdwJhu/ALgc2nKJx/CDmZYAYF9LU7JYedtMpU2Ed/g3p0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3zK10yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE976C32782;
	Tue, 28 May 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903031;
	bh=MEnlAMANldkFFgFaW2dPY9k/vDKMcxv7qLE2ki50xZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r3zK10yf3Ifkfjfm0XilwW/eGTy7OWjNS1rMvVOiA2ti9qwvarr6E7Ym3Z9ty7AHA
	 ndBZ/RLWdWdgMdrxrey3d9q4M7KCqhmAGf5PGNk+lxRfloIBSe2VnJh+16z/D1ioMX
	 uC7cEOWT2aGcEg38YOBZ44t8zkvxR/3St5wvXuxRC8Uh8v/0f8mj7J6zRlmCVk5n8u
	 vW8h0FFyTLvDq4RhZ3VNS+BnEbI90wLPYTTdUEWU4p0PSS2AR+hswj6+gLMQBSrQUQ
	 Bu2d9g24Ktx3nvaVS5S22VZ4A9xS7hpW9NE622F2pRHqaVUmUMJzbRT94NMDVHgBQ4
	 862AVCkAtnsdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98A36C4361C;
	Tue, 28 May 2024 13:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] net: ethernet: dead struct removals
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171690303161.16079.15088419887819972158.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 13:30:31 +0000
References: <20240526172428.134726-1-linux@treblig.org>
In-Reply-To: <20240526172428.134726-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ionut@badula.org, tariqt@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 May 2024 18:24:24 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This removes a bunch of dead struct's from drivers/net/ethernet.
> Note the ne2k-pci one is marked obsolete so you might not want
> to apply it; but since I'd already done it by the time checkpatch
> told me, I included it on the end of the set.
> 
> [...]

Here is the summary with links:
  - [1/4] net: ethernet: starfire: remove unused structs
    https://git.kernel.org/netdev/net-next/c/b2ff2698508f
  - [2/4] net: ethernet: liquidio: remove unused structs
    https://git.kernel.org/netdev/net-next/c/a09892f6e281
  - [3/4] net: ethernet: mlx4: remove unused struct 'mlx4_port_config'
    https://git.kernel.org/netdev/net-next/c/ef7f9febb33d
  - [4/4] net: ethernet: 8390: ne2k-pci: remove unused struct 'ne2k_pci_card'
    https://git.kernel.org/netdev/net-next/c/18ae4c093cd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



