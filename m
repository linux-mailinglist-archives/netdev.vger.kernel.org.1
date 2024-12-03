Return-Path: <netdev+bounces-148433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FC9E1B27
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B678B35C90
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D71E0DB7;
	Tue,  3 Dec 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj63jyaH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1E1E0DB1;
	Tue,  3 Dec 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219934; cv=none; b=mOj2j1qUBnSxRuO83C9pNB8Zzwtkzn3dz2/0vpXc/aucHbEbERJGWGglTWfQmqr1iraceaTuK6mLBezDZWRBkSPtibpya4a2t2Pl9LTSImkruz2QcZKy8exdbMBVyBq8fsk/w2NFu8mTk23Hq6uynwnj8JIqgUtivUTEl7PUo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219934; c=relaxed/simple;
	bh=Fe19fPPyYsSwV1q4NFtqUopQnd9ZcosRSVGJO5ThQaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GWnSAMGZFo5MRbQhM6ekUIIl2s49oWDIJkD82QoXGeVrz3Uyxhofu8nevIV9F4SKAwZZ08sjWJ3NLiIESLg4lo5MmwgtIW88Wep30NmmEwxEKJSEVSilx6PVFy5gyx/sW34DHk9z91EJnp30FkmuU0LDMIicYusiJ30564is0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj63jyaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C3AC4CEDA;
	Tue,  3 Dec 2024 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733219934;
	bh=Fe19fPPyYsSwV1q4NFtqUopQnd9ZcosRSVGJO5ThQaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sj63jyaH+V0NFeM7VklCF/duCTGSCf4sZva59vlIlJk0DoAO+Tb//r9CFNdGiWpev
	 VYXPZs4dhuzBCCdLCSs9Nmtjqfd7GSug1o2UJFC5Sn58R2zPwznfEuJHSWt0IN1K/h
	 xpu4oSYw3eIEIf7P8DvrjsdJNV1J1tgvrfIe1kK7B0CdtjHTFixgHh1oRoniHlUoIA
	 PJpOFH91OEykcIdTe53iuhC1qCKPnas3mc8nsQ9kjFWL+88ocIzUBtq5s7X98sZW+8
	 O+82KzAFu/ytmMYeJPrGhrM8/cni+M4ptjESb9/kCmnem7nquT2Dq/do9eiOvZZKaG
	 FjVde3R9hgvtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E93806656;
	Tue,  3 Dec 2024 09:59:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/qed: allow old cards not supporting "num_images"
 to work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173321994821.4135237.10058501196334020638.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 09:59:08 +0000
References: <20241128083633.26431-1-louis.leseur@gmail.com>
In-Reply-To: <20241128083633.26431-1-louis.leseur@gmail.com>
To: Louis Leseur <louis.leseur@gmail.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, florian@forestier.re

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 28 Nov 2024 09:33:58 +0100 you wrote:
> Commit 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
> added support for populating flash image attributes, notably
> "num_images". However, some cards were not able to return this
> information. In such cases, the driver would return EINVAL, causing the
> driver to exit.
> 
> Add check to return EOPNOTSUPP instead of EINVAL when the card is not
> able to return these information. The caller function already handles
> EOPNOTSUPP without error.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/qed: allow old cards not supporting "num_images" to work
    https://git.kernel.org/netdev/net/c/7a0ea70da56e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



