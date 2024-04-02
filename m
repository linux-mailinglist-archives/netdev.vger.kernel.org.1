Return-Path: <netdev+bounces-83878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D67894AA6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5511CB23D34
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E61417C7B;
	Tue,  2 Apr 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjve5mZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DE17C61
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033429; cv=none; b=AQY5SesBtNe5hI389Wn9W8GbkK9uyuXJJvVSycVwH8faE+0sbMW8fR93L0S+Dy9kicEGOHp+4ykY14l+l8sRAsAb7/GnQ9riwOVhQC7cfopMFTbHIPr2fkgtrk047s6+E1uXlTcya3dNe7QYZeHwFQ8P/7CEBSh+XQ6wcIW2pJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033429; c=relaxed/simple;
	bh=p0IzjC06pOhJVIcX7jMCS72dcpu0zCPqM1/NrOV+aAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eje6hX8gkPaRubdbbbdSdWiXBR0760xfmOJKX/22tOZRyWJOmuLwoohb+d2ygmvAVz0T9nL8c6LQi0y8lp0MTxIsZ03esdaI9oIG1VwYn9pyjk6+R86Ohx3bUfo+fQufLxRWV9InkcfI3tCOTkhDeU6WThDF+lcHawvQoq2EUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjve5mZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73FDAC43390;
	Tue,  2 Apr 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033428;
	bh=p0IzjC06pOhJVIcX7jMCS72dcpu0zCPqM1/NrOV+aAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cjve5mZ5VYuCOCZkQmFxUvunLXwOD5CZRNfWjS4VQwaGTTXg4YnBx6qZUW/8MHZws
	 py1qeZmyU1v5Sel/bKUiKdvom6yteK1Y6jVL0Vp6bxiYFQGt7rrrnFFt/l+VZ7XC/T
	 avttvEL3W49iNkY1GLkEiBXN6QNoEN1NPqKBUrbHseu8cQS5mFOcDTZwV2aeCLw/Zb
	 9mybRG+oGW7coWJTS+XRj9oK5etHHJ0ZrlzFP1Fx/Pdfu4qENQoJqO3vGGpzKtTXmo
	 v8zTxnlFkCstVCbxAJhr2QFkki7oXdW49OOPHTpn6E3DM7ReGOwJNwtErI3s4PY0Gf
	 CjllBcfo6lvXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61637D9A14F;
	Tue,  2 Apr 2024 04:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Fix VF MAC filter removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203342839.12415.7819569177815858395.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:50:28 +0000
References: <20240329180638.211412-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240329180638.211412-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ivecera@redhat.com,
 horms@kernel.org, mschmidt@redhat.com, brett.creeley@amd.com,
 rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 11:06:37 -0700 you wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Commit 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove
> administratively set MAC") fixed an issue where untrusted VF was
> allowed to remove its own MAC address although this was assigned
> administratively from PF. Unfortunately the introduced check
> is wrong because it causes that MAC filters for other MAC addresses
> including multi-cast ones are not removed.
> 
> [...]

Here is the summary with links:
  - [net] i40e: Fix VF MAC filter removal
    https://git.kernel.org/netdev/net/c/ea2a1cfc3b20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



