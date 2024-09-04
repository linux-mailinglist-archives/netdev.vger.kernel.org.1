Return-Path: <netdev+bounces-124769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DF96AD6D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0CF1C22BDD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3841EBFF5;
	Wed,  4 Sep 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj7CdQI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376E4A21;
	Wed,  4 Sep 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410428; cv=none; b=ZP8Bg7psjO4Fv5i4G+HthoIKok79k2S5NB1kBhpjRoDZWoyEIMBCCV4ntg6/TRTbJS3PaT3b7NIc+ydFq1cD9ZD3UyBDiGQbuP9THX8obi6YX9Gh756kjre9QTNrc4O1bL85JS1yjScwBaTOLpQGwhiogtxbo7dGVP764Kza2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410428; c=relaxed/simple;
	bh=2ESxtzqtV2oZC47KJLhTv722Zv4zkVX+e7v9h6p6FRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Efn1oyWnoSuQmqkkrsHZ8xG5K1RGgh7oCpihm3RyD6gMN3wLZfsvM/hrxT+Gy2S49qHoEq/C/OUaujD2uy3nfNz6mYT4ovDyfL0KemWmxQhyTvX7I+H/HFhj8DPr5kdG05DV1yikQhmDW7N8aEM/E18Esr1vaUSFD85am4ZVQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj7CdQI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4159FC4CEC4;
	Wed,  4 Sep 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725410428;
	bh=2ESxtzqtV2oZC47KJLhTv722Zv4zkVX+e7v9h6p6FRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dj7CdQI1pJBgK9l5ylcHAfSgwuFRPRwyVIQxU8yxzNlczvrMS7FYv6jNxB67exFo/
	 +ztyWLPEhylX4u7+rGEZxxgbx4Nb3nefIyspLJAHtNMftclC7DZhzsqS0eBHkJl3ob
	 ZmFso7RdRC4lKA9x9Apk9afz8ezsUqU2bYyz+WVrb6+jaVJN8Oza6rjLPvy+nPa9hN
	 kX/cYXeQ17eQ06TgtGEG5trgDRvm5W1cHx9eyTx1Wcv9xi45EyzEH6K3xoJnCwY1LT
	 PkZLA7rf8mkOkq66lKXI5AAe0pLlCSBQRgCUrb3sIDntjrcQUGrorsHzOv14dz9jl8
	 UKIIR5t6J9THw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EFD3806651;
	Wed,  4 Sep 2024 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] be2net: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172541042874.524371.17425248529541145089.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 00:40:28 +0000
References: <20240902113238.557515-1-yuehaibing@huawei.com>
In-Reply-To: <20240902113238.557515-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Sep 2024 19:32:38 +0800 you wrote:
> Commit 6b7c5b947c67 ("net: Add be2net driver.") declared be_pci_fnum_get()
> and be_cmd_reset() but never implemented. And commit 9fa465c0ce0d ("be2net:
> remove code duplication relating to Lancer reset sequence") removed
> lancer_test_and_set_rdy_state() but leave declaration.
> 
> Commit 76a9e08e33ce ("be2net: cleanup wake-on-lan code") left behind
> be_is_wol_supported() declaration.
> Commit baaa08d148ac ("be2net: do not call be_set/get_fw_log_level() on
> Skyhawk-R") removed be_get_fw_log_level() but leave declaration.
> 
> [...]

Here is the summary with links:
  - [net-next] be2net: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/3d4d0fa4fc32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



