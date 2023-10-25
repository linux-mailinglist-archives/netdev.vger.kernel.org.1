Return-Path: <netdev+bounces-44053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67FE7D5F02
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A345B20F4A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D346199;
	Wed, 25 Oct 2023 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEGpbv4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CA197
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0FECC433C8;
	Wed, 25 Oct 2023 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698193223;
	bh=MIHLktY/jFGsHDFapxfOv6YXLF5jHomyDyv5lJN8Ft0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XEGpbv4maitd9lgJ5N+U/o4g04W1WjF46BYt6fYod9Ae4U3k6dk04Pd1ZlZaDMftk
	 83G4G1+h+XF6OS/ECbg3y3LocSEdTZSGm8gQZqpPyAYl7vPaGcoSVZ+RYHtixOcAJt
	 2axjCZYxL+uIwpYVaK+rQ4dvLXWIm6iY+3sULW7iiJOR3Gqt8JpjkDqn83iOrxojdF
	 OtM3nXkytXexlCGkyYbqhHmqE6Hm6EX+i7oB4QCN579wyp4w9IdgSt4v835wqRqMSf
	 vTichGex/CAxdkB6j3X/75isMWyCijPHc63/B4ytcgOEjws9ySALYPlFOO4RVSm76k
	 KkFovKvO3GVbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A80E3C00446;
	Wed, 25 Oct 2023 00:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: remove wo pointer in
 wo_r32/wo_w32 signature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819322368.28608.12820686128790784897.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 00:20:23 +0000
References: <530537db0872f7523deff21f0a5dfdd9b75fdc9d.1698098459.git.lorenzo@kernel.org>
In-Reply-To: <530537db0872f7523deff21f0a5dfdd9b75fdc9d.1698098459.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 frank-w@public-files.de, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 00:01:30 +0200 you wrote:
> wo pointer is no longer used in wo_r32 and wo_w32 routines so get rid of
> it.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: remove wo pointer in wo_r32/wo_w32 signature
    https://git.kernel.org/netdev/net-next/c/42c815c545a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



