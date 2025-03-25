Return-Path: <netdev+bounces-177489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41444A7051A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54503B20C4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC11F75A6;
	Tue, 25 Mar 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB/v0tTZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F551990AF
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916604; cv=none; b=F0B7YB6FJBu2qXPUOHrbbehZacLZ19qxCYRaObX0W9Q5voBa+dhf2dg+hdaXjTi6Z2R+IC678FDoforboyBFzPY/5fxmJF4DKVrboSk8POrFR6AXaVZEJBLgz7CYB34cOV+L66sWYEW5KLxHvkRtenj/oWQHkvFWbxZgsHVKbjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916604; c=relaxed/simple;
	bh=gnd0MHLjE2Tyxs8M1Lom3tFTqFurZMYTdcPWuCSBZ68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CcBJnGDAbfE6u9zXj7cWPub7Fxk/fKYVSivi1EcqQw2J0fzW2Kx001uTP8cgE9kVl6dbkby7igeR4qPG6pQh3PMeT/Z0KRPW9u+Qf1l3u6kan9VoglB0WKJXe42r5nKEOruyaqGMEO0kyT8DOZVxkda36M8m1H8ao0meTrbxnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB/v0tTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFECC4CEE4;
	Tue, 25 Mar 2025 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916604;
	bh=gnd0MHLjE2Tyxs8M1Lom3tFTqFurZMYTdcPWuCSBZ68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vB/v0tTZj7vIe+DUrDUvN/UlTrRF6fkT1jzeOF0/Qhp+g0oRM4Rd5cBHSdlj2MjoG
	 Q6QCcSUphKMl6A3r+gmUE82QeGjnOFlrxfYEdHegA1JdPSHDMDMidsRmsrJUS9qyXe
	 7/MPOqlj+lCzbkz/t4x/BNOuOQMnut8Y/30cnyuFVAe+CwPf6SBb8KTyu0af4dgdPH
	 JYqoGVofUl/aBZhgKiM45l1zAovT4RwUhkvRxzjPvgrBabc27JF5EgCd+dzPovccWk
	 PJbfd1+5ltNJRk5veIGmstQ0AjuI5Ch+GT9GGiiRCuMZ130T62J8mDQ1Ohl6By5u2i
	 Mto1jGPxKBeqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE72380CFE7;
	Tue, 25 Mar 2025 15:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ibmvnic: Use kernel helpers for hex dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291664031.618403.6937243786024944262.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:30:40 +0000
References: <20250320212951.11142-1-nnac123@linux.ibm.com>
In-Reply-To: <20250320212951.11142-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, davemarq@linux.ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 16:29:51 -0500 you wrote:
> Previously, when the driver was printing hex dumps, the buffer was cast
> to an 8 byte long and printed using string formatters. If the buffer
> size was not a multiple of 8 then a read buffer overflow was possible.
> 
> Therefore, create a new ibmvnic function that loops over a buffer and
> calls hex_dump_to_buffer instead.
> 
> [...]

Here is the summary with links:
  - [net] ibmvnic: Use kernel helpers for hex dumps
    https://git.kernel.org/netdev/net/c/d93a6caab5d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



