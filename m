Return-Path: <netdev+bounces-130776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7498B7C6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96481C22ADB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDF19D07A;
	Tue,  1 Oct 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIl63NUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167719CD1B;
	Tue,  1 Oct 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773233; cv=none; b=KU9lJzSF7CJ4ZvnYOR72DSTGpacFc6EgyrW73HtcbR/acSN3ECvyEJpQNc7k+l133dXA5wUpG3je5PGK8Y8uWsbLRmDRJ0NtOdZLXofN8w5tn3YbwFC5q2DhZ3QiGR9Z4zstrnD9DwUJySR/BovfVAbz/JwN8/3t3axbsZzayDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773233; c=relaxed/simple;
	bh=qnrRGB2hE5WK70hKlKMThajCVE7OY91rJ5Op2WASCrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oWHI9MhqN6sv5b/NyAQJWaKf+rcLVEAsBFY53fG+d7a5M4HXY6bdxfcF/RCk5/0PPVHhQyrFeEy2lsCFMKD98S/MK0Rdd8N1i667oNQps5KI5L7MWHOe5UqbDANPwbwF74koH/F6p2D7tFDdf+lN5YdNVCvYYoXPZ2FTZviiwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIl63NUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7436C4CECD;
	Tue,  1 Oct 2024 09:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727773231;
	bh=qnrRGB2hE5WK70hKlKMThajCVE7OY91rJ5Op2WASCrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nIl63NUPhAxWs0fwz12hKTNZlgRNK5u3ktkjXyVvG1Rhtr0X3jHESsd8dzcmqN1Th
	 8MH2GX4F7WuIbsxnBG8372PES9N7Qh/TX/Mr2BK5jfF2faB8a9yXsD4W58TqDtvk1t
	 mys06ASO2+rdrtYDnJa2ABqfZnOANlvI9jqYB2OnZRIhx5B9GM2g8ARsHoWOBEpvGR
	 e1ObqAvHrZdUAJIGMSmXzaG1p2GapYxvD0yZEFIvJd/Gw1bXg8PVwSLTuxJGtQG/yr
	 CP+UpH/sp0A/puOpTo3Nr0dsdJn5lyQ4l+6aGUUVYXBdKgEEM320E4BWCrUinFlViZ
	 PWdHSPxU2/lfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB163380DBF7;
	Tue,  1 Oct 2024 09:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] net: ethernet: lantiq_etop: fix memory disclosure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777323449.272646.497497810031492357.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 09:00:34 +0000
References: <20240923214949.231511-1-olek2@wp.pl>
In-Reply-To: <20240923214949.231511-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 john@phrozen.org, ralf@linux-mips.org, ralph.hempel@lantiq.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Sep 2024 23:49:48 +0200 you wrote:
> Changes in v3:
>  - back to the use of the temporary 'len' variable
> 
> Changes in v2:
>  - clarified questions about statistics in the commit description
>  - rebased on current master
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: ethernet: lantiq_etop: fix memory disclosure
    https://git.kernel.org/netdev/net/c/45c0de18ff2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



