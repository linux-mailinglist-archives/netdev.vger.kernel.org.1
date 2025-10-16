Return-Path: <netdev+bounces-229838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152BBE125D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3513C19A6E19
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D94207A09;
	Thu, 16 Oct 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ7ZSfXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A5202C30;
	Thu, 16 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576433; cv=none; b=ArnmODuG/O6QyhYIMDetWmsKtMd+galLDfp7Tv8hfFA5dxhZY5a0xLelQ71jO5YAmd24oasVl9T1Mw0aJ8GByajNvmz8f7ckueHeXqUqEzywIjUV3LGPyWsrNVtVyle6OuyR9G+uqLaQ4vVsa+wESEtKBhlYBm6NJIpRwf2nEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576433; c=relaxed/simple;
	bh=1nSU2VJutd8xKbFho8sBZm+rC9jYH3ub9ZnyfZw4e3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aWn+Fp7j1pDJTiSyz97O6sU3Uwsf7aEKG/+Oc9uK9aC5ewquk0bq2HDa3yTZg0oHsiuBtfufcZ+3QTp7o95exddMYFoY+uvSvrTNphmllMndqidxWMjNbuZqrQ4BwiWNbbJrr9SqGrSnkhjx4px/uQdP6WfSuFYZ8kYAOxSd/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ7ZSfXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D6C4CEFE;
	Thu, 16 Oct 2025 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760576431;
	bh=1nSU2VJutd8xKbFho8sBZm+rC9jYH3ub9ZnyfZw4e3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NZ7ZSfXT159Oh4mT3hyQ8+8r0zjNcrrGjnsPwQMskbShORCV1koAxkq5Plp2IhEdt
	 mcHaSiW2eReTQyQAwqORRhBGd4DPK8f/eirXg4JeRNncwBQRqHUk9157NZWXbzIn3Q
	 q2NRN4DN1LH1eP9KZobP8W5+/MRNsY84lcxgcvJafci/7+3tApyxmRAFWUePPY9hPX
	 +vu2SC5lNBV1G/UAxGMnTMzi1NzciArco/8r8P3U5CvHBBV6EVHf625mAn9rXwK5np
	 0hGeWBHqmUtRZw0UV09+4/l96UpmjDXtkupKeVr3dPoLkQAIPGHNVffMmuxckNw4SM
	 T3xSVntgFpRaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E26380DBE9;
	Thu, 16 Oct 2025 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: airoha: npu: Introduce support for
 Airoha 7583 NPU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057641599.1117105.16062969451575878802.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 01:00:15 +0000
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
In-Reply-To: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 15:58:48 +0200 you wrote:
> Introduce support for Airoha 7583 SoC NPU.
> 
> ---
> Changes in v3:
> - Rebase on top of net-next
> - Link to v2: https://lore.kernel.org/r/20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: airoha: npu: Add AN7583 support
    https://git.kernel.org/netdev/net-next/c/9fbafbfa5b99
  - [net-next,v3,2/3] net: airoha: npu: Add airoha_npu_soc_data struct
    https://git.kernel.org/netdev/net-next/c/0850ae496d53
  - [net-next,v3,3/3] net: airoha: npu: Add 7583 SoC support
    https://git.kernel.org/netdev/net-next/c/4478596f71d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



