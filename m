Return-Path: <netdev+bounces-112042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15474934B2C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1EB1F248A1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644F78C92;
	Thu, 18 Jul 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjB0wWQ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE893A1B0
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296232; cv=none; b=euhjUfGHZfeXRB6q//SEmSX9BgEANjNu+LkAf3ne3Wbx2Covu3n8dyht9urgWokL21mbs2pAYcdja+szMT4e+vXAmpvj1Vg/Fk38aZZ5oqpJf8p9AHqonew0XgDIv1zjyTd36BY7Dtqu9ibhtfO0VNgq/fN1ALT9q7iN1ei7OtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296232; c=relaxed/simple;
	bh=NmMbqNEq417p0M0i/dA/33XfPB9L8BA4WFDWPW7yDzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dIUVEtgun4rw8vWEGtMSBvHSOrDk5MGDvV6chTHC/wE0EeXw26HLFwd/LgNoNMywN5xL81D4a0RiFHEnULUfxWCOMtnp+7wG8+UdGpeJvbHE+LmFbJCp1fN+9Cd+Cfdr0v1hxrpag7tb6jrSICVEX9Y0ZQ4yZHqdhb/xLYYrh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjB0wWQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6ADBC4AF09;
	Thu, 18 Jul 2024 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721296231;
	bh=NmMbqNEq417p0M0i/dA/33XfPB9L8BA4WFDWPW7yDzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OjB0wWQ7yTNPUwv/hT+4uf2Y1GzfUWAh0tj+DmEABT5bSIfS3VnutizYF8TI/h1Yk
	 THbXxcfAn69L9NnTXvjMXD5Bs982+T4kOzGoI3M2tUrzAjJy6QUpT3MDRJqavXp/JF
	 u3OqwE1SZ5Y1KC4RCYje41lx0SNYFerUg1B0t61yutfMsYb06nZQmcXfdPth7FxFS9
	 cF0QSWoyr69tamDvWqmrRGIeQIZbnpyuyXlEEgbEMtlK30s3zCBhjDADvrecbzupuP
	 iQqst1ZGqZbRvS98M+X/J5hwWDAof3fpBunibAMk9RFoinXYCkWWzWIhkeWB2J2p2K
	 Az3qdPRh5KlAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A079DC43613;
	Thu, 18 Jul 2024 09:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net,v3] net: wwan: t7xx: add support for Dell DW5933e
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172129623164.5775.484196429931641435.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 09:50:31 +0000
References: <20240716024902.16054-1-wojackbb@gmail.com>
In-Reply-To: <20240716024902.16054-1-wojackbb@gmail.com>
To: None <wojackbb@gmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Jul 2024 10:49:02 +0800 you wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> add support for Dell DW5933e (0x14c0, 0x4d75)
> 
> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> ---
>  drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net,v3] net: wwan: t7xx: add support for Dell DW5933e
    https://git.kernel.org/netdev/net/c/a1a305375dc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



