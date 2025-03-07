Return-Path: <netdev+bounces-172712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E5A55C96
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3733B72BC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCB85270;
	Fri,  7 Mar 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqbl255n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FE152160
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309200; cv=none; b=oTkUSTyU81QZAt6EqpTmigjR0OyMhFbYVIDszPEHvOnCVR5cJqqT30DzreSSiPA8y3X/tM+KmjBbjzG7cWMySkEfCbsUMV9hcNv4Knn1UiM1R3z+349j8O3uj65mYMtCJhM1C8Xml2xMAFr4xSJ8DPvB7uwFBqkF1fuYctxlShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309200; c=relaxed/simple;
	bh=X55DFRFSwu+cUi1eXLiOrNYt6pgkbJ1bD1YE9jn5pFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tyP9B5D2KnFgqyojENPMNwbAF1bcfwYhTg3AXa7ETdWdFnMmBWgFr8Ak7QzfyxdQVgljDl9Sv+wUbo/xE2t631e/lGGAb5NnnHY5kGtEcBXehZ2BN7kTBmXFqg64WTPDgoSrNy40/Ad0fq9Kdr3lnMdkVAO4a0klqnQicFGjfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqbl255n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61872C4CEE0;
	Fri,  7 Mar 2025 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309199;
	bh=X55DFRFSwu+cUi1eXLiOrNYt6pgkbJ1bD1YE9jn5pFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aqbl255nyucQICStW8ErA4WgsR0Jvj+T3uC7XgvHztIUhzZVVjJON7tOJXPqP355u
	 UjzOQL6WfcmOckfIECPr81z/GDmC60jB1ejUAgqz0FRIGJ/QzIlL7l6FgD3KvUYx7e
	 3JibRGygvBaSMb7eqghJYwHy1tH+12kNhnMr97tZT+DdJ+v6L2YMp9qe4fvs+YP4pi
	 xVfPbCi3gYdOwGY6YqOmNCp0eCIvciY3gmJYlbB4mpYp0iOwW8n0metqkHZbTIY8vc
	 4CdidXM26HHCYOl2fxD62pxJQVaVKon/QRA8ob2zz4/3iBkTqdYD7wzMW4oIAPfB3Y
	 /lrTtN3llUF1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA70380CFF6;
	Fri,  7 Mar 2025 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Enable TSO/Scatter Gather for LAN
 port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130923275.1838424.9254960891722689987.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 01:00:32 +0000
References: <20250304-lan-enable-tso-v1-1-b398eb9976ba@kernel.org>
In-Reply-To: <20250304-lan-enable-tso-v1-1-b398eb9976ba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 mateusz.polchlopek@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 16:46:40 +0100 you wrote:
> Set net_device vlan_features in order to enable TSO and Scatter Gather
> for DSA user ports.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Enable TSO/Scatter Gather for LAN port
    https://git.kernel.org/netdev/net-next/c/a202dfe31cae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



