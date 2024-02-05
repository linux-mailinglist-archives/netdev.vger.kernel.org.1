Return-Path: <netdev+bounces-69285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB284A924
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2A29FF07
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442D4BA8F;
	Mon,  5 Feb 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmBw4+nI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC44B5A7
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171626; cv=none; b=e9VpbL55Tbj2cP/er/pq5igCNMVCdhpxGXTfgKCbWQefAk4pCWM0iYAwDu654mYWMlPtL3Ot14CUBKfMBONgqHV2WLw3B+Q9Nj4y+wXqMfPZzKHvM0N1TRZecH+oD4rBRgWtm2BOW2aEGeZOuAZilvaoYgUiuzCCRA3Py1tBCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171626; c=relaxed/simple;
	bh=923s2Ef9juZpmsUjlwOT9PFfcLDUrUQoDCFMO68GsH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s5PiqyRwoZWyzFvOncoJnEVwb9K58ZDcUfJKYCZJuu35Nn0XHSotwZ/DDCAfk22PLIMNt/vIgi7ODB/txAoc/qJh0FcIeJEEPF/CMYYIz2CdS5sFdSd96zCXUCLHPCvmd129TnkLYPz/Ivebaqt7VvJMS+8QYUPbkpBU/DHtbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmBw4+nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29401C43390;
	Mon,  5 Feb 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707171626;
	bh=923s2Ef9juZpmsUjlwOT9PFfcLDUrUQoDCFMO68GsH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WmBw4+nIsl1nz1laPdvI4YcVbWTH9AAcon7TJdPcXBMdzZ1yt0SxJ4VN7ZWQwfju9
	 pOy7kzN4+jQua9bWwGz0veTmN3HyX5IRk3SMZuK9PKHlF4JTMY46JPecx+0ZK5r/B/
	 sV1YWbbEY4GasY8leENbBiLRXTavp6LFxWxzw7h18KXx4q2mKFspt/K0Wh+aadkLZz
	 jKbeAIFjfmEfPJLLSM+g9lTkQkOWWSp3ROg7E0j/LHXE3AtP1t6jqGvy8HNlGp69AS
	 LZoV+iR5LPE+8EWN5Slx2YDRPwJamCjVNfDcL4RWlMrfr1b7MQThx9vMjWRsP693A6
	 zjFEcLagVNoDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1161BD8C981;
	Mon,  5 Feb 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Add missing -echo option to usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170717162606.15886.14337056755909676489.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 22:20:26 +0000
References: <20240205192923.3246-1-yedaya.ka@gmail.com>
In-Reply-To: <20240205192923.3246-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  5 Feb 2024 21:29:23 +0200 you wrote:
> In commit b264b4c6568c ("ip: add NLM_F_ECHO support") the "-echo" option
> was added, but not to the options in the usage. Add it.
> 
> Note there doesn't seem to be any praticular order for the options here,
> so it's placed kind of randomly.
> 
> Fixes: b264b4c6568c ("ip: add NLM_F_ECHO support")
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> [...]

Here is the summary with links:
  - ip: Add missing -echo option to usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e33309752730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



