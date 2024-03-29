Return-Path: <netdev+bounces-83140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345489105A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342BC1F22252
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13617999;
	Fri, 29 Mar 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYlYi+uL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17917554
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675832; cv=none; b=p3fMaFV8nNQWivRNbMBja2smLWd7kt8OZVM0bvRtH7Z9l/r0/TxvuMM8oaVt37vJX4f7W91LoJdQM4hjmwh0yJTBERtAf9RWVuDGEnsQsacYbbQ/wWz6wK7mHxsanj7ilKBrjeAbZ6wzQkohobhed+WqBMoeh1qSwQ0JcNUFESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675832; c=relaxed/simple;
	bh=1dbpCAst9LeCdvmA/1tkDBrDw+XB+U8yA8dyKd5cetQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tyncoyJpnDiKMuUbzg5ufao0IM+LVGBv3l6sE3isP5zG/Sw1Ku39mpJDnHx3/fEAJ+bPpP4+nFcWr37VQbcZ9hu3zjVvrwOCqw4m8dayP1poTX5dGxtet3/soJiUFynXs6riRFg6vKS0l/fNg+cncmVJ3GMEFanrAppAWxWLR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYlYi+uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 838E0C43394;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675832;
	bh=1dbpCAst9LeCdvmA/1tkDBrDw+XB+U8yA8dyKd5cetQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JYlYi+uLKVqeK7FVcz8ybPxJP6viopIeHdJenCsj6uv2zBybVGPqcFTLDxVSmnYCL
	 11QK9+wMI55OnQzbblcAJOMgeQG0n1Evl7O7bC9GW+r9gbcEwa/m6QDNHHVizZxSNF
	 VJubGkEALeP8L8FrOuW5gZV7+zqp2QzIBed/LBWRR+e+5FQnm8nFeCElREZMdSPT7E
	 tta4uM5S1RA5cpMCeYS5ad0W7mq4WChGBliyAwJuXnxUVNP3iNMkaVb3fp6ZpNUi1n
	 M44Ro6wnUSMoNYALNqpOcA6m+oRbRyOMv51d3LYTSuxvsrvTJDI3MPbz8RST5gk8XK
	 ey+Aayn45Pjgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 754ECD8BD1D;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] Documentation: Add documentation for eswitch
 attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167583247.32458.11370717659230070472.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:30:32 +0000
References: <20240325181228.6244-1-witu@nvidia.com>
In-Reply-To: <20240325181228.6244-1-witu@nvidia.com>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, bodong@nvidia.com, jiri@nvidia.com,
 kuba@kernel.org, saeedm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 11:12:28 -0700 you wrote:
> Provide devlink documentation for three eswitch attributes:
> mode, inline-mode, and encap-mode.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3: add Reviewed-by from Jakub
> v2: feedback from Jakub
> - add link to switchdev and representor
> - emphasize "mode"
> - document that inline-mode and encap-mode can be use either with
>   legacy or switchdev mode
> 
> [...]

Here is the summary with links:
  - [net-next,v3] Documentation: Add documentation for eswitch attribute
    https://git.kernel.org/netdev/net/c/931ec1e4cb7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



