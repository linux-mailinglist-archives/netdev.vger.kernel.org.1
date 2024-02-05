Return-Path: <netdev+bounces-69191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D884A044
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F10F1C21E0B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE9405DE;
	Mon,  5 Feb 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jva+uhWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1D4176E
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153027; cv=none; b=It20egaqB6rjCxlWcHV/sXFiDfZ4yp+/JLQQ6IDvF4/g2kwtQu3LtN7JmX4Mi6QT3iGg4TOu+vu7oJkE8wvZA2t/XywXXURZ/wSwiUEbaBjsmdNCD6aXwPr8fNDa8B1+C7TGDMMugi33qc7zRet10ODhtJDzYi0zb5+6UcY07vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153027; c=relaxed/simple;
	bh=4Eur2Zj/pix6D7XzRVSiRoC6MJd8cx7h4HVqzsGm6u8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iE3oYwCgPtZPzraK9dhd3iFQWDYw7sdazm6Ze+0KiAQ0Eh9dyvlgR/0Xpekh7F/QrVdSqjDQj/QFs9nb0ujuk7sdh4SGKnJRlkJ8pPdxzBmGz9NcrEmROQooreP5e/Mi6YpLHnnCz8jm51dIpiaWbabvXkMqA9ID0m4Co7dqb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jva+uhWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDB37C433F1;
	Mon,  5 Feb 2024 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707153026;
	bh=4Eur2Zj/pix6D7XzRVSiRoC6MJd8cx7h4HVqzsGm6u8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jva+uhWqLZH5EbvJn0tf8YVw+gZvwD0+d4xxITfRHUoN/IHPrLjJB2wJNYYi8Y+oK
	 TO3jS/vWBwwS8CYUxguhyML//ms1wTUcbWrQfFfBgOsgC6r27c58pWad4mBr0z60O1
	 sj6yzIVa8SPwXidssxrteElkpWds92lEAfmsCRVoI43i8VEPxf53d8b5CYs0tJaoc0
	 xfkZcnUwzIaIjXddiTzKcI4hkoVAGyCWFXv0MItvwtd33RsO6O+yq8xTTw23Zv7kXF
	 CYqk4kqouuQTvLoSDM8vqKvyys1FqYkqKBNW/H7elMJ41k1IDsvgiMec1jFD22dbY9
	 FA3YnWNRmykYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D448E2F2F9;
	Mon,  5 Feb 2024 17:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Add missing stats command to usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170715302663.5558.107656198902446854.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 17:10:26 +0000
References: <20240203200305.697-1-yedaya.ka@gmail.com>
In-Reply-To: <20240203200305.697-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat,  3 Feb 2024 22:03:05 +0200 you wrote:
> The stats command was added in 54d82b0699a0 ("ip: Add a new family of
> commands, "stats""), but wasn't included in the subcommand list in the
> help usage.
> Add it in the right position alphabetically.
> 
> Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> [...]

Here is the summary with links:
  - ip: Add missing stats command to usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=32bb7f8f99d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



