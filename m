Return-Path: <netdev+bounces-117857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E794F8FA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79576B21F2F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230CB16D33F;
	Mon, 12 Aug 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhO4ZQCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C631581EB
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498255; cv=none; b=DMXtoEGYn1jvUaNp8RfXun+fDWCjGclK34IByl9plCoooz6eB3S89JvF24iZOLhmRq4azNzaoTPkitOL7PBf7qj8X46B9cT15Euxexphb4l9gi0k6FagiaqAD8I8yOFUoEtpZ6FRkCkPrJ0fZ7efzfh0Wu38+18XyzTe4wGMh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498255; c=relaxed/simple;
	bh=Rc6Ozq9p3l1CRe6JW/NxQgYa7+T7C6XQWBz3aP1cVew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzTIcFFWbhCwrofuo9dKHnPROy8KEGJndHcoDqT6190LIFALQ9tfzgLCtCr2O0cMRnkRPFcsSJ5hbqd2MAP2OHh142iuIp4HmUliKCd8hHNTmB7NsBxjKE9tj/uJS2gvUt6IiBFRiSh9nMxysPgT1VuamimwyUSquvqcXv4ypHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhO4ZQCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7010DC4AF0D;
	Mon, 12 Aug 2024 21:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723498254;
	bh=Rc6Ozq9p3l1CRe6JW/NxQgYa7+T7C6XQWBz3aP1cVew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FhO4ZQCalpgDXfFZSgShsZVTNsr+PLY1zAPWiYsaFTRXWOry/GFpoNNPY9ozsLOfw
	 oVCHFLNMpD/6JT1ycImS/dUtFpLaomM+1DHWXKsO4qPgRPFo9aZHujVCilFArsecO4
	 tZ8yxGYWwStxvbZkFPA6nXMgfS2blprrOUmY0q7ozfq/F93aiBgr3M3XCqoTCr5Q8f
	 tOX/Zk29j/MvBR9Vq44xAuOjbPAG401tNyR8O87XbLPNlF1F/BbUn+ESV3QCPsyQ9l
	 gIaHpO9mNuSUtHPw4yOSI9VdtqJctfa3TZgC/1xDvlpDGH50GS+a9LY8DZQSM5wBlF
	 7C0/cUh/yFafw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4D382332D;
	Mon, 12 Aug 2024 21:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] man/tc-codel: cleanup man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172349825349.1144807.6389584109889129985.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 21:30:53 +0000
References: <20240811165501.7807-1-stephen@networkplumber.org>
In-Reply-To: <20240811165501.7807-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 11 Aug 2024 09:54:44 -0700 you wrote:
> Instead of pre-formatted bullet list, use the man macros.
> Make sure same sentence format is used in all options.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/tc-codel.8 | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [iproute] man/tc-codel: cleanup man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6e4c3ffb8227

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



