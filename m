Return-Path: <netdev+bounces-72903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564285A12B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9813E1F2170A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C328DC3;
	Mon, 19 Feb 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFRucYm8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410E28DBD
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339225; cv=none; b=U5MWJPS22B97rj9hp2voc1ZBoIcvZwOkSh4VZLPthEDcG5Vx6eMWHVUOFlzIUKT6SBeIgw/RDSzjYBiffedOnTPoDr2pVqduyVbG7Nxac900U8Dwz3Tf8xonBK2CgIYHVsRuyyG3MZN+CshFnRsUHASFyD2/Uw+vII5XmuIDP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339225; c=relaxed/simple;
	bh=mwE+UQVoYbSFTvIFcOPqUGC5//mPJtTv82fvfy7nPCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pHXq1SMko4iz2aNG8iQF7aWvBFU0MdFrS+2TcwDB5IL44X2EOdQDMtlNC2IMlPRkEV+OZaEuA6AhuRLydiPpMlveOgyQzZsH7hfN+MgvFgLlhfz5f8N0kjjySq1U+RjE5MRBoEQiRp600vE3NRKsJN0xud5EWSmHAs3YhIoxqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFRucYm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 138CEC433A6;
	Mon, 19 Feb 2024 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339225;
	bh=mwE+UQVoYbSFTvIFcOPqUGC5//mPJtTv82fvfy7nPCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KFRucYm8Qf/AM2HEPAcC3/qcQdYIhsJqIei5GpRe7cynnWtvoahcaCjmX+JePYvD8
	 PpFrN9C+BTpr/EsXsB4cCZN+I1iTzRQDNA2HY5G8vLUwEiAc5E78cGn4QrSYBI1ZCd
	 /r6jcgn2l/C9XW06fpkwpkKZrskYix85tGkJKH6R2c6XBEDxO935r0vJtfyxVlcRw6
	 z4LvFUitCQjujfEkgFGBtUgBmRJXDuWqWcUtT4ejR48Y/MbQ7wtlQjSYzX2juAVhnf
	 o2FAEZu2pYPEUpYQ6M+V6Od1xue3NZ4hHDXSc2BITsaPmk9RfSe8n1VIorsUdMOYNk
	 B5NpAmZV4fSjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F40A1D990D8;
	Mon, 19 Feb 2024 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] pds_core: AER handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170833922499.7770.1619459229569752785.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 10:40:24 +0000
References: <20240216222952.72400-1-shannon.nelson@amd.com>
In-Reply-To: <20240216222952.72400-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 16 Feb 2024 14:29:49 -0800 you wrote:
> Add simple handlers for the PCI AER callbacks, and improve
> the reset handling.
> 
> Shannon Nelson (3):
>   pds_core: add simple AER handler
>   pds_core: delete VF dev on reset
>   pds_core: use pci_reset_function for health reset
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] pds_core: add simple AER handler
    https://git.kernel.org/netdev/net-next/c/d740f4be7cf0
  - [net-next,2/3] pds_core: delete VF dev on reset
    https://git.kernel.org/netdev/net-next/c/2dac60e06234
  - [net-next,3/3] pds_core: use pci_reset_function for health reset
    https://git.kernel.org/netdev/net-next/c/2cbab3c296f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



