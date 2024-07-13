Return-Path: <netdev+bounces-111287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62F9307B2
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8971F218BA
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008C143C4B;
	Sat, 13 Jul 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw4Q4Sjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016229401;
	Sat, 13 Jul 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720909831; cv=none; b=lp0/0GpEpf0/RwgiSfgpGI2NzgS68Ejq1cL8EQs//YDLTsmfXyryy6rqNVJEcp7HfVUlNJqg20kOEADP4nMqraFIuInLqKM6+MpbnKfAvLwh7SKk843jL7/AxWniNqsAJPfzRJdnSoLmSyOK/i7oSNFlZg/+hMvJ0/5/XSSxuNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720909831; c=relaxed/simple;
	bh=/kxyB3Qgh1/+WecZvn2L0QpS3PENQuiFBDO4kA7IrKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sZSv5/PjvLnyLnb5BPWt4WiL+LCnwVT9dIT8b5z4UKerfrL7FXMIOfgjqt1Frag639CFd8zErDLgss+o/p3NOKFeBmijBeruBXnFOwBFYiwvSfxd81qNrHs4vxNLWyUCRkHmXM+PFO78QVvUoODN5uHz7/Q+rniWKjB3Glx6Hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw4Q4Sjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B4DC4AF09;
	Sat, 13 Jul 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720909831;
	bh=/kxyB3Qgh1/+WecZvn2L0QpS3PENQuiFBDO4kA7IrKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uw4Q4SjoXKWIMLfvkKqlr9g0N9FIgf48q+7Bk7KrTFRJrUK+bc+c6R/PNP7o63SHs
	 CArs28OgQOkxWdAhVgcDu/2AOBfQXZ9q8VyDCuihI0vCY/b73KvnQmKtlAifPw9gCJ
	 We6M76uuuNcIrdX8YRe+Prkcrb07x6TbtD1q7Z/yvhIv6GK6v2Jyfsiph7PlnfPrpO
	 YFnDoXnvIG0lzrxAhWQipd3UFou4hNKAMvaOZZns5uNp+V/0vdFHMZiKLSO3KJ6Hwa
	 KbzZXEpP6m9FeS/9Hcm1Q3vuwLaGbwt/fz0OSj/PnoQx7oKEht54/oyIqh+WtTP8tk
	 5uIZ5iNFKNGZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E98C3C43168;
	Sat, 13 Jul 2024 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] test/vsock: add install target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172090983095.21567.16489087258072186235.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:30:30 +0000
References: <20240710122728.45044-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240710122728.45044-1-peng.fan@oss.nxp.com>
To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, peng.fan@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 20:27:28 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add install target for vsock to make Yocto easy to install the images.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> [...]

Here is the summary with links:
  - [V2] test/vsock: add install target
    https://git.kernel.org/netdev/net-next/c/42ffe242860c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



