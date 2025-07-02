Return-Path: <netdev+bounces-203533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1177AF64D9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BB1C43E1B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0252500DF;
	Wed,  2 Jul 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4zU45qD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490524C06A;
	Wed,  2 Jul 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494196; cv=none; b=BDTQBYj/QjUq3lm2a/0eUxEUkAVI1+ZNmsbb4j/Do1UQG/aFJ4dUIFCNCAWFMVb9URb6DMl+EP9rsHc3p+GHyvrYzQuu8Tq+06k/mfsQXzKXwpn0nFWGK0zLy4Meh0lN+tc29WyYUzHPrst53kfijeGdbseuQQ07nttG39i8Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494196; c=relaxed/simple;
	bh=+NxvQYU7wQxyO/16lPutXJsg77AvAE6AeyUKVPB18LA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMNxZZ6HeT5lkB8EErNC4koS3rFIuwXGCzp35QO4ffI1MbSdO973edrbiMoT7y+2MhSxC02G2cTcdMSCny2RGCvZLMihfeGc52ejLo0CYbLye0UuGksNh9+ELBXuH+ENO80Xn2XY00gCUoG5oBQpCQtu0TiRtI7XSsA5i+uZuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4zU45qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3696C4CEE7;
	Wed,  2 Jul 2025 22:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751494195;
	bh=+NxvQYU7wQxyO/16lPutXJsg77AvAE6AeyUKVPB18LA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4zU45qDeFcwe7TOPtdq6DocquCb3GJzUc0begB9daO6iH4XdJcVLu8FX4ROViPBg
	 1cAjVjfl37Om+Xp1Zz+gmUnhq5CAqjX8MjCSXz6J4X0p5qt6l9ZOUwQSm5AERnNjH9
	 8f3coe5qsf8fnmDvjj+OKxMWv803KAMOrhVySVs+JWUxneznvYPPZLvJfPr/p50xsJ
	 ugN6ntbIVzfaR3JISru3pmWQ1Ev63G0Kkv2twXP3/iCXOdK7/JlR1zMDebvfkD5WZR
	 5we+bJMeNjaLHkG428lhCTHGwYDzFni/ZDvbu+XQOxqwYa/DB6mWa/7HRxJyzF0yUk
	 gH5VdrZqZeJ+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C56383B273;
	Wed,  2 Jul 2025 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149422000.880958.14366434982913389673.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:10:20 +0000
References: <20250630213748.71919-1-matthew.gerlach@altera.com>
In-Reply-To: <20250630213748.71919-1-matthew.gerlach@altera.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, mun.yew.tham@altera.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 14:37:48 -0700 you wrote:
> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [v7] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
    https://git.kernel.org/netdev/net-next/c/6d359cf464f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



