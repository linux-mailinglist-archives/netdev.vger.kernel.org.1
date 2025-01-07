Return-Path: <netdev+bounces-156025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B4A04AF5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31827161966
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419F194A6B;
	Tue,  7 Jan 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9NLiOmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC501940B0;
	Tue,  7 Jan 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281808; cv=none; b=O+fhdjXbWttOxHqSNfqXTde124eWaDVE9KPK5MRlPb8EUh0aWqmwcsdBbQvGyZxW751U/IdK3xkFsglv1l62E0XRuAUqCswWMxDbIXBTEM9hz+w5jEFUm3KJ7GiYotAx4z0iwlv4Xtxj11jvu2H2n1A98KS8yl8p//C4jJvZUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281808; c=relaxed/simple;
	bh=2Rl/hLoacjoKxAKxjdlgB4LqfpqR6pSIKiFXVy76qhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MC9KAYj2yptGjwUzdPLQerOi8TTpBQwBLeUApXkue/hzy1eRM9ASs5FvKxotSYEYGzc5bq4FL1mwkrQZaRbLSwnV/7YHrvpmKl4PeOVVD5gY9hJgAUHrjCqZfYWEloRMmciQip8SP7irSelCBY0BoAGtmmpGvL/PPho+pFXJnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9NLiOmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B140C4CEDE;
	Tue,  7 Jan 2025 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281808;
	bh=2Rl/hLoacjoKxAKxjdlgB4LqfpqR6pSIKiFXVy76qhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F9NLiOmiqx/RujK/QZfwcgfB5CAU/TCgpiOeUARaq/75ZnTUKAT48Qoau8Vs53ajp
	 ACz9gNWQ2AvfbmOUfo0Mu1NU++yx+Njzh2XsZrxX00Hof51LzPTKFi+LGsfMvYeSnA
	 eRunvlZEsqeW5oe6wybFlV1OMDs+PHDtORnk5RWmug2U/i/ojJDDsN4vuVOk2wtIqr
	 2XiZbsFPxQb+C+upvniG1NW5VEL3LuyxH4TKDFz4l9OUxIUj+9voRFYQuuELrMlDr7
	 rD1876Ad43G/992NeCJV8tz+yxzBS81CXd+krJvaVhf2I46W5M9EzKAfHz9IRgVjkZ
	 FlWWFWtcLNyHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6B380A97E;
	Tue,  7 Jan 2025 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] eth: fbnic: Revert "eth: fbnic: Add hardware monitoring
 support via HWMON interface"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173628182976.88638.3355348009760397634.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 20:30:29 +0000
References: <20250106023647.47756-1-suhui@nfschina.com>
In-Reply-To: <20250106023647.47756-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net,
 michal.swiatkowski@linux.intel.com, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, vadim.fedorenko@linux.dev,
 kalesh-anakkur.purayil@broadcom.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 10:36:48 +0800 you wrote:
> There is a garbage value problem in fbnic_mac_get_sensor_asic(). 'fw_cmpl'
> is uninitialized which makes 'sensor' and '*val' to be stored garbage
> value. Revert commit d85ebade02e8 ("eth: fbnic: Add hardware monitoring
> support via HWMON interface") to avoid this problem.
> 
> Fixes: d85ebade02e8 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v3] eth: fbnic: Revert "eth: fbnic: Add hardware monitoring support via HWMON interface"
    https://git.kernel.org/netdev/net/c/95978931d55f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



