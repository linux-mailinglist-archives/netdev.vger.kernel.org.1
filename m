Return-Path: <netdev+bounces-223310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA31B58B3E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8414A0643
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0465261591;
	Tue, 16 Sep 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvOfAHPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF72609D6;
	Tue, 16 Sep 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986248; cv=none; b=aAvOVPQMVtYfD0Th+ob6nSN8xiMHvjDYpHxoNfUDg8K0ya/OQZVpXlUS4uK4OZ1onAvUl30D6lUJjKZzgxqOgT1P2eJMyJBSwYj4x5S3mhEr5lC825OZZG9wdvBlyFEiRJSGmWiEXBsppf0QKuIbw0w9thJxEO1U3oUuI2S8S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986248; c=relaxed/simple;
	bh=l+k05JxJ+WyOuJExxNrMBN7GSiEEMANIADGgpVWpKsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcG2mZoECWAyfTMVn3SyFeWwLlBKlwIz1pp5HGHXnDkAgKFP681o6TxCmSwfQn5axDt87odZ9e2msoCTQRnMhEylCcD14yhyuxka0uQHSpa2pWW7HOObdK4r544LGhg/qQ82NbTPv4OhKCptTkB0qJ9/UfDPcnfbn2Tw3R79hmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvOfAHPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1854FC4CEF9;
	Tue, 16 Sep 2025 01:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986248;
	bh=l+k05JxJ+WyOuJExxNrMBN7GSiEEMANIADGgpVWpKsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bvOfAHPDFQvnxK6GBC4I2HLh0bT2v/kXxWxi4X4uZOxGoxgkXnpzcRWdk9L39pTAw
	 cKocm9+hsX4Gz+gopdShsfcnChoUNgGVNy16Z9cZL9D0s00NeXBeYicQpONfkd778L
	 5H6k9w4J9tBwydjYND2f9aR552wdKUrCUpjgI09j+peqRzf35JsNSTjKEPl4gGSSJa
	 0Wo76VGNJXZ9vXY/1KkDSo6dVpsG0AsvEO4WweKBiTRsPYSfl2mvLqgFA4TSUKSqZu
	 2lPkX3S82FQdyBaN80OJpX7kHP+2nj03ozMn7yhEnCPEcPhsQBTeGT9kNwxCV4FROJ
	 51WZqxwFMABvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8C39D0C17;
	Tue, 16 Sep 2025 01:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mlxsw: spectrum_cnt: use bitmap_empty() in
 mlxsw_sp_counter_pool_fini()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798624917.559370.11581493379614646139.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:49 +0000
References: <20250913180132.202593-1-yury.norov@gmail.com>
In-Reply-To: <20250913180132.202593-1-yury.norov@gmail.com>
To: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Sep 2025 14:01:31 -0400 you wrote:
> The function opencodes bitmap_empty(). Switch to the proper API in sake
> of verbosity.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - mlxsw: spectrum_cnt: use bitmap_empty() in mlxsw_sp_counter_pool_fini()
    https://git.kernel.org/netdev/net-next/c/7acc8b904836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



