Return-Path: <netdev+bounces-216755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5CBB350D1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8867F24530F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C42264A76;
	Tue, 26 Aug 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKIhFQLt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF558223301;
	Tue, 26 Aug 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170599; cv=none; b=bwf2UuUc1v+J37xmez75/drwGEOP3puhT37uHbd56NsdgXEpeI+L14DLQ2zmq4ACdUaAnysKXFqtVLGZJuT6gt8B++UsWXn3VoT9wJLN33GXr9v1DMUqY+axLSCfDl4a/Aw5htDhYGG75dWLSCSrY/Fay7uaTPDBUWzVi2Bw6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170599; c=relaxed/simple;
	bh=2MU1wsisj2bpi9gw4bNtqYogONq6KHZrFXV+50sZ3WE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dH5K6oa5JkmuYL/mU13h54H/rUdtFuU1fyAG+6Jt9nxsV1uGmQ5Gau/PFF0fIAD1slTYzvKoFolvxqxnZjLQ4TmL/mEpHn9ng6rldJy7SpUjPQ063gGPaTB7nebshYQf3fYEdqJGLkiPKSrUBDeBNtqBzlF44FhroohroiJaZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKIhFQLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59356C4CEF1;
	Tue, 26 Aug 2025 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756170598;
	bh=2MU1wsisj2bpi9gw4bNtqYogONq6KHZrFXV+50sZ3WE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mKIhFQLtK2Yjz+ZCyjolsgwwzaWjvM7Osc/Bf3GkYHP2qhDYF9kaCMG0JVhG6Xau8
	 W8L6h4ICepCDdZsWoLeQ29jS6YFrBL0oC7ZdNPl5ehtSWzh/Q/BjLJwuwjwcKfj7CT
	 5a1vQfLWrU1XNlB4D8uO6dDGZLn/Z6WiosO0TAFF3XgPVJz/9WEzQ6uGe0AFeDDbeZ
	 vC2ry6ov1mkO+HwALBx2jx0mpNwMVYJv2/NRCO/hdbDu1d8Fs37FpDkLDXhFD2R+bm
	 CuUfnNC73StpbVo1MTOfTXF55NveyXbGSCaBkh/Y1jtA2amIwalKM1bqA0M0fReOH1
	 zu9dT9yCQqhVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D26383BF70;
	Tue, 26 Aug 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: remove stale an_enabled from doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175617060625.3613843.15947704573135304216.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 01:10:06 +0000
References: <20250824013009.2443580-1-mmyangfl@gmail.com>
In-Reply-To: <20250824013009.2443580-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 Aug 2025 09:30:03 +0800 you wrote:
> state->an_enabled was removed before, but is left in mac_config() doc,
> so clean it.
> 
> Fixes: 4ee9b0dcf09f ("net: phylink: remove an_enabled")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  include/linux/phylink.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phylink: remove stale an_enabled from doc
    https://git.kernel.org/netdev/net-next/c/df534e757321

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



