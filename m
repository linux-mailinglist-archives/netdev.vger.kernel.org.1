Return-Path: <netdev+bounces-173647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C8A5A51C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8835218919B8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9763C1DF972;
	Mon, 10 Mar 2025 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYbMISkn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C531DF74F
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639203; cv=none; b=AV7NslvGTmf5Dtwm0nawFg0DrhnNOKO7j6EQ7XHQA33nblDgv+MEvfyRsHzsfIUr5jZT/zDq5tPAVUo88w1aefw/c2aUSMOvfIJY1DnKDyi5pNo/rPqLV/sKlqEMaa0hFxO7rp7InIXkHK2aD1ZQRIo6yS5Ja6I5OTTiT7GkHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639203; c=relaxed/simple;
	bh=zZmzGbyWEQAda18+jtCSMcKVPBOSGOyq/t7JXpDJf0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EjhfNGQqxiMNH64qYqbk9+/AjZyzFMcZgxEhC19rV//51PpaM4ceHd5OAS2EiuaQu6U04fm/TgY1DrVJYKGtvjRTgl1X2aWNGLbSJQgX/iv2QXRYwadQ4DMcrvAM2To+tmBzDzAs+5Sr6kJx6uqo3ydrjCjTDa9bPvTnbnuQuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYbMISkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD19EC4CEEE;
	Mon, 10 Mar 2025 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639202;
	bh=zZmzGbyWEQAda18+jtCSMcKVPBOSGOyq/t7JXpDJf0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fYbMISkngbbfsMXjtDs3qcG7mf9EH/HC+nCqMW7SiQY1q2GHJ5x0AG/B/TFTLJrkG
	 HxYpwfRvZWQREuYhg+4xHWAKX2PyD+VcIQDzwtyHrrIwpnIilGcjFgM+VidLfYINJR
	 3MlbydHCy8bRVuEIEqnB2uvCoy41ysoNZsRzVZ7g23uddPUdT5xmAKoSNbGodW1Kwa
	 JAVd/DAeepnXsrGPH512eqgp6EI1yQaJ4BE48/V+QPZ+zsr9np9cB3D0DBf/MxiDB1
	 khj+mGieag2YHw1cLMuqz+6nmC+n4EnaAYpSWF0yvb/54WUsuLLuoBhJPeXSLrELXk
	 Ozy4f+8kU9EIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8B380AACB;
	Mon, 10 Mar 2025 20:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: sfc: remove Martin Habets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163923700.3688527.13693924016041570945.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:40:37 +0000
References: <20250307154731.211368-1-edward.cree@amd.com>
In-Reply-To: <20250307154731.211368-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Mar 2025 15:47:31 +0000 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Martin has left AMD and no longer works on the sfc driver.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net] MAINTAINERS: sfc: remove Martin Habets
    https://git.kernel.org/netdev/net/c/77b2ab31fc65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



