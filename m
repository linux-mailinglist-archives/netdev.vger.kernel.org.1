Return-Path: <netdev+bounces-162793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C08A27EEC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFFE18822A5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8072226552;
	Tue,  4 Feb 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Edt+7s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D879226550;
	Tue,  4 Feb 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709405; cv=none; b=PVPwkWF8qZz6aC6pqti3mve4xgJtV+A9POrDs27BMgqDTPSykGubOXFTZ2q8YvtQjp7etiPQ49KYHCY3V581c+IZb3W+G1npk3c/Cbn/WCuAYf4DGQ/n6hLklk7D4ZXpY/Ws8bmKZbAq/0oG3C9fe1AHXkufyupkvpfZYWOdI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709405; c=relaxed/simple;
	bh=RpZOrhMpv3L09Zhmm0sES0z2YFIuufsIHhwMxBFh08M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jLz46bONEXScLCAYsiZUAMDrSTRrKDtX95zP6yYNouv/69Pajt8xeoxLh2RdN0TctHk5qmzVYSipDUX4HaicpxBrtPpOTiVvE2y/cXZuYo16dkhQ0B12B1ALttw5PYmjfrPeeoCHtRVnrmOr01ev5IwutFd/51lUJReQarat+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Edt+7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7705C4CEDF;
	Tue,  4 Feb 2025 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738709405;
	bh=RpZOrhMpv3L09Zhmm0sES0z2YFIuufsIHhwMxBFh08M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t4Edt+7s7XIekpcVZLXM08sf8+AK0NGx+hUS1g7fzKJFOfcmMDLM3rUqXUl2zUzxf
	 Rpm3grR+ESd+1yok8+TzxalGztZ1mD8XKm3bZGOzd2kxgDRWZtVYiUYLObj3Py3Juj
	 bqImAbPvWkdXTmQUjR2YlnTI93mjP6ivT4Cl5xX+2eOIWMdmexXwi+aEQeWXSqR3Fi
	 jf7VvT0Zvo63U3HXcsCLCbNk1RmDypURic9Bl2GBJrDMWoScHm8l9Zt6gHcF/k1oyv
	 Oa6QSxcJ6yw+oNDzPw22iAKSwp9ULtGz1aL8BWLUsrPYc2tSteVMP+1VimrPDjdjZ9
	 o7ZP74RzRjdMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7160C380AA7E;
	Tue,  4 Feb 2025 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] cavium/liquidio: Remove unused lio_get_device_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870943226.172153.16714367445659493180.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:50:32 +0000
References: <20250203183343.193691-1-linux@treblig.org>
In-Reply-To: <20250203183343.193691-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 18:33:43 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> lio_get_device_id() has been unused since 2018's
> commit 64fecd3ec512 ("liquidio: remove obsolete functions and data
> structures")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] cavium/liquidio: Remove unused lio_get_device_id
    https://git.kernel.org/netdev/net-next/c/b565a8c750ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



