Return-Path: <netdev+bounces-160471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE761A19D7E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 05:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A703ADDC1
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC011494A5;
	Thu, 23 Jan 2025 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arRBY/Z2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC1487C5;
	Thu, 23 Jan 2025 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605409; cv=none; b=Ue5KxCus9qN4eP4EjodSx7tF5vB0AG6fuwd+aTN4lDlRGO/znG9olGuo3KbcGkHrjp9mhoDpdmMGkPMKYc3SaOwe+YBaJa6KIOTU51LcVvagLKoVl0KNQaHoJ2A2oUgw0kAvq1VwzLzLthRI+nhMoU4H4H4v04hm5L7zpEI0Tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605409; c=relaxed/simple;
	bh=daqV2j5gKWoRRAkiUI749/S1FrgW6ntJamzuwaoxGxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VcSRntFwpZW4CrXeQwcHphgHhc/Pp+G1PDgIMIbZnnrChjFwtnaw50NtfVO9rL7Jr+uLNjN18yaCAtjVJPJdABToqmo5+AeDeNkndCKOBO+luv3OjX9zhey7bXXD8kijaAkfWZlEfeD9GH6Fweb1+gFHGHrMC83jmj/QWAbP4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arRBY/Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC76C4CEE1;
	Thu, 23 Jan 2025 04:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737605408;
	bh=daqV2j5gKWoRRAkiUI749/S1FrgW6ntJamzuwaoxGxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=arRBY/Z2wKPtTGv1SRBHhnMXAeqhkibD4Jd0pu89xYNvZvumeQ6x+Imy/AAiKMS6w
	 Xczt1+jJazdSEoD2Zm8+4RedyiSLZa4WRIS1yJOq3lPB6+XicSX2rrHCJcNASn/6gv
	 s1RrCkMdrE6RCN9PKjQfCPHTACPVa2y8yYRLJfPQ3imlYVjyeyuVCB4q+/tRmpkjyi
	 7mQhsWU4vfuSuA+MjdEkk494mwPVGx5taq85RePYsPGYg9GPZN7PVldV+VapJNytY3
	 wEM6QqHn9pTxEiKfAs0WthvSa4mPO64KuRQG3EANZlhHgMjkEt6aySqH3C9QR4sdX8
	 C3uXOpzfLfplw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340B1380AA70;
	Thu, 23 Jan 2025 04:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] net: airoha: Fix wrong GDM4 register definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173760543275.917319.6422811627993615173.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 04:10:32 +0000
References: <20250120154148.13424-1-ansuelsmth@gmail.com>
In-Reply-To: <20250120154148.13424-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: lorenzo@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jan 2025 16:41:40 +0100 you wrote:
> Fix wrong GDM4 register definition, in Airoha SDK GDM4 is defined at
> offset 0x2400 but this doesn't make sense as it does conflict with the
> CDM4 that is in the same location.
> 
> Following the pattern where each GDM base is at the FWD_CFG, currently
> GDM4 base offset is set to 0x2500. This is correct but REG_GDM4_FWD_CFG
> and REG_GDM4_SRC_PORT_SET are still using the SDK reference with the
> 0x2400 offset. Fix these 2 define by subtracting 0x100 to each register
> to reflect the real address location.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Fix wrong GDM4 register definition
    https://git.kernel.org/netdev/net/c/d31a49d37cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



