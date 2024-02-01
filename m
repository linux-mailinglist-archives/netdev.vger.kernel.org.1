Return-Path: <netdev+bounces-68141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54720845E5C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108A0283747
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA351649DA;
	Thu,  1 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAiTvCRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCC1649B0
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808028; cv=none; b=kznQhMO81DYkrRkQcOOi+TAbQYtcQXPdgtCxLeaBTnSGUDHDfa9SSsOugovSqoIYhFpn6UR0cHWEE+MjpPzCgTfKeFua/N7cprK/Wk9pugUUVwsJq7GqgvqU/HhqhAQD12TJtwCtIkQyANE9xV8AhGJ5uOQagFb1DNh6gBpRB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808028; c=relaxed/simple;
	bh=I8y+YBYPLDd31ye3EcDQ5X69ftKGRmzs6Jpk+aELy44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ssX3mzJiCoNH6RhsWr3crze2ErG1G5bbLJdURl5KYV7v08DHgQEeldpCy6n8Hny4lNpp2L4z41rK3dvIW2ZC9IUVPKgGr7WYF9vBpMZeCS8aPfyss1fWyF0Q8L4Y7OoE50jUbqH/RDj6nT9yF+G8CIX8lH4rq2PbSZPrym4EITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAiTvCRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A926C43399;
	Thu,  1 Feb 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808028;
	bh=I8y+YBYPLDd31ye3EcDQ5X69ftKGRmzs6Jpk+aELy44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dAiTvCRhS8ksH6YiH9IEnNCQ63cNIwDFeNlLZn3Oxc5x9egoS6LJQsNIGPpDX+xyc
	 F6xdCQoQJrVbU+suHODOYDhMnt7tm4SWIjYrZXq4LZXi0v1qW2wllX24dq0MO5Sbff
	 mCwt6xQCEqt2nhi1fEBn7sobeUDmfYoS+J376xhMzPp8eUkXWCGNTfrzfOC6EW6I03
	 bg9+d7HtVu9NFtM9tNc8D/OFn9VFK7/yYLfwWO9bqncna+zf76dCC4fqy3u/Ch3xzp
	 EZegEUcaLTCqLC+Dk9kboKtmcvAbGtRJa8Wh3pY7wLkTk6fJkm7v5QvOn8VgWnecEh
	 dT1vB3/O0qJZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F029ED8C9A3;
	Thu,  1 Feb 2024 17:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] idpf: avoid compiler padding in virtchnl2_ptype struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680802797.24895.2232597688333198588.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 17:20:27 +0000
References: <20240131222241.2087516-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240131222241.2087516-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, pavan.kumar.linga@intel.com,
 willemb@google.com, David.Laight@ACULAB.COM, lkp@intel.com,
 przemyslaw.kitszel@intel.com, pmenzel@molgen.mpg.de, horms@kernel.org,
 krishneil.k.singh@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jan 2024 14:22:40 -0800 you wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> In the arm random config file, kconfig option 'CONFIG_AEABI' is
> disabled which results in adding the compiler flag '-mabi=apcs-gnu'.
> This causes the compiler to add padding in virtchnl2_ptype
> structure to align it to 8 bytes, resulting in the following
> size check failure:
> 
> [...]

Here is the summary with links:
  - [net,v3] idpf: avoid compiler padding in virtchnl2_ptype struct
    https://git.kernel.org/netdev/net/c/f0588b157f48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



