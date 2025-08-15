Return-Path: <netdev+bounces-213889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539ABB2742A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D21A0620A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4FB19CCF5;
	Fri, 15 Aug 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQgsAILo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AB199E89;
	Fri, 15 Aug 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218416; cv=none; b=SvjvcWr1jjgT3VQA7VcCrJ0Pp4LOY/WdOoxeN/57ADRPSuxQmIO/anoG6ZXkjcz+rO9L3mwtO7YiGjEnMpRVVVExEbolOSHrkzFx8I7CiRQjg99yWGiS+BHy/vDCzSaIUXyq5F0lj8sGLbNirPhXZHT+J5HszFOaOt5S7GU3kR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218416; c=relaxed/simple;
	bh=sfa2ZgT0lVDtBUjV/lAn9PnI/RFisjiwnHvqty5qEt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wxg7WJaTKL2F1EeWrGUMIcCoxEKqUYsVKDimE8TSKiC2COS5YuOwQMHAZmpyB3bGUl5zmMgmud3cNWPP9ocj01SFmui7NFZRIhRhPwSc3ElRsu7783peK34RN87FOMHd5MrRp00F0JFbbGWUDE7z01ku5pcw2nYhoIHpU2aN40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQgsAILo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E23C4CEED;
	Fri, 15 Aug 2025 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218416;
	bh=sfa2ZgT0lVDtBUjV/lAn9PnI/RFisjiwnHvqty5qEt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iQgsAILoVSBmVbE+rF2RY4tkBs3PjixDvFCSC7OJDxGRijL8hxqlsdHpkA8F8tzCZ
	 HmY1TxdEOmLD/n/mApFDZZ1qlae+LlKC9oTJG8lQZAMYtrn4telbFhAoFAChdyWiIC
	 aXuJTW7Wycikseuv5r0pnmnN/PmUonuKBZqVZfps4Jow/nFaD59jNWil5m/PSUJ6jM
	 uu4FuJe9Rr0VKd9clOANzDLWfAKi1W+FTr785yOWkwyZGee1/w0rUfcPRxWPjXraTL
	 tlsutJQoZDjFh+tNfpfOqVxjQCJkCSCZcBwUYeZSZNz2HVFVLB58UWkhWSrm8b3S3v
	 cVOR5suzS8v8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA839D0C3E;
	Fri, 15 Aug 2025 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfc: pn533: Delete an unnecessary check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521842724.497413.12048950309887791940.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:40:27 +0000
References: <aJwn2ox5g9WsD2Vx@stanley.mountain>
In-Reply-To: <aJwn2ox5g9WsD2Vx@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: poeschel@lemonage.de, krzk@kernel.org, pabeni@redhat.com,
 amishin@t-argos.ru, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 08:51:22 +0300 you wrote:
> The "rc" variable is set like this:
> 
> 	if (IS_ERR(resp)) {
> 		rc = PTR_ERR(resp);
> 
> We know that "rc" is negative so there is no need to check.
> 
> [...]

Here is the summary with links:
  - [net-next] nfc: pn533: Delete an unnecessary check
    https://git.kernel.org/netdev/net-next/c/c6f68f69416d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



