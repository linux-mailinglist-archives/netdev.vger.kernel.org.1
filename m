Return-Path: <netdev+bounces-210615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EEB140B7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1554258E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF72750F1;
	Mon, 28 Jul 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1YcS/wj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AF2750ED
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721400; cv=none; b=a8GXlMV7vC7BpBnP2ETUE1SyAjpj33H7kYdpTnTjEwRO+oN51GoFHDDmfzGGHOMdcZiKU+nG39JLNSWy3fGU9+Y+/SYm0M+N4oiL/ndkrAkzk/YC2wWiFziuv3q39SuGfRDXPHlpn3ZIws18ogagMlJRUqmLqZKksN/S4f8TuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721400; c=relaxed/simple;
	bh=mVF1NELgqGlj/RH2fjC+392/3K+Zsg4cPXHVdvHpIec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JbPBPo7UFb4Zb590LXivMj+l202IqZXBUclRidU5Tzy+kZ82G2YDOctGhZwE6Jn7k0tBeX/53rc5bFde+SglTCdZBepjJDJm2jpX12J1pTLmnQCmZYRyIVzpzYPOrVq4txchZkwGeyQZ86adiUErypA1D1nLhXHeXG+Hec6fw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1YcS/wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C19C4CEEF;
	Mon, 28 Jul 2025 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721399;
	bh=mVF1NELgqGlj/RH2fjC+392/3K+Zsg4cPXHVdvHpIec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1YcS/wj1QOi4n0pICyKi4c94or25PC/cUph4sHZWkuTMyLb6ZNv4wOg1UvcMZ7hH
	 FPhgVUijZPVZQJRy2iE01pBlbhjFeYNBpq1wrmqdxYNyyBVepFwEeGPr/NaXewoMCz
	 7HZeZJaUHeAYEG1rFPqXClg+AKejAUXNtoMur1Zbb2PKSKefsuFadRt/DsfN0Zb+qe
	 vWOz98pAEBI3eR4wp4NdKY3yVo64EVkMmvJCL/NdqPTPSh02Gj2caomHAB34X71axe
	 wte8U7ru4oop+Q3VXfCqUziqgE/3gnYuSXN8BHuXf0+KupfAvX3cb4hwX7eQek6yyg
	 dCSx/aAn9N5EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6F383BF5F;
	Mon, 28 Jul 2025 16:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] devlink: Update TC bandwidth parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175372141605.776676.4265992623140543917.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 16:50:16 +0000
References: <20250728154438.2178728-1-cjubran@nvidia.com>
In-Reply-To: <20250728154438.2178728-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, jiri@nvidia.com,
 netdev@vger.kernel.org, tariqt@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 28 Jul 2025 18:44:38 +0300 you wrote:
> Kernel commit 1bbdb81a9836 ("devlink: Fix excessive stack usage in rate TC bandwidth parsing")
> introduced a dedicated attribute set (DEVLINK_RATE_TC_ATTR_*) for entries nested
> under DEVLINK_ATTR_RATE_TC_BWS.
> 
> Update the parser to reflect this change by validating the nested
> attributes and sync the UAPI header to include the changes.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] devlink: Update TC bandwidth parsing
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1a60e903d949

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



