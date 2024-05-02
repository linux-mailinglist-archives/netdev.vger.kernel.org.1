Return-Path: <netdev+bounces-93035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F78B9C2F
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29305282770
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B413C69C;
	Thu,  2 May 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soYttnjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403413C687
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659634; cv=none; b=NQVx7cUwG8jrJEoLKvGWlesOn67vBD472iJubq51LzyFsg61HU+VWlo1nS6ACSMYUBU6+1TkJBRkzBNf/4QwrL5MQ7mx2cQEoQtkxpKNKBpe8XeTvDSqRxR0WZhWfvM5iswvvlQTrsuwdLA9GjAsIJsGKCqHlM/B6ThprmAFM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659634; c=relaxed/simple;
	bh=xtk7RswArOXHNDcFgtUJG/1dveYQdYYp0OBzH1X5Jbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hpYI6p229ZHpZku6ixxuaAqykmHQHZpJ0csJAvj4GRWIWidNyoQMl2M5wzcyiOMQIaiKqOOkBRYmleXaO1o5zE3fM4UpyH1VFo7TA4oW+D5+SA4RYkgMejLzqigmTzLNdRoAS9zOSxZPD43kupuQCCD7DnHtOqfn3bKgOis9bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soYttnjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08721C4AF14;
	Thu,  2 May 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659634;
	bh=xtk7RswArOXHNDcFgtUJG/1dveYQdYYp0OBzH1X5Jbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=soYttnjjKXRLTbjxjq7ajE8n1qm452cdKG0r/SSg8KS93xwwpOKIdHfpxZ1bQKVMl
	 ZxUjJ+hF4crmc+CXujTIepeuIj5OqcN5xcQNRCerBFVKKaOhyOd+//OeVTz1DjViiW
	 d663whEYwVg1UKWWr4KzR0pe0zos9+4Qg4EISiARcaMicGXmNkgFvajVp+G03qS2KO
	 nU1uDxzAElLy27iJPv6SEilqUHmc0PqKs7Pw4sm7jw0BATjvfRF4lTHjcztKfQFE51
	 1KuF90zfbSQdpv7ocKAsmm2PWoBpcdUlAsM55ujP1rKu/HyoBisL/f5IgP8TkDrZxf
	 WilemlO0nfRVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB361C4333C;
	Thu,  2 May 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] i40e: cleanups & refactors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171465963395.28830.15157646433345358918.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:20:33 +0000
References: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ivecera@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 30 Apr 2024 11:06:30 -0700 you wrote:
> Ivan Vecera says:
> 
> This series do following:
> Patch 1 - Removes write-only flags field from i40e_veb structure and
>           from i40e_veb_setup() parameters
> Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
>           and i40e_notify_client_of_netdev_close()
> Patch 3 - Refactors parameter of i40e_detect_recover_hung()
> Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
>           in existing code
> Patch 5 - Consolidates checks whether given VSI is the main one
> Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
>           in existing code
> Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
>           particular and uses it to replace existing open-coded pieces
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] i40e: Remove flags field from i40e_veb
    https://git.kernel.org/netdev/net-next/c/b92379dc94c1
  - [net-next,2/7] i40e: Refactor argument of several client notification functions
    https://git.kernel.org/netdev/net-next/c/54c4664e48ee
  - [net-next,3/7] i40e: Refactor argument of i40e_detect_recover_hung()
    https://git.kernel.org/netdev/net-next/c/7033ada04e33
  - [net-next,4/7] i40e: Add helper to access main VSI
    https://git.kernel.org/netdev/net-next/c/43f4466ca91d
  - [net-next,5/7] i40e: Consolidate checks whether given VSI is main
    https://git.kernel.org/netdev/net-next/c/6c8e355ea5fc
  - [net-next,6/7] i40e: Add helper to access main VEB
    https://git.kernel.org/netdev/net-next/c/5509fc9e3ab6
  - [net-next,7/7] i40e: Add and use helper to reconfigure TC for given VSI
    https://git.kernel.org/netdev/net-next/c/29385de33956

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



