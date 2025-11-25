Return-Path: <netdev+bounces-241349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F76C82F5A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34A4C4E14DB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCB1EE7DC;
	Tue, 25 Nov 2025 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG8kDB32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122A1E520C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031844; cv=none; b=jx/N5vqOKYcx4BAIazJbiQH4riCGka62wEiDFDOeXBlHqmNBpyH5Ju9BR3nAZj4vjjz49LJhMG3SMgSymmKl1PN+rdp3Q34wDMgHcPs3QmANpzwE+RfNscNf5Lps/aNugcqoCELvbvjO1A0bW3vU60ZnQzVGyX2ZyfOwVER6vVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031844; c=relaxed/simple;
	bh=/fjM8ZVgYQLFvnSPn40XHr9mF0nwTi+jwKUv08fdqZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lp6hp/ziPeKPbkR7d169wN8M+i2UXLF8X/U7m06Q4+TepIaIxao2JdpDcsPULCgjPVafKNvki0WoEabv6yhkeYKfgK9frSuJbfOhpViGjrJ0UnBkxuhikQ5DIFLfLejhKwTzb5hbhYJFOQzpU1gjGoFOkht0EmwyXyaN6Khe0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG8kDB32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB52C4CEF1;
	Tue, 25 Nov 2025 00:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764031843;
	bh=/fjM8ZVgYQLFvnSPn40XHr9mF0nwTi+jwKUv08fdqZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oG8kDB32+cmxMqHnv/x5CDDVo/Fl1vQGs4cXZ+wVQOJdJYe05cDM8WXjL+ws4DZGq
	 1a6pcnGa0p9H+wzIebNeDEZjqAhop7i8Y8rUdBA0nq8vdoMJ3kbrn1+VWUQY3ISGXV
	 BgJ3y3wu7Fv5n98G3kfLrX5Ma1mUBDts7qwxhUJQr5fCOPnA3y5v8qdQKTzq3X0MK0
	 Nm+W25oiD0Fj8eiscn2zb3O60Qoi0ifp8EjYdJkq7SU2rxzPMzTDBJa4Xmj1+M41v7
	 eXmiaUP+o6KlI3b7jBiWsqKDFgSo9lUEKQ53LtEv8mf70EEAimhytI3ia4KP6Rh3vl
	 wkObNKbbE2HPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 723153A8A3C1;
	Tue, 25 Nov 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] tuntap: add missing brackets to json output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176403180626.133538.10568118341935314151.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 00:50:06 +0000
References: <20251123165345.7131-1-stephen@networkplumber.org>
In-Reply-To: <20251123165345.7131-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, i@fuzy.me

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 23 Nov 2025 08:53:06 -0800 you wrote:
> The set of processes attached to tuntap are displayed
> as JSON array, but was missing the inner brackets to
> allow for multiple processes.
> 
> Fixes: 689bef5dc97a ("tuntap: support JSON output")
> Reported-by: Zhengyi Fu <i@fuzy.me>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] tuntap: add missing brackets to json output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9cc782b36abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



