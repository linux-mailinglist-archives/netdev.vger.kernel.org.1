Return-Path: <netdev+bounces-227265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9FBAAEB7
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB621921E93
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32DB1E5B71;
	Tue, 30 Sep 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd2e6YGR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08F35949
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197039; cv=none; b=XVZStg7wNjXm7U8znSoUa3+Iqsc1/oMrP+x4jTvCIF+t0y0WLmTAErj9FIfHWLYmq1AHdQcLUvWEDulDWvQOA5bHgG8GB5O3HfMwiy31iuTbbk51uvUxpL+P1oCw3Y+qdLZjjLsK+e1BV/rL9uiOpr/EqixBDrsHw1x82tItLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197039; c=relaxed/simple;
	bh=7vCpZdeQwPS2fyRYRDEZmqUp8l+5Qw9jGbpHMNpeczo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uy3mmhqw8t+MlKAQn6h6IsT7QhAs3cb6pgcutwgdOMFFzpypI+IPbc+WPWVqZgumHvq5Q5PodU15w041OdeWlXQAfbSDciNvbOwCYPMVjoWQqJKt0lY7GCBnp4wtNwjJ4TMy8uNhVUDvz2iNC2iiqYJAY0AkRozvkrY6VklBlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd2e6YGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4578DC4CEF4;
	Tue, 30 Sep 2025 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197039;
	bh=7vCpZdeQwPS2fyRYRDEZmqUp8l+5Qw9jGbpHMNpeczo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qd2e6YGRca9FPRFeBTyxsaQ0Z4G2QvSju+SMypCjyz8zP/dv9uTClWS/k5urHx5BJ
	 rv+1oMmASFlrnKBCLvSp9PIklV2uvWEZfjy11XGFAIbNCfW9gyBpjgY7dI7bWtPV84
	 wzpcfsevwTGg7GpJimWXH5lIRMnR1SDD3Vd2hnJAT90aMw3nYfOAP/yI3eTk9XJI6D
	 8eJBMKokHAjaGqjBFntX+P6QBDhokDJb+dmuafdfXWoLsog1nTa55by20yNOJojWhW
	 sXPBy1T3OvxsRZ6VjTTDT6jfJpZNAvyUvbOBbbLMsHo/XF3NfX8BbJPgMmmbHbgdAV
	 7W4/xtQvjZVYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE139D0C1A;
	Tue, 30 Sep 2025 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: rtnetlink: fix typo in
 rtnl_unregister_all()
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919703249.1783832.2626363077014602597.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:50:32 +0000
References: <20250929085418.49200-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250929085418.49200-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuniyu@google.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 01:54:12 -0700 you wrote:
> Corrected "rtnl_unregster()" -> "rtnl_unregister()" in the
>   documentation comment of "rtnl_unregister_all()"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2
> Drop change for "bugwards compatibility" as Jakub comment.
> Added Reviewed-by: Simon Horman
> Rephrase commit subject
> https://lore.kernel.org/all/20250913105728.3988422-1-alok.a.tiwari@oracle.com/
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: rtnetlink: fix typo in rtnl_unregister_all() comment
    https://git.kernel.org/netdev/net-next/c/4ed9db2dc5d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



