Return-Path: <netdev+bounces-114765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48480943FE2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CDFB28A29
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68B140E5C;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfrhSHla"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC3200A3;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474637; cv=none; b=pZdqdshmYOJ6Gh98RNyEXzhWkyFiyhyS94tAJdeea6WXrD4fvt/J7hahO32qs0qsvcn+Zjup2kDqa6R+amG1YJM7LG4rTUv1FjFy+afApaJKHJ1XBV/rS1ivHT/FddVFX2z1Dp7P77OIF5TFzJ9FYHPIIFyOXgIMAn3hK92NokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474637; c=relaxed/simple;
	bh=5pekV9wyOQzuoUdRu/1idacnuxzW9pNNfb3AKHrb9fI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XBf3/ul28jbo6h+zfzWPkc20W59CDeToPkVNedHsUygyrtWEiZx6uulf/0L5GusXP4pN8JWSox5ESw9S64Vu4jEyjjJjjm0DFAkU8MjRy7QQYFqMoAueH8CVwHG3fULWcDKNr+DCm3XlpMvm1v1eiH/hur5MxhuK9vM5Hfj0s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfrhSHla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52A54C32786;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474637;
	bh=5pekV9wyOQzuoUdRu/1idacnuxzW9pNNfb3AKHrb9fI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AfrhSHlal6LeY43VCU92LVPU5ALrvZ4oGFem3VUR+dKX3kJA4Dxp2EgVvk4dWLzXx
	 Sc9i4BtY2QfUUDXbHKAqa82a7B/35YMXOKvEajgVRAvBFBrtwKdahIqATgV+aKvLHg
	 zZkF/z20nxfNJvzlX9lEUtqxFvNIinda0RZtFdtG7EZjk6Vk1WfpWGft7aeGbW5UnY
	 W34a6UgYLBPynPQ9EyOY3zO564D/5jzRzYjD0py3oNg0C86HM51/tElJ6pffvuUIy+
	 kX/qNlOaN/FZ+PCvek5bVK4QPpylYbYuNqrEmQYMN1f4Z/CtCR6AK8FOTHr71L3RHg
	 qw/JHzO/oyuyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40736C6E39B;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: Add skbuff.h to MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247463726.20901.13788765479950503016.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:10:37 +0000
References: <20240730161404.2028175-1-leitao@debian.org>
In-Reply-To: <20240730161404.2028175-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 09:14:03 -0700 you wrote:
> The network maintainers need to be copied if the skbuff.h is touched.
> 
> This also helps git-send-email to figure out the proper maintainers when
> touching the file.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: Add skbuff.h to MAINTAINERS
    https://git.kernel.org/netdev/net/c/8f73ef829858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



