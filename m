Return-Path: <netdev+bounces-99936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C78D7272
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C1D281F9D
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4423775;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6kiCXT/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EE1D55D
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280434; cv=none; b=SWojK2I+d7QU9Jp2udoZcZTxPjDlZFDP0AMmCvYqwNFFMUlPkNLH+IAA5yY5wyJv3diuKCb2xKDo6Dr/kkYQHmOCVbLeToOyCcewUKkBCyPu0acw0iuCPxZgbgz1dJx7tWGz09oRD6OghOHQFH4mqIHrjMnphFqTE2u2Su7ob1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280434; c=relaxed/simple;
	bh=SF9f83XmMGbMCUnNR1wGIJPrEwXUBjOkOkxovBlolK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e7nQ33MB03FfsJuykcGZjE1cbX5IvtS57Iv2OXe5aHUXMmFv/19XsbLqrYKP1gxKUkps87BddAp70YCHvajrUDyzg9bVnFz2RDycJHpUoEDOWlPzZtuMF2vl93jlzPFWRgOpecNhySdQwXfRhgOBm50qEHMg6C72PnXBKEn+Hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6kiCXT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CB7BC32786;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717280433;
	bh=SF9f83XmMGbMCUnNR1wGIJPrEwXUBjOkOkxovBlolK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d6kiCXT/e/zwMbCqhK43c8WqgRwpVhHE5mzMK1QQKuT6ztbOdgKu6xJ39AUFllViG
	 5sYNe7eEKNYQx/LFFCWzeY6Y7miG3pMmnMyCPDkZnEZHDQOH2cHdl45gLOx90wMpGa
	 6SX4al5CSiQu2S8WzKuWrq2RTAf5mLjWJ4uzmEbKfPJfkgswHqROSPBswWz4BKllAM
	 fWyWtd/zqlI//mpK7xzfEHN0c6fJXZgQADjtexZV61syPaS5o9aA6bmq08LCMKzy9x
	 WDUu3IYRQ3bTt9/GyH7FQEi0LWV0Rz+A9Xw3529vgEyqY4lsc+RcIs0Bjszu4CNVHC
	 Wrw9BBNiuZKTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BACAC4361B;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: init tsinfo stats if requested
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728043356.17681.5088618731012026625.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:20:33 +0000
References: <20240530040814.1014446-1-vadfed@meta.com>
In-Reply-To: <20240530040814.1014446-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 rrameshbabu@nvidia.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 21:08:14 -0700 you wrote:
> Statistic values should be set to ETHTOOL_STAT_NOT_SET even if the
> device doesn't support statistics. Otherwise zeros will be returned as
> if they are proper values:
> 
> host# ethtool -I -T lo
> Time stamping parameters for lo:
> Capabilities:
> 	software-transmit
> 	software-receive
> 	software-system-clock
> PTP Hardware Clock: none
> Hardware Transmit Timestamp Modes: none
> Hardware Receive Filter Modes: none
> Statistics:
>   tx_pkts: 0
>   tx_lost: 0
>   tx_err: 0
> 
> [...]

Here is the summary with links:
  - [net] ethtool: init tsinfo stats if requested
    https://git.kernel.org/netdev/net/c/89e281ebff72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



