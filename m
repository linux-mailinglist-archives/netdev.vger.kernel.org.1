Return-Path: <netdev+bounces-202085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92399AEC309
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B3189FF45
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9F28BABF;
	Fri, 27 Jun 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceLZUeAq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E541E572F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067588; cv=none; b=SU2LIUKK6qAE1YRuKb9lX1uIu4hIT9VyZRrza5L6OKs2oWJGLmG6xNPq6L/yEq8OOEd17eovJBhOySX2Ej8S6zpWWXAvuvJoZoRIhJDpqrUlFuslUhBtspTwu/Ztb0283vM67uIODtQiPNYm1VAPkIkEutcDkRMpWsueri4/uhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067588; c=relaxed/simple;
	bh=oTxIc/lOOJM306oBAzAQTkXMyCzDiKd3fekPAe0p1NU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dHHrJwLcpy5LaTqx/U+1GUyxa8EgaP3LDzaqXxrGz8ngLDkWvi2403RYO/DuUapBXvcVvb95ryZ+EqXHfmbPeQ2VBAB29IQR4gPUQ6Rc+RATUzkpsUcb6M5CuKMD5IVAPqX+nhNRRSUV1GqjtwmPEKNnIEZt9FnyDPe5ebTQJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceLZUeAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4F5C4CEE3;
	Fri, 27 Jun 2025 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751067588;
	bh=oTxIc/lOOJM306oBAzAQTkXMyCzDiKd3fekPAe0p1NU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ceLZUeAq3ZSk+Wo50v/N2vuhvRL3T13iVDFmtCuKGO1Qhc0FKJFqgNS76NwlPrcIf
	 Y+SzNwfM2OE6s0VsA7mRYvUDBsn8/6BV/lNITPRWFuCScNQylyWtJsRCWxt3QPYlLF
	 EwR0cKVVGT6TUVupMFmNNdGqRoOpMvyUuTtTkp/b4sxPzHLZ9Zi2v1G+Fjr1A+FnIx
	 btGXl85YjosZCXFn8A7ZM5GRMNJ6Wr+ZOZ6yuQo3v8kL/Zwz4hhigDoCQfI8tiolU3
	 Gu4lS6vM/jbdZrRSYABm9MewEpYG9d8DON5pJcmKlT5SQvz+A6vpOshXJLPAomfRuj
	 4RtuESRI4nyLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ECC38111CE;
	Fri, 27 Jun 2025 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] ice: remaining TSPLL cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106761425.2089384.132710419861513584.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 23:40:14 +0000
References: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 karol.kolacinski@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 26 Jun 2025 09:29:11 -0700 you wrote:
> These are the remaining patches from the "ice: Separate TSPLL from PTP
> and cleanup" series [1] with control flow macros removed. What remains
> are cleanups and some minor improvements.
> 
> [1] https://lore.kernel.org/netdev/20250618174231.3100231-1-anthony.l.nguyen@intel.com/
> ---
> IWL: https://lore.kernel.org/intel-wired-lan/20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com/
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ice: clear time_sync_en field for E825-C during reprogramming
    https://git.kernel.org/netdev/net-next/c/d261d755300e
  - [net-next,2/8] ice: read TSPLL registers again before reporting status
    https://git.kernel.org/netdev/net-next/c/38f742df9fcf
  - [net-next,3/8] ice: use bitfields instead of unions for CGU regs
    https://git.kernel.org/netdev/net-next/c/c6b4486a6201
  - [net-next,4/8] ice: add multiple TSPLL helpers
    https://git.kernel.org/netdev/net-next/c/5755b4c023db
  - [net-next,5/8] ice: wait before enabling TSPLL
    https://git.kernel.org/netdev/net-next/c/df3f3c5645be
  - [net-next,6/8] ice: fall back to TCXO on TSPLL lock fail
    https://git.kernel.org/netdev/net-next/c/84b8694433c8
  - [net-next,7/8] ice: move TSPLL init calls to ice_ptp.c
    https://git.kernel.org/netdev/net-next/c/e980aa685209
  - [net-next,8/8] ice: default to TIME_REF instead of TXCO on E825-C
    https://git.kernel.org/netdev/net-next/c/8b4987543453

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



