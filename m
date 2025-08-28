Return-Path: <netdev+bounces-217567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C691B3912C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4523D3A4CD8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18021B9DA;
	Thu, 28 Aug 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVWU77Mv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638B18A921
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345204; cv=none; b=O2FQ8jEqN8XR6powXZ2SxpS0OX0DCcXEn48zrhdBdalIVAoqnvJuX7DkJ6NaB+TtI+rjEdIQSDPmD1OI5Zcd2GJGekeqGpUixkAzFCZ1kVOQ5Z4nyochzJu4ZrZJjXki2hvug0ZN6ObpZbEJpOPY3m6SH+snBk4GF0XNgrqVTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345204; c=relaxed/simple;
	bh=asZksoZQkNGFzHBDanUmL4Sw5nFpqwfEbvIkvmpjIWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h42vkAXkGqW5/xF9LV90xQ1eZ7OAvcupIOPAIO17XjsPioWyjo2TTAqUL2WqXzjY0EiiRtwlDGmg0N4gL1eICRXsvATiSY1SD3bl1QT0cWLr3d8FIDLMpcec0QvcsayDo4K9nysa98Xg8Hu/T5o1ekk6TPoky4+fkyQG3WEzFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVWU77Mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F9C4CEEB;
	Thu, 28 Aug 2025 01:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756345202;
	bh=asZksoZQkNGFzHBDanUmL4Sw5nFpqwfEbvIkvmpjIWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gVWU77MvNRKkDmHbUzB0aIFEqtGkntnQI0bIIWE8c4pkmR7b6/sl2qEcJhHjr1WIE
	 A/D/RGZ6wB4Acs8kzmZ76LqGdG8QgXEfwphh44kovxnbd0jwN9tXQxsw7eFr9McAGZ
	 mE3LciQD/xU+7X2HsQRM76ddhwgJwT1UxNOxO9uqObmvMTgDFeZYH62LzFEQ62Sh0W
	 Rgk2wpKPKQoZ3p9S/s0/6uCruVS6SofhQ3NfauIgGeVzw52//0r0MfY6HVKaEpfnKX
	 62AxZsgJiartHAQcdG/8e8yyw3yPQGjwRVIZamBBAW7wiR7PGVwO0djhbuZ1xExdtI
	 dsJA5UCgl909w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71007383BF76;
	Thu, 28 Aug 2025 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v7 net-next 0/2] net: Prevent RPS table overwrite
 of
 active flows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634520925.903433.2926794635303316783.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 01:40:09 +0000
References: <20250825031005.3674864-1-krikku@gmail.com>
In-Reply-To: <20250825031005.3674864-1-krikku@gmail.com>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 tom@herbertland.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, atenart@kernel.org, krishna.ku@flipkart.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 08:40:03 +0530 you wrote:
> As requested, I am resending the same [3] patch after the 6.17
> merge window. It applies cleanly to the current net-next tree
> and has been tested under heavy traffic for 15 minutes.
> 
> This series splits the original RPS patch [1] into two patches for
> net-next. It also addresses a kernel test robot warning by defining
> rps_flow_is_active() only when aRFS is enabled. I tested v3 with
> four builds and reboots: two for [PATCH 1/2] with aRFS enabled &
> disabled, and two for [PATCH 2/2]. There are no code changes in v4
> and v5, only documentation. Patch v6 has one line change to keep
> 'hash' field under #ifdef, and was test built with aRFS=on and
> aRFS=off. The same two builds were done for v7, along with 15m load
> testing with aRFS=on to ensure the new changes are correct.
> 
> [...]

Here is the summary with links:
  - [RESEND,v7,net-next,1/2] net: Prevent RPS table overwrite of active flows
    https://git.kernel.org/netdev/net-next/c/97bcc5b6f454
  - [RESEND,v7,net-next,2/2] net: Cache hash and flow_id to avoid recalculation
    https://git.kernel.org/netdev/net-next/c/48aa30443e52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



