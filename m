Return-Path: <netdev+bounces-198514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD9ADC88C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409701795AB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319BD293C58;
	Tue, 17 Jun 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsz9kIDM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9B291C13;
	Tue, 17 Jun 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156802; cv=none; b=GjfIz/0eXHlpu1fZ0qsOHlcN16hxqOO7C4ZQ86K5hxeCQvBZM+SRfCnjqqz6YqxjtEgFyVOcr+9hBOe2y51d9rMbXCIDaJT4BV4wxOVRSPMAcjpLQ+wVDdlmJnmCg2VHQXLEDEREDHJ2t5Q5FQX9Qxlvu7jHg/k/VeifIWoilNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156802; c=relaxed/simple;
	bh=qHDehiEf7FkPkXNpC0E+vVdk3OUloB21p0vLW7HN+3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G51rxHREysAUjfP4cu2e5+pgs3teeJQeGslmjzcFIo5qF8iu35Y/se82Jx/sCL10tbbPXJVHUuEzvlwEN6FvDrLOUAVW0sW4EjPb7cXqNRif8OoYrKoaX6tQQBeR5PD2zW+KcigdnnRRpsjEgKFOEabb+pMbXbucd4HfR5idW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsz9kIDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD1C4CEE3;
	Tue, 17 Jun 2025 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750156801;
	bh=qHDehiEf7FkPkXNpC0E+vVdk3OUloB21p0vLW7HN+3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hsz9kIDMKPlOO6v9kKEtm8/ofHAxBmJ3FFakQRcoDglOTzcuRkAoh1NyPmzPZF2Yl
	 aonmJuvT1aLmG96piMlM3Cx4u6uEOaGr9kQFH+m1H4ifsmouW6X0XY584xU5Dg60si
	 DqrUwh4K36lLib+Y3IVu5OJvjmeH80vAegzUpti8zaADpkMLUGnwU5NRipEHK+4KOC
	 Oq/sGQVW9ek7a8sVqvUkBDgG78ONQnXDRMOiBN6gGUDSePQpomKjqRg3vmfwWdsITi
	 Bjf5KFbwRvekQNMRZY6WZjmZJvNdyLuYAgY4Dad516CYCNLp/hltm3Gz2e3fuvU4jZ
	 m47iYOkdScbgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2B2380DBF0;
	Tue, 17 Jun 2025 10:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: enetc: replace PCVLANR1/2 with
 SICVLANR1/2
 and remove dead branch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175015683050.3069208.4099570428895361110.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 10:40:30 +0000
References: <20250613093605.39277-1-wei.fang@nxp.com>
In-Reply-To: <20250613093605.39277-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Jun 2025 17:36:05 +0800 you wrote:
> Both PF and VF have rx-vlan-offload enabled, however, the PCVLANR1/2
> registers are resources controlled by PF, so VF cannot access these
> two registers. Fortunately, the hardware provides SICVLANR1/2 registers
> for each SI to reflect the value of PCVLANR1/2 registers. Therefore,
> use SICVLANR1/2 instead of PCVLANR1/2. Note that this is not an issue
> in actual use, because the current driver does not support custom TPID,
> the driver will not access these two registers in actual use, so this
> modification is just an optimization.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: enetc: replace PCVLANR1/2 with SICVLANR1/2 and remove dead branch
    https://git.kernel.org/netdev/net-next/c/dd4a5780f7d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



