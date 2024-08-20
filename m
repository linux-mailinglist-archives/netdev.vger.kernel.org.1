Return-Path: <netdev+bounces-119957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E41957AAF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846E61C23486
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4443399F;
	Tue, 20 Aug 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR/mJt1j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725D38DDB;
	Tue, 20 Aug 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115640; cv=none; b=fSXjdq/P/TzLl1NbtqoUl/GdnuQo0xIjN37weS+8b8b2VLQcHdKSGc8SiVDRnXLBfC7qV4/TXWC5baaTT5jETflvjNUY/eHjucq1cUvWu6cXkRj6zrHW9qT+WuyG4GjbKYlQuMiWWN4R+Xgm00URbNXQjm/43fyagpsl6yEgLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115640; c=relaxed/simple;
	bh=KYzEMolPPgPwLT+q1Q+R1NUmi/Mk69DnugO4SGkI9JE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qmtk1xy/WPNyvOeacDS/iRr1q6z5OC2bvFKL/k8RrfhKRZBhLjcrGuKE6nmNPnLD8tjEvh9M3qLByEcE/Q66zKk8EgKdEA0n76U+rU/6fDCrTf97xCxAb53dT6cCfclkAxTBDwdJOSjxeNf0TFoNDsizzFRCQLpXrLl3EyvXWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR/mJt1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD1C4AF12;
	Tue, 20 Aug 2024 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115640;
	bh=KYzEMolPPgPwLT+q1Q+R1NUmi/Mk69DnugO4SGkI9JE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lR/mJt1ja6JA5FmH+Q3CyLERB3El3StA64u0H7OkjaFxNWgJiXSDQnZcDj/xwfAkc
	 59bX9dFmi1JZxRkRg35kEA2wDxpdm2JD2MXjbAgDomkqTKxjEkeyRpYKSZrZ3S84DA
	 4PeAfuYoNWUXrjVPLmnuFqbUBdQZwoy/GZ7tBQHc74xgLGG3ufHbAQlvCl8rmuHwE9
	 SE9TN7K7Xr/oStA91+HXAqorU7YudehzLbX4S3Y4lzO4uFKmp90ZTBUWzBQRHoVk/W
	 9cWMjBhznpNZ8qwxxudNhEl6fqII8yPkIkwMLhAJ7Opjxteb1inghkWdBSBQzkJEKT
	 3CcHa8WIm0TLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B263823271;
	Tue, 20 Aug 2024 01:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Remove unused declaration gve_rx_alloc_rings()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411563975.698489.8716288117564781874.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:00:39 +0000
References: <20240816101906.882743-1-yuehaibing@huawei.com>
In-Reply-To: <20240816101906.882743-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, hramamurthy@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 18:19:06 +0800 you wrote:
> Commit f13697cc7a19 ("gve: Switch to config-aware queue allocation")
> convert this function to gve_rx_alloc_rings_gqi().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] gve: Remove unused declaration gve_rx_alloc_rings()
    https://git.kernel.org/netdev/net-next/c/359c5eb0f736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



