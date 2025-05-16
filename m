Return-Path: <netdev+bounces-191196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA38ABA608
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C9D1721D4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A9A233706;
	Fri, 16 May 2025 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzSZoXkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D222D782;
	Fri, 16 May 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435794; cv=none; b=skuhQrUzsefVPloAiiWB4efk4F5EZMhpgoHgGA9IU1mhns0ZRktVd6FrcpWMv6Igyn1Eo3D2bbvFEREgppDkPxalLQK+Nn5kVXAff6cDNeER5HIBoAM/aYWq0J5gA8rdN50H25fjVx+8qlm9sqXYWxuanpTe2BkeaqttUSJyqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435794; c=relaxed/simple;
	bh=qUi8otodMLMUrDtS/XcEvffPvGwm5qp42DqdxzJ0syo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSp1kDj9ciq5LwLc7PxbNXzuN0KAjtVWuhym86gyj3L0umOWKNRaVpXdOyVG2+J6tt3wEuM3SkKJjE6SWHbvP6arMrqAEl4w5oqtK/mriRQGBrlvEpyiCAQmfDPxyllSCgMlh01ppsforXCBV8Q89h44fh4y4NYgZTX/bN0HuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzSZoXkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6157C4CEEF;
	Fri, 16 May 2025 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747435793;
	bh=qUi8otodMLMUrDtS/XcEvffPvGwm5qp42DqdxzJ0syo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzSZoXkvv3StJpCiTHlRgOErkG+7E2UwpMrrWcv7XG/gyrAGM5qg0425ya4oaQtve
	 5k3dFiFuHbvYyM8PM4zf1XVHDrjORbYrbdOJguETFHfM7+FH8y0ybMT3pA9k3Pfw8Y
	 2CSDfGV5uTBEofPRKyQrG9qYoBBJizqKQqvJzd4QmDIN0LAVAGTpeXsJzTAAhRVVSO
	 KEiW9HZCyE0sX9EAZGO417buOaHS/PRdxDAKwIAT4ikXsDXBNl1hKMwE4YGiH7jG/Z
	 VVwvXyMwLUcPmRmD8bTTqycaVB6rEkjs1ieVccIJ5HNYNT6Vj3wx4OACfh9xSSJ4z7
	 uBSqz+gm+PdKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEF3806659;
	Fri, 16 May 2025 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] ptp: ocp: Limit signal/freq counts in summary output
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743583051.4084431.1945181110828030946.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 22:50:30 +0000
References: <20250514073541.35817-1-maimon.sagi@gmail.com>
In-Reply-To: <20250514073541.35817-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 10:35:41 +0300 you wrote:
> The debugfs summary output could access uninitialized elements in
> the freq_in[] and signal_out[] arrays, causing NULL pointer
> dereferences and triggering a kernel Oops (page_fault_oops).
> This patch adds u8 fields (nr_freq_in, nr_signal_out) to track the
> number of initialized elements, with a maximum of 4 per array.
> The summary output functions are updated to respect these limits,
> preventing out-of-bounds access and ensuring safe array handling.
> 
> [...]

Here is the summary with links:
  - [v5] ptp: ocp: Limit signal/freq counts in summary output functions
    https://git.kernel.org/netdev/net/c/c9e455581e2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



