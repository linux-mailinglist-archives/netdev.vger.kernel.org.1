Return-Path: <netdev+bounces-91433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C68B28CC
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C232CB212E5
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD04A1509AE;
	Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMlX2k2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B21509A0
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072228; cv=none; b=uhdlOyY5cJCCIuDcqzU2q1+RgGUgS2JkYdYKjINiCkWqUxdx6pVEowcGzhd/qH12ouuqoFdLopw6zqdYo2uVRR1Mhn4YRpkegmVE0L2Sw1u1W+rDUlMy4JrDhgWx1T9hCH7xPVMIujZxqO0oKGJPzVa9UaOa5hqPJZWIwrHDXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072228; c=relaxed/simple;
	bh=Zp9VFesc/f1bV/aREqq6jfy/NxGVyPzWdmw9jOkZqgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+a0sf83DFmHfAFEYsIWHsxY6Nf62Wz9etCDZl4LQz0cGU5ntyz40cTMjQ9jHugB04ThLq+t8xLKjxtloQ7gQqGSA/fHiMVNAiCIWgeyt7PyuTQMymGYn4z5jDhMd6ppcXOS4dgwdQlxLl/KM54JCFKhojmstcWo/SgT+GiMK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMlX2k2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C56C4AF08;
	Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072228;
	bh=Zp9VFesc/f1bV/aREqq6jfy/NxGVyPzWdmw9jOkZqgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dMlX2k2tiEYDgbnnfq9p4/Uqx7JjxGQhRgaSGSgyh61Z/QM67soXcMYlkzZAMTYWD
	 MX4GIvVAHjepAZaotuBwL13KDT+niROVRL+g+aVADxl0A7UYD3vHSWQ1szAh3py1EO
	 70eOOyISCUwLS0+izF7x6J/NOPUiVKtonDSOkTpBSxG6BcvOI3lsMdF99O8+mPJoBh
	 xq7PATIRGMLYrShM6IfifXG2GhQOFy913UP30AU8Y75eiCbst+J9Gl0m8UUnHWYSKe
	 rj0k4nrp1g2N7YCTPu2+oIUqzehZclF6qreM1OMHEsZcDG0nDVIQyKITvehatO7pyf
	 MHiyXnH2kcNIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2458AC43140;
	Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] use missing argument helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171407222814.4720.17158914675271356503.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 19:10:28 +0000
References: <20240423160652.68304-1-stephen@networkplumber.org>
In-Reply-To: <20240423160652.68304-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 23 Apr 2024 09:05:43 -0700 you wrote:
> There is a helper in utilities to handle missing argument,
> but it was not being used consistently.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  ip/ip.c               | 10 +++++-----
>  ip/iproute_lwtunnel.c |  7 ++-----
>  ip/rtmon.c            |  4 ++--
>  tc/f_u32.c            |  2 +-
>  tc/m_sample.c         |  7 ++-----
>  tc/tc.c               |  2 +-
>  6 files changed, 13 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [iproute2] use missing argument helper
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=911c62bf9de6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



