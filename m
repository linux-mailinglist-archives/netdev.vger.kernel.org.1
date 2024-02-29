Return-Path: <netdev+bounces-76017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339A86BFE2
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359912868E7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B33714C;
	Thu, 29 Feb 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THrJsV1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270173D7B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181029; cv=none; b=lGsdJk78zY0dYBLB4eoIZ/azVg95laYyZv7Ero56KhUcx39pCn0CXZn7/JQ4WmNS1ZHz7ubFUwHA0rSM6qWMnxXrmQYHDAFq5Nntt+sUsAVdXhUUotmbNhjJgjFfgbwuWT0RZUZ05f0lJ4CUpxTfKKLiYDNCIHDq1IOIAUk/98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181029; c=relaxed/simple;
	bh=/Mn5OvICCYWiZE9N9VzQOuRNxNv0djSdXP1WnEVSdMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MGiw4QzAiAuqWcmE40vNctMD8VZe74Tb3OLkdaK5RGUHIG8pZd6nRYCpW5I/nqJLZ1DPUAZEJn2iO8I3IxPxE1KBXMkU3sJM5vn8I1VvkkEQPRNjOyEW+Szzlt47xiob/eXSgQOWP8WqVzDo1KmbgJaE3Pia1ERhyxiPRhMcEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THrJsV1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ABDBC43390;
	Thu, 29 Feb 2024 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709181028;
	bh=/Mn5OvICCYWiZE9N9VzQOuRNxNv0djSdXP1WnEVSdMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THrJsV1p7EycUpKRd11Kkf9drfWjK+FxleGVZ9jSNg0eazUJ05YNOjfYVOR6Z3syK
	 FtDf9+KYoy+bHsdLER2RT2mkqyhqXlLilsuQ85torIjhDhKXvAlkJJuV3zJx9DQQgF
	 gCXj4CcM3TTzqVnScD3iGbFgi3rDtcE1nAqmvRyj8Xr06nN0lzfffhbpPa4DblweWF
	 Q9bJ5c9OyDHZnUnRorHxn5abvKity4mVaVDHuFHZaABpfyqZ9zUpiyWjts+rmyjfEa
	 pBrSqZVG1WV+4jpWl2wc5gojW/l2yWLpxUoiIf1qlOR3tGMXH8RfPFpCXpbTPD1SXi
	 Nv++pTCBo2vHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FCD3D84BBA;
	Thu, 29 Feb 2024 04:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170918102845.16199.15163755908236131752.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 04:30:28 +0000
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, o.rempel@pengutronix.de,
 richardcochran@gmail.com, nathan.sullivan@ni.com, jacob.e.keller@intel.com,
 himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 10:49:41 -0800 you wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> The i211 requires the same PTP timestamp adjustments as the i210,
> according to its datasheet. To ensure consistent timestamping across
> different platforms, this change extends the existing adjustments to
> include the i211.
> 
> [...]

Here is the summary with links:
  - [net] igb: extend PTP timestamp adjustments to i211
    https://git.kernel.org/netdev/net/c/0bb7b09392eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



