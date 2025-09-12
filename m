Return-Path: <netdev+bounces-222389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFDB5408E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872365A420C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5123F429;
	Fri, 12 Sep 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV4Vjp7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E820E6F3
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644807; cv=none; b=ZvCX0No4rCDIncuh0IqiD/yKwUOzmFv9g/EKPnoCRvcmaJIIAmzmgIIJEMbvi5zQ1DRH7W2jx5RUHPr1aujYI9z5mc449uhy4fUjtln8ZSh17N0+MJSZB9sPRKw8lAhSXY6QajRyB2g/N/PuDBOjA+yQrQcsYIHIqSlymIw5DpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644807; c=relaxed/simple;
	bh=x7mZHrBOM6QGdB6tsfyaUJZ2fX75xDUiN69iRB2j64Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mijVPE4Gd/5QWSxlmk8ll2OzxySkp13yLvXSHGQ/EsSmXqRpdjFbWvi43QwQtl7DkzXACmjE3yLVP0eGkNq2TP+SIuLZAbmirCJB/YEMnAgyTo3s1CX3+UcCu3bgsTHdYI74DqaTKOh1Ezsz3MChxniRE5zWssyQD6Da4Sx5lEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV4Vjp7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311E4C4CEF0;
	Fri, 12 Sep 2025 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644807;
	bh=x7mZHrBOM6QGdB6tsfyaUJZ2fX75xDUiN69iRB2j64Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LV4Vjp7/jiC8KmEtgRrFBvriEAx5n7KhQM5/x3egyidhGMbV4Nt+oVe3Mp5WLQjfQ
	 AhskIOBiqlZW18yaNe0cSSdqNjFC/8ZfnfRvaF5QV5WbSst50VKXGV8KAXW7hxfBo/
	 WBj7JI7GueJwOGnpMyZF4uTp4PePJ5m62ix4GGswdLo1lUae55i5DSnmmGQGSS25w/
	 eEFii3h1Oc8FGWWtc4G2CHoTet5fFptpscEyFpYkucZQ4go0FzSZMGsipYSFOGHvln
	 dZYVyKG686PG8mB98efLHibE6e4zbFotlslyBx8gQGHxXLSjhKoz+wXuk38BuEKCXf
	 X/8aZqDGlJpSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE0383BF69;
	Fri, 12 Sep 2025 02:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] udp_tunnel: use netdev_warn() instead of
 netdev_WARN()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764480970.2382321.18187125356507305675.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:40:09 +0000
References: <20250910195031.3784748-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250910195031.3784748-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 12:50:26 -0700 you wrote:
> netdev_WARN() uses WARN/WARN_ON to print a backtrace along with
> file and line information. In this case, udp_tunnel_nic_register()
> returning an error is just a failed operation, not a kernel bug.
> 
> udp_tunnel_nic_register() can fail in two ways:
> 1. "-EINVAL":
> Invalid or inconsistent udp_tunnel_nic_info provided by the driver
> (e.g. set_port without a matching unset_port, missing sync_table,
> first table with zero entries). These paths already trigger an
> internal WARN_ON(), so misuse is caught and logged with a backtrace.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] udp_tunnel: use netdev_warn() instead of netdev_WARN()
    https://git.kernel.org/netdev/net-next/c/dc2f650f7e68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



