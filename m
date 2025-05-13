Return-Path: <netdev+bounces-190278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC4AB5FDF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 01:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24056865E5A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813020E6F3;
	Tue, 13 May 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B11VVRfD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99F13A3F2;
	Tue, 13 May 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178993; cv=none; b=a+G3zflNssrnc1iA9JPize+4+fnhfy/ZoOLF7SIeQfy0Y1paM2t5HdBX0iPi6FbQCexZMyNifaZBL0kLJ7XnKorZNIhPfujdJli4G5UoESmVrslYWLh9jqws4RjLdtf/soc/EMLuwUmvxxFko6wdxtp5+pGJLb9JjhAvgCS8CPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178993; c=relaxed/simple;
	bh=2dON00NtWNDNF7j0KY/AMwF2T7aaiXyC+XezOH5qHgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E4p//1xfhycHhpud+RSaRS7sua8h3pMQcelHdo3J0qvwBxzaIfoepre1DhxSweE+3IScUuRgtXWbL9tTNGUCKSuSMhSSgpFZvpnJHYKyOUif+fnu75rD1mpa2dAKFJbGiJf3+gQe1OzlCSDE6bggI8WoLsmm4CXT2wgnZ0LIV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B11VVRfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0647AC4CEE4;
	Tue, 13 May 2025 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747178993;
	bh=2dON00NtWNDNF7j0KY/AMwF2T7aaiXyC+XezOH5qHgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B11VVRfDIPRy6lTRgI2I99t3eIRYk+nmy3CLnpU1swGxY5Wx8YvIZvNWLoKPWA7Oe
	 21b523unCwlT2FQb/YoyRJb6sLxYpMVgzqZRkKZdcKJcYZ4z1xufH5fV6Cf+W6PnLW
	 gcGMZrUGW8CClJz4w9veqPVknDWPnTJeglRwitIHJ1odPRcKWUOY5Tvdkop03Szhlw
	 cXkH/X/7xEDj+6PpvK8eIWPbsNTrmBXMGIFo28X2aUzpZpDIZgR8rTeb9/9UcwIAxK
	 thOzEumFzlo8NVfDxSmKl3jM4N0HcQ5Wgp18olkkr7TBRjSVeAK477drC5xuUyxpL2
	 0DoczXAxDK5yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB9380DBE8;
	Tue, 13 May 2025 23:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipa: Make the SMEM item ID constant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717903051.1822709.8476087509794952354.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 23:30:30 +0000
References: <20250512-topic-ipa_smem-v1-1-302679514a0d@oss.qualcomm.com>
In-Reply-To: <20250512-topic-ipa_smem-v1-1-302679514a0d@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bjorn.andersson@oss.qualcomm.com, marijn.suijten@somainline.org,
 luca@lucaweiss.eu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 konrad.dybcio@oss.qualcomm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 20:07:39 +0200 you wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> It can't vary, stop storing the same magic number everywhere.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/net/ipa/data/ipa_data-v3.1.c   |  1 -
>  drivers/net/ipa/data/ipa_data-v3.5.1.c |  1 -
>  drivers/net/ipa/data/ipa_data-v4.11.c  |  1 -
>  drivers/net/ipa/data/ipa_data-v4.2.c   |  1 -
>  drivers/net/ipa/data/ipa_data-v4.5.c   |  1 -
>  drivers/net/ipa/data/ipa_data-v4.7.c   |  1 -
>  drivers/net/ipa/data/ipa_data-v4.9.c   |  1 -
>  drivers/net/ipa/data/ipa_data-v5.0.c   |  1 -
>  drivers/net/ipa/data/ipa_data-v5.5.c   |  1 -
>  drivers/net/ipa/ipa_data.h             |  2 --
>  drivers/net/ipa/ipa_mem.c              | 21 +++++++++++----------
>  11 files changed, 11 insertions(+), 21 deletions(-)
> 
> [...]

Here is the summary with links:
  - net: ipa: Make the SMEM item ID constant
    https://git.kernel.org/netdev/net-next/c/0d161eb27d69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



