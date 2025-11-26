Return-Path: <netdev+bounces-241764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2EC8802C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 852673552EA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9573126A5;
	Wed, 26 Nov 2025 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrTGfSD3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD3311C3F;
	Wed, 26 Nov 2025 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129666; cv=none; b=ipR6siZGKHzBt2InovcxabZ8PRwh6t1KvcfxHq8nkSnhgTj7p90YewRBqsF8GoQsiLhP2necW6QM+lzMtHLfu7vJS4wgQ4BgwWjF3AJSZ3YQVjEbpGhsuB9rRynYc+fS9bRwLudOpUQ0qeyBHG/FL0vSfJCtaFiRowjrJUmM4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129666; c=relaxed/simple;
	bh=xQsTEl82BCaQQpAUz4pWguNBxZRS1DZ8ZpqGkMUWE6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iWVL+fqV75wRqrIMFfyiB+a1G1Kfw1DXfZAikOv2F6f8z24P7MSP+JBO6eAePYS7Zb7Z1MYTNT6wyDY+S3107N4ocmLRJKzXoPcYa1gszvs2JWhNnWAn5lZchzXGAPMeGNOslrCjArz1lzMgRfvYqRn4FgCsxbGdmMRWmI4JY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrTGfSD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46601C116C6;
	Wed, 26 Nov 2025 04:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129666;
	bh=xQsTEl82BCaQQpAUz4pWguNBxZRS1DZ8ZpqGkMUWE6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrTGfSD3J72cjE9PykghJPIM534Bfkn94/NGFefSN2oMBCY1Sy7/lr+DgM+vxqr3y
	 V+5DOSDCNV0twtZQOt4+jixDJXQxw3lMePitj2SoIKtgxvpdv+7DiVyDtoWZyVQcnp
	 7t3pVzH8+14w4Nw2zWZPc1oyg86sFViXZZ57JxUO0xzjE8KICpdD//K4L3IgTNiG9J
	 yRqbMF59zITECdY5Qr6kNRnTXTYSplMV7nLOjc3boayY2XBaQNF84lVO+21z3BCJ1N
	 CNcTMCPfAvg/AnEVy/0M6AR212ZDXEXyeUP1Lp1HedG145uh5Y8orO8aKYYCS6JP8P
	 zG2YzrkI3/ykw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5C380AA73;
	Wed, 26 Nov 2025 04:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] chtls: Avoid -Wflex-array-member-not-at-end warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412962824.1513924.890605240324097452.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:00:28 +0000
References: <aSQocKoJGkN0wzEj@kspp>
In-Reply-To: <aSQocKoJGkN0wzEj@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 18:42:08 +0900 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> [...]

Here is the summary with links:
  - [next] chtls: Avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/d696c7371614

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



