Return-Path: <netdev+bounces-170785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938DA49E0A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CF16F93A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73F272920;
	Fri, 28 Feb 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDRzPlH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63A2702D6
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757798; cv=none; b=UN6sgtrtO1Bm5QwaoH6htSpYjlRdgSq5TqgnnKRfd6VIIpxRGB94qYyEfuQWaU3m1YbIC3ZD+YbU8PQYAaVfPRS7QIW7LtKgkV01lFw1ohKuTpqpLysI3oXdkDqHKDLjAM4j2xysw9FlcvnzjujRB3TXoekinu4381ClohWKGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757798; c=relaxed/simple;
	bh=H5oMgKOHtlNRq2ABZUvpExhoDiqdZaW1LyWPzSMqu+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/IAeRm838DFQBSC7UZDOBm6DWgZb48K0LSyy1nimYyd4Mdp8sW70y4sW0SYQKiQ77vmYgFo+4xwBLMNOhIXs4PgD2ES7AA3sPUSBtwtjM/xxsDrKhzrI1l2T8trhhT0zlH6ZpOp/QiNxRoJ2H3nDf/PG9w1ve5kqsj1VItZLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDRzPlH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47177C4CED6;
	Fri, 28 Feb 2025 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740757798;
	bh=H5oMgKOHtlNRq2ABZUvpExhoDiqdZaW1LyWPzSMqu+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WDRzPlH4TVBSoz0Sco1x2720oMJbHdxgZCjsvxJSdRKgQ0dos0tK09E6s8FtphbuU
	 EWUkOnyl42uLMK4TQxuzZjDKNIULsTWSfyESRHp3iXlMTlOlaaD+Xz1In6OfW7JFi/
	 qiekK5RTlAt3fWr7JtWa1j8W8oPHeK/n49sS4rBRQUnJMaq/jlvR6VKQwvx4ODQHlB
	 tN42o0XKABleavFxBllGIMEfYZrnuLKUHtRuOuyNcZuGYYUQn6F9ls2yAb+dpf6FIl
	 /q0IvM+mXiqEW9lQvR+lVmj696EfhHoUO+ZNzQ7I5B2MDjpKBSJmwdKD7L9rX8rP6k
	 wOLvbVxZmT9Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7E380CFF1;
	Fri, 28 Feb 2025 15:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174075783051.2186059.10891118669888852628.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 15:50:30 +0000
References: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
In-Reply-To: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
To: Jonathan Lennox <jonathan.lennox42@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, stephen@networkplumber.org,
 jonathan.lennox@8x8.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 26 Feb 2025 18:53:21 +0000 you wrote:
> Currently, tc_calc_xmittime and tc_calc_xmitsize round from double to
> int three times — once when they call tc_core_time2tick /
> tc_core_tick2time (whose argument is int), once when those functions
> return (their return value is int), and then finally when the tc_calc_*
> functions return.  This leads to extremely granular and inaccurate
> conversions.
> 
> [...]

Here is the summary with links:
  - [iproute2,v3] tc: Fix rounding in tc_calc_xmittime and tc_calc_xmitsize.
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d947f365602b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



