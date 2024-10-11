Return-Path: <netdev+bounces-134733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB7799AF18
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED021C23417
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35381E1A35;
	Fri, 11 Oct 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjPnX276"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45C1E1A10
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688242; cv=none; b=fqDOXNuJjNsSfAjeDf8960pACdp5X0GbzF6+/GLsdtDKbsFUwuQ1sLJRM8LzCvAtL5wDBD2d5zdHG+AKQapwlUdA28wUvXrkIqZiMdl2JWou6EQhAGgRQzwnqRt4GB203wI9zwCDFrYSUvL6XQNE/PEAGm9AhkClKuHTBx6H9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688242; c=relaxed/simple;
	bh=lOCJhsNnLawTp/KwtiSKSFAZ6Ee6TQkWUVfR9ZZjEWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ln/OyB7fXJH+BZYyzDNNWgRWFVHATPqnnP3lwrJX1kBh3oeo8GsczOm4/Gk9BxV6Kf+jGbWGIqT4VvY51PP3TfoiiVi7aqALBQHO4yqDFEA0TrLGlwQUlRsRvEyYDGrPucJ4zZvqGAbwer/x44sz8fAGRcLPwBF2VNsSPJP3Beg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjPnX276; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AA9C4CEC3;
	Fri, 11 Oct 2024 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688242;
	bh=lOCJhsNnLawTp/KwtiSKSFAZ6Ee6TQkWUVfR9ZZjEWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjPnX2760EH81FXH9G0Ven4giAxrvJH6GIBhcXe+wYmlLYLvXP17CvQE+ninykGbo
	 SxEnt/JYoKaYc4ryMJCPkUi7xsdGUfDUW4cIk7bu37LECxJEV+AQaS0dYwPxfUvsUM
	 wdZucgmiggagPfltik5zpsg0+QlRxdGQtgg5kFkM39dl29CktFNgCfxZYMwxJ31Hmy
	 GGHK9JIKkmRDYXLZvLRJ3y1PN/x4oqlwnzuVu2D/yjzleARPDRIozrLDSZAffvVGR3
	 mASntKK3VfTrFjJlydA3lYHfxqmlafNYrxwhTHFINnyO91MQNUzcIj/kOxEovUCLFe
	 K+24rX/vdUy3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC538363CB;
	Fri, 11 Oct 2024 23:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: add missing trailing backslash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868824673.3022673.13819228292368546861.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:46 +0000
References: <20241010211857.2193076-1-kuba@kernel.org>
In-Reply-To: <20241010211857.2193076-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 14:18:57 -0700 you wrote:
> Commit b3ea416419c8 ("testing: net-drv: add basic shaper test")
> removed the trailing backslash from the last entry. We have
> a terminating comment here to avoid having to modify the last
> line when adding at the end.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: add missing trailing backslash
    https://git.kernel.org/netdev/net-next/c/ec35b0c53cc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



