Return-Path: <netdev+bounces-112554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35908939EDB
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 12:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F69283565
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B914E2E3;
	Tue, 23 Jul 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBCpTBqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B814E2CF
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731232; cv=none; b=b2ixFa7CMoe6pMN2r9x1NcU92ejkCYVQj5f0t0q6plBr+rlYwK2czja6JWjwjJ9FJY6JvO06vnjTSCQEzuQr5EqrKzpBwDbyldy6W1nsyV83yBDfw69ZNhYd0UsK52fdI9ELfhGCv3zrVuPFqKl8mtUJO4OMpyAPl5yjJSNucj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731232; c=relaxed/simple;
	bh=PGyVl1XEk9wsuy409pc0uqap2hLP+phvFbWFKQpZh30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SuRWvhQd+fg4PgTsn7clSvUokXuTsGhk9Vb4xxjjRuPwAMO7DiDICRYKPqwK6mBfZwVQPosEhOK15/TrsT7xX7qiWPtzpTIbuTrve4FAeAiBGnRWWzeXAo+3L7ozR5QYaImaZxzCX9PbKHk2NjAXoRmy8ARkdn6xm2S1i8BwOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBCpTBqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 654ADC4AF0B;
	Tue, 23 Jul 2024 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721731231;
	bh=PGyVl1XEk9wsuy409pc0uqap2hLP+phvFbWFKQpZh30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lBCpTBqeOwMG+KsHqvNxQGg/y6rLE6sIIKMoYdbJ23Xevd7V2LivEzfDlIPmTrGJB
	 JYOUWbG43qtlCX9F8EIchh3ZFT1O9tS19ZBd6SmtfK2Nk/X18RBM0b3xzu3NTxfY87
	 E4GER4DgRraKJFNmH0B0VRAB5vhX2yL754H0x61lf9XKwWOGg6cegEuG3m0yzKwBld
	 HbdgnuE1iWYrhd1SM3+W+mkscU16j0EvtZvalf2t673JM9NZRvZLVIz5vkchKsfyvB
	 8nkmpxRf+NlERG82hIV5SrOSBSQajCC8yrmeu5FusJQZjWy51YbFoqFJQDbBanQl3E
	 6yI0HO5HqNpfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52940C4332D;
	Tue, 23 Jul 2024 10:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix MBI_RX_AGE_SEL_MASK definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172173123133.6377.16575807879324365123.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 10:40:31 +0000
References: <d27d0465be1bff3369e886e5f10c4d37fefc4934.1721419930.git.lorenzo@kernel.org>
In-Reply-To: <d27d0465be1bff3369e886e5f10c4d37fefc4934.1721419930.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, angelogioacchino.delregno@collabora.com,
 lorenzo.bianconi83@gmail.com, dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Jul 2024 22:38:31 +0200 you wrote:
> Fix copy-paste error in MBI_RX_AGE_SEL_MASK macro definition
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: airoha: Fix MBI_RX_AGE_SEL_MASK definition
    https://git.kernel.org/netdev/net/c/39a9c25bcdfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



