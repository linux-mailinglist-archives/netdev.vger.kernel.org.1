Return-Path: <netdev+bounces-186612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CBA9FE1D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844EF467A06
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C674C76;
	Tue, 29 Apr 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMZBWbG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA63C17;
	Tue, 29 Apr 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745885390; cv=none; b=l35iAULmBEheXtJ5HGW+XSf8E1fVOD5577MSq7R10/j06+FV09V+SFBOtWhpZgHdNORP9p1KtC0jHSq8DgfJ1zf3kl9hLuCrDqUss6XdHZlDPvPPEzeMqB0ql/lB3WWZGPQu6FmFltaKKo4ImKbKhSHRkFhEegNcH3tE2Jk8teM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745885390; c=relaxed/simple;
	bh=Qf3ebDuShvVbdeEzgslrmOh/1kLvnJJWT/G7Fq5xhmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WNakCF3+S0QvtnQG1aBU9wB9hv2dEtZ7MDxJ+rEp5uHcHNPS1hni9GCS1hNTwRpXigrjuuILqf6bFWD3zd9FJXG5UHDZkYnKEj3TGbcmQ2tLUCa+qKkEw8i/+gFjYH/6vjJjADLjN79GeX3nFxh0im6ZnyOQmB95kGLBofHBNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMZBWbG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C524BC4CEE4;
	Tue, 29 Apr 2025 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745885389;
	bh=Qf3ebDuShvVbdeEzgslrmOh/1kLvnJJWT/G7Fq5xhmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YMZBWbG3dXzKj+m/8LM2SOIEwn7jTIVjFQywAsS4gESw4pH09qc17cYnnP/TL7NMj
	 f9+9Nrft6XZ+ck0GGAK2TWgPvbtJ+bKCA4LZstnBOkSuENyDL2iiwTiNFv6smAZKFq
	 MmooPt5G2EpXeY/mgwTTUOTsGW3TrlOcoF5NCe7y3IbcVsnFJxt8U/YRknEcNL5ArY
	 Y8Oo9p+3qpJkinubxGg1VtP8Eq0lmMKhORJe11h9VAZAogFPqxtEgCZlMW8Ji7FiX6
	 qgje73GAroZ4nvDgh9LonO9sV8TLryDu3uvShL0pvP0I2D+vm5QK6zR1SQ2qNkoPkp
	 9XvGPSlRTf5Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF63822D4A;
	Tue, 29 Apr 2025 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rtase: Modify the format specifier in snprintf to
 %u
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588542850.1085948.8654233885630135019.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 00:10:28 +0000
References: <20250425064057.30035-1-justinlai0215@realtek.com>
In-Reply-To: <20250425064057.30035-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com, jdamato@fastly.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 14:40:57 +0800 you wrote:
> Modify the format specifier in snprintf to %u.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> ---
> v1 -> v2:
> - Remove the Fixes tag.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rtase: Modify the format specifier in snprintf to %u
    https://git.kernel.org/netdev/net-next/c/ef7d33e17456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



