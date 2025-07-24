Return-Path: <netdev+bounces-209588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3537B0FE9E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 04:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0D0AA61C7
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6BD1E51EE;
	Thu, 24 Jul 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q07TD+6c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA71E493C
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322429; cv=none; b=WrgScEl6WOJx+Q5GbJhp757m1MFOZHUvSCMk/2RlMc/T1MnIkBqEzT+mgaL/CoClSvALji3ADLeknyJGmzIFdypfspL+KS8J32hZEobiCCnoqU93UZDXLa0hIfKctKVCgrA3/3FMgifhq8VRXYh7YAFe2jcXUlkrswVe+TnskLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322429; c=relaxed/simple;
	bh=jGmFbpr+YmtDyxU+Rdwyb7A+UTLOb4OLlE0ybjv/eNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZ8IPybAUolUJ0wcL+NZEdOK6B3uSDDe60OcQGQR17SJSHhUSCjj5Zbd6mNuIXKTKFMoOqlIU8dh70j9k7EQOhZ1P0nQE2GKb/wkgTZgpKyOPwEk5BPX3egnUgDr6io4d86u21bLFKVRFo872G67m8agx+exAclXbpQeGUReORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q07TD+6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236E1C4CEEF;
	Thu, 24 Jul 2025 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322429;
	bh=jGmFbpr+YmtDyxU+Rdwyb7A+UTLOb4OLlE0ybjv/eNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q07TD+6cNUltkENvKkxW4Yj0CJpgzlAe8AH+d0dCwy/BeN8tREecYYc49Y+Wp8hG4
	 izaDiVXOkWeHbngRQa3WVdiBMbBhBXhGijkNnoEWHjl3Vx8lU1whE+W9WIoGupJG/v
	 p5MMopcLskETiVRERIYKzPj5lxQcmhExNAPijS69UE4cmJ1Y3+zTTTsOq3f2xrIZEU
	 fJLXzgvccIVn+NnPAoJZ5+K11uhpckl/1CEk0Qg3dHJ7vCsUEnCgxbpuqVjaKxGYOd
	 gUUCOacOiYFsOSpbbqVAzo2bh47zFP3VCDNm1myE9XEs+98CQsdSmBvIt9+rnWOYNK
	 CeNQdL7SXhjog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A92383BF4E;
	Thu, 24 Jul 2025 02:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdevsim: add fw_update_flash_chunk_time_ms
 debugfs knobs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332244699.1844642.7371821332383657527.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:00:46 +0000
References: <20250722091945.79506-1-jiri@resnulli.us>
In-Reply-To: <20250722091945.79506-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 11:19:45 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Netdevsim emulates firmware update and it takes 5 seconds to complete.
> For some use cases, this is too long and unnecessary. Allow user to
> configure the time by exposing debugfs a knob to set chunk time.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdevsim: add fw_update_flash_chunk_time_ms debugfs knobs
    https://git.kernel.org/netdev/net-next/c/9a5bbab285cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



