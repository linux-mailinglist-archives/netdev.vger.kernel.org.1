Return-Path: <netdev+bounces-239377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C1C67436
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE2B13652AC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E122BE7D6;
	Tue, 18 Nov 2025 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejwHLFda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0329D265;
	Tue, 18 Nov 2025 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440262; cv=none; b=S+9X3Bzff4seHwnfy85gu+fWgSMWfnuxhq9ymwRu1w4yOdCIFhCjxz5Uh6GKQdHLQhblKiPhzrX+P/MNtkdnPQWRY4ouMUnw/CV8oRVukV38MHj3s5IzXwb2jpgH6PInNJ2zd9aEHLSRJp/XmwA23DmbdIcTD0Fk7wn10+K/Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440262; c=relaxed/simple;
	bh=hIWghiiiw3G6q2cjtlCU0RnuVD2T0o1ZpqmSbacYUBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kPq3ZCZ+jeH7VK4dLueNzsS59+iuv0xxMRqyzPHYR/Kr2efu/mCc4epKapnec9b5LMAjp4Rxi8Q9r1Jnpf5QhwXySO9GHfzckyZMhPTi1JtNyX6n1YDBYghji53akkZR8pZR7T8GqVjLG1LWPgxsmgEgwnAm0WvcmMDwzQ/NXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejwHLFda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9223BC2BCB5;
	Tue, 18 Nov 2025 04:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763440260;
	bh=hIWghiiiw3G6q2cjtlCU0RnuVD2T0o1ZpqmSbacYUBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ejwHLFdaEUcS5rqqGWjSv8D+HZ/pPEMdNHrErLjlGoAtZWDjhkeyrz0fHAE/MYgN9
	 EOjNh9IEIX6SnH+lOVftaaQ3oVB2EtHl2pi9N18ppQZMh2Ac501yszi/6KUAQiiDiE
	 kG+p2XBdLAj4+PUeEM+RKPmGI2wBdeWqMZqo+qM/qY2CL99mPmVjaLSA5+m4fJIUMm
	 aKyXYWUjprJkqpbl/rMWfyLqqOTDhVm5silq4H36lNlVem6P2R0yEHwzHxe82Ne2DT
	 7w96f60nD/GMvpxkzea/AyCtDzJaM+fGPbQ71UiFgHioFdoR9lpaWBB89z2bCQJMXa
	 XHcYnjn6sJlxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B603809A1D;
	Tue, 18 Nov 2025 04:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] dpll: zl3073x: Refactor state management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176344022699.3968687.11755986970582847257.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:30:26 +0000
References: <20251113074105.141379-1-ivecera@redhat.com>
In-Reply-To: <20251113074105.141379-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 mschmidt@redhat.com, poros@redhat.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 08:40:59 +0100 you wrote:
> This patch set is a refactoring of the zl3073x driver to clean up
> state management, improve modularity, and significantly reduce
> on-demand I/O.
> 
> The driver's dpll.c implementation previously performed on-demand
> register reads and writes (wrapped in mailbox operations) to get
> or set properties like frequency, phase, and embedded-sync settings.
> This cluttered the DPLL logic with low-level I/O, duplicated locking,
> and led to inefficient bus traffic.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] dpll: zl3073x: Store raw register values instead of parsed state
    https://git.kernel.org/netdev/net-next/c/58fb88d30b02
  - [net-next,v3,2/6] dpll: zl3073x: Split ref, out, and synth logic from core
    https://git.kernel.org/netdev/net-next/c/607f2c00c61f
  - [net-next,v3,3/6] dpll: zl3073x: Cache reference monitor status
    https://git.kernel.org/netdev/net-next/c/5534a8202d7c
  - [net-next,v3,4/6] dpll: zl3073x: Cache all reference properties in zl3073x_ref
    https://git.kernel.org/netdev/net-next/c/5bc02b190a3f
  - [net-next,v3,5/6] dpll: zl3073x: Cache all output properties in zl3073x_out
    https://git.kernel.org/netdev/net-next/c/5fb9b0d411f8
  - [net-next,v3,6/6] dpll: zl3073x: Remove unused dev wrappers
    https://git.kernel.org/netdev/net-next/c/01e0e8b6a2d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



