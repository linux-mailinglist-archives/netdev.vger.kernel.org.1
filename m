Return-Path: <netdev+bounces-79311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D97878B51
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 00:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD79F281443
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10258234;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRYnXn8g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3858119
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198033; cv=none; b=AMlOonx/fm7yQxRyrTp2C7kS2b6WHo7i2dNeg1YQFdWtrD4b9ShS3M6ck71tQl341BvSKVxfvh9yYsrIM3laoMHel5BC30GW4O3LsZddN+T07fMHGhfaMqM7XJCFsVyddVIr+aiik1l5XRMwt6hEVguKj+QPbTWB3kyc2PLZAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198033; c=relaxed/simple;
	bh=137TvHcexZSr58dHCalta7cWntD+7qBRdlYP2+viTVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k+WJmVHRdeMp7YGN1UYKDkIPGqEm8VoJxWSDkCzrGscbL461JLYehMExk0SQsaXLbVoIY7iP8EqNhM5ZkFmV7iyBhxFGgzLZjj/+0uejALpCJXEmXAW/hbC8WMfnCfXFWSqre1Ffwf4buv7GaiG5Mdwk4smsIcR8XT7heescIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRYnXn8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9905FC43390;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198032;
	bh=137TvHcexZSr58dHCalta7cWntD+7qBRdlYP2+viTVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hRYnXn8gEA+KrxYJ4idFZDAGFDOEfIXlIXJwiheI9AjQDk19kBcdnBLgWv8ZKi85A
	 YIPy8rrr9972EJ2NTFAgVADWBqME0Tlq81DgCQhyEPq4LBqTnd3QwSShmAj5NCp3eS
	 dwzErucKbKspMPl8FYU3eCOfQ+wPiglEtzi09Y3OSTZOJg8YelMrht4p9FT/1msFgV
	 c1BbFTMwHQorSJswKZGfmET+5PQo/jZM5oh0+QJ3oHF/EjD6lRGG6ODPadMnRuhG8f
	 EstRqRzF57UuhNrJ5RUwG+kT7EB6IPT6VKDVqjfzVeDt/9B3dqLbnlKfnGs5SlQd9L
	 Ru//65TUCVu6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E221D95055;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Fix length of eswitch inline-mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019803251.14238.5061905000337723301.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:00:32 +0000
References: <20240310164547.35219-1-witu@nvidia.com>
In-Reply-To: <20240310164547.35219-1-witu@nvidia.com>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Mar 2024 18:45:47 +0200 you wrote:
> Set eswitch inline-mode to be u8, not u16. Otherwise, errors below
> 
> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>   inline-mode network
>     Error: Attribute failed policy validation.
>     kernel answers: Numerical result out of rang
>     netlink: 'devlink': attribute type 26 has an invalid length.
> 
> [...]

Here is the summary with links:
  - [net] devlink: Fix length of eswitch inline-mode
    https://git.kernel.org/netdev/net/c/8f4cd89bf106

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



