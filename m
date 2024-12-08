Return-Path: <netdev+bounces-149941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CAC9E82FC
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AF918842BD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884B8F77;
	Sun,  8 Dec 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2puoYXl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514E9479
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733621414; cv=none; b=cyHzxcli7prHXXdegySeDklBxGf2VR/dpPFlf5idU2pAmMnqLIZg7Ujr/uy7MgLsgNN/VYJ/L6YfOwwIB/5CYHxA4JefEvrqBVhoD/ZZEO1MtIHMS396DfrEsW5YU3DIIgRIJlADC88vK+msRSazWCf+XS/T/r1zIEW0FiluMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733621414; c=relaxed/simple;
	bh=E7vPT37YcJzE304iAfODVoB2F5z6IuZ9RPig6yw3KNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KsLVdLlQSWNelTQHpT7q+Krm8MRZOuLhui4VB/g2y2WJBigrnXulZJqGcZ2QuGhNs1xF6a5hekI/zbLciaKPANpvIBuqfcQ06LvGV+K10fwt9HTgUaVTo8MVqnWIdILMTdNxcrSd+NRrAomOnRQvEaKbtqrMaMYoD59vonq4aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2puoYXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4668CC4CECD;
	Sun,  8 Dec 2024 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733621414;
	bh=E7vPT37YcJzE304iAfODVoB2F5z6IuZ9RPig6yw3KNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2puoYXl5R/haaMulJeem8Z6m3IZCK9zJgCg8Iwk9OtsPHvmZlV7JlqiwTt6FWcTR
	 BRIrG4j6AiGF6p52V6M805iy1SfcZGcF737qoGjDT1ES3Pb+HKCvMd/MrthEt6kH5a
	 hwUZTMHsNyP8TiI42HfO+n9JN+X5mRZS6DHGGFlfAyZdOrMONuqcCs1mTISYbZAWww
	 wrII1UttDAxpTaDvsif927m/dEH3XaWPir1HFsG1zEofyOlr96qSfX+RhYJv25kpN0
	 JCI6ZMciISx1Z6LFfnZw5B2mGKeKxlrN9AR9Mj2j7HF2xKP/uaMat6Av5kaUyQTK0Q
	 wjDiHhBKqgKqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF13380A95D;
	Sun,  8 Dec 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] tools: ynl-gen-c: annotate valid choices for
 --mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362142950.3127133.1101714095899627130.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 01:30:29 +0000
References: <20241206113100.e2ab5cf6937c.Ie149a0ca5df713860964b44fe9d9ae547f2e1553@changeid>
In-Reply-To: <20241206113100.e2ab5cf6937c.Ie149a0ca5df713860964b44fe9d9ae547f2e1553@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Dec 2024 11:30:56 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This makes argparse validate the input and helps users
> understand which modes are possible.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tools: ynl-gen-c: annotate valid choices for --mode
    https://git.kernel.org/netdev/net-next/c/00ab24675082
  - [net-next,2/2] tools: ynl-gen-c: don't require -o argument
    https://git.kernel.org/netdev/net-next/c/81d89e6e88d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



