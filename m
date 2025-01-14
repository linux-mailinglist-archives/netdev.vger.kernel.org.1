Return-Path: <netdev+bounces-158272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38136A114E5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3533A4E92
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4AD223323;
	Tue, 14 Jan 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijOGAkeZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7422258C
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895615; cv=none; b=NIX1qiANMSYgTEbMZRZnUDMjB6LsslnMp+8JC4b2a64USR6hKJZf+KikG+WQ6efUY7jh6l1Jj0YnnvkQI/uqYeifnIBLq6C04mgx/8CDJhJIMMEQj2NYqmZ1s2OfKfaQ1Xd+Icg6qdMqEzmjVRnxrqGlGayaSDFTkzNr1eopx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895615; c=relaxed/simple;
	bh=45AjFLaK/7izSXX3obJx1raHb1S7jqMf9Y3VMy5vKKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nfIvKQemLOIROQGassoCN5+rCvy1xx3Mx6R1aRjlVWkCSbIrRCz/y1afdw8cVO0ducN7lb7ccjxgZhr4q+d4blFrtydev632Eo3pnMpPIu4t2A2h1DOLDpMvlPgkcRj1NvgC3+yUyZEzWSPSiNy6pTEDErOl1Md+0UeQhsmhYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijOGAkeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1798C4CEE1;
	Tue, 14 Jan 2025 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736895615;
	bh=45AjFLaK/7izSXX3obJx1raHb1S7jqMf9Y3VMy5vKKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ijOGAkeZwRxoIqA4DfqcLMCMhWj5qRIsAjV/h6LNtAWKoqNP4l1sQu3DZ7V2dVRc9
	 ny31ssTzy16g49gJqDgwVduDD2BiIXN815hVYT6GWn0w/fdMtGLYUPdH9tGpm2AxrG
	 LWQVCU2IgofncaYifhfeXizedlyp39Zty06PYLIlZiIWV0QN+BDjb0+BkklGn2zfl7
	 TXWd6qgSpKttcNti2Ai5FF5dsxn0W++5bc+lv2PXd7UGg7Wk28onzMIKocn8a2DFkn
	 xk+pWqb4idqhJ01n9ZwuxY4JtCw5lU3+dEZXcc1e9lsMnyS0X9MygfgYvaWNyW1mqj
	 EP8nEfdraUjdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A9380AA5F;
	Tue, 14 Jan 2025 23:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW
 only if !DSA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689563749.170851.13993640477630771895.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 23:00:37 +0000
References: <20250110125737.546184-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20250110125737.546184-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, s-vadapalli@ti.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, rogerq@kernel.org,
 c-vankar@ti.com, jpanis@baylibre.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jan 2025 13:57:35 +0100 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Only configure VLAN-aware CPSW mode if no port is used as DSA CPU port.
> VLAN-aware mode interferes with some DSA tagging schemes and makes stacking
> DSA switches downstream of CPSW impossible. Previous attempts to address
> the issue linked below.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW only if !DSA
    https://git.kernel.org/netdev/net-next/c/62507e3856af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



