Return-Path: <netdev+bounces-210235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB53EB1275A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF35917F82B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADB25B1EA;
	Fri, 25 Jul 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBQ+IuA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D825A334
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485947; cv=none; b=oMZA/GK33jzEoe+ggQYxFMVNhjJ39sH+Q6JDXD7zZ62HZRUt5FpyZ71qQwnuFEjY0T3+GA2S8dOYtaKLWkk5gwyV8cdhbZb7YLiJxjvGAQs6vFrDnx2vJh7Zia18tieqSOERDVaWfokNxl+sTj62XDvyvixd+NrriAkAWM6NxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485947; c=relaxed/simple;
	bh=BjmTHZb1Gc5BFF4YF7ds2rgMppgL8kivlXIJ+AncmhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cdv/lhlbRnOvenWNIVteMbqWDc0PElLvbmpZja0yLIL9UDvddRgcuEbnT06SVgYahcqY7oi2LLNPsbbnS2VuDs5SOkCMh/DXR9GFSTp/s95t3zf1UAG+9LFQWwpcBXe0YdYrypOryhPOkQgprFT0SNLD+gQAnWSKrW667JZhEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBQ+IuA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42385C4CEE7;
	Fri, 25 Jul 2025 23:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485947;
	bh=BjmTHZb1Gc5BFF4YF7ds2rgMppgL8kivlXIJ+AncmhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PBQ+IuA8j6DLvXLK6B/cPbl122bvNmjVx8H5loEDZpIa1y75451mY2o27RZTaVDw5
	 5WxYnZaK05UTlZDQJR90OUNLpM2xlJTNS2fs+6faR53Vp1OiYIcTpTuHURavVCuqPh
	 F+j/hT9he8ODGlx5ov+lzxdzRrL9oqEdgLXjhMiFtgZc0vHBhDCgWzZUWVxVGPfP/w
	 f2FmX+RZUKiF10cyp8vj52qH46h0Hea9Q0uj2cZadT7tyXlx9LD5EeRkkan01zN4Lh
	 kiWRdORowdf1y299DZNlkde4joYezuZ9WImLlAJaYtLJ5qfo7G5VFjgzbb105qVKDs
	 HOZfivX1Mg0Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3E383BF4E;
	Fri, 25 Jul 2025 23:26:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] libie: commonize adminq
 structure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348596475.3366157.4569740937025846002.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 23:26:04 +0000
References: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
 aleksandr.loktionov@intel.com, jedrzej.jagielski@intel.com,
 larysa.zaremba@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 24 Jul 2025 11:28:16 -0700 you wrote:
> Michal Swiatkowski says:
> 
> It is a prework to allow reusing some specific Intel code (eq. fwlog).
> 
> Move common *_aq_desc structure to libie header and changing
> it in ice, ixgbe, i40e and iavf.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ice, libie: move generic adminq descriptors to lib
    https://git.kernel.org/netdev/net-next/c/fdb7f139864a
  - [net-next,2/8] ixgbe: use libie adminq descriptors
    https://git.kernel.org/netdev/net-next/c/5b36bef44443
  - [net-next,3/8] i40e: use libie adminq descriptors
    https://git.kernel.org/netdev/net-next/c/b46012a20006
  - [net-next,4/8] iavf: use libie adminq descriptors
    https://git.kernel.org/netdev/net-next/c/0eb61b356922
  - [net-next,5/8] libie: add adminq helper for converting err to str
    https://git.kernel.org/netdev/net-next/c/5feaa7a07b85
  - [net-next,6/8] ice: use libie_aq_str
    https://git.kernel.org/netdev/net-next/c/e99c1618f9df
  - [net-next,7/8] iavf: use libie_aq_str
    https://git.kernel.org/netdev/net-next/c/43a113063234
  - [net-next,8/8] i40e: use libie_aq_str
    https://git.kernel.org/netdev/net-next/c/026cea3c61c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



