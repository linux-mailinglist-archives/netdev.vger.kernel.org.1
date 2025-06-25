Return-Path: <netdev+bounces-201351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7FAE9156
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A421C25A0F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900A2F5499;
	Wed, 25 Jun 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFb3gBdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E12F5492;
	Wed, 25 Jun 2025 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891830; cv=none; b=YpcTzaNGbblQzm9HWaFLCql6notJvqqi6+7op8V6hF9WgUHPlY1kOmiEA1F1FALUrlLrRcyWTQLcmF0liBCDebE+3mM1uH1ApRcymjrHrkblvFAdC43MeVf9oX38YuQT7efYQdggi9LSCKHVzqc22N2xFLvRWE2vj6dgY/UCUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891830; c=relaxed/simple;
	bh=zcUzjb23r5QpNhNn8c/nb+z5V6dk70uQ2GZM9pR4TWs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmdNEI7l5jYVKuzlYxYzdu8Ux5tx4xvhFVxeGJFiRisiVaOkkAPeHStekLnkv+fZhKUhl+v3yIQYRZCgqKa+BIYnOLKx3+v+XTB4eh2q45P7OO0f7wk8P8ZlJQVMrmBH1WEhr+L4N8qFwjveECwQD0/QgcmJt6eW4wC6GVE1d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFb3gBdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB5CC4CEEA;
	Wed, 25 Jun 2025 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891830;
	bh=zcUzjb23r5QpNhNn8c/nb+z5V6dk70uQ2GZM9pR4TWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RFb3gBdAfWuRdo6eQ0RbCGO3KPbWRFzF2ibMDnDEUinzRxO+C0y17pSXqf67pRJOS
	 P0j6K75q/g4oJLxIAjfuTOdk8OLG7F25Nsx1qSkq1j++D0cS0i6MvmFW1PSANsCbeZ
	 m3fFvcnxvM1zC88QHMt8YTGFUGzjzlQqlC3YkscHHxhf43xPpFBBHLcv+LRzZsDafR
	 iUJ6zX0NCMDSlDguSJlCWKdauJGxhKvsuYFPsP0LP4VuBjQqsTw8LOQAwblkRB+rW6
	 Jww19PiVB09McM4sLJZWlbfggfaxd+JeA7mModgIXUJ1kQ/ggWfr5yR1Ik69fcHuCI
	 DKmNYZAmD9WxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D103A40FCB;
	Wed, 25 Jun 2025 22:50:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] lib: packing: Include necessary headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089185703.646343.5899078602477730270.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:57 +0000
References: <20250624-packing-includes-v1-1-c23c81fab508@amd.com>
In-Reply-To: <20250624-packing-includes-v1-1-c23c81fab508@amd.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: olteanv@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 08:50:44 -0500 you wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> packing.h uses ARRAY_SIZE(), BUILD_BUG_ON_MSG(), min(), max(), and
> sizeof_field() without including the headers where they are defined,
> potentially causing build failures.
> 
> Fix this in packing.h and sort the result.
> 
> [...]

Here is the summary with links:
  - lib: packing: Include necessary headers
    https://git.kernel.org/netdev/net-next/c/8bd0af3154b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



