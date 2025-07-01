Return-Path: <netdev+bounces-202852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56EAEF5F4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EFE1C01806
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F670272E45;
	Tue,  1 Jul 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwisG6mi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C726CE10
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367597; cv=none; b=NOg0Ok9SB89StNBPIoKZ2zuDUOBs14zwkBexBySFFpDB9lwQYUUDIwAJ/VKgx+tBSGERBId+dgcsiW5j4r09oVw57Xkj0j5ih7XVl1BCohB84ulnsSwdk13CCP1nRlvuOrP1q2/dTmPeaE69pdbJI/cGFgnzDjP5g/DK33EYLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367597; c=relaxed/simple;
	bh=MkD3WD20qC7Ut0jDDH0Gu298Hls1RQbWL3Yz23IzkH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YehPy9iT58FW9UlM/aznmoSYCKYiAJ/Ss6C9Il2W9GVWr21BXqoW3N2x9qHMmhnx7MBQcPyOKdnr15zQooq3v2ONWxQUiA74++tAIvniNbMN5hiPZYUAN7m0H13nETKeIpyhriwRPygnsWZJfK7R3AFhI59HmkBWf/B3c84X4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwisG6mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBBFC4CEF1;
	Tue,  1 Jul 2025 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751367597;
	bh=MkD3WD20qC7Ut0jDDH0Gu298Hls1RQbWL3Yz23IzkH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GwisG6miN0cr3EvTmpetEAkuy1uH8z7TaaI4k00oyxdEe+CktFjhOvban8i7p0wuG
	 ME3VmEbBMj/s3ppXsFtq2tVlihMzcD4QbQDu/kiDIV4QtlI3K948CwblkOI1ewlj54
	 0U/E5sy5fpLrtyFcA+W01guFaOFRJhTFCtGuYeYPiWfbE/Yk3jzgpX6UPmOun/fk2g
	 PT0AUpKNUJf1Z2YeUzBj29cjOXCuG5kaT2oiyDrE9MOHGD0eSVib5ruiLBW7P/XhgL
	 kybdlngmdHXGOmUmTQLuFfjcRWVqgSUfONyRWOd/hKnloUFUntq33yMdUuTDvhYCzM
	 HpgcDHIIKc0EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5E38111CE;
	Tue,  1 Jul 2025 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: fbnic: explain the ring config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175136762174.4118367.10732364437837323221.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 11:00:21 +0000
References: <20250626191554.32343-1-kuba@kernel.org>
In-Reply-To: <20250626191554.32343-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Jun 2025 12:15:53 -0700 you wrote:
> fbnic takes 4 parameters to configure the Rx queues. The semantics
> are similar to other existing NICs but confusing to newcomers.
> Document it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)

Here is the summary with links:
  - [net-next] docs: fbnic: explain the ring config
    https://git.kernel.org/netdev/net-next/c/8b79380dfe3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



