Return-Path: <netdev+bounces-91372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE038B2563
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8FA1C22E27
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FE14C5BA;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPKYDCg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26D14C5A0;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059630; cv=none; b=iscohRZ2oWR1Cmqisrrsp+MchN6Ww3ETI/NQF1fMrvGy5khrRqEvaBDG+GUsTuCUIWvm0f+wQqMAZeqaYMhoZRRw6u2s8zNec3sidekYMxsE6zCFEtP1ciOp5nCxsDTmHDOmQ4NGuQtWhh2JbnkE79Cz74uviSo1lhO1W2yHsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059630; c=relaxed/simple;
	bh=b7GVQbEg3N5QP7SXqOpXjBURWNBnzbcnNGtzANRii64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XGq89KH+PAX8csMYj59wCoAuq377/jj1YgkiztcaBcpli+LEbdrlaqScZS0oDWDIk3JzhvRXj7Jwl7pBVOmCfOhAMybLIU/NXYMA6qQJTSU7aFxgW3gKqTOE49dKhv81tcNtT6dxvo426Biw5K509E1PiD8ipC8sVkPtKnXYKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPKYDCg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21110C32786;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059630;
	bh=b7GVQbEg3N5QP7SXqOpXjBURWNBnzbcnNGtzANRii64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iPKYDCg0DxJRpzL9qiubfg6PSK8EAFDhAGdk6MREdcr1zJV5/t8KEdqqcUk+aZyzX
	 IATLyX/xWcnh+2ZCdgmS+UQoBYRFy6ulpQcWy8zctwacMyp12GFN/naGSCNw9J2cFB
	 m9+mZi+5Xnv+/qitDRK8nMyFs16uto5UwQmKWkbPjaamv9c36LXD4BGpg1B4AUQnHL
	 kXEhNg3CyJAVhSgmPoZPnHkgCdNlnibPo1ZlnGv9RLTrlOq7SmJteXyxtslm0s3YWM
	 W5KfLYqKOdvqJjiCemHbmP9IJ19Y+RSLGvvx0cC5D2/wFpvuky8LJ9NrP5ZvcLypqI
	 QHJvsDHzOWwUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06A03CF21C2;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dpll: fix dpll_pin_on_pin_register() for multiple
 parent pins
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405963002.10966.12819145929067304526.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:30 +0000
References: <20240424101636.1491424-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20240424101636.1491424-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 davem@davemloft.net, rrameshbabu@nvidia.com, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 12:16:36 +0200 you wrote:
> In scenario where pin is registered with multiple parent pins via
> dpll_pin_on_pin_register(..), all belonging to the same dpll device.
> A second call to dpll_pin_on_pin_unregister(..) would cause a call trace,
> as it tries to use already released registration resources (due to fix
> introduced in b446631f355e). In this scenario pin was registered twice,
> so resources are not yet expected to be release until each registered
> pin/pin pair is unregistered.
> 
> [...]

Here is the summary with links:
  - [net,v2] dpll: fix dpll_pin_on_pin_register() for multiple parent pins
    https://git.kernel.org/netdev/net/c/38d7b94e81d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



