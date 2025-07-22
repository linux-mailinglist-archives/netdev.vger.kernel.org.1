Return-Path: <netdev+bounces-208735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BBCB0CEBB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C5D188A0C1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B55D8F0;
	Tue, 22 Jul 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYJp9v3W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5D49659
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144205; cv=none; b=Hwrfbm8Wz9/rCCxwO0DZejoQb38gH1CfascEJbYEay2Nnp01aDIVnLJHo+pbEvjjmiaf5ABTcgSpIBBpMaUuK/l3/NTD/T2/bSmFmY9Yfny0iMczmkxm2LA3tw60dynNqyRsMouWl0BI+3UTFD/sqmd/K6vOZZqxDQMDIkYUeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144205; c=relaxed/simple;
	bh=cj55tb7eycWznPxo7xd0o5FrrX39leJdLXHvABiqRck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eIjZz4yfBONywUggoUPdBS5cnwAQ4GwS+/gH5eyQPKGjU2OfkOQGMMEUSSL1b1k/4IymrJjUfw5hjl2SWpbZQx9xShw8MxWDVnWE50ENHl+GsKzVjHD393iElCUxRsL1zkdDw46wzpS8UuwYxXzZuBwZt6p5tQYd+Rt5izZFYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYJp9v3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40872C4CEED;
	Tue, 22 Jul 2025 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753144205;
	bh=cj55tb7eycWznPxo7xd0o5FrrX39leJdLXHvABiqRck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SYJp9v3WiOZkg22dHFakRpKuyEnDwKSrOR1HZSj0YvUTiidjku6hz8WMqo4AeltUW
	 uuK7IQgKYB8LiDy3KicwQfkVv1a8GLnSIiNXj/nzyIDcM6I+QplV5FzpUxA1Bk2+d0
	 uY1zBAaf3wVK3lyOExkm+5lguZe+V0hl9EeTx3RxQb0LNdv5cRivMxx98SdbbG0dQt
	 3PrIvaQBqUOHZru+h64GGTqZRdKHr/LPFI7U4yTMjW1WCUTsicyByOOxMlcHW0v3zm
	 WPYoVG+KWk1gaLNaBLxsITAlEEc74qlhiIMW7mhXJlLcEb2tr532kKkMHKqqg/4YcB
	 i2gq7Z0UXsetg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C19383B267;
	Tue, 22 Jul 2025 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver
 Updates
 2025-07-18 (idpf, ice, igc, igbvf, ixgbevf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314422400.243210.663675499722808802.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:30:24 +0000
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 18 Jul 2025 11:51:01 -0700 you wrote:
> For idpf:
> Ahmed and Sudheer add support for flow steering via ntuple filters.
> Current support is for IPv4 and TCP/UDP only.
> 
> Milena adds support for cross timestamping.
> 
> Ahmed preserves coalesce settings across resets.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] virtchnl2: rename enum virtchnl2_cap_rss
    https://git.kernel.org/netdev/net-next/c/7cc6d633c08d
  - [net-next,02/13] virtchnl2: add flow steering support
    https://git.kernel.org/netdev/net-next/c/bff423578d4f
  - [net-next,03/13] idpf: add flow steering support
    https://git.kernel.org/netdev/net-next/c/ada3e24b84a0
  - [net-next,04/13] idpf: add cross timestamping
    https://git.kernel.org/netdev/net-next/c/e831f9e276c5
  - [net-next,05/13] idpf: preserve coalescing settings across resets
    https://git.kernel.org/netdev/net-next/c/e1e3fec3e34b
  - [net-next,06/13] ice: add 40G speed to Admin Command GET PORT OPTION
    https://git.kernel.org/netdev/net-next/c/9419c43859e1
  - [net-next,07/13] ice: add E835 device IDs
    https://git.kernel.org/netdev/net-next/c/0146da536701
  - [net-next,08/13] ice: convert ice_add_prof() to bitmap
    https://git.kernel.org/netdev/net-next/c/850a9a32ab6d
  - [net-next,09/13] ice: breakout common LAG code into helpers
    https://git.kernel.org/netdev/net-next/c/351d8d8ab6af
  - [net-next,10/13] igc: Relocate RSS field definitions to igc_defines.h
    https://git.kernel.org/netdev/net-next/c/bdfaa8d70da2
  - [net-next,11/13] igc: Add wildcard rule support to ethtool NFC using Default Queue
    https://git.kernel.org/netdev/net-next/c/d5b97c01ce28
  - [net-next,12/13] igbvf: remove unused fields from struct igbvf_adapter
    https://git.kernel.org/netdev/net-next/c/dfe80201e1b0
  - [net-next,13/13] ixgbevf: remove unused fields from struct ixgbevf_adapter
    https://git.kernel.org/netdev/net-next/c/0d1c95e42b77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



