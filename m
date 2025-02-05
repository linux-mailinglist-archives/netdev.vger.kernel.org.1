Return-Path: <netdev+bounces-162827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E507A281AF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53A03A17FC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138820F087;
	Wed,  5 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTqwmjDV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003E25A65D;
	Wed,  5 Feb 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722011; cv=none; b=jM6DE572jYkMZMN6fZiAVbrQyh7kEbHRfhLPqlY8tjn4ZaaQmzdrfIfumKzkNDam8LBBMHXLwDNGRZ5+52zxzgPqdhXh9ZR7qoXvWgzbqQEwHzJd6TyFbI3UZNeqX9+EbOGhxinY6Qpg/k3t9yj6E9zhafcoWBoOcZ0eMBFoa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722011; c=relaxed/simple;
	bh=NUZSa1vxr5EDFxVFDX5aCdrF7cT0eA6QoO3DDZvH3Tw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jCAaEjDaP7KEEgS+w4wnWlzfm6AXtZWGZhrt2VpqSYvYeIhZYuAxoTrpgPsZS8WfyqTrD3K76a+J2NyMzNMQOKjuN7nn2rXnHwOr5CKBxSO8pu1wT/9gC24wsXWIqbOqPzsEnB1uX2jqi+QcJ+St4ejz5Eo7HSQxeZUxe5IogaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTqwmjDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE01C4CEDF;
	Wed,  5 Feb 2025 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722009;
	bh=NUZSa1vxr5EDFxVFDX5aCdrF7cT0eA6QoO3DDZvH3Tw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTqwmjDVIePtGhk3qGU2dSU4xDyIKnIcSke+R74P7qYGkzDvEoJq/k0upcPl/ZfMg
	 mXr/RleTOUD99UmwPEy3PTmxGnI2LpkQRs3GzTdsLQNtBrxU2TDhO3I+eA+J1nvWn8
	 ubXjeichkiGYFbf/uyUxYdjc0Gm9oFv2r2dHyL/BCgFN1fdxJXzfEjimA50G6yE2uu
	 U9ifkvwjiDZ+9GuZG2/HdpiSUYGmnGnjHY2pf2POB4Qmwnuzjea4Glcf7YabaXTB1a
	 pXI2jfCR7hOSthNpDaHYr+m3XqBIGO4P2uVUXv4i92ciwsFqg306L6f41SoKr73ycv
	 wIcnsEaBnpn2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0F2380AA7E;
	Wed,  5 Feb 2025 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] net: atlantic: Avoid -Wflex-array-member-not-at-end
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173872203681.246239.10910954158742758610.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 02:20:36 +0000
References: <Z6F3KZVfnAZ2FoJm@kspp>
In-Reply-To: <Z6F3KZVfnAZ2FoJm@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Feb 2025 12:40:49 +1030 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unused flexible-array member `buf` and, with this, fix the following
> warnings:
> drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Here is the summary with links:
  - [v2,next] net: atlantic: Avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/33b565fa2bc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



