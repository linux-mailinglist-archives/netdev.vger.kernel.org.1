Return-Path: <netdev+bounces-86810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE008A05B5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E34E1C21E94
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41B6217D;
	Thu, 11 Apr 2024 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5qbTEN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541079DC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800836; cv=none; b=HSeVsLhOEREKdJ81RDCsRsRHO+UU1WiED5+BESPSokeJaeG26VYsck94MD9kOSRw0SmPQLsopKN9YDagB6f1YdOylp0ZB1E+DUK7MUtscloRNvNQsyDWBuMOxKuhbn17bsQIZA3bXHu3wesnuOF8HgG1o7yPctuZwFVEb07k8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800836; c=relaxed/simple;
	bh=+fqOuazy+UGg2Y3lYTOUH+TSsMLI9bZUXZGxa77ou7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9R7wzjhDDgE7IimDEH2OC5+lz2c0tl2MrPDkLsYftI93m+EcQc4/BMqWblrzlYRprQWE2SdFOER9GKctK5qLkS75k3u7yiJg/ni/o4QMILWsLIycLyb240DqGSmd6bX6zEGk/PVlSQ2gj3wdhmjw5eyxfxJw7zAUlX09XrJWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5qbTEN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6935EC43390;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712800835;
	bh=+fqOuazy+UGg2Y3lYTOUH+TSsMLI9bZUXZGxa77ou7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V5qbTEN6LLUCIcDMZFQJXOyihTWsyBdGwbVFxDNUocNszFX5UBT5D6m1p/BYGohyD
	 qHnOjHBB7wvteWfZE5ATnrt1gF+Pz2yuFvli1fa2IdUvVKQ8ycbfj1i3TVyTgRP9US
	 dhCvZMW3QruXBwfCz5H2ZmhuZjqWCMUr0itpD0f+to5Fi1L1I/JYVqN9qEa9gcFou7
	 CPBBTnIvBYRoq9WhTIFtK+7mNKn3Q20yQe2UWBJ5IBXTKPIRQLsTrpks5tEa39rTTV
	 dK/EtXjNZpp6hESfQliW4eEhIhTNYT6TIJLGWI/4/z+klpy80UiIzSJ7IPliyqiidd
	 a+fVyxCh2xZBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5574BC395F6;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: add missing conditional compiling for call to
 r8169_remove_leds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280083534.2701.11819073106768813081.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:00:35 +0000
References: <d080038c-eb6b-45ac-9237-b8c1cdd7870f@gmail.com>
In-Reply-To: <d080038c-eb6b-45ac-9237-b8c1cdd7870f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, venkat88@linux.vnet.ibm.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 15:11:28 +0200 you wrote:
> Add missing dependency on CONFIG_R8169_LEDS. As-is a link error occurs
> if config option CONFIG_R8169_LEDS isn't enabled.
> 
> Fixes: 19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] r8169: add missing conditional compiling for call to r8169_remove_leds
    https://git.kernel.org/netdev/net/c/97e176fcbbf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



