Return-Path: <netdev+bounces-102248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8990217D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABE02816E7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09487FBDF;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR3ge/Ri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE07FBA8
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022033; cv=none; b=feP/Y/jJLoEG8rT9yg4+AljpnrHh6uTCfnvGNF1/sL5ktRhBGcc7zhBSeKHEct5scnlT75YLhnnaKcizFumAtkDEU6pRcp3XubPqeVX6NEE3w0qSxJ5bWhDSFykus5W95DvPDwUCoQhjMgS/bAVXfQUCVvRBLqUoKF3BuuON4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022033; c=relaxed/simple;
	bh=lHEDkNzzt3nYqpypAiks5IX3K8fzJ8jsFx+jvXkBpAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mg2g4XggKi7Z34SfG0vZv8krFXnXfr9UYe89/Y5GNKi84Y8sKiOROleV6If/5dq+TByXIOLDSbDq7FRSoYwqNUwfOH5Xt38SA02SJJZ74C2j7WQ6zz9Hmf45fiKz4jqk3K6UBrrni2Mu6cbrkDKw/y4xXDiePA7mRpKSPCRonRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR3ge/Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A24CC4AF48;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718022033;
	bh=lHEDkNzzt3nYqpypAiks5IX3K8fzJ8jsFx+jvXkBpAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BR3ge/Rim+Q0QfnR6yxNUeY81CGMTZKIICF+LsGkBfBv0V6oaX8syIwRpPZ9zSP9J
	 JYj6HXRYhHxmlwKno27jPRZ7DGKeVrdMLvbwo6ySNX0rX0GOQ8ugdhT+/QIXRqTj+q
	 NpTS0c2M5OGlHdhKHyxXEzBkXpD4IRNmHxwDMRC0c5lH4d38sKnGl9eMYeCRnuRFjv
	 0LVOc2mzKD4QaRt1xGXVOqxUUoHvmdiiSaHYhNZHL836NnHi7iF6D22zdSAHI4rT3c
	 wu0PWDuvLfrsulLHQzUjSXaU7XL7u+ODFeVdfpCdlTessdj6GJOJaS2NHcXmqvKaCh
	 16XZRtE3P/Prw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BCF8E7B609;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] geneve fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171802203330.2008.15446674732099700467.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 12:20:33 +0000
References: <20240606203249.1054066-1-tariqt@nvidia.com>
In-Reply-To: <20240606203249.1054066-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jun 2024 23:32:47 +0300 you wrote:
> Hi,
> 
> This small patchset by Gal provides bug fixes to the geneve tunnels flows.
> 
> Patch 1 fixes an incorrect value returned by the inner network header
> offset helper.
> Patch 2 fixes an issue inside the mlx5e tunneling flow. It 'happened' to
> be harmless so far, before applying patch 1.
> 
> [...]

Here is the summary with links:
  - [net,1/2] geneve: Fix incorrect inner network header offset when innerprotoinherit is set
    https://git.kernel.org/netdev/net/c/c6ae073f5903
  - [net,2/2] net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets
    https://git.kernel.org/netdev/net/c/791b4089e326

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



