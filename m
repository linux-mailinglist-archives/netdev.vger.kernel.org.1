Return-Path: <netdev+bounces-67137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B3842254
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E9128DFBD
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3A664CC;
	Tue, 30 Jan 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwM+jnfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A9664AE
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613032; cv=none; b=CytpRiUEP5RxskgzLdrShT1dl+f1fMrkmfq8gNSpSDHKbtTIwb9saT9lwOPeNuFmUOmJBZICkjF4+uxHc1DLoQ3eGggTba1O6MFrqUG43Hf4Vjw+9Y/bRR0PwgfotrGP5DdU+NiBFBw7S1aQ7k42/4Bs10+OBgm3us/0NBQAWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613032; c=relaxed/simple;
	bh=IKMsE08EIB2gNmC9ygTBh8s8tU5qDq1kEAmAJNqzuq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eYg2avWYEaB/XEUPYs226gdPXg74kBONAnenlrzavBg3XKlwJ6kH4SMcS+QtvWphz2HdLgmtQPbMnPZH6HCyR036dv+L9A5ZWqPKWAzmjSdC+vDSr7U7B81lR8ygtxLNNXZ1qptg5guAX2u9jAdNYSg6VHrVujrKEjn+W5AIQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwM+jnfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11B3EC43394;
	Tue, 30 Jan 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706613032;
	bh=IKMsE08EIB2gNmC9ygTBh8s8tU5qDq1kEAmAJNqzuq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WwM+jnfS/aGVNjm7vZ73Zw+6scNsNmo/qi4BO0sr61W/4Ghr9x0P4r9uwMNzdxpP6
	 1m2qgJMCB5khF1HWWBmpFk7PyhjyJwnAzVZsBppzOsBt6XmkC92RF0NcDTVae9wln8
	 jdEcLYpxJ2nrp86w97a9IN88w4UY3ScXiVLpWPHds6kE1iUpBe4gzY2LkBW/uUfqlz
	 UM0CFDYWPiG6VG0Qu9MMWrzF/JdGAvXomrIf1jX9PvEQmcsCSUnCSPBxSBfExrcXXh
	 0UBbOALruk6YFh94B+IYGvXRUpAEuH9lS3asgKfJm1Ne7+idvtOBC4euiLM51W5UO4
	 WaysqPh/GW8iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E707BD8C96C;
	Tue, 30 Jan 2024 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] ice: fix timestamping in reset
 process
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661303194.21939.11991755421301289279.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 11:10:31 +0000
References: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, richardcochran@gmail.com,
 karol.kolacinski@intel.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 25 Jan 2024 13:57:48 -0800 you wrote:
> Karol Kolacinski says:
> 
> PTP reset process has multiple places where timestamping can end up in
> an incorrect state.
> 
> This series introduces a proper state machine for PTP and refactors
> a large part of the code to ensure that timestamping does not break.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ice: introduce PTP state machine
    https://git.kernel.org/netdev/net-next/c/8293e4cb2ff5
  - [net-next,2/7] ice: pass reset type to PTP reset functions
    https://git.kernel.org/netdev/net-next/c/c75d5e675a85
  - [net-next,3/7] ice: rename verify_cached to has_ready_bitmap
    https://git.kernel.org/netdev/net-next/c/3f2216e8dbce
  - [net-next,4/7] ice: don't check has_ready_bitmap in E810 functions
    https://git.kernel.org/netdev/net-next/c/fea82915fca6
  - [net-next,5/7] ice: rename ice_ptp_tx_cfg_intr
    https://git.kernel.org/netdev/net-next/c/1abefdca85e8
  - [net-next,6/7] ice: factor out ice_ptp_rebuild_owner()
    https://git.kernel.org/netdev/net-next/c/803bef817807
  - [net-next,7/7] ice: stop destroying and reinitalizing Tx tracker during reset
    https://git.kernel.org/netdev/net-next/c/7a25fe5cd5fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



