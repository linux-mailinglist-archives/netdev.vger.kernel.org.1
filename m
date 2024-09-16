Return-Path: <netdev+bounces-128596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D897A820
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632551C23A3E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE015B548;
	Mon, 16 Sep 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfnJfAfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601831BDC8;
	Mon, 16 Sep 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517429; cv=none; b=EVvE4pnRL7MAzB3A6eMZTUVZawyaXWIZvr9qhAhQHnhKIHIzplKH7AXCPyFfwZD+jD1bXFIkzu1bBbSb6EEOKTXpTTlIwUCo+IduqJT2N6UNIU0qmyNxbF9cSWSmItbtBHH0HK3k4MvKXldIcboR30H2pWVpyiMywt7pVmJmPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517429; c=relaxed/simple;
	bh=mitQRs/4RxakfLIGJqBVURErMP+2VQrjP/Gui4PXVT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k9YKRI4qDFbWhcqKtR6qAFqXLKY+XGGK9EyKlcCSqj9djTZI0DMAY1U7iN65gD+7UxuO4KSMmPq8XhCwfA07R6zt34fdbKe86DGm680YXdpNdiPsIqBiTCWBoBbr5e3KKoowFFsRQiCvhAplQGO06/B9GQbarRZgVPb4xT/M79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfnJfAfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E74C4CEC4;
	Mon, 16 Sep 2024 20:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517429;
	bh=mitQRs/4RxakfLIGJqBVURErMP+2VQrjP/Gui4PXVT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KfnJfAfrvFz+ak1E998PwkYvVhybcVUd06DZOH70xha3E2NNmaW5ojqgPWQZeJSHV
	 vQxtpNO6qIO7r9ahHO9UcBRSneDUI8PBNn2D1o8I/NVHsK9iU55/d1UNLb+ADXrzPt
	 ZEQysX0GUAC/77cvYNPhdfBMyOzXrsvZjJCvolFPscN/pkZODGV4Kbm1KJSwlbuMPT
	 Yppi/el3q3kSFjiEdNaVPmnYYgFQNcI9ytK29s++YnPigBuGCBflvB33YXYF6QM9lW
	 MAfaAwnWAk3S1atH9avFE0YxqOPiqowIdeCQUnS5inppAS/CwynVUzLKeWxBRJ+P9o
	 2rX4YSm8I82Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24F3806644;
	Mon, 16 Sep 2024 20:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next 0/3] Add support for new features in C33 PSE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172651743051.3804981.18226051659707322760.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 20:10:30 +0000
References: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
In-Reply-To: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, mkubecek@suse.cz,
 kyle.swenson@est.tech, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Thu, 12 Sep 2024 11:20:01 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This series adds support for several new features to the C33 PSE commands:
> - Get the Class negotiated between the Powered Device and the PSE
> - Get Extended state and substate
> - Get the Actual power
> - Configure the power limit
> - Get the Power limit ranges available
> 
> [...]

Here is the summary with links:
  - [ethtool-next,1/3] ethtool: pse-pd: Expand C33 PSE with several new features
    (no matching commit)
  - [ethtool-next,2/3] ethtool.8: Fix small documentation nit
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=35a3d5003331
  - [ethtool-next,3/3] ethtool.8: Add documentation for new C33 PSE features
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



