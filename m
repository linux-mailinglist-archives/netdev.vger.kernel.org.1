Return-Path: <netdev+bounces-221945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8297B5260C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C9A3A1E71
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456D1C7012;
	Thu, 11 Sep 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD0I5cQ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6680C02
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555404; cv=none; b=EevSqth5U7lv4mMwlVZAT5xHkNgFVcVawqtzG+fYFb0UVV1i5pcLdBKbRrc3WYYx2xBgCZO2wXWpgXfy9SjNqHtm7RcuyrX7jGlVa2fFmgJScSo6IxKE+jSpMN4LrgcWoa1dlicl5VPHa/t5uHwLh8qJpzUEa/WrfRnTFvMT3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555404; c=relaxed/simple;
	bh=dATO5+5fpOqbEDEZjsYSw3dZwqCksyvm+jIQJ8TsLTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pu8wyzHE6dkbmRQNHEeihcpOtOW7/DnwD35eh88nezSDUP01xs8M01MjuYmYW74oI2SaVbfvCkY0UPQUuMs24CPG/ZB3CI1HBo+zpngDo0GG60lJKoWr16UYnKek1QU7dKlpTWbfZnRjJqGMVn3ps4RplnGQQ/VOQUlPrFpfEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD0I5cQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3EAC4CEEB;
	Thu, 11 Sep 2025 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757555404;
	bh=dATO5+5fpOqbEDEZjsYSw3dZwqCksyvm+jIQJ8TsLTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qD0I5cQ4QRGiByqXTuLFIG53/i8WeJquIM6BfGqNreT3V3OYELkfDZQ5R6ljBmhGd
	 v2h3w6/iX53G1/fbjp2fC/ki7OekTM1X0LxjjiRFTaODLkLebXlUDW+tw0kHutIqZ8
	 ecvDN/eJ297/Tv3aDNoCLwZ3Xxbl9eZLUkVuVu64IlLOC21pO5uZKnZH1brsAsXS5t
	 g+IJyVY/lyUR7H1bw0HevCPAKgA+I0Nr9uPAhG4PA5n9j+5lNqzUogDTs3VgMJ7MNn
	 fGtYfuIMzaRjycP7VmuT0VMlS/mMZPFRp49LOMx9Z2X99CioCMNIQL31CcwCdHlLnY
	 GQD4L0rXpZfuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E76383BF69;
	Thu, 11 Sep 2025 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: replace sleeps in fcnal-test
 with
 waits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755540700.1625707.11415955157779836629.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:50:07 +0000
References: <20250909223837.863217-1-kuba@kernel.org>
In-Reply-To: <20250909223837.863217-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 15:38:37 -0700 you wrote:
> fcnal-test.sh already includes lib.sh, use relevant helpers
> instead of sleeping. Replace sleep after starting nettest
> as a server with wait_local_port_listen.
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: replace sleeps in fcnal-test with waits
    https://git.kernel.org/netdev/net-next/c/15c068cb214d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



