Return-Path: <netdev+bounces-80725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C73880A5B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81211F23171
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B1679C2;
	Wed, 20 Mar 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuLxEWHU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305E1C2D
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909029; cv=none; b=e4x2FHPygCMLB9v1ap87bnJQE3RAhMLZVoOnwpVIS1hTZyUvJlUnEbtyFSKI+ehFxhe8GaW3rwohE5PNuKoJAb7y0EtwQ8rUqgCW3O55gpuktknq1h269Lk35D3bQ7jCUp7zXeU9AkPVoe0QV655k7VIuAjKznaGkTS3tu517TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909029; c=relaxed/simple;
	bh=aJM+Qj4IySUKJ3GhJkHmGtdo1dEF4zmMeYif3zqJA6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JsQqeHBqRxAn2U9Sc6c3C0Ko3PUtskdSNO/fEnoBDR4Z1MwRep/6gcPhfnjKHCk5bBeQixWjVta+SbLD3bXDsHlOUev6zYpjXJLs+TIF3crqckuWpHr3ZzyIomr3vkj9e3hX7vzhm7c8/SYjcuKOYNCtZPY+a8WVXQHWuwtCcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuLxEWHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AC63C433C7;
	Wed, 20 Mar 2024 04:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710909029;
	bh=aJM+Qj4IySUKJ3GhJkHmGtdo1dEF4zmMeYif3zqJA6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LuLxEWHUwxu/W5mvh6qbYXQteXs23fPUqHOqsaBQOOl3mexnIyb781MfVmDr34m80
	 OZvXgzU1WGideeOj2Xlbahr1AZHxU7qXaBW5BzPmP8OgxcKoJ7vwDrIzC6ha6qHb7q
	 boVBASBUhPs2Ltj+8exscXdk7Msm3Q4VtarLBshNVkf6cY9xBhC/H7bRKhc8p7g+Cg
	 v8xxTUfO+sUc4dGpam7oPnp/tiO+R78FWSPs5pWIqMhHfavWKfyb6bk7/jvFbnH6ju
	 VvTyU33eakoYyMpPoRv9gSNQ9AEB84+hvIY7es4yjoxDJwOdiEl54tkf6lma57WwPS
	 3LehSt+Av2AXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CC88D84BB0;
	Wed, 20 Mar 2024 04:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2] ifstat: handle strdup return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171090902931.27266.1895053888910896704.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 04:30:29 +0000
References: <20240318091541.2595-1-dkirjanov@suse.de>
In-Reply-To: <20240318091541.2595-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 18 Mar 2024 05:15:41 -0400 you wrote:
> get_nlmsg_extended is missing the check as
> it's done in get_nlmsg
> 
> v2: don't set the errno value explicitly
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> [...]

Here is the summary with links:
  - [iproute2,v2] ifstat: handle strdup return value
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b22a3430bd17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



