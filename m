Return-Path: <netdev+bounces-239521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D1C692CB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C36374F4D4C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68B2C0303;
	Tue, 18 Nov 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwuK6TH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600761EB9FA;
	Tue, 18 Nov 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466041; cv=none; b=ey4LHsAwjPZNYIqzO6DX63dXlYuEItT2hsNyyxDvXtYPbAo6UhA5VXK8Q2fEmm9MjVCYhGRLf9Uw8U2V4i4j+PhOR1kgw2p5MB/XY491EfjkQnfDXtEoZLSZHi5IRI5qp6rv/KuRst/V7DwVckFfyTwL20Xk5NU64vIj9SmKURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466041; c=relaxed/simple;
	bh=Z6GSwPyQy2eYbtEeZSuWK+cWOiXSjWhICZdzZMBBoQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HfDXgkhvWUUa6CmWCv8GWDgVlv48251d3uj1Z7tyejyUHzFndUCCKFQiysf5iAkKAVDWS05BbhGVrNpVpbMaFYauKWxh6WjsrEKXDZj61QLIfZnOpYYbSMJQI+ff4VpQPGFjPDsxSyyu9knnWYvK+8y9TLG1Zj6Wkrn8dq0jGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwuK6TH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A560FC19422;
	Tue, 18 Nov 2025 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763466040;
	bh=Z6GSwPyQy2eYbtEeZSuWK+cWOiXSjWhICZdzZMBBoQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pwuK6TH1ovOY3qtAfydGPeBptIVAk869cB1Yscoigbtoh1WfsiyM/rHcpU0Bu6rBf
	 rrQZ0yhNnDBb3rtK3PotTqP/IJzI04UaDmyU4WCVb9LAh8cDPstnZzCwHKiRExnA1m
	 sXgPTtvbc+D1HqttzbCPBbrnTf1057/4MFk2oRnTC+UhbcUF3T+pQfcRRMmCq3nMu1
	 XXnUHB+GXNXJS6exoneKmEUSurHiVQWLzXXBt7SsFEGfC8u2oPx4UYOnXnG6uFQ23Z
	 T9Zp2/v5dScdKPo5fux47HNvEZjJ3lwdbGRItue6Og2XGyX/kN/zaU5CCxFVX77Ofy
	 IyUruWG2A8DKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B773809A87;
	Tue, 18 Nov 2025 11:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ps3_gelic_net: handle skb allocation failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176346600613.4108098.16858864386263047134.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 11:40:06 +0000
References: <20251113181000.3914980-1-fuchsfl@gmail.com>
In-Reply-To: <20251113181000.3914980-1-fuchsfl@gmail.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: geoff@infradead.org, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mokuno@sm.sony.co.jp, jeff@garzik.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Nov 2025 19:10:00 +0100 you wrote:
> Handle skb allocation failures in RX path, to avoid NULL pointer
> dereference and RX stalls under memory pressure. If the refill fails
> with -ENOMEM, complete napi polling and wake up later to retry via timer.
> Also explicitly re-enable RX DMA after oom, so the dmac doesn't remain
> stopped in this situation.
> 
> Previously, memory pressure could lead to skb allocation failures and
> subsequent Oops like:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ps3_gelic_net: handle skb allocation failures
    https://git.kernel.org/netdev/net/c/0f08f0b0fb5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



