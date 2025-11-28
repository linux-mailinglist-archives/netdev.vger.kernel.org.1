Return-Path: <netdev+bounces-242484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E670C90A0A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A34E47EF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4722C0F89;
	Fri, 28 Nov 2025 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecsOdr89"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39029E11B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296613; cv=none; b=vB+y4WCog5YWg0+jtGXrFj7TTE0pye6DOEdXHw3zzdtSlgUa9fFzfA/HJTxg0N5oY5TaICDBIzI82E/Nq+6kuF6AFmLzpP4lZhPE0LCxDV/Zpvn+S2fMXGV5rhuuqiayzLDTOCVqLlG9P46mlqYxrZrKvFGli9t4EDeaC+TL4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296613; c=relaxed/simple;
	bh=K2Xr8A9fSQ4EItW2U1DFgjbtA11o/Mr9EMYz9HnInRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r5kCFwkJI2xz50w9u+ot8B5LejXQexlRhsa6MWM1VFBxHDE+N6KSzxVUzij21YVtTfBXOeM6VcdP8wWkhW5ZR/uEXxfz0vn7P7GBQGQ0lpoP2gkPUD3lTmhaxk1u8sUDaGQ+9Kuzr6zWQTYGg7NTkI+ZmF68/+F5khdyhaVy+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecsOdr89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED23C4CEF8;
	Fri, 28 Nov 2025 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296613;
	bh=K2Xr8A9fSQ4EItW2U1DFgjbtA11o/Mr9EMYz9HnInRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ecsOdr89hRc0cl4moNY8aXdu6fB8BT7C2P4k1ldOTLasPZ+17QaVLO4pj3iVVi84z
	 +Bp3X4N8GgKM6cdIgGVmqLOrwyJ5192RjMl9NHYCwIs76q3D9Q0PVjEs3nR+lKCDT2
	 lr9+Oip1XCoHMjZPObNj4oZzZvmecb6SE+n0IcYIlBVP6T+QkiQcKw2XISUGWC1Tqt
	 lS/sF1FUwpvzpLt6X0nOcI3y/SwJEyE4F/GaBjlexk/9Yg/+MdqjWJoWJJSaXDPCpY
	 rMsNTJaAi4NmPpwJBPdczJQ4uuv1/x4ZO1W6b4JSb5FXVcwbtcHGESMs5VzINE7Dhf
	 aRV1qZ+AshE3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5C573808204;
	Fri, 28 Nov 2025 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dibs: Remove KMSG_COMPONENT macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429643527.114872.11233539510222940718.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:35 +0000
References: <20251126142242.2124317-1-hca@linux.ibm.com>
In-Reply-To: <20251126142242.2124317-1-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, wintera@linux.ibm.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 15:22:42 +0100 you wrote:
> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree doesn't
> exist anymore.
> 
> [...]

Here is the summary with links:
  - [net-next] dibs: Remove KMSG_COMPONENT macro
    https://git.kernel.org/netdev/net-next/c/4636b4e797f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



