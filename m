Return-Path: <netdev+bounces-65686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A558A83B587
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461F81F2365A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669513666F;
	Wed, 24 Jan 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLLESttA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAC13666A
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138428; cv=none; b=qYHTQ4fxYvFdnHl71i2XYfuIgjHUwBj8UqwqyWr5vRUqoaite5DZ5sQt55BBEoG5+rS5incLLmAn4qDVKkL3KiNL+vQcSE5JO/589i176QyajAtMQuFBf7t2xShk112vlj770CuEA2HGYB4/Km3z61eALih8/l5vSaP2S0pPJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138428; c=relaxed/simple;
	bh=xaEPyaxpZeZK6ZCT2bhkeKrXNpGSj+nY2v1/WZL/eSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FT02/PZgW6D9/1fPfbHCAKYA/qta8/VZgDVW5ZWOKIE/yUWPI6yzQdy1dI92C59SM4574BSz6Yq0PgLQCbTWLLuFPAAnh85J9vwmonCdAyu2tIDgoZKy7k6FkYkySmv24qj899oMXwl4399K+QSEYM/Gj4wgPAgUeXgN0VIFzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLLESttA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3627C43141;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706138427;
	bh=xaEPyaxpZeZK6ZCT2bhkeKrXNpGSj+nY2v1/WZL/eSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rLLESttAEK5RCM2iHnjURVyfVASANpcG7bRR0ymei+f/Fn3lJ/5sN4HmFcwr/vuU/
	 0mq9SVYyC0PlBsHi65tTs7DAEZRSaapX5c/mGOwIn1Ld3LQ2ExrZNrbtebBTWJYOAj
	 CHd8tPpwOAJ9+DuVH5LfHmtbHhSFv3fBr4+YUR0uAWHDEHPfft33uLsXEXbZphSGg4
	 lNXfLNRpuv5oEEaRQyNsmjD9sKbJQZGTjM41uFyYv20TA5qOGFl2CXibnln9GYROGd
	 gFozqWWwp0QeltVfoB5FFSIximP+qsYfNvS0epa9WrvtKMVz0oYvgtrJMUC03s9bb7
	 JlGqdr4Ri5bAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D389BD8C966;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] color: handle case where fmt is NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170613842786.28029.4972541107041251626.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 23:20:27 +0000
References: <20240123043010.266210-1-stephen@networkplumber.org>
In-Reply-To: <20240123043010.266210-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, pctammela@mojatatu.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 22 Jan 2024 20:30:10 -0800 you wrote:
> There are cases where NULL is passed as format string when
> nothing is to be printed. This is commonly done in the print_bool
> function when a flag is false. Glibc seems to handle this case nicely
> but for musl it will cause a segmentation fault
> 
> Since nothing needs to be printed, in this case; just check
> for NULL and return.
> 
> [...]

Here is the summary with links:
  - [iproute2] color: handle case where fmt is NULL
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=da5a2d94dc01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



