Return-Path: <netdev+bounces-196390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C79AD4701
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884E7179CE0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3152328C01A;
	Tue, 10 Jun 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk8Y46Up"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C228BAAB
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599424; cv=none; b=TBT0ctAak+z1rhfm0lzr5XrmXeo5UZDNa3vKwrYPWvWzBZKz/o476IpjkEE9JDGi9dDZAA74RM2vAQOmnxAuL+6dtKjr2CxNoEIhTjXyCaKap5bJwB83gWxvO3ZHImLgCxoA9QI/dA5ucmftm050PozRrioPzmgtxDDStsOGJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599424; c=relaxed/simple;
	bh=VLnBGRnT5riPXQGHPVv9nXvuSyd3C1lgbt3ggc3+moo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TKPRlcJ20nFBH6hx9x9tFkbh0kkSc3KKZ4xU235vJ317kSUGdffuYAAljkRsKAM/7Ma0BaZ/8xaaTorAaBpzV44pfV78a2tnjCFdAYwrDDr1Gs6KX+eH9O/cq12SY1vjY8VpkfnJQvQNa07YhmmqRp7HL+t3ec5KRCVU7p71qx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk8Y46Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B6C4CEF3;
	Tue, 10 Jun 2025 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749599423;
	bh=VLnBGRnT5riPXQGHPVv9nXvuSyd3C1lgbt3ggc3+moo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tk8Y46Uppfo0RNht877ASYhhCL8bxfgULwwjiffe8CGk5yGPDuseI3Gi0yuGM7xk2
	 Oh53IHzQYI/V7nPh1p5mHrAarxvhYgSiti5JcAcw7xOdnUeeNfYjL5/Z+b7KiGaS1d
	 Dqc61hAqHe1Saz1GrWW9wMqHVWHMiiLOcaqXN7NDCv85chioIZspdZevtQ539i/OBh
	 gR4h4wpxlorvwSdQfc9sj7oaTVcQzs/SAqo2hffRm65S0lEPUSJQsLIZ/75oJ7CgyO
	 iVCdP84w8QEtgAMsDorTUmwsyOKxqtzm7J6DtNBE/KA6dDZMWlH8XjkxEYZoYydTKM
	 IyrvgILEYdSZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B1738111E3;
	Tue, 10 Jun 2025 23:50:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: add NULL check for get_string() in features.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959945423.2737769.2970076626331161450.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:50:54 +0000
References: <20250513200128.522-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250513200128.522-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 13 May 2025 23:01:28 +0300 you wrote:
> Report of the static analyzer:
> Return value of a function 'get_string' is dereferenced at features.c:279
> without checking for NULL, but it is usually checked for this function (6/7).
> 
> Correct explained:
> Added NULL check for get_string() return value before passing to strcmp()
> to prevent potential NULL pointer dereference. This matches the behavior
> in other similar code paths where get_string() is used.
> 
> [...]

Here is the summary with links:
  - netlink: add NULL check for get_string() in features.c
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=d12a0a7b343e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



