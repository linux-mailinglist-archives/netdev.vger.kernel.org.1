Return-Path: <netdev+bounces-71655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79368547AD
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 12:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CE628E6B6
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7618E06;
	Wed, 14 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h92L0Hl4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162B18B04
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908426; cv=none; b=RB6NdtSk46z+5WtS/VwkbFn/F8jdYPABuavu3zcQFvsibbvjLwoX11t0Ohcz0iTeUjzX0skCfbFdU9jGgN/3TmqLjde+F6POD7omrw8WcOJsUQlrs2bsYYnXWUlzDNj0LxU5f8sUFj85ogvA8e+RbcAz2eiooo80S7qim09ZOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908426; c=relaxed/simple;
	bh=1A4KE5QTHmfenozSjJWk1nPYjPo01Fn3Q2c0jLNhOQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mdStFRctAfez5pjEfxJEYIeZAXJL9d3pMGYbNGM0z7j3FsSo3/wZM4QQCuAF/1ktrTMfX9gmmo+DgVH7SmhUEMc+8f/zgI3bI02Ph+hZJ69PsLNUKWSSToF+/0VxvAR5cgkQFRc1QRGQOrfA1hAAhi0nRq17SvFcgyE9kSFDrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h92L0Hl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27854C433B1;
	Wed, 14 Feb 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707908426;
	bh=1A4KE5QTHmfenozSjJWk1nPYjPo01Fn3Q2c0jLNhOQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h92L0Hl4t128Po+EQXdLtsH3+ZT6QTWjMFyUDIQXnjIbwXEVIVF8Bn8MSFVIQYI+8
	 c7ARtKpanp5ZhYN19QutUH9bNdHNhCEKneyOgyCeYsoCd0vzZgi/O/asC/quK6nR5z
	 57h2TMWxHAd7HO/++YMIL056YyRHrwuPGCN/d5v2VN2MTcvZoJHSaZ6V73Yg6eRs6E
	 /qkrmN62g/lE33aY+ZfPqrP7RzdlUuJ6F1eKSKLMArgu87OxBVI19Ttg+jMj/StuZa
	 ehxEie/0wD2/2tYEHMF+ZcFrStvnh6QHpazMJ4+918U+oURkisuDCtZxxDCj/OUV/x
	 FzvxvtREqE/Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15886D84BCE;
	Wed, 14 Feb 2024 11:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ena: Remove redundant assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170790842608.10752.8468291107377871443.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 11:00:26 +0000
References: <20240213031718.2270350-1-kheib@redhat.com>
In-Reply-To: <20240213031718.2270350-1-kheib@redhat.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 shayagr@amazon.com, darinzon@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 Feb 2024 22:17:18 -0500 you wrote:
> There is no point in initializing an ndo to NULL, therefor the
> assignment is redundant and can be removed.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ena: Remove redundant assignment
    https://git.kernel.org/netdev/net-next/c/723615a14b87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



