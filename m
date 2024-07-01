Return-Path: <netdev+bounces-108219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B1B91E6A9
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8212FB23761
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73716EBE6;
	Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqYrYuRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3446434;
	Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855028; cv=none; b=YNalxIcsFoBkUEtdlOe3PL1I6XWxOIflvyY+TSp69y2JJtuCTGwoEG56/YOfFvn6yI02+nEJdyJbQvOYPTk/RVtYyXZm4D+4BfUVRAlTuyWr15AZxb7YlsJLlCQuYIwCkfkKcRMfpnbBwZiAbxCr37Oj7fS+qwDZh/oOwPW6kTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855028; c=relaxed/simple;
	bh=/40oz/s8RXfS81mQyn18qyWYU+aDlAPyeqR/p4JT5tA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lkCm5jkmX3rddJPhJkSL7pEyzT1IXgf0mi3LBR7MvScmzYmepqdcPAkkfXretn0CrzBHCNhXlELB6BNfTPFYCeAVrA0nxBv6ZDF0wSmtusJPmhtTf5bUtIBM39IY5o8xLPlenppzs8OB6MuBXX/h+1LjolevrhJPGIemkGfotxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqYrYuRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A042C2BD10;
	Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719855028;
	bh=/40oz/s8RXfS81mQyn18qyWYU+aDlAPyeqR/p4JT5tA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gqYrYuRzf3NTkTOhhAV4lwmrklGgFS2fdxAoSTBNzjCwicWeIvVvNqiPYR6vIx+x2
	 T3679jsW4MacnvnNlqZQRGiCI4EpeBbmP87c+cSMak7Pt9pHoOSKZkVXUaHR3/9C7E
	 q2UVT56Yu8KG8vZjJdQ9xXxQXX6tiHrue5w3egCyixEoUtStHP8yi8X+0S1Kh+BiDn
	 Y9U3cTrdyv4r3i6c85NZfog+bPqOkoFFSCyF4FnY/P2sxUcFdgBuB1fcfIXwW57COt
	 RClLO8zIwpw585IT3HFgt5fELKOk2KUkpXSN1q+U08/EDIwTHsmHTcVh2f3X0GPLOb
	 +uTAjeSBeH0Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42775C43468;
	Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to
 the json-schema
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171985502826.17789.16520261156550841642.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 17:30:28 +0000
References: <20240628054635.3154-1-zajec5@gmail.com>
In-Reply-To: <20240628054635.3154-1-zajec5@gmail.com>
To: =?utf-8?b?UmFmYcWCIE1pxYJlY2tpIDx6YWplYzVAZ21haWwuY29tPg==?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sean.wang@mediatek.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, rafal@milecki.pl

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 07:46:35 +0200 you wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Dropped serial details from example
> 2. Added required example include
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> [...]

Here is the summary with links:
  - [V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
    https://git.kernel.org/bluetooth/bluetooth-next/c/31cdab2ae178

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



