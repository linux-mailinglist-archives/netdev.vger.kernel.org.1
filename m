Return-Path: <netdev+bounces-73528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49485CE54
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CDA2832A2
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BE28371;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+bB4gee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08992F36;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483829; cv=none; b=mviUQP0eGESQGyeTTCmgBKARDseQhMNNqbqsnR0gbZY+CtQ2u9NHlVVFQfr8txuMrnem+pVwn9EunHC1ixFqRmYLAgu845+j+SPYOsViFpWHsJK+vKxooyshkr3hLbisJNcfH8mqWorzYLHFL2FaJ9mlk8GEgHM5VTk7QhN5MSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483829; c=relaxed/simple;
	bh=ft6GS4HttWFaomhruIwxgB1TwBKcke3gHYkZySKkgrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iyFk1ff2U5xQ4R3gqYBONntacrKKIIDI9FQSj2UqJX5wRAyxVjpkTZ7E2MyMBAHQMYxr3EI27P7VZ46y+gZTBUmY9PC7SOT9ahRlc+M50v/fvDax5N3lAiAxlhP4jMWig8pr/SRDtq+ZmqTidkZ1DEm4+wGsecoNmtpbh0Oogx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+bB4gee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58BC0C43399;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708483829;
	bh=ft6GS4HttWFaomhruIwxgB1TwBKcke3gHYkZySKkgrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z+bB4geejshT8htwTNcfuJPtC9LkXsg/g7Q2TzaI/OcUQYS0ZBoX5M0gx5t3gp+sC
	 qIMZBhXHIfdGlUifIGIET/pWA99SoW3JFZBJbm01zMqtPVfVwj+G8KqNGNvy1s90FM
	 1I9rSbQEV0iedhstnPnGFnPKp59dFOAbHOHWZoMi0HsN7Bw/Qb+/QO9FezV3CVqjIg
	 Uqr5FA4adZoMCoaMfMvHivfn8Yxq1/ilKiqCHKTIauNC6Ytt00aN+U0j8pDQ8QUHSF
	 A5pUekvEACZ50vnRoGX/2XYXehaQOX4+AErVftzA/ouPMHEoqtYyAJzxdhy8inn70t
	 JwG7ugxFwb41A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40262D990D7;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next] net: wan: framer: constify of_phandle_args in
 xlate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170848382925.20526.2525351962528037305.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 02:50:29 +0000
References: <20240217100306.86740-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240217100306.86740-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Feb 2024 11:03:06 +0100 you wrote:
> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/net/wan/framer/framer-core.c   |  9 +++++----
>  include/linux/framer/framer-provider.h | 14 +++++++-------
>  2 files changed, 12 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [RESEND,net-next] net: wan: framer: constify of_phandle_args in xlate
    https://git.kernel.org/netdev/net-next/c/2f3bfa8e30b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



