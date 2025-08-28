Return-Path: <netdev+bounces-217574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B43B3915A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA4463144
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC8195FE8;
	Thu, 28 Aug 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/1UpK6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA06FC5
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346428; cv=none; b=R6VHU2qdTUyyhKU7aFoRykdFeJZnASH1rL8QqrHLuNKrqi+EH5cA0W/3nYuZ/4QJctvz2tJlFNkNdvMqba6tEElIeKr9kZjVjkG/P9FulqM0+nfIfDP2xsfz0fVvRC3d2sPK6r/ZAX/1t46T0tycudg3OU+H4AJMkqYEIbM9yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346428; c=relaxed/simple;
	bh=OjUKhWm3emWUWV1s0qO3smtGIPjNwvCVkpcps0SM9XM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OWhCou2X9H84JxsxAYVOwa3gV+H1loDcbtbslD9UwKSSKyPvhtZNlnQ/euGzlKYI5ERc0ZA0qXiPwZG2XTFkxQmAv7PZx+ZVNMhS83cIEIKt06gS9ELbNwV55cA5WYqwP6u/F24LZVrbJMcDmLQdVICBu0FymSkQdi9vqj+QLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/1UpK6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CF9C4CEEB;
	Thu, 28 Aug 2025 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756346426;
	bh=OjUKhWm3emWUWV1s0qO3smtGIPjNwvCVkpcps0SM9XM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R/1UpK6Cax1PyRZjliBGApYejylMOMAZKyvNKk9aRUYCWFAOPgvSO83lH+GV4r5hN
	 Phts+sLX97mAsHGjJ5BOWT3GPhviauJUED4IcbycdB8NSFQnGnFHq9UFinZOC1HxWS
	 2WN4ynSoQQexBBLfRGq7ZvUmgk43WgRy3EvWdvJN34AQuVtgtJRMAE7r1yq1Fo0cgP
	 IUz1AaKDz9MeMkKpTPJC03oZlyZoVHuyhz1X6trg/123X5hR4WphTHKwkm0x78HmD5
	 og42hUARoronDtV8jJ8he5bjpHjOpkl1uW07vk/KsWHOibcrlGzxDd9xxcO7k1LiK3
	 5IAJsh6lhDZRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF4383BF76;
	Thu, 28 Aug 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13] macsec: replace custom netlink
 attribute
 checks with policy-level checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634643374.908900.8830557654640227942.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 02:00:33 +0000
References: <cover.1756202772.git.sd@queasysnail.net>
In-Reply-To: <cover.1756202772.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 15:16:18 +0200 you wrote:
> We can simplify attribute validation a lot by describing the accepted
> ranges more precisely in the policies, using NLA_POLICY_MAX etc.
> 
> Some of the checks still need to be done later on, because the
> attribute length and acceptable range can vary based on values that
> can't be known when the policy is validated (cipher suite determines
> the key length and valid ICV length, presence of XPN changes the PN
> length, detection of duplicate SCIs or ANs, etc).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] macsec: replace custom checks on MACSEC_SA_ATTR_AN with NLA_POLICY_MAX
    https://git.kernel.org/netdev/net-next/c/d5e0a8cec12c
  - [net-next,v2,02/13] macsec: replace custom checks on MACSEC_*_ATTR_ACTIVE with NLA_POLICY_MAX
    https://git.kernel.org/netdev/net-next/c/ae6a8f5abed1
  - [net-next,v2,03/13] macsec: replace custom checks on MACSEC_SA_ATTR_SALT with NLA_POLICY_EXACT_LEN
    https://git.kernel.org/netdev/net-next/c/8cf22afc152c
  - [net-next,v2,04/13] macsec: replace custom checks on MACSEC_SA_ATTR_KEYID with NLA_POLICY_EXACT_LEN
    https://git.kernel.org/netdev/net-next/c/d29ae0d7753a
  - [net-next,v2,05/13] macsec: use NLA_POLICY_MAX_LEN for MACSEC_SA_ATTR_KEY
    https://git.kernel.org/netdev/net-next/c/15a700a8429e
  - [net-next,v2,06/13] macsec: use NLA_UINT for MACSEC_SA_ATTR_PN
    https://git.kernel.org/netdev/net-next/c/82f3116132fc
  - [net-next,v2,07/13] macsec: remove validate_add_rxsc
    https://git.kernel.org/netdev/net-next/c/80810c89d39c
  - [net-next,v2,08/13] macsec: add NLA_POLICY_MAX for MACSEC_OFFLOAD_ATTR_TYPE and IFLA_MACSEC_OFFLOAD
    https://git.kernel.org/netdev/net-next/c/35a35279e8ff
  - [net-next,v2,09/13] macsec: replace custom checks on IFLA_MACSEC_ICV_LEN with NLA_POLICY_RANGE
    https://git.kernel.org/netdev/net-next/c/17882d23a6c6
  - [net-next,v2,10/13] macsec: use NLA_POLICY_VALIDATE_FN to validate IFLA_MACSEC_CIPHER_SUITE
    https://git.kernel.org/netdev/net-next/c/4d844cb1ea1f
  - [net-next,v2,11/13] macsec: validate IFLA_MACSEC_VALIDATION with NLA_POLICY_MAX
    https://git.kernel.org/netdev/net-next/c/b81d1e958867
  - [net-next,v2,12/13] macsec: replace custom checks for IFLA_MACSEC_* flags with NLA_POLICY_MAX
    https://git.kernel.org/netdev/net-next/c/b46f5ddb40c8
  - [net-next,v2,13/13] macsec: replace custom check on IFLA_MACSEC_ENCODING_SA with NLA_POLICY_MAX
    https://git.kernel.org/netdev/net-next/c/db9dfc4d30dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



