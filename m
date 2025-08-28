Return-Path: <netdev+bounces-217530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C721FB38FC4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A603C7B2C9D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318316132F;
	Thu, 28 Aug 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFLmfi9q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA030CDA0
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341001; cv=none; b=btoFkWyiPYEVezqTjEry0aXAhQkGPlFmoDpyYY2xz+hX8t1ldKBPMsDObu2R4j94O0xS+jaAOtGimr2pCxtLoTqAbXYT9V+gUzTEh5uROgBbu1b0vvlCUbDBEbLw3WGyDN/q2gLUIcdyobDN4jOC2Kyod+3LCz+CK2cJRPlGoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341001; c=relaxed/simple;
	bh=/mQTlaLNYBvTUhoD9nekHkXHxfWJhiBkVzRLZEaVSp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hct8d7wML+QiXzgGz/MH35XkPMSeXsHPEGeVnADWbNAXMAL+OS7SRSl7u+mm2nnYZIeV+ufpV6FHAOzMfQ7G80mVOwB5N0Vei6b1S+oLFAeePEmWEWC3tC7s9IWwlbkUBNnxT2RQYmbTPAClCbW/LISPAX/glh1cWyNvGPk+YIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFLmfi9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D0CC4CEEB;
	Thu, 28 Aug 2025 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341001;
	bh=/mQTlaLNYBvTUhoD9nekHkXHxfWJhiBkVzRLZEaVSp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vFLmfi9qICBjCNZ7B4QkgNar81ckx3Ap1d6KzlMacvYfZFvtnbojzQyMjjTd/jI8m
	 Vosp8h7hOUuqGtZCoGsO1l+6ap9OcHJkVlAlwufb3t0+ds80RVrdeZ0N8ZSuIFfDbt
	 //lpB0rNV1SPPnqVT+ddIl5RX8gs/PmfqrJsZfgr7FYU8WZSicDGtDPADr/FYb2Csp
	 PlrEHoethvygwCnTYO63RAl+cN/Z1GNN+zhPkOUMbtm66UQSArIHQv19P3uo977PYC
	 MQpCWB2ptwx/P9sU5buECF9OK3ACCDOB2Yvrz6VI+lJ/TL3aRLNZqkEly31lRkrf2J
	 k7UTjMk4PZ3/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE20383BF76;
	Thu, 28 Aug 2025 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: rmnet: Update email addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634100850.886655.1251648472546637167.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:30:08 +0000
References: 
 <20250826215046.865530-1-subash.a.kasiviswanathan@oss.qualcomm.com>
In-Reply-To: 
 <20250826215046.865530-1-subash.a.kasiviswanathan@oss.qualcomm.com>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 14:50:46 -0700 you wrote:
> Switch to oss.qualcomm.com ids.
> 
> Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: rmnet: Update email addresses
    https://git.kernel.org/netdev/net/c/bcd6f8954dc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



